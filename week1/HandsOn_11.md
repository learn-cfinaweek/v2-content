In this hands on, we are going to generate an XML sitemap that is formatted for use with Google Sitemaps.

**Tags Used**: [\<cfxml>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-u-z/cfxml.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cffile>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-f/cffile.html)

**Functions Used**: [toString](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-t-z/tostring.html)

1. Create a new file in the `/www/` folder called `generateSitemap.cfm`.
1. On line 1, create an open <cfxml> tag and provide the following attribute:
    * **variable**: xmlSiteMap
1. After the opening <cfxml> tag enter the following code:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.google.com/schemas/sitemap/0.90">
    <url>
        <loc>http://www.myWebsite.com/</loc>
        <priority>0.5</priority>
    </url>
    <url>
        <loc>http://www.myWebsite.com/about.cfm</loc>
        <priority>0.5</priority>
    </url>
    <url>
        <loc>http://www.myWebsite.com/resume.cfm</loc>
        <priority>0.5</priority>
    </url>
    <url>
        <loc>http://www.myWebsite.com/portfolio.cfm</loc>
        <priority>0.5</priority>
    </url>
    <url>
        <loc>http://www.myWebsite.com/contact.cfm</loc>
        <priority>0.5</priority>
    </url>
    <url>
        <loc>http://www.myWebsite.com/blog.cfm</loc>
        <priority>0.5</priority>
    </url>
    </urlset>
    ```
1. After this code, enter a closing `</cfxml>` tag.
1. Your code should look similar to this:

    ```cfml
    <cfxml variable="xmlSitemap">
        <?xml version="1.0" encoding="UTF-8"?>
        <urlset xmlns="http://www.google.com/schemas/sitemap/0.90">
            <url>
                <loc>http://www.myWebsite.com/</loc>
                <priority>0.5</priority>
            </url>
            <url>
                <loc>http://www.myWebsite.com/about.cfm</loc>
                <priority>0.5</priority>
            </url>
            <url>
                <loc>http://www.myWebsite.com/resume.cfm</loc>
                <priority>0.5</priority>
            </url>
            <url>
                <loc>http://www.myWebsite.com/portfolio.cfm</loc>
                <priority>0.5</priority>
            </url>
            <url>
                <loc>http://www.myWebsite.com/contact.cfm</loc>
                <priority>0.5</priority>
            </url>
            <url>
                <loc>http://www.myWebsite.com/blog.cfm</loc>
                <priority>0.5</priority>
            </url>
        </urlset>
    </cfxml>
    ```

1. After the closing `</cfxml>` tag, create an open `<cfoutput>` tag.
1. On the line after the `<cfoutput>` tag, write `#toString( xmlSiteMap )#`.
1. After the toString line of code, write a closing `</cfoutput>` tag.
1. Open up a browser and navigate to `/www/generateSiteMap.cfm`.
1. View the source of the page and you will see the generated XML.
1. Return to your code editor and remove the `<cfoutput>` tags and their contents.
1. After the closing `</cfxml>` tag, create a `<cffile>` tag with the following attributes:
    * **action**: write
    * **file**: #expandPath( './sitemap.xml' )#
    * **output**: #toString( xmlSiteMap )#
1. Your code should look similar to this:

    ```cfml
    <cffile action="write" file="#expandpath( './sitemap.xml' )#" output="#toString( xmlSitemap )#">
    ```

1. After the `<cffile>` tag, create a `<p>` tag. Provide the text "File created!" and place a closing `</p>` tag after the line of text.
1. In your browser, reload the `/www/generateSiteMap.cfm` page and confirm that you see the message "File Created!"
1. Navigate to `/www/sitemap.xml` and confirm that the XML file was created and that all your XML nodes are displayed.
