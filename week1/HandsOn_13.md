In this hands on, we are going to separate out the header and footer and put the code into separate files that will be included.

**Tags Used**: [\<cfinclude>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfinclude.html), [\<cfparam>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfparam.html), [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html)

1. Create a folder called `includes` in the `www` folder.
1. Create a new file in `/www/includes/` called `header.cfm`.
1. Create a new file in `/www/includes/` called `footer.cfm`.
1. Open up the `/www/about.cfm` file in your code editor.
1. Copy all lines from `<!DOCTYPE`, on line 2, down to and including the `<!--header end -->` line, on line 76.
1. Paste these lines of code into the `header.cfm` file.
1. Delete these lines from `/www/about.cfm`.
1. Copy all lines from below the `about end` comment.
1. Paste these lines of code into `footer.cfm`.
1. Delete these lines from `/www/about.cfm`.
1. In a browser, navigate to the `/www/about.cfm` page. Notice that it no longer looks correct.
1. Go back to the `/www/about.cfm` file in your code editor.
1. At the top of the file, just below your `<cffunction>` tag block on or around line 11 and create a new tag called `<cfinclude>` with the following attribute:
    *   **template**: includes/header.cfm
1. Go to the bottom of the file and create a `<cfinclude>` tag with the following attribute:
    *   **template**: includes/footer.cfm
1. Go back to your browser and refresh the `about.cfm` file. You should now see the page as it used to be.
1. Open up the `/www/includes/header.cfm` file in your code editor.
1. At the top of the page, create a `<cfparam>` tag with the following attributes:
    *   **name**: section
    *   **default**: home
1. Locate the link to the homepage in the navigation, which should be on or around line 51.
1. Inside the `<li>` tag, add the following line of code:

    ```cfml
    <cfif section eq "home">id="selected"</cfif>
    ```

1. Do the same for the other links in the navigation, but instead of checking if `section eq "home"`, replace home with the value of the `<li>` class.
1. Once completed your code should look similar to this:

    ```cfml
    <ul class="arrowunderline" id="nav">
        <li class="home" <cfif section eq "home">id="selected"</cfif>><a href="index.cfm">Home</a></li>
        <li class="about" <cfif section eq "about">id="selected"</cfif>><a href="about.cfm">About</a></li>
        <li class="resume" <cfif section eq "resume">id="selected"</cfif>><a href="resume.cfm">Resume</a></li>
        <li class="blog" <cfif section eq "blog">id="selected"</cfif>><a href="blog.cfm">Blog</a></li>
        <li class="portfolio" <cfif section eq "portfolio">id="selected"</cfif>><a href="portfolio.cfm">Portfolio</a></li>
        <li class="contact" <cfif section eq "contact">id="selected"</cfif>><a href="contact.cfm">Contact</a></li>
    </ul>
    ```

1. Refresh the `/www/about.cfm` page in your browser. You will notice that the navigation is currently highlighting the 'Home' navigation item rather than the 'About' navigation item. This is because we have not set the Section variable on the `about.cfm` page.
1. Open up the `/www/about.cfm` in your code editor and locate the `<cfinclude>` tag which includes the header. This should be on or around line 12.
1. Before the `<cfinclude>` tag, create a `<cfset>` tag and set the value of `About` to a variable called `Section`. Your code should look similar to this:

    ```cfml
    <cfset section = "About">
    ```

1. In your browser, refresh the `/www/about.cfm` page and notice that the 'About' navigation item is now highlighted.

Home Work
---------

Update all other pages in the site so that they use the included header and footer rather than the inline code.
