In this hands on, we will create a more complex loop that uses an array of structures.

**Tags Used**: [\<cfscript>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfscript.html), [\<cfloop>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html)

**Functions Used**: [arrayAppend](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-a-b/arrayappend.html)

1. Open the `/www/portfolio.cfm` file in your code editor.
1. At the top of the file, create open and closing `<cfscript>` tags.
1. Inside the `<cfscript>` tags create a variable `myPortfolio` and instantiate an empty array.
1. Your code should look similar to this:

    ```cfml
    <cfscript>
        myPortfolio = [];
    </cfscript>
    ```

1. Once you have an empty array, you need to populate it with some data. Below the variable declaration, write the following line of code:

    ```cfml
    arrayAppend( myPortfolio, { title='', website='', image='', description='' } );
    ```

1. Add this line 2 more times.
1. Provide information for all 3 structures. Your code should look similar to this:

    ```cfml
    <cfscript>
        myPortfolio = [];
        arrayAppend( myPortfolio, { title='Title 1', website='http://www.website1.com', image='portfolio1.png', description='Description 1' } );
        arrayAppend( myPortfolio, { title='Title 2', website='http://www.website2.com', image='portfolio2.png', description='Description 2' } );
        arrayAppend( myPortfolio, { title='Title 3', website='http://www.website3.com', image='portfolio3.png', description='Description 3' } );
    </cfscript>
    ```

1. Go to the comment `Start Portfolio`.
1. Once the array has been populated you can loop over it and output its data. Below the comment, create a `<cfloop>` tag with the following attributes:
    * **array**: #myPortfolio#
    * **index**: portfolio
1. Add a closing `</cfloop>` tag after the first closing `</li>` tag.
1. Replace the value of the `href` attribute with `#portfolio.website#`.
1. Replace the value of the `title` attribute with `#portfolio.title#`.
1. Replace the `src` attribute of the `<img>` tag with `assets/images/portfolio/#portfolio.image#`.
1. Replace the contents of the `<h5>` tag with `#portfolio.title#`.
1. Replace the contents of the `<p>` tag with `#portfolio.description#`.
1. Delete the remaining 2 `<li>` tags that are outside of the `<cfloop>`.
1. Wrap the `<cfloop>` tag with an opening and closing `<cfoutput>` tag.
1. Your code should look similar to this:

    ```cfml
    <ul id="portfolio-list">
        <!\-\- Start Portfolio -->
        <cfoutput>
            <cfloop array="#myPortfolio#" index="portfolio">
                <li>

                    <div class="left">
                        <a href="#portfolio.website#" title="#portfolio.title#" class="viewDetail ">
                            <img src="images/assets/small/#portfolio.image#" alt=" " border="0">
                            <h5>#portfolio.title#</h5>
                        </a>
                    </div>
                    <div class="right">
                        <p>
                            #portfolio.description#
                        </p>
                    </div>
                </li>
            </cfloop>
        </cfoutput>
    </ul>
    ```

1. Load the `/www/portfolio.cfm` page in your browser; notice that the contents from the struct is being displayed.

Homework
--------

1. Update the contents of the structs with more relevant information.
2. Add 2 new portfolio items.
