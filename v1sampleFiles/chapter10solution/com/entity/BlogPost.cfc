component persistent="true"{
	property name="id" column="blogpostid" fieldtype="id" generator="increment";
	property name="title" ormtype="text";     
	property name="summary" ormtype="text";
	property name="body" ormtype="text";
	property name="dateposted" ormtype="timestamp";
	property name="createdDateTime" ormtype="timestamp"; 
	property name="modifiedDateTime" ormtype="timestamp"; 
	property name="deleted" ormtype="boolean";
	
	property name="comments" singularname="comment" fieldtype="one-to-many" cfc="blogComment" fkcolumn="blogpostid" cascade="all";
	property name="categories" fieldtype="one-to-many" cfc="blogPostCategory" fkcolumn="blogpostid";
	
	public string function getCategoryIDs(){
		var categoryList = '';
		if(hasCategories()){
			for(var categoryPost in getCategories()){
				categoryList = listAppend(categoryList, categoryPost.blogCategory.id);
			}
		}
		return categoryList;
	}
	
	public string function getCategoryNames(){
		var categoryList = '';
		if(hasCategories()){
			for(var categoryPost in getCategories()){
				categoryList = listAppend(categoryList, categoryPost.blogCategory.name,', ');
			}
		}
		return categoryList;
	} 	 	
}