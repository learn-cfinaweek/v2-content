In the first part of this hands on we are going to convert some pages to .cfm pages. We will then add some variables and output them to the user. Finally, we will add a comment to our code.

**Tags Used**: [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html)

1. Rename the `/www/index.html` file to `index.cfm`.
1. Confirm that the ColdFusion page displays by going to `/www/index.cfm` in your browser.
1. Open up the `/www/index.cfm` file in your code editor.
1. First, let's create some variables that we will display later on in the page. On line 1, write a `<cfset>` tag that sets the variable `myName` with a value of your name. The tag should look something like this:

    ```cfml
    <cfset myName="Simon">
    ```

1. On the next line, create another variable called `myPosition` with a value of 'Developer'. The tag should look something like:

    ```cfml
    <cfset myPosition="Developer">
    ```

1. Now, let's output these variables. Locate the text \[Name\] on or around line 80. Replace \[Name\] with `#myName#`.
1. Locate the text \[position\] on or around line 81. Replace \[position\] with `#myPosition#`.
1. Refresh the page in your browser and confirm that you now see #myName# and #myPosition# displayed.
1. In your code editor, locate the `#myName#` variable on or around line 80 and place a `<cfoutput>` tag before it and a `</cfoutput>` tag after it so that the code looks similar to this:

    ```cfml
    <cfoutput>#myName#</cfoutput>
    ```

1. Do the same for the `myPosition` variable on or around line 81.
1. Refresh the browser and confirm that you now see your name and position displayed on the page.
1. Go to line 2 and update the variable `myPosition` so that it has a value of 'A Developer'. The tag should look similar to this:

    ```cfml
    <cfset myPosition="A Developer">
    ```

1. Refresh the browser and confirm that you see your change.
1. In your code editor, locate the comment that says `Data Output`. Add a new line after this tag and write the following text: "This is where the name and position are output".
1. Refresh the browser and confirm that you see this text displayed on the page.
1. Go back to your code editor and add ColdFusion comments around the line of text so that it looks similar to this:

    ```cfml
    <!\-\-\- This is where the name and position are output --->
    ```

1. Refresh the browser and confirm that the text is no longer visible on the page.
1. In your code editor, locate the link to `index.html` on or around line 52. Change the link so that it points to `index.cfm`.
1. Now let's update some of the links to point to the new .cfm pages. Locate the link to `about.html` on or around line 53 and change it to point to `about.cfm`.
1. Rename the `/www/about.html` file to `about.cfm`.
1. Refresh your browser and click on the about link at the top of the page.
1. Confirm that the about page loads.
