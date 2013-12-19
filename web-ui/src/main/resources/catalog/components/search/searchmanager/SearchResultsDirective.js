(function() {
  goog.provide('gn_search_form_results_directive');

  var module = angular.module('gn_search_form_results_directive', []);

  module.directive('gnSearchFormResults', [
    function() {

      var activeClass = 'active';

      return {
        restrict: 'A',
        replace: true,
        templateUrl: '../../catalog/components/search/searchmanager/partials/' +
            'searchresults.html',
        scope: {
          searchResults: '=',
          paginationInfo: '=paginationInfo',
          selection: '=selectRecords'
        },
        link: function(scope, element, attrs) {

          // get init options
          scope.options = {};
          jQuery.extend(scope.options, {
            mode: attrs.gnSearchFormResultsMode,
            selection: {
              mode: attrs.gnSearchFormResultsSelectionMode
            }
          });

          // Manage selection
          if (scope.options.selection) {
            scope.selection = [];
            if (scope.options.selection.mode.indexOf('local') >= 0) {

              /**
               * Define local select function
               * Manage an array scope.selection containing
               * all selected MD
               */
              scope.select = function(md) {
                if (scope.options.selection.mode.indexOf('multiple') >= 0) {
                  if (scope.selection.indexOf(md) < 0) {
                    scope.selection.push(md);
                  }
                  else {
                    scope.selection.splice(scope.selection.indexOf(md), 1);
                  }
                }
                else {
                  scope.selection.pop();
                  scope.selection.push(md);
                }
              };
            }
          }

          // Event on new search result
          // compute page number for pagination
          scope.$watchCollection('searchResults.records', function() {
            if (scope.searchResults.records.length > 0) {
              scope.paginationInfo.pages = Math.ceil(
                  scope.searchResults.count /
                  scope.paginationInfo.hitsPerPage, 0);
            }
          });

          // Default settings for pagination
          // TODO: put parameters in directive
          scope.paginationInfo = {
            pages: -1,
            currentPage: 1,
            hitsPerPage: 2
          };
        }
      };
    }]);
})();
