In this hands on example, you are going to add the list and create functionality in the Admin for the blog posts and categories.

**Tags Used**: [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html)

**Functions Used**: [EntityLoad](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entityload.html), [EntityNew](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitynew.html), [now](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-m-r/now.html)

1. Open up the `/www/admin/content/blog/editBlogPost.cfm` file in your code editor.
1. Locate the `Edit Entity` comment tag on or around line 39.
1. Load the entity into a `blogPost` variable by adding the following code:

    ```cfml
    <cfset blogPost = EntityLoad( 'BlogPost', form.id,true )>
    ```

1. Set the blog post properties from the `form` scope by adding the following lines of code below the `<cfset>`:

    ```cfml
    <cfset blogPost.title = form.title>
    <cfset blogPost.summary = form.summary>
    <cfset blogPost.body = form.body>
    <cfset blogPost.datePosted = form.datePosted>
    <cfset blogPost.modifiedDateTime = now()>
    ```

1. Next, add the logic to create a new blog post. Locate the comment tag that reads `Create Entity` on or around line 47.
1. Create a new blog post object and set it to the `blogPost` variable by adding the following line of code:

    ```cfml
    <cfset blogPost = EntityNew( 'BlogPost' )>
    ```

1. Set the object properties from the form scope by adding the following lines of code below the `<cfset>`:

    ```cfml
    <cfset blogPost.title = form.title>
    <cfset blogPost.summary = form.summary>
    <cfset blogPost.body = form.body>
    <cfset blogPost.datePosted = form.datePosted>
    <cfset blogPost.createdDateTime = now()>
    ```

1. At this point, the `blogPost` object has all the information it needs and will be saved successfully. The next step is pull the blog post information for the edit form. To do this, find the `Get Entity Data` comment tag.
1. Create a blog Post object using the URL variable ID and set it to the `blogPost` variable by adding the following line of code:

    ```cfml
    <cfset blogPost = EntityLoad( 'BlogPost', url.id, true )>
    ```

1. Now set the `blogPost` properties into the `form` scope so that they will display in the form. To do this, add the following lines of code below the `<cfset>` tag:

    ```cfml
    <cfset form.id = blogPost.id>
    <cfset form.title = blogPost.title>
    <cfset form.summary = blogPost.Summary>
    <cfset form.body = blogPost.body>
    <cfset form.datePosted = blogPost.datePosted>
    ```

1. The add/edit process is now complete, but before you test it, update the listing page to pull the entities. Open up the `/www/admin/content/blog/listblogpost.cfm` file in your code editor.
1. Find the comment `Pull Blog Posts` and add a `<cfset>` below, that calls `EntityLoad` on `blogPost` and sets the value to a variable called `blogPosts`. Do this by adding the following line of code:

    ```cfml
    <cfset blogPosts = EntityLoad( 'BlogPost' )>
    ```

1. Next, output the information to the user. Find the `Title` comment tag and output the title property of the `blogPost` object. Do this by adding the following code below the `Title` comment tag:

    ```cfml
    #blogPost.title#
    ```

1. Then, output the `datePosted` value; add the following line of code below the `Date Posted` comment tag:

    ```cfml
    #dateFormat( blogPost.datePosted, "mm/dd/yyyy" )#
    ```

1. The final stop to complete the listing page is to output the blog post ID in the edit link so that the edit page knows which blog post is being edited. To do this, append the following line of code to the `ID` URL attribute in the `<a>` tag under the `Edit Post` comment:

    ```cfml
    #blogPost.id#
    ```

1. The admin is now able to create and edit `blogPosts`. Navigate to `/www/admin/` in your browser and login with the Email Address of `admin@myWebsite.com` and password of `admin`. Once logged in, click on 'Blog'.
1. Click on 'Add Blog Post' and create a new blog.
1. Go back to the listing page and edit your blog.

## Homework

Update the `blogCategory` files in the admin so that blog categories can be create and edited.
