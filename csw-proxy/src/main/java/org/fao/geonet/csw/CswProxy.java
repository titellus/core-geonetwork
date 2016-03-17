/**
 * Copyright (C) 2001-2016 Food and Agriculture Organization of the
United Nations (FAO-UN), United Nations World Food Programme (WFP)
and United Nations Environment Programme (UNEP)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
Rome - Italy. email: geonetwork@osgeo.org
 */
package org.fao.geonet.csw;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;
import java.nio.file.Path;

import org.apache.commons.lang.NotImplementedException;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.kernel.SchemaManager;
import org.fao.geonet.services.metadata.format.Format;
import org.fao.geonet.services.metadata.format.FormatType;
import org.fao.geonet.services.metadata.format.FormatterWidth;
import org.fao.geonet.utils.Xml;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.NativeWebRequest;

import jeeves.server.context.ServiceContext;

/**
 * CSW proxy to be able to transform external metadata on the fly
 * 
 * @author delawen
 * 
 * 
 */

@Controller("csw-proxy")
public class CswProxy {
    
    @Autowired
    private Format formatter;
    
    @Autowired 
    private SchemaManager sm;

    @RequestMapping(value = "/{lang}/csw-proxy", produces = {
            MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
    public @ResponseBody String doProxy(String format, String url, 
            final NativeWebRequest nativeRequest)
            throws Exception {
        String res = "";

        URL original = new URL(
                url + "&outputSchema=http://www.isotc211.org/2005/gmd");
        BufferedReader in = new BufferedReader(
                new InputStreamReader(original.openStream()));

        StringBuilder sb = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            sb.append(inputLine);
        }
        in.close();

        res = sb.toString();

        // Convert to format
        switch (format) {
        case "rdf/xml":
        case "application/rdf+xml":
            res = convertToRdf(res, original);
            break;
        case "html":
            throw new NotImplementedException("Format not recognized");
        case "dublincore":
            throw new NotImplementedException("Format not recognized");
        case "pdf":
        case "application/pdf":
            res = convertToPdf(res, nativeRequest);
        case "json-ld":
            throw new NotImplementedException("Format not recognized");
        default:
            throw new NotImplementedException("Format not recognized");
        }

        return res;
    }

    /**
     * @param res
     * @param original
     * @return
     * @throws Exception 
     */
    private String convertToPdf(String res, NativeWebRequest request) throws Exception {
        final ServiceContext context = ServiceContext.get();
        SAXBuilder sax = new SAXBuilder();
        Document doc = sax.build(new StringReader(res));
        Element e = (Element) doc.getRootElement().getChildren().get(0);
        e.detach();
        String schema = sm.autodetectSchema(e);
        
        FormatterWidth width = FormatterWidth._100;
        
        formatter.execXml(context.getLanguage(), FormatType.pdf.name(),
                "full_view", res, null, schema, width, null, request);
        return "";
    }

    /**
     * 
     * <output sheet="../xslt/services/dcat/rdf.xsl" contentType=
     * "application/rdf+xml; charset=UTF-8" > <call name="relation" class=
     * ".guiservices.metadata.GetRelated"/> <call name="isoLang" class=
     * ".guiservices.isolanguages.Get"/> <call name= "thesaurus" class=
     * ".services.thesaurus.GetList"/> <call name="clear" class=
     * ".services.metadata.ClearCachedShowMetadata"/> </output>
     * 
     * @param md
     * @return
     * @throws Exception
     */
    private String convertToRdf(String md, URL url) throws Exception {

        final ServiceContext context = ServiceContext.get();

        Path xslPath = context.getAppPath().resolve(Geonet.Path.XSLT_FOLDER)
                .resolve("services").resolve("dcat").resolve("rdf.xsl");

        Element record = transform(md, url, context, xslPath);

        return (new XMLOutputter()).outputString(record);
    }

    private Element transform(String md, URL url, final ServiceContext context,
            Path xslPath) throws JDOMException, IOException, Exception {
        SAXBuilder sax = new SAXBuilder();
        Document doc = sax.build(new StringReader(md));

        Element e = (Element) doc.getRootElement().getChildren().get(0);
        e.detach();

        // Create environment manually to be used when defining the catalog
        Element modelEl = new Element("root");

        Element serverEl = new Element("server");
        int port = url.getPort();
        if(port < 0) {
            port = 80;
        }
        serverEl.addContent(
                new Element("port").setText(Integer.toString(port)));
        serverEl.addContent(new Element("host").setText(url.getHost()));
        serverEl.addContent(new Element("protocol").setText(url.getProtocol()));

        Element siteEl = new Element("site");
        siteEl.addContent(new Element("name").setText(""));
        siteEl.addContent(new Element("organization").setText(""));

        Element guiEl = new Element("gui");
        Element systemConfigEl = new Element("systemConfig");
        Element systemEl = new Element("system");
        systemEl.addContent(serverEl);
        systemEl.addContent(siteEl);

        systemConfigEl.addContent(systemEl);

        guiEl.addContent(systemConfigEl);
        guiEl.addContent(
                new Element("language").setText(context.getLanguage()));
        guiEl.addContent(new Element("url").setText(url.getProtocol() + "://"
                + url.getHost() + ":" + port + url.getPath()));

        modelEl.addContent(guiEl);

        modelEl.addContent(e);

        Element record = Xml.transform(modelEl, xslPath);
        return record;
    }

    public Format getFormatter() {
        return formatter;
    }

    public void setFormatter(Format formatter) {
        this.formatter = formatter;
    }
}
