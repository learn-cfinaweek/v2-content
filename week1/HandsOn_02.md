In this section of the hands on we will switch from tag based code to script based code and create a structure of data. We will then output that on the page.

**Tags Used**: [\<cfscript>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfscript.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html)

1. Open up the `/www/about.cfm` file in your code editor.
1. Locate line 1 and write an opening and closing `<cfscript>` block. Put the closing `</cfscript>` tag on the second line. Your code should look something like this:

    ```cfml
    <cfscript>
    </cfscript>
    ```

1. In between the opening and closing `<cfscript>` tags, create a struct by write the following code:

    ```cfml
    personalInfo = {name='', dob='', address='', phonenumber='', email='', website='', skype=''};
    ```

1. For each variable of the `personalInfo` struct, provide some information (you do not have to use real information if you prefer not to).
1. Locate the \[Name\] placeholder text on or around line 116.
1. Replace \[Name\] with `#personalInfo.name#`.
1. Replace the other placeholders with their matching variables in the `personalInfo` struct.
1. Wrap all the `<div>` tags with the class of clr in a `<cfoutput>` tag. Your code should look similar to this:

    ```cfml
    <cfoutput>
        <div class="clr">
            <div class="input-box">Name </div><span>#personalInfo.name#</span>
        </div>
        <div class="clr">
            <div class="input-box">Date of birth </div><span>#personalInfo.dob#</span>
        </div>
        <div class="clr">
            <div class="input-box">Address </div><span>#personalInfo.address#</span>
        </div>
        <div class="clr">
            <div class="input-box">Phone </div><span>#personalInfo.phoneNumber#</span>
        </div>
        <div class="clr">
            <div class="input-box">E-mail </div><span><a href="#">#personalInfo.email#</a></span>
        </div>
        <div class="clr">
            <div class="input-box">Website </div><span><a href="#">#personalInfo.website#</a></span>
        </div>
        <div class="clr">
            <div class="box1">Skype </div><span><a href="#">#personalInfo.skype#</a></span>
        </div>
    </cfoutput>
    ```

1. To test that your changes have taken place, load the `/www/about.cfm` page in your browser.
1. Notice that you have received a ColdFusion Error. The error states that it has found an Invalid CFML construct. This is due to the single # signs inside the links for email, website, and Skype. ColdFusion uses the # sign to denote variables and it is trying to evaluate everything between the first # sign and the next one. To resolve the error, we must escape the single # signs.
1. Locate the link that wraps around the email output on or around line 121.
1. Update the value of the href attribute to ## rather than #. You're `<a>` tag should look similar to this:

    ```cfml
    <a href="##">
    ```

1. Do this also for the website and Skype links.
1. Refresh the `/www/about.cfm` page in your browser and confirm that you now see your information being displayed.

## Homework

1. Convert all remaining .html pages to .cfm pages.
1. Update all navigation links to point to the .cfm files rather than the .html files.
1. Create a structure on the Contact page that stores your address, phone number, email, and Skype information; display it on the right hand side under Contact Info.
