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
                version="2.0" exclude-result-prefixes="exslt">

  <xsl:output indent="yes"/>

  <xsl:variable name="map">
    <entry>
      <keyword>environment</keyword>
      <iwrmtheme>Environmental context</iwrmtheme>
    </entry>
    <entry>
      <keyword>biota</keyword>
      <iwrmtheme>Environmental context</iwrmtheme>
    </entry>
    <entry>
      <keyword>transportation</keyword>
      <iwrmtheme>Environmental context</iwrmtheme>
    </entry>
    <entry>
      <keyword>farming</keyword>
      <iwrmtheme>Environmental context</iwrmtheme>
    </entry>
    <entry>
      <keyword>farming</keyword>
      <iwrmtheme>Risk</iwrmtheme>
    </entry>
    <entry>
      <keyword>elevation</keyword>
      <iwrmtheme>Environmental context</iwrmtheme>
    </entry>
    <entry>
      <keyword>boundaries</keyword>
      <iwrmtheme>Administrative context</iwrmtheme>
    </entry>
    <entry>
      <keyword>location</keyword>
      <iwrmtheme>Administrative context</iwrmtheme>
    </entry>
    <entry>
      <keyword>inlandWaters</keyword>
      <iwrmtheme>Surface water
      </iwrmtheme>
    </entry>
  </xsl:variable>

  <!-- Map all keywords to new value.
      If no new value define, current value is used. -->
  <xsl:template match="gmd:descriptiveKeywords" priority="2">
    <xsl:copy-of select="."/>
    <xsl:if test="following-sibling::*/name() != 'gmd:descriptiveKeywords'">
      <gmd:descriptiveKeywords>
        <gmd:MD_Keywords>
          <xsl:for-each select="..//gmd:topicCategory/gmd:MD_TopicCategoryCode">
            <xsl:variable name="keyword"
                          select="."/>
            <xsl:variable name="iwrmtheme"
                          select="$map//entry[keyword = $keyword]/iwrmtheme"/>
            <xsl:if test="$iwrmtheme != ''">
              <gmd:keyword>
                <gco:CharacterString>
                  <xsl:value-of select="$iwrmtheme"/>
                </gco:CharacterString>
              </gmd:keyword>
            </xsl:if>
          </xsl:for-each>
          <gmd:type>
            <gmd:MD_KeywordTypeCode codeList="http://www.isotc211.org/2005/resources/codeList.xml#MD_KeywordTypeCode"
                                    codeListValue="theme"/>
          </gmd:type>
          <gmd:thesaurusName>
            <gmd:CI_Citation>
              <gmd:title>
                <gco:CharacterString>IWRM themes</gco:CharacterString>
              </gmd:title>
              <gmd:date>
                <gmd:CI_Date>
                  <gmd:date>
                    <gco:Date>2017-05-11</gco:Date>
                  </gmd:date>
                  <gmd:dateType>
                    <gmd:CI_DateTypeCode
                      codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#CI_DateTypeCode"
                      codeListValue="publication"/>
                  </gmd:dateType>
                </gmd:CI_Date>
              </gmd:date>
              <gmd:identifier>
                <gmd:MD_Identifier>
                  <gmd:code>
                    <gmx:Anchor xmlns:xlink="http://www.w3.org/1999/xlink"
                                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                                xlink:href="http://193.70.117.229/cat_ec/srv/eng/thesaurus.download?ref=external.theme.IWRM-theme">
                      geonetwork.thesaurus.external.theme.IWRM-theme
                    </gmx:Anchor>
                  </gmd:code>
                </gmd:MD_Identifier>
              </gmd:identifier>
            </gmd:CI_Citation>
          </gmd:thesaurusName>
        </gmd:MD_Keywords>
      </gmd:descriptiveKeywords>
    </xsl:if>
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
