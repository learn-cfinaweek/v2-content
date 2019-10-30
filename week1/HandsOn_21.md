In this hands on, we are going to add categories to blog posts. The logic for this involves creating a linking entity to which both the blog post and category will be associated. This is an alternative method to using a many-to-many relationship.

**Tags Used**: [\<cfloop>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html)

**Functions Used**: [EntitySave](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitysave.html), [for](https://helpx.adobe.com/coldfusion/developing-applications/the-cfml-programming-language/extending-coldfusion-pages-with-cfml-scripting/using-cfscript-statements.html#Usingforloops), [ListAppend](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-l/listappend.html), [EntityDelete](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitydelete.html)

1. In order to be able to associate multiple categories to a blog post and also be able to associate multiple blog posts to a category, we need to create a linking entity. Create a new file called `blogPostCategory.cfc` in the `/www/com/entity/` folder.
1. Open up the `/www/com/entity/blogPostCategory.cfc` file in your code editor.
1. Add the following lines of code:

    ```cfml
    component persistent="true" {
        property name="blogPost" fieldtype="id,many-to-one" cfc="blogPost" column="blogPostid" ;
        property name="blogCategory" fieldtype="id,many-to-one" cfc="blogCategory" column="blogCategoryid" ;
    }
    ```

1. Now that the linking entity is created, you need to associate that entity to both the `blogPost` entity and the `blogCategory` entity. To do this, open up the `/www/com/entity/blogPost.cfc` file in your code editor.
1. Locate where the comment relationship is defined. This should be on or around line 11.
1. After this line of code add the following line of code:

    ```cfml
    property name="categories" fieldtype="one-to-many" cfc="blogPostCategory" fkcolumn="blogpostid";
    ```

1. The line you just entered associates the blog post to the `blogPostCategory` entity. The next step is to do the same for the `blogCategory`. Open up the `/www/com/entity/blogCategory.cfc` file in your code editor.
1. Locate the `name` property definition on or around line 2 and add the following line of code below it:

    ```cfml
    property name="posts" fieldtype="one-to-many" cfc="blogPostCategory" fkcolumn="blogCategoryid";
    ```

1. Now that the entity properties have been set, reload the application so the ORM changes can take effect. To do this, go to the `/www/index.cfm` page in your browser and append `?reload=1` to the URL.
1. Your application has now created the new linking table and you have the new entity properties at your disposal. Next, let's write the logic which will save categories to a blog post. Open up the `/www/admin/content/blog/editblogpost.cfm` file in your code editor.
1. Locate the `Add Category to Entity` comment.
1. Below the comment, instantiate a new instance of the `BlogPostCategory` and call the variable 'blogPostCategory'.
1. Below that line, load in a `blogCategory` object and use the variable `categoryID` as the identifier and call the variable `blogCategory`.
1. Your code should look similar to this:

    ```cfml
    <cfloop list="#form.categories#" index="categoryID">
        <!--- Add Category to Entity --->
        <cfset blogPostCategory = EntityNew( 'blogPostCategory' )>
        <cfset blogCategory = EntityLoad( 'blogCategory', categoryID, true )>
    </cfloop>
    ```

1. After the `blogCategory` variable has been created, set the values of the `blogPostCategory`. The first value to be set is the `blogCategory`. To do this, set the `blogCategory` property value of the `blogPostCategory` object to the `blogCategory` variable. Your code should be similar to this:

    ```cfml
    <cfset blogPostCategory.blogCategory = blogCategory>
    ```

1. Next, set the `blogPost` property of `blogPostCategory` with the `blogPost` variable which was saved earlier in the page.
1. Once this is done, save the entity. Simply call the `entitySave` function and pass in the `blogPostCategory` object. Your final code should look similar to this:

    ```cfml
    <cfloop list="#form.categories#" index="categoryID">
        <!--- Add Category to Entity --->
        <cfset blogPostCategory = EntityNew( 'blogPostCategory' )>
        <cfset blogCategory = EntityLoad( 'blogCategory', categoryID, true )>
        <cfset blogPostCategory.blogCategory = blogCategory>
        <cfset blogPostcategory.blogPost = blogPost>
        <cfset entitySave( blogPostCategory )>
    </cfloop>
    ```

1. Now that this logic is complete, we can associate a category with a blog post and save it. Open up the `/www/admin/content/editBlogPost.cfm` page in your browser.
1. Enter some blog information, select a category, and click 'save'.
1. You will see on the listing page showing that the blog post has been saved. Click on the blog post you just saved and review the data on the screen.
1. You will notice that the category is not pre-checked. This is not because the category has not been saved, but because we have not put the logic in place to generate the list of category ID's that the page needs. To do this, you need to set a form value called 'categories'. Locate the `Get Entity Data` comment tag.
1. Below the last `<cfset>` tag in the `<cfif>` block, create a new `<cfset>` tag that sets `blogpost.categoryids` to the variable `form.categories`. Your code should look similar to this:

    ```cfml
    <cfset form.categories = blogPost.categoryids>
    ```

1. If you were to run the page now, you would generate an error. The functionality to get the category ID's is not present in the `blogPost` entity. We must first create that functionality by adding a custom function into the `blogPost` entity. Open up the `/www/com/entity/blogPost.cfc` file in your code editor.
1. Below the last property definition, create a public function that returns a string and is called `getCategoryIDs`.
1. Inside the function, create a variable called `categoryList`, assign it to the `var` scope and set it to an empty string. Your code should look similar to this:

    ```cfml
    public string function getCategoryIDs(){
        var categoryList = '';

    }
    ```

1. Next, check that the `blogPost` actually has some categories from which to generate a list. To do that, create an `if` statement that calls the `hasCategories()` function.
1. Inside of the `if` statement, begin looping over the categories and concatenating a string of their ID's. To do this, create the following `for` loop inside the `if` statement:

    ```cfml
    for ( var categoryPost in getCategories() ){

    }
    ```

1. Inside the `for` loop, get the `ID` of the `blogCategory` and append it to the `categoryList` variable. To get the category ID access the `blogCategory` property and then access the ID value from the returned `BlogCategory` object. Use the `listAppend` function to append that result with the `categoryList` variable. The code will look similar to this:

    ```cfml
    categoryList = listAppend( categoryList, categoryPost.blogCategory.id );
    ```

1. Finally, return the generated list by calling the `return` statement and passing it the `categoryList` variable.
1. Our final function should look similar to this:

    ```cfml
    public string function getCategoryIDs(){
        var categoryList = '';
        if ( hasCategories() ) {
            for ( var categoryPost in getCategories() ) {
                categoryList = listAppend( categoryList, categoryPost.blogCategory.id );
            }
        }
        return categoryList;
    }
    ```

1. Open up the `/www/admin/content/blog/listblogposts.cfm` page in your browser and append the `?reload=1` value to the URL.
1. Click on the blog post and notice that the category is now checked.
1. If you were to click 'save' again, your blog post would end up with duplicate categories associated to it. If you were to uncheck a category and click 'save' teh category woudl not be removed from the blog post.This is because we have added logic to add categories, but we have not check if they are already associated or if they need removing. The easiest way to solve this is to remove all categories from the blog post when editing, then re-add the new categories. To do this, open up the `/www/admin/content/blog/editBlogPost.cfm` file in your code editor.
1. Find the `Edit Entity` comment tag and go to the last `<cfset>` tag. After the `<cfset>` tag, create a `<cfloop>` tag with the following attributes:
    * **array**: #blogPost.getCategories()#
    * **index**: category
1. Inside the `<cfloop>`, create a `<cfset>` tag that calls the `entityDelete` function and pass it in the variable `category`. Your final code should look similar to this:

    ```cfml
    <cfloop array="#blogPost.getCategories()#" index="category">
        <cfset entityDelete( category )>
    </cfloop>
    ```

1. Go back to the `/www/admin/content/blog/listblogposts.cfm`, click on a blog post, and save the blog to confirm you have no errors.

## Homework

Create a function similar to the `getCategoryIDs` function. Instead of returning ID's, create a function that returns a list of the category names. Replace the category output, which is currently 'ColdFusion', in `/www/blog.cfm` with this new function call.
