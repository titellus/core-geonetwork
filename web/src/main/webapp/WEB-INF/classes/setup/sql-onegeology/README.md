# OneGeology

## migration to version 4

* Stop previous version
* Dump database
* Restore dump in new one (if needed)
* Apply [SQL migration script](migrate-4.1.0.sql)
* Start new version, sign in
* http://localhost:8080/geonetwork/doc/api/index.html#/tools/callStep and apply
  step `org.fao.geonet.MetadataResourceDatabaseMigration`

## Query test

* All

```xml

<csw:GetRecords xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" service="CSW" version="2.0.2" resultType="results"
                maxRecords="1000" startPosition="1">
  <csw:Query typeNames="csw:Record">
    <csw:ElementSetName>full</csw:ElementSetName>
    <csw:Constraint version="1.1.0">
      <Filter xmlns="http://www.opengis.net/ogc">
        <And>
          <PropertyIsEqualTo>
            <PropertyName>dc:type</PropertyName>
            <Literal>dataset</Literal>
          </PropertyIsEqualTo>
          <PropertyIsLike matchCase="false" escapeChar="\" singleChar="?" wildCard="*">
            <PropertyName>AnyText</PropertyName>
            <Literal></Literal>
          </PropertyIsLike>
        </And>
      </Filter>
    </csw:Constraint>
  </csw:Query>
</csw:GetRecords>
```
Replace by
```xml
  <PropertyName>AnyText</PropertyName>
  <Literal>*</Literal>
```


* Full text + extent

```xml
<csw:GetRecords xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" service="CSW" version="2.0.2" resultType="results"
                maxRecords="1000" startPosition="1">
  <csw:Query typeNames="csw:Record">
    <csw:ElementSetName>full</csw:ElementSetName>
    <csw:Constraint version="1.1.0">
      <Filter xmlns="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
        <And>
          <PropertyIsEqualTo>
            <PropertyName>dc:type</PropertyName>
            <Literal>dataset</Literal>
          </PropertyIsEqualTo>
          <PropertyIsLike matchCase="false" escapeChar="\" singleChar="?" wildCard="*">
            <PropertyName>AnyText</PropertyName>
            <Literal>lithology</Literal>
          </PropertyIsLike>
          <BBOX>
            <PropertyName>ows:BoundingBox</PropertyName>
            <gml:Envelope>
              <gml:lowerCorner>-11.030921584182721 -43.104997192588435</gml:lowerCorner>
              <gml:upperCorner>90.03589481110083 43.104997192588435</gml:upperCorner>
            </gml:Envelope>
          </BBOX>
          <PropertyIsLike matchCase='false' wildCard="%" singleChar='_' escapeChar='\'>
            <PropertyName>Subject</PropertyName>
            <Literal>serviceprovider@Council for Geoscience</Literal>
          </PropertyIsLike>
        </And>
      </Filter>
    </csw:Constraint>
  </csw:Query>
</csw:GetRecords>
```

Add `gml` namespace to Envelope and Corners:
```
    <ows:ExceptionText>java.lang.IllegalArgumentException: cvc-complex-type.2.4.a: Invalid content was found starting with element '{"http://www.opengis.net/ogc":Envelope}'. One of '{"http://www.opengis.net/gml":Envelope}' is expected.</ows:ExceptionText>
```

Replace `keyword` by `Subject` (which is a CSW queryable; `keyword` was only a GN Lucene field which is now `tag.default`).



```xml
* Advanced search
<csw:GetRecords xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" service="CSW" version="2.0.2" resultType="results"
                maxRecords="1000" startPosition="1">
  <csw:Query typeNames="csw:Record">
    <csw:ElementSetName>full</csw:ElementSetName>
    <csw:Constraint version="1.1.0">
      <Filter xmlns="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
        <And>
          <PropertyIsEqualTo>
            <PropertyName>dc:type</PropertyName>
            <Literal>dataset</Literal>
          </PropertyIsEqualTo>
          <PropertyIsLike matchCase="false" escapeChar="\" singleChar="?" wildCard="*">
            <PropertyName>AnyText</PropertyName>
            <Literal></Literal>
          </PropertyIsLike>
          <PropertyIsLike matchCase='false' wildCard="%" singleChar='_' escapeChar='\'>
            <PropertyName>Subject</PropertyName>
            <Literal>thematic@Bedrock</Literal>
          </PropertyIsLike>
          <Or>
            <PropertyIsLike escapeChar='' singleChar='?' wildCard='*'>
              <PropertyName>Anytext</PropertyName>
              <Literal>*portrayal_age_or_litho_queryable*</Literal>
            </PropertyIsLike>
          </Or>
        </And>
      </Filter>
    </csw:Constraint>
  </csw:Query>
</csw:GetRecords>
```

Invalid query:
```
    <ows:ExceptionText>java.lang.IllegalArgumentException: cvc-complex-type.2.4.b: The content of element 'Or' is not complete. One of '{"http://www.opengis.net/ogc":comparisonOps, "http://www.opengis.net/ogc":spatialOps, "http://www.opengis.net/ogc":logicOps, "http://www.opengis.net/ogc":Function}' is expected.</ows:ExceptionText>
```

At least 2 clauses in `Or`.
