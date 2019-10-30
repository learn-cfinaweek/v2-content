In this Hands On we are going to create an encapsulated cfc that holds error data.

**Functions Used**: [ArrayAppend](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-a-b/arrayappend.html), [ArrayLen](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-a-b/arraylen.html)

1. Create a new file called `errorBean.cfc` in the `/www/admin/cfc/` folder.
1. Open up the `/www/admin/cfc/errorBean.cfc` file in your code editor.
1. This cfc will be written entirely in *cfscript* so create a *cfscript* based `component` declaration. Your code should look similar to this:

    ```cfml
    component{
    }
    ```

1. The first function we are going to create is the `init` function. This function will instantiate the internal variables and return itself. Create a function called `init` that is `public` and returns a variable type of `errorBean`.
1. Inside the function create a variable declaration called `variables.errors` and instantiate an empty array.
1. Below this return the `this` scope. Your function should look similar to this:

    ```cfml
    public errorBean function init(){
        variables.errors = [];
        return this;
    }
    ```

1. Next create a function called `addError` that is `public` and returns `void`. Create 2 required string arguments called `message` and `field`.
1. Inside the function append a struct to the `variables.error` variable. The structure should consist of 2 keys, `message` and `field`. Set each key to their related `argument` value. This function will be used to add errors to the object. Your function should look similar to this:

    ```cfml
    public void function addError( required string message, required string field ){
        arrayAppend( variables.errors, { message=arguments.message, field=arguments.field } );
    }
    ```

1. Next we will create a function called `getErrors` which will return all errors stored in the object. The function will be `public`, return an `array`, and accept no arguments.
1. Inside the function return the `variables.errors` variable. Your function should look similar to this:

    ```cfml
    public array function getErrors(){
        return variables.errors;
    }
    ```

1. We now need to create a function that will tell us if there are any errors stored in the object. Create a `public` function called `hasErrors`. The function will return a `boolean` value and will accept no arguments.
1. Inside the function create an `if` statement that checks the array length of the `variables.error` array. If there is a length, return `true`. If there is not a length return `false`. Your function should look similar to this:

    ```cfml
    public boolean function hasErrors(){
        if ( arrayLen( variables.errors ) ){
            return true;
        }
        else {
            return false;
        }
    }
    ```

1. Finally we will create a function that removes all errors from the object. Create a function called `clearErrors` that is `public`, does not return anything and accepts no arguments.
1. Inside the function assign an empty array to the `variables.errors` variable.
1. You have now created an encapsulated object. We will test that this object works in one of the other Hands On's but for now confirm that your cfc looks similar to the following:

    ```cfml
    component{
        public errorBean function init(){
            variables.errors = [];
            return this;
        }

        public void function addError( required string message, required string field ){
            arrayAppend( variables.errors, { message=arguments.message, field=arguments.field } );
        }


        public array function getErrors(){
            return variables.errors;
        }

        public boolean function hasErrors(){
            if ( arrayLen( variables.errors ) ){
                return true;
            }
            else {
                return false;
            }
        }

        public void function clearErrors(){
            variables.errors = [];
        }
    }
    ```
