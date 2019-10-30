In this hands on we are going to secure our session and improve our admin security by hashing our passwords.

**Tags Used**: [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfqueryparam>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfqueryparam.html)

**Functions Used**: [len](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-l/len.html), [trim](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-t-z/trim.html), [Hash](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-h-im/hash.html), [GenerateSecretKey](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/generatesecretkey.html), [SessionRotate](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/sessionrotate.html), [SessionInvalidate](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/sessioninvalidate.html)

1. Open up the `/www/Application.cfc` file in your code editor.
1. When cookies are enabled on a web site (which is the case for this web site), it is important to secure them. Locate the block of variable declarations that sets values of the `this` scope. They should be at the top of the file.
1. After the last variable declaration, add the following lines of code:

    ```cfml
    this.sessioncookie.httponly = true;
    this.sessioncookie.timeout = "10";
    this.sessioncookie.disableupdate = true;
    ```

1. Now that the session cookies are secured, improve the security of the admin area by updating the administrator passwords. Open up the `/www/admin/content/system/editadministrator.cfm` file in your code editor.
1. Locate the line of code that checks if there were any validation errors on or around line 38.
1. The first thing to do when implementing hashing into the admin is to check if a password has been submitted. If no password has been submitted when the record is being updated, then we do not plan on updating the password and do not need to hash anything. Create a `<cfif>` tag that checks if `form.password` has a length. Remember to trim the value just in case any errant spaces have been entered. Your code should look similar to this:

    ```cfml
    <cfif len( trim( form.password ) )>

    </cfif>
    ```

1. Inside of the `<cfif>` tag, create two values: the first is the `salt` value we will be using and the other will be the hashed `password`. To create the `salt` value, create a `<cfset>` tag that creates a variable called salt. In the `<cfset>` tag call the `Hash()` function and pass in a call to the `GenerateSecretKey` function as the string to hash, and pass in `SHA-512` as the algorithm to use when hashing. In the `GenerateSecretKey` call, pass in `AES` as the algorithm to use. Your `<cfset>` should look similar to this:

    ```cfml
    <cfset salt = Hash( GenerateSecretKey( "AES" ), "SHA-512" )>
    ```

1. Next, generate the hashed password. To do this, create another `<cfset>` tag that sets a variable called `password`. In the `<cfset>`, call the `Hash()` function again and pass it in a concatenated string of the `form.password` value and the `salt` value. Tell the `Hash()` function to use the `SHA-512` algorithm. Your `<cfset>` should look similar to this:

    ```cfml
    <cfset Password = Hash( form.password & salt, "SHA-512" )>
    ```

1. Once there is a salt and a hashed password created, we need to update the queries to accept these values. Locate the `<cfquery>` tag that updates the administrator record on or around line 45. Update the SQL code so that the password value stored is the new password variable. Also, update the SQL so that the salt value is saved into a column called `salt`. The update query should look similar to this:

    ```cfml
    <cfquery>
        UPDATE
            administrator
        SET
            firstname = <cfqueryparam value="#trim( form.firstname )#" cfsqltype="varchar">,
            lastname = <cfqueryparam value="#trim( form.lastname )#" cfsqltype="varchar">,
            emailaddress = <cfqueryparam value="#trim( form.emailaddress )#" cfsqltype="varchar">
            <cfif len( trim( form.password ) )>
                ,password = <cfqueryparam value="#password#" cfsqltype="varchar">
                ,salt = <cfqueryparam value="#salt#" cfsqltype="varchar">
            </cfif>
        WHERE
            id = <cfqueryparam value="#form.id#" cfsqltype="integer">
    </cfquery>
    ```

1. Once the update functionality is changed, it is time to change the insert functionality. Locate the `<cfquery>` that creates a new `administrator` and update the statement to use the new `password` variable. Also update the SQL to store the `salt` value. Your `<cfquery>` should look similar to this:

    ```cfml
    <cfquery>
        INSERT INTO
            administrator (
            firstname,
            lastname,
            emailaddress,
            password,
            salt
        ) VALUES (
            <cfqueryparam value="#trim( form.firstname )#" cfsqltype="varchar">,
            <cfqueryparam value="#trim( form.lastname )#" cfsqltype="varchar">,
            <cfqueryparam value="#trim( form.emailaddress )#" cfsqltype="varchar">,
            <cfqueryparam value="#password#" cfsqltype="varchar">,
            <cfqueryparam value="#salt#" cfsqltype="varchar">
        )
    </cfquery>
    ```

1. Now that the newly encrypted password can be saved, we need to update the login logic to accommodate the changes that have been made. Before we do this, update the password for the current administrator. If we do not, as soon as the new logic is in place you will no longer be able to login to the admin. Open up `/www/admin/` in your browser.
1. Login with the username: `system@yoursite.com` and password: `admin`.
1. Navigate to: System > List Administrators.
1. Edit the Administrator, provide a new password and click 'Save'. You have now updated your account with a newly hashed password.
1. Now that the new password is created, we can update the login logic.
1. Open up the `/www/admin/login.cfm` file in your code editor.
1. Update the query that checks the `username` and `password`. Because we need to hash the password supplied with the applicable salt value, we can no longer search on the `password` value. Locate the `<cfquery>` tag with the name of `qLoginCheck` on or around line 10.
1. Remove the part of the query that searches against the password and update the select list to return the `password` and `salt` columns.
1. Locate the `<cfif>` statement that checks if any records were returned from the query, on or around line 22.
1. Next, hash the password that was submitted by the form with the salt that was returned in the query. If that hashed value does not match what was returned by the query, then the password is incorrect. Update the `<cfif>` statement so it reads:

    ```cfml
    <cfif !qLoginCheck.recordcount || qLoginCheck.password NEQ Hash( form.password & qLoginCheck.salt, "SHA-512" )>
    ```

1. The logic is now in place to check the submitted password with the hashed password. Before testing it out to make sure everything is working, we are going to add 2 more function calls to protect our session identifiers. Locate the `<cflocation>` tag on or around line 27.
1. Before this tag make a call to `SessionRotate()` using a `<cfset>` tag. This will rotate the session identifiers every time we log in.
1. Next, make sure the session is completely removed when we log out; open up the `/www/admin/logout.cfm` file in your code editor.
1. Locate the `<cflocation>` tag on or around line 3.
1. Before this tag, make a call to `SessionInvalidate()` using a `<cfset>` tag.
1. Now that we have our hashed passwords set up and our session protection in place, it is time to test that everything is working. Log out by clicking on the `system@myWebsite.com` email address on the top right of the admin.
1. Fill in the log in details for the administrator account you edited.
1. Once logged in, click around the admin and then click log out. You have now successfully added security to our admin area.
