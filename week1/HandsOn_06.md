In this hands on, we are going to refactor our code and take out any unnecessary logic we might have.

**Tags Used**: [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html), [\<cfelse>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-d-e/cfelse.html)

1. Open up the `/www/contact.cfm` file in your code editor and locate the `<cfif>` statement that checks the `form.contactname` variable. Remove the `eq 0` part of the expression; as any number greater than 0 is treated as true, and the number 0 is treated as false, we do not need this additional part of the `<cfif>` statement. Because we only want to run the code when there is NO value passed we must negate the value by putting the word NOT before it.
1. Remove the `eq 0` part of the `form.email` and `form.message` `<cfif>` statements and add NOT before the `len` function call.
1. Locate the `<cfif>` statements that checks the variable `OK` on or around line 120.
1. Remove the `eq false` part of the expression. As a `<cfif>` tag is looking for a true or false value, we do not need to check the value of the variable as it is already going to be a true or false value. As we are checking if the variable is false then we need to put the ! symbol before the variable. ! is the same as NOT.
1. Before the closing `</cfif>` tag of the expression that checks the `OK` variable, insert a `<cfelse>` tag.
1. Between the `<cfelse>` tag and the closing `</cfif>` tag add the following code: `<p>Form submitted successfully!</p>`
1. Your final code block should look similar to this:

    ```cfml
    <cfif form.submitted>
        <cfset ok = true>

        <cfif NOT len( trim( form.contactname ) )>
            <cfset ok = false>
        </cfif>

        <cfif NOT len( trim( form.email ) )>
            <cfset ok = false>
        </cfif>

        <cfif NOT len( trim( form.message ) )>
            <cfset ok = false>
        </cfif>

        <cfif !ok>
            <p>You did not provide all the required information!</p>
        <cfelse>
            <p>Form submitted successfully!</p>
        </cfif>
    </cfif>
    ```

1. Reload the `contact.cfm` page in your browser and enter spaces in all form fields.
1. Click 'submit' and notice that the message "You did not provide all the required information!" message is displayed.
1. Provide information for all the form fields and click 'submit'.
1. Notice that the message "Form submitted successfully!" is displayed.
