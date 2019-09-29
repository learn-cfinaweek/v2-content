component{
	public errorBean function init(){
		variables.errors = [];
		return this;
	}
		
	public void function addError(required string message, required string field){
		arrayAppend(variables.errors,{message=arguments.message,field=arguments.field});
	}
		
	public array function getErrors(){
		return variables.errors;
	}
		
	public boolean function hasErrors(){
		if(arrayLen(variables.errors)){
			return true;
		}
		else{
			return false;
		}
	}
	
	public void function clearErrors(){
		variables.errors = [];
	}
}