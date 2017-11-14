/*
 * Copyright (C) 2001-2016 Food and Agriculture Organization of the
 * United Nations (FAO-UN), United Nations World Food Programme (WFP)
 * and United Nations Environment Programme (UNEP)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 *
 * Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
 * Rome - Italy. email: geonetwork@osgeo.org
 */

(function() {
  goog.provide('gn_facets_dimension_directive');
  goog.require('gn_utility_service');

  var module = angular.module('gn_facets_dimension_directive',
      ['gn_utility_service']);

  module.directive('gnFacetDimensionList', [
    'gnFacetConfigService', 'gnLangs',
    function(gnFacetConfigService, gnLangs) {
      return {
        restrict: 'A',
        templateUrl: function(elem, attrs) {
          return attrs.template || '../../catalog/components/search/facets/' +
              'partials/dimension-facet-list.html';
        },
        scope: {
          dimension: '=gnFacetDimensionList',
          facetType: '=',
          // Define a subset of facet to display
          // in this facetType set.
          facetList: '=',
          params: '=',
          tabField: '='
        },
        link: function(scope, element, attrs) {
          scope.facetQuery = scope.params['facet.q'];
          scope.facetConfig = null;

          scope.fLvlCollapse = {};
          scope.collapseAll = function() {
            angular.forEach(scope.fLvlCollapse, function(v, k) {
              scope.fLvlCollapse[k] = true;
            });
          };
          scope.expandAll = function() {
            angular.forEach(scope.fLvlCollapse, function(v, k) {
              scope.fLvlCollapse[k] = false;
            });
          };

          var hasOverridenConfig =
              angular.isArray(scope.facetList) &&
              scope.facetList.length > 0;
          scope.getLabel = function(facet) {
            if (hasOverridenConfig) {
              for (var i = 0; i < scope.facetList.length; i++) {
                var f = scope.facetList[i];
                if (facet['@name'] === f.key) {
                  var newLabel = f.labels && f.labels[gnLangs.getCurrent()];
                  if (newLabel) {
                    return facet['@label'] = newLabel;
                  }
                }
              }
            }
            return facet['@label'];
          };

          scope.tabs = null;
          scope.activeTab = null;
          scope.isTabMode = angular.isDefined(attrs['tabField']);
          scope.initialValues = null;
          if (scope.tabField) {
            // Init the facet to use for tabs the first time
            // search is triggered
            scope.$watch('dimension', function(n, o) {
              if (n !== o && scope.dimension.length > 0) {
                angular.forEach(scope.dimension, function(value) {
                  if (value['@name'] === scope.tabField) {
                    if (scope.tabs == null) {
                      scope.initialValues = value.category;
                    } else {
                      angular.extend(value.category, scope.initialValues);
                    }
                    scope.tabs = value;
                    scope.categoryKey = scope.getLabel(scope.tabs);
                    angular.forEach(scope.tabs.category, function(c) {
                      c.isSelected = scope.activeTab === c;
                    });
                  }
                });
              }
            });


            scope.buildPath = function(category, $event) {
              return gnFacetConfigService.buildPath(scope.path, category);
            };

            scope.buildLabel = gnFacetConfigService.buildLabel;

            scope.filter = function(category, $event) {
              category.isSelected = !category.isSelected;
              if (category.isSelected) {
                scope.activeTab = category;
              } else {
                scope.activeTab = null;
              }
              angular.forEach(scope.tabs.category, function(c) {
                c.isSelected = scope.activeTab === c;
              });
              gnFacetConfigService.filter(scope, category, category.isSelected);
            };

            scope.isOnDrillDownPath = function(category, $event) {
              return gnFacetConfigService.isOnDrillDownPath(scope, category);
            };

            scope.isInFilter = function(category, $event) {
              return gnFacetConfigService.isInFilter(scope, category);
            };
          }

          scope.isDisplayed = function(facet) {
            if (hasOverridenConfig) {
              // Check if the facet should be displayed
              for (var i = 0; i < scope.facetList.length; i++) {
                var f = scope.facetList[i];
                if (facet['@name'] === f.key) {
                  var newLabel = f.labels && f.labels[gnLangs.getCurrent()];
                  if (newLabel) {
                    facet['@label'] = newLabel;
                  }
                  return true;
                }
              }
            } else {
              return true;
            }
            return false;
          };

          // Facet is collapsed if not in current search criteria
          scope.isFacetsCollapse = function(facetKey) {
            return !angular.isDefined(scope.params[facetKey]);
          };

          // Load facet configuration to know which index field
          // correspond to which dimension.
          gnFacetConfigService.loadConfig(scope.facetType).
              then(function(data) {
                scope.facetConfig = {
                  config: data,
                  map:  {}
                };

                angular.forEach(scope.facetConfig.config, function(key) {
                  scope.facetConfig.map[key.label] = key.name;
                });
              });
        }
      };
    }]);

  module.directive('gnFacetDimensionCategory', [
    'gnFacetConfigService', 'RecursionHelper', '$parse', '$timeout',
    function(gnFacetConfigService, RecursionHelper, $parse, $timeout) {
      return {
        restrict: 'A',
        templateUrl: function(elem, attrs) {
          return attrs.template || '../../catalog/components/search/facets/' +
              'partials/dimension-facet-category.html';
        },
        scope: {
          category: '=gnFacetDimensionCategory',
          categoryKey: '=',
          path: '=',
          params: '=',
          facetConfig: '='
        },
        compile: function(element) {
          // Use the compile function from the RecursionHelper,
          // And return the linking function(s) which it returns
          return RecursionHelper.compile(element,
              function(scope, element, attrs) {
                var initialMaxItems = 5;
                scope.initialMaxItems = initialMaxItems;
                scope.maxItems = initialMaxItems;
                scope.toggleAll = function() {
                  scope.maxItems = (scope.maxItems == Infinity) ?
                      initialMaxItems : Infinity;
                };

                // scope.$watch('category', function (n, o) {
                //   // if (o !== n) {
                //     $timeout(function() {
                //       scope.toggleAllNode();
                //     }, 200);
                //   // }
                // });

                // Facet drill down is based on facet.q parameter.
                // The facet.q parameter contains a list of comma separated
                // dimensions
                // <dimension_name>{"/"<category_value>}
                // Note that drill down paths use '/' as the separator
                // between categories in the path, so embedded '/' characters
                // in categories should be escaped using %2F or alternatively,
                // each category in the path url encoded in addition to
                // normal parameter encoding.
                //
                // Multiple drill down queries can be specified by providing
                // multiple facet.q parameters or by combining drill down
                // queries in one facet.q parameter using '&'
                // appropriately encoded.
                //
                // http://localhost:8080/geonetwork/srv/fre/q?
                // resultType=hierarchy&
                // facet.q=gemetKeyword/http%253A%252F%252Fwww.eionet.europa.eu
                //  %252Fgemet%252Fconcept%252F2643
                //  %2F
                //  http%253A%252F%252Fwww.eionet.europa.eu
                //    %252Fgemet%252Fconcept%252F2641

                scope.buildPath = function(category, $event) {
                  return gnFacetConfigService.buildPath(scope.path, category);
                };

                scope.buildLabel = gnFacetConfigService.buildLabel;

                scope.filter = function(category, $event) {
                  var checked = $event.currentTarget.checked;
                  gnFacetConfigService.filter(scope, category, checked);
                  $event.preventDefault();
                };

                scope.isOnDrillDownPath = function(category) {
                  return gnFacetConfigService
                  .isOnDrillDownPath(scope, category);
                };

                scope.isInFilter = function(category) {
                  return gnFacetConfigService.isInFilter(scope, category);
                };

                scope.toggleNode = function(evt) {
                  el = evt ?
                      $(evt.currentTarget).parent().parent() :
                      element.find('span.fa');
                  el.find('.fa').first()
                  .toggleClass('fa-minus-square')
                  .toggleClass('fa-plus-square');
                  el.children('div').toggleClass('hidden');
                  !evt || evt.preventDefault();
                  return false;
                };

                scope.toggleAllNode = function(evt) {
                  el = evt ?
                  $(evt.currentTarget).parent().parent() :
                  element.find('span.fa');
                  var isExpanded = undefined;
                  el.find('.fa').each(function(idx, e) {
                    e = $(e);
                    if (angular.isUndefined(isExpanded)) {
                      isExpanded = !e.hasClass('fa-plus-square');
                    }
                    e.removeClass(isExpanded ?
                    'fa-minus-square' : 'fa-plus-square');
                    e.addClass(isExpanded ?
                    'fa-plus-square' : 'fa-minus-square');
                  });
                  el.find('div[data-gn-facet-dimension-category]')
                  .each(function(idx, e) {
                    if (isExpanded) {
                      $(e).addClass('hidden');
                    } else {
                      $(e).removeClass('hidden');
                    }
                  });
                  !evt || evt.preventDefault();
                  return false;
                };
              });
        }
      };
    }]);
})();
