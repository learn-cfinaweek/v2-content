component persistent="true" {
	property name="blogPost" fieldtype="id,many-to-one" cfc="blogPost" column="blogPostid" ;   
	property name="blogCategory" fieldtype="id,many-to-one" cfc="blogCategory" column="blogCategoryid" ;   
}	