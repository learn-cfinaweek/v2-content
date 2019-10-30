In this hands on, you are going to create an image file upload. Once the image is uploaded, you are going to resize it to fit specific measurements.

**Tags Used**: [\<cffile>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-f/cffile.html), [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html)

**Functions Used**: [listFindNoCase](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-l/listfindnocase.html), [getReadableImageFormats](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/getreadableimageformats.html), [imageScaleToFit](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-h-im/imagescaletofit.html), [imageWrite](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-h-im/imagewrite.html), [getTempDirectory](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/gettempdirectory.html)

1. Open up the `/www/admin/content/portfolio/editportfolio.cfm` file in your code editor.
1. The first thing that needs to be done is to check that an image has been provided in the form to upload. To do this create a `<cfif>` tag that checks if the `form.image` variable has a length. Locate the `Image Upload Process` comment and add it after.
1. Upload the image onto the server. Once on the server, you can manipulate it however desired. Create a `<cffile>` tag with the following properties inside the `<cfif>` tag:
    * **action**: upload
    * **filefield**: image
    * **destination**: #getTempDirectory()#
    * **nameconflict**: makeunique
1. This tag will upload the file that is in the form field called image and will place it into a temporary directory on the server, making the file name unique if the file already exists on the server. Your code should look similar to this:

    ```cfml
    <cfif len( form.image )>
        <cffile action="upload" filefield="image" destination="#getTempDirectory()#" nameconflict="makeunique">
    </cfif>
    ```

1. Next, confirm that the file that was uploaded is of a file type that can be processed. To do this, create a `<cfif>` statement that uses the `ListFindNoCase` function. The first argument of the function will be a call to the `getReadableImageFormats` function, and the second argument will be the `serverFileExt` variable in the `cffile` structure. Your code should look similar to this:

    ```cfml
    <cfif listFindNoCase( getReadableImageFormats(), cffile.serverFileExt )>

    </cfif>
    ```

1. Inside the `<cfif>` tag you will add the image resize logic. If the checks in the `<cfif>` have passed, then we know that the image is safe to resize. Inside the `<cfif>` create a `<cfset>` tag. In this set tag you are going to read in the image using the `imageRead` function and set it to the variable name `imageObject`. Your code should look similar to this:

    ```cfml
    <cfset imageObject = imageRead( cffile.serverDirectory & '/' & cffile.serverfile )>
    ```

1. Next, call the `imageScaleToFit` function and pass it the `imageObject` with the dimensions to resize the image. As the `imageScaletoFit` function does not return anything, you do not need to assign it to a variable. Add the following line of code below the `<cfset>` tag:

    ```cfml
    <cfset imageScaleToFit( imageObject, '202', '131' )>
    ```

1. Once the image has been resized, save the image object back to the file system. When writing the file, write it to a location in the web root, rather than a temporary directory, so that it can be displayed to the user. Use the `imageWrite` function and pass it the `imageObject` variable and the desired path to where the file should be written. Your code will look similar to this:

    ```cfml
    <cfset imageWrite( imageObject, expandpath( '../../../assets/images/portfolio/#cffile.serverfile#' ) )>
    ```

1. Once the file has been written, overwrite the `form.image` value with the image file value so it can be stored in the database. The name of the image is stored in the `cffile` structure under the key of `serverfile`. Your `<cfset>` tag will look similar to this:

    ```cfml
    <cfset form.image = cffile.serverfile>
    ```

1. It is possible that the user has tried to upload a file that is not accepted on the server. If this occurs we will simply remove the value from the `form.image` variable. Before the closing `</cfif>` on or around line 32, create a `<cfelse>` tag and place the following code inside:

    ```cfml
    <cfset form.image=''>
    ```

1. Your final `<cfif>` block should look similar to this:

    ```cfml
    <cfif listFindNoCase( getReadableImageFormats(), cffile.serverFileExt )>
        <cfset imageObject = imageRead( cffile.serverDirectory & '/' & cffile.serverfile )>
        <cfset imageScaleToFit( imageObject, '202', '131' )>
        <cfset imageWrite( imageObject, expandpath( '../../../assets/images/portfolio/#cffile.serverfile#' ) )>
        <cfset form.image = cffile.serverfile>
    <cfelse>
        <cfset form.image=''>
    </cfif>
    ```

1. Open up the `/www/admin/` page in a browser and navigate to the portfolio section.
1. Once in the portfolio section click on 'New Portfolio'.
1. Fill in the form and provide an image to be uploaded.
1. Click on 'Submit' to create the new portfolio item.
1. Open up the `/www/portfolio.cfm` page in your browser and confirm that the new portfolio item is being displayed along with the resized image.
