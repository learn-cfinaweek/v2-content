In this hands on, you are going to create an error and view the error information in the log files.

**Tags Used**: [\<cfoutout>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html)

1. To view the error information, we must first throw an error. Create a new file in the `/www/` folder called `throwError.cfm`.
1. Open up the `/www/throwError.cfm` file in your code editor.
1. Add the following lines of code:

    ```cfml
    <cfoutput>
        #foo#
    </cfoutput>
    ```

1. Open the `/www/throwError.cfm` page in your browser. You will see an error that states 'Variable FOO is undefined'.
1. Notice that the error is displayed but with not much additional information. This is not helpful when developing a web site. Open up your ColdFusion administrator and log in. The URL for the ColdFusion Administrator is most likely [http://localhost:8500/CFIDE/administrator/](http://localhost:8500/CFIDE/administrator/).
1. Click on 'Debugging Output Settings' under 'Debugging and Logging'.
1. Check the 'Enable Robust Exception Information' option and click 'Submit Changes'.
1. Reload the `throwError.cfm` page in your browser. Notice that you now get the file name and line number the error is on.
1. Go back to the ColdFusion administrator.
1. Click on the 'Log Files' link under Debugging & Logging.
1. Click on the 'Search / View Log File' button (the first one) for the `application.log` file.
1. You will notice that the first item on the screen is details regarding the error that was just thrown. The application name column will show the name of the application which threw the error, in this case, `learncfinaweek`. Also, you will see details regarding the error that was just shown to you on the screen. You can see the error message, the file that threw the error, and the line number. When error handling is turned on, this information can be very useful when debugging errors.
1. Go back to the Log Files screen.
1. Click on the 'Delete Log File' icon (the 4th icon from the left) for the `exception.log` file. This will delete the exception log file.
1. Go back to the `throwError.cfm` page and refresh.
1. Go back to the Log Files screen and you will see the `exception.log` file is back.
1. Click on the 'Search / View Log File' icon (1st on the left) for the `exception.log` file.
1. The first item in the list will be the error that you generated. In this view, you will see a lot of additional information regarding the error, such as the full Java stack trace.
