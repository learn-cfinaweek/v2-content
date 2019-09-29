component persistent="true"{
	property name="id" column="blogCommentid" fieldtype="id" generator="increment";
	property name="author" ormtype="string";     
	property name="comment" ormtype="text";
	property name="createdDateTime" ormtype="timestamp"; 
	property name="deleted" ormtype="boolean";
	
	property name="blog" fieldtype="many-to-one" cfc="blogPost";    
 		
}