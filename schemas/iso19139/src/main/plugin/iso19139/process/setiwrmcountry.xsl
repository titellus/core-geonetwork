<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common" xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gml="http://www.opengis.net/gml#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                version="2.0" exclude-result-prefixes="#all">

  <xsl:output indent="yes"/>

  <xsl:variable name="places"
                select="document(concat('file:///', replace(util:getConfigValue('codeListDir'), '\\', '/'), '/external/thesauri/place/IWRM-country-basin.rdf')"/>
 <!--<xsl:variable name="places"
                select="document('/data/dev/gn/oieau/web/src/main/webapp/WEB-INF/data/config/codelist/external/thesauri/place/IWRM-country-basin.rdf')"/>
-->

  <xsl:variable name="hasIwrmPlaces"
                select="count(//gmd:descriptiveKeywords[
                          not(*/gmd:thesaurusName)
                          and */gmd:keyword/*/lower-case(.) = $places//skos:Concept/skos:prefLabel/lower-case(.)]) > 0"/>


  <!-- Map all keywords to new value.
      If no new value define, current value is used. -->
  <xsl:template match="gmd:descriptiveKeywords[
                          not(*/gmd:thesaurusName)
                          and */gmd:keyword/*/lower-case(.) = $places//skos:Concept/skos:prefLabel/lower-case(.)]"
                priority="200">

    <gmd:descriptiveKeywords>
      <gmd:MD_Keywords>
        <xsl:for-each select=".//gmd:keyword/gco:CharacterString">
          <xsl:variable name="keyword"
                        select="."/>
          <xsl:variable name="iwrmPlace"
                        select="$places//skos:Concept/skos:prefLabel[lower-case(.) = lower-case($keyword)]"/>
          <xsl:if test="$iwrmPlace != ''">
            <gmd:keyword>
              <gco:CharacterString>
                <xsl:value-of select="$iwrmPlace"/>
              </gco:CharacterString>
            </gmd:keyword>
          </xsl:if>
        </xsl:for-each>
        <gmd:type>
          <gmd:MD_KeywordTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#MD_KeywordTypeCode"
                                  codeListValue="place"/>
        </gmd:type>
        <gmd:thesaurusName>
          <gmd:CI_Citation>
            <gmd:title>
              <gco:CharacterString>IWRM Country Basin</gco:CharacterString>
            </gmd:title>
            <gmd:date>
              <gmd:CI_Date>
                <gmd:date>
                  <gco:Date>0017-11-07</gco:Date>
                </gmd:date>
                <gmd:dateType>
                  <gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#CI_DateTypeCode"
                                       codeListValue="publication"/>
                </gmd:dateType>
              </gmd:CI_Date>
            </gmd:date>
            <gmd:identifier>
              <gmd:MD_Identifier>
                <gmd:code>
                  <gmx:Anchor xmlns:gmx="http://www.isotc211.org/2005/gmx"
                              xmlns:xlink="http://www.w3.org/1999/xlink"
                              xlink:href="http://localhost:8080/geonetwork/srv/eng/thesaurus.download?ref=external.place.IWRM-country-basin">geonetwork.thesaurus.external.place.IWRM-country-basin</gmx:Anchor>
                </gmd:code>
              </gmd:MD_Identifier>
            </gmd:identifier>
          </gmd:CI_Citation>
        </gmd:thesaurusName>
      </gmd:MD_Keywords>
    </gmd:descriptiveKeywords>

  </xsl:template>


  <xsl:template match="gmd:extent[$hasIwrmPlaces and */gmd:geographicElement]">
    <xsl:variable name="keywords"
                  select="../gmd:descriptiveKeywords[
                          not(*/gmd:thesaurusName)
                          and */gmd:keyword/*/lower-case(.) = $places//skos:Concept/skos:prefLabel/lower-case(.)]/*/gmd:keyword/gco:CharacterString/lower-case(.)"/>

    <xsl:for-each select="$places//skos:Concept[skos:prefLabel/lower-case(.) = $keywords]">
      <gmd:extent>
        <gmd:EX_Extent>
          <gmd:geographicElement>
            <gmd:EX_GeographicBoundingBox>
              <gmd:westBoundLongitude>
                <gco:Decimal>
                  <xsl:value-of select="tokenize(gml:BoundedBy/gml:Envelope/gml:lowerCorner, ' ')[1]"/>
                </gco:Decimal>
              </gmd:westBoundLongitude>
              <gmd:eastBoundLongitude>
                <gco:Decimal>
                  <xsl:value-of select="tokenize(gml:BoundedBy/gml:Envelope/gml:upperCorner, ' ')[1]"/>
                </gco:Decimal>
              </gmd:eastBoundLongitude>
              <gmd:southBoundLatitude>
                <gco:Decimal>
                  <xsl:value-of select="tokenize(gml:BoundedBy/gml:Envelope/gml:lowerCorner, ' ')[2]"/>
                </gco:Decimal>
              </gmd:southBoundLatitude>
              <gmd:northBoundLatitude>
                <gco:Decimal>
                  <xsl:value-of select="tokenize(gml:BoundedBy/gml:Envelope/gml:upperCorner, ' ')[2]"/>
                </gco:Decimal>
              </gmd:northBoundLatitude>
            </gmd:EX_GeographicBoundingBox>
          </gmd:geographicElement>
        </gmd:EX_Extent>
      </gmd:extent>
    </xsl:for-each>
  </xsl:template>


  <!-- Do a copy of every nodes and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>

</xsl:stylesheet>
