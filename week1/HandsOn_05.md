In this hands on, you are going to update our code to provide a better user experience to your users as well as improve the form validation.

**Tags Used**: [\<cfparam>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfparam.html), [\<cfoutout>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html)

**Functions Used**: [len](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-l/len.html), [trim](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-t-z/trim.html)

1. Locate the `<cfparam>` tag at the top of the `/www/contact.cfm` file.
1. Below the `<cfparam>` tag, create another one for contactname, email, and message. Leave the default attribute as empty. Your code should look similar to this:

    ```cfml
    <cfparam name="form.contactname" default="">
    <cfparam name="form.email" default="">
    <cfparam name="form.message" default="">
    ```

1. Locate the `contactname` form input on or around line 132 and add a `value` attribute with a value of `#form.contactname#`.
1. Locate the `email` form input on or around line 136 and add a `value` attribute with the value of `#form.email#`.
1. Locate the `message` textarea on or around line 140 and place the value `#form.message#` between the open and close tags.
1. Confirm your code looks similar to this:

    ```cfml
    <div>
        <label>Name <span class="font-11">(required)</span></label>
        <input name="contactname" type="text" class="required" value="#form.contactname#"/>
    </div>


    <div>
        <label>E-mail <span class="font-11">(required)</span></label>
        <input name="email" type="text" class="required email" value="#form.email#"/>
    </div>


    <div class="textarea">
        <label>Message <span class="font-11">(required)</span></label>
        <textarea name="message" rows="6" cols="60" class="required">#form.message#</textarea>
    </div>
    ```

1. Locate the open `<form>` tag on or around line 129 and put on open `<cfoutput>` tag before the form tag.
1. Locate the closing `</form>` tag on or around line 146 and put a closing `</cfoutput>` tag after the form tag.
1. Reload the `contact.cfm` page in your browser; fill in 2 of the 3 inputs of the form and click 'submit'.
1. Notice that the form is now pre-populated with the values you submitted, but you still receive the message "You did not provide all the required information!"
1. Reload the `contact.cfm` page in your browser.
1. Add a space in all form fields and click submit.
1. Notice that the message does not display on the page. This is due to the fact that the form fields do have a length, even though it is just a space.
1. Locate the `<cfif>` statement that checks the length of `form.contactname` on or around line 108.
1. Wrap the `form.contactname` variable in a `trim()` function. This will remove all whitespace at the beginning and end of the variable.
1. Your code should look similar to this:

    ```cfml
    <cfif len( trim( form.contactname ) ) eq 0>
    ```

1. Add the `trim` function to the `form.email` and `form.message` `<cfif>` statements.
1. Reload the `contact.cfm` page in your browser and add spaces to all 3 form fields. Notice that the message is displayed.
