In this hands on we will create an Application.cfc file, create some application wide variables, and implement some of the Application.cfc event handlers.

**Tags Used**: [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfquery](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html)

**Functions Used**: [createTimeSpan](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/CreateTimeSpan.html), [structKeyExists](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/structkeyexists.html), [createObject](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/CreateObject.html)

1. Create a new file called `Application.cfc` in `/www/`.
1. Open up the `/www/Application.cfc` file in your code editor. Note: for this hands on we will be doing all our coding in script format.
1. Create a `component` declaration. Your code should look similar to this:

    ```cfml
    component{
    }
    ```

1. Create two variables in the `this` scope called `name` and `datasource`. Set both variables to 'learncfinaweek'.
1. Create another variable in the `this` scope called `applicationTimeout` and give it a value of:

    ```cfml
    CreateTimeSpan( 10, 0, 0, 0 );
    ```

1. Create another variable in the this scope called `sessionManagement` and set it to true.
1. Create another variable in the this scope called `sessionTimeout` and give it a value of:

    ```cfml
    CreateTimeSpan( 0, 0, 30, 0 );
    ```

1. Your code should look similar to this:

    ```cfml
    component{
        this.name='learncfinaweek';
        this.datasource='learncfinaweek';
        this.applicationTimeout = CreateTimeSpan( 10, 0, 0, 0 );
        this.sessionManagement = true;
        this.sessionTimeout = CreateTimeSpan( 0, 0, 30, 0 );
    }
    ```

1. Create a function called `onApplicationStart` that accepts no arguments and returns true.
1. Inside the `onApplicationStart` function, create two variables set in the application scope. The first variable should be called `myName` and should have the value of your name. The second variable should be called `myPosition` and should have the value of 'A Developer'.
1. Your code should look similar to this:

    ```cfml
    component{
        this.name='learncfinaweek';
        this.datasource='learncfinaweek';
        this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0);
        this.sessionManagement = true;
        this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0);

        function onApplicationStart() {
            application.myName = 'Simon';
            application.myPosition = 'A Developer';
            return true;
        }
    }
    ```

1. Below the `onApplicationStart` function,create a new function called `onRequestStart` which accepts one string parameter called 'targetPage'.
1. Inside the function, create an `if` statement that calls the `StructKeyExists` function. The `structKeyExists` function should be passed the URL scope as its first parameter and the string 'reload' as its second parameter.
1. Inside the `if` statement, a call should be made to the `onApplicationStart` function.
1. Your code should look similar to this:

    ```cfml
    function onRequestStart( string targetPage ){
        if ( structKeyExists( url, 'reload' ) ){
            onApplicationStart();
        }
    }
    ```

1. Open up the `/www/index.cfm` file in your code editor.
1. Remove the `<cfset>` tags at the top of the page.
1. Locate the `myName` variable output on or around line 15 and change it to `application.myName`.
1. Locate the `myPosition` variable output on or around line 16 and change it to `application.myPosition`.
1. In your browser, navigate to the `/www/index.cfm` page. The index page should display as normal.
1. Go to the `/www/application.cfc` file in your code editor and change the `application.myPosition` variable to have the value of 'A Great Developer'.
1. In your browser, refresh the `index.cfm` page. Notice that nothing has changed. This is because the application has already started, so the `onApplicationStart` method does not get called.
1. In your browser, append `?reload=1` to the `index.cfm` in the location bar. Hit return to load the page. Notice that the position has now updated to the new value.
1. Open up the `/www/resume.cfm` file in your code editor. Locate both `<cfquery>` tags and remove the `datasource` attributes.
1. In a browser, navigate to the `/www/resume.cfm` page. Notice that the page loads normally. Both queries are now using the application wide data source.
1. In the `onApplicationStart` function in the `/www/Application.cfc` file, create a new application variable called 'utilities'. Set the value of `application.utilities` to:

    ```cfml
    CreateObject( 'cfc.utilities' );
    ```

1. Your code should look similar to:

    ```cfml
    function onApplicationStart() {
        application.myName = 'Simon';
        application.myPosition = 'A Great Developer';
        application.utilities = CreateObject( 'cfc.utilities' );
        return true;
    }
    ```

1. Open up the `/www/about.cfm` file in your code editor and remove the `<cfset>` tag on or around line 4.
1. Locate the `utilities.convertStringToASCII` function call on or around line 58 and change it to `application.utilities.convertStringToASCII`.
1. In a browser, navigate to the `/www/about.cfm` page, remembering to include `?reload=1` in the URL as we have made an `application.cfc` change.
1. Notice that the page loads normally. The `convertStringToASCII` function is now stored in the application scope and can be accessed from any page within the application.

## Homework

1. Remove the datasource attribute from all query tags.
1. Update the email address in the `/www/contact.cfm` file to use the `convertStringToASCII` function.
