In this hands on example, you are going to create the ORM entities for the Blog Section.

**Functions Used**: [ormReload](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-m-r/ormreload.html)

1. Open up the `/www/Application.cfc` file in your code editor.
1. Locate the `this.sessionTimeout` variable declaration on or around line 6.
1. Below this, create the following new variables in the `this` scope:
    * this.ormEnabled = true
    * this.ormSettings = { logsql = true, dbcreate = "update", cfclocation = "com/entity" }
    * this.invokeImplicitAccessor = true;
1. Your code should look similar to this:

    ```cfml
    this.sessionTimeout = CreateTimeSpan( 0, 0, 30, 0 );
    this.ormEnabled = true;
    this.ormSettings = {
            logsql = true,
            dbcreate = "update",
            cfclocation = "com/entity"
    };
    this.invokeImplicitAccessor = true;
    ```

1. Go to the `onRequestStart` Function and add an `ormReload()` function call inside of the `if` statement. Your code should look similar to this:

    ```cfml
    function onRequestStart( string targetPage ){
        if ( structKeyExists( url,'reload' ) ){
            onApplicationStart();
            ormReload();
        }
    }
    ```

1. Create a new file called `blogPost.cfc` in the `/www/com/entity/` folder.
1. Open up the `/www/com/entity/blogPost.cfc` file in your code editor.
1. Declare the file as a component by adding the component script tags:

    ```cfml
    component{
    }
    ```

1. Add an additional property to the component declaration, `persistent`, and set that value to true. Your code should look similar to this:

    ```cfml
    component persistent="true"{
    }
    ```

1. Inside the component definition, enter the following code:

    ```cfml
    property name="id" column="blogpostid" fieldtype="id" generator="increment";
    property name="title" ormtype="text";
    property name="summary" ormtype="text";
    property name="body" ormtype="text";
    property name="dateposted" ormtype="timestamp";
    property name="createdDateTime" ormtype="timestamp";
    property name="modifiedDateTime" ormtype="timestamp";
    property name="deleted" ormtype="boolean";

    property name="comments" singularname="comment" fieldtype="one-to-many" cfc="blogComment" fkcolumn="blogpostid" cascade="all";
    ```

1. Create a new file called `blogCategory.cfc` in the `/www/com/entity/` folder.
1. Add the following code to the file:

    ```cfml
    component persistent="true"{
        property name="id" column="blogCategoryid" fieldtype="id" generator="increment";
        property name="name" ormtype="string";

    }
    ```

1. Create a new file called `blogComment.cfc` in the `/www/com/entity/` folder.
1. Add the following code to the file:

    ```cfml
    component persistent="true"{
        property name="id" column="blogCommentid" fieldtype="id" generator="increment";
        property name="author" ormtype="string";
        property name="comment" ormtype="text";
        property name="createdDateTime" ormtype="timestamp";
        property name="deleted" ormtype="boolean";

        property name="blog" fieldtype="many-to-one" cfc="blogPost";

    }
    ```

1. Open up the `/www/blog.cfm` page in your browser and append `?reload=1` to the url. The `ormReload` function will now have been called and the database tables will have been created.
