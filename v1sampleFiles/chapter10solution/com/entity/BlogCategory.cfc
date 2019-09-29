component persistent="true"{
	property name="id" column="blogCategoryid" fieldtype="id" generator="increment";
	property name="name" ormtype="string";     
	property name="posts" fieldtype="one-to-many" cfc="blogPostCategory" fkcolumn="blogCategoryid";
}