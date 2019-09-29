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
<cffile action="write" file="#expandPath('./sitemap.xml')#" output="#toString(xmlSiteMap)#" />
<p>
	File Created!
</p>