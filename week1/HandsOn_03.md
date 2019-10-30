In this hands on, you are going to add some conditional logic to the site as well as create a form post.

**Tags Used**: [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html), [\<cfparam>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfparam.html)

1. Open up the `/www/contact.cfm` file in your code editor.
1. Locate the comment that reads Message Output.
1. Below the comment, create a `<cfif>` statement that checks if the `form.submitted` variable is true. Your code should look something like this:

    ```cfml
    <cfif form.submitted>

    </cfif>
    ```

1. Inside the `<cfif>` tag, place the text `<p>Your form has been submitted</p>`.
1. Navigate to the `/www/contact.cfm` page in your browser.
1. Notice that you receive an error stating that 'Element Submitted is undefined in form'. This error is thrown because the `form.submitted` variable does not exist. When dealing with forms, it is important to provide `<cfparam>` tags that will create the variable if it is not already defined.
1. Go to line 1 of `contact.cfm` and add the following line of code:

    ```cfml
    <cfparam name="form.submitted" default="0">
    ```

1. Refresh the page in your browser and notice that the error has been resolved.
1. Locate the `<form>` tag on or around line 109.
1. Update the action attribute to point to `contact.cfm`.
1. Refresh the page in your browser and click the submit button.
1. Notice that the form was submitted but the text was not displayed. This is because the `form.submitted` value still does not exist, and the `<cfparam>` is setting that value for us.
1. Locate the closing `<form>` tag on or around line 130.
1. Before the closing `</form>` tag, add a hidden input called `submitted` and give it a value of '1'. The tag should look similar to this:

    ```cfml
    <input type="hidden" name="submitted" value="1">
    ```

1. Refresh the page in your browser and click the submit button.
1. You should now see the text "Your form has been submitted" displayed on the page.
