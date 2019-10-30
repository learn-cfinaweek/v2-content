In this hands on, you are going to add caching to the blog and to the portfolio sections.

**Tags Used**: [\<cfcache>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-c/cfcache.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html)

**Functions Used**: [sleep](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/sleep.html), [cacheGet](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/CacheGet.html), [isNull](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-in-k/isnull.html), [cachePut](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/CachePut.html)

1. Before you add caching, turn on the debugging information of the page so that the changes we are about to make can be detected. Login to your ColdFusion administrator. The ColdFusion Administrator will be located at [http://localhost:8500/CFIDE/administrator/](http://localhost:8500/CFIDE/administrator/).
1. Once logged in, go to 'Debugging Output Settings' under Debugging & Logging.
1. Check the 'Enable Request Debugging Output' option and click 'Submit Changes'.
1. Open up the `/www/blog.cfm` page in your browser.
1. Scroll to the bottom of the page and take note of the additional information being displayed.
1. Open up the `/www/blog.cfm` file in your code editor.
1. The first thing you need to do is create a `<cfcache>` tag. Locate the `Blog Posts` comment and create a `<cfcache>` tag on the line below it with the following attributes:
    * **action**: cache
    * **timespan**: #createtimespan(0,1,0,0)#
1. Place the closing `</cfcahe>` tag after the closing `</cfoutput>` tag.
1. Reload the `/www/blog.cfm page` in your browser. Take note of the execution time.
1. Refresh the page again and take note of the execution time. If this were a larger page, you would have noticed a decrease in the execution time.
1. One problem right now is that even though the output is being cached, all blog posts are being pulled at the beginning of the page request. To rectify this, move the `<cfset>` located on line 1 so that it is inside the `<cfcache>` tag.
1. If you were to run the page now, the output would still be cached as the cache will not expire for an hour. To clear the cache, call the `<cfcache>` tag with an action value of flush. Create a new page in the `/www/` folder and call it `clearCache.cfm`.
1. Create a `<cfcache>` tag with the following attribute:
    * **action**: flush
1. In your browser, go to the `/www/clearcache.cfm` page. You will not see any output but the cache is now cleared.
1. Go back to the `/www/blog.cfm` page in your browser and refresh. Take note of the execution time.
1. Refresh the page again and compare the two execution times. If the page took long enough to run, you will see an improvement in the execution times.
1. To make the differences more visible, let's slow down the page load. Right after the opening `<cfcache>` tag, add the following line of code:

    ```cfml
    <cfset sleep( 500 )>
    ```

1. The line of code you added will have ColdFusion wait for 500 milliseconds before it continues. Before testing this functionality, go back to the `clearcache.cfm` file in your browser and reload the page.
1. Now that the cache is cleared, go back to the `blog.cfm` file in your browser and reload it. Take note of the execution time.
1. Refresh the `blog.cfm` page and review the execution time. You will notice that the execution time is drastically different. This is because the cached content is being called, rather than processing the block of code.
1. Remove the sleep tag we just entered.
1. Now that the `<cfcache>` tag is in place, lets look at some programmatic caching. Open up the `/www/portfolio.cfm` file in your code editor.
1. At the top of the page you should have a `<cfquery>` tag. Prior to this, create the following `<cfset>` tag:

    ```cfml
    <cfset myPortfolio = cacheGet( 'myPortfolio' )>
    ```

1. The `cacheGet` function pulls the cache from memory that has the identifier of `myPortfolio`. Right now, there is nothing cached with that identifier. First check if anything was returned; if not, you need to execute the code and store the result in cache. After the `<cfset>` tag, create a `<cfif>` tag, which will check if the `myPortfolio` variable is null. The code should look similar to this:

    ```cfml
    <cfif isNull( myPortfolio )>

    </cfif>
    ```

1. Move the `<cfquery>` that was already in the file inside the `<cfif>` tag.
1. After the query, create a `<cfset>` tag that calls the `cachePut` function, passing in the string 'myPortfolio' as well as the query object called `myPortfolio`. The resulting code block should look similar to this:

    ```cfml
    <cfset myPortfolio = cacheGet( 'myPortfolio' )>
    <cfif isNull( myPortfolio )>
        <cfquery name="myPortfolio">
            SELECT
                id,
                title,
                summary,
                website,
                image
            FROM
                portfolio
        </cfquery>
        <cfset cachePut( 'myPortfolio', myportFolio )>
    </cfif>
    ```

1. The `myPortfolio` query will now get cached if it is not already in cache. Run the page a few times and compare the execution times. If you want to clear the cache, reload the `/www/clearCache.cfm` page.
