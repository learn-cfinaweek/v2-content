In this hands on, you are going to add an Error Handling solution to the web site.

**Tags Used**: [\<cfdump>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-d-e/cfdump.html)

**Functions Used**: [include](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfinclude.html), [mail](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfmail.html)

1. Open up the `/www/Application.cfc` file in your code editor.
1. After the `onRequestStart` function, create a new function called `onError`. The function will accept 2 arguments. The first is of type `any` and is called `Exception`. The second is of type `string` and is called `EventName`. Your code should look similar to this:

    ```cfml
    function onError( any Exception, string EventName ) {

    }
    ```

1. Inside the function, include the file `sorry.cfm`.
1. After the file, place the following code, which will email the error information to you:

    ```cfml
    var errorEmail = new mail();
    errorEmail.setTo( 'you@domain.com' );
    errorEmail.setFrom( 'system@domain.com' );
    errorEmail.setSubject( 'An Error has Occured' );
    errorEmail.setBody('
        Message: #arguments.exception.message# <br>
        Details: #arguments.exception.detail# <br>
        Type: #arguments.exception.type# <br>
    ');
    errorEmail.setType( 'html' );
    errorEmail.send();
    ```

1. Your function should look similar to this:

    ```cfml
    function onError( any Exception, string EventName ) {
        include 'sorry.cfm';
        var errorEmail = new mail();
        errorEmail.setTo( 'you@domain.com' );
        errorEmail.setFrom( 'system@domain.com' );
        errorEmail.setSubject( 'An Error has Occured' );
        errorEmail.setBody('
            Message: #arguments.exception.message# <br>
            Details: #arguments.exception.detail# <br>
            Type: #arguments.exception.type# <br>
        ');
        errorEmail.setType( 'html' );
        errorEmail.send();

    }
    ```

1. Open up the `/www/throwError.cfm` file in your browser. You should now see a 'sorry' page.
1. Open up your ColdFusion Administrator and login. The URL for the ColdFusion Administrator is most likely [http://localhost:8500/CFIDE/administrator/](http://localhost:8500/CFIDE/administrator/).
1. Click on 'Mail' under Server Settings.
1. Click on the 'View Undeliverable Mail'.
1. The first item in the list should be your error email. Review the contents of the email that is sent when an email is thrown.
1. Open up the `/www/throwError.cfm` file in your code editor.
1. Change the contents of the file to the following code:

    ```cfml
    <cfdump value="2">
    ```

1. Open up the `/www/throwError.cfm` file in your browser and notice that an error is not thrown. `onError` does not catch tag syntax errors. For that, we must rely on the site-wide error handler.
1. Create a new file called `sitewideErrorHandler.cfm` in the `/` folder.
1. Open the `/sitewideErrorHandler.cfm` file in your code editor.
1. Add the following line of text to the file:

    ```cfml
    An error has occurred!
    ```

1. Go back to your ColdFusion Administrator.
1. Click on 'Settings' under Server Settings.
1. Go to the Site-wide Error Handler input and enter the following value:

    ```
    /learncfinaweek/sitewideErrorHandler.cfm
    ```

1. Go back to the `/www/throwError.cfm` page in your browser and refresh.
1. You will now see the message 'An error has occurred!'. The site wide error handler has caught the exception and displayed a friendlier message to the user. You can now find details about the specific error from the server log files.
