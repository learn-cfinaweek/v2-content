<cfquery name="myBlog" datasource="learncfinaweek">
	SELECT
		title,
		summary,
		datePosted
	FROM
		post
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="description" content="Clean Slide Responsive Vcard Template" />
	<meta name="keywords" content="jquery, Responsive Vcard, Template, Vcard, Clean Slide" />
	<meta http-equiv="X-UA-Compatible" content="IE=9" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<title>This is my WebSite</title>
	
	<!-- Loading Google Web fonts -->
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,700' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/css?family=IM+Fell+DW+Pica' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />
	
	<!-- CSS Files -->
	<link href="assets/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="assets/css/style.css" rel="stylesheet" type="text/css"  id="color" />
	<link href="assets/css/typography.css" rel="stylesheet" type="text/css"  id="customFont"/>
	<link href="assets/css/arial_content.css" rel="stylesheet" type="text/css"  id="contentfont"/>
	
	<!-- include jQuery library -->
	<script type="text/javascript" src="assets/js/jquery-1.7.min.js"></script>

	<script src="assets/js/raphael.js" type="text/javascript"></script>
	<script src="assets/js/init.js" type="text/javascript"></script>
</head>
	
<body>

	<!-- wrapper -->
	<div class="clr" id="top-head">&nbsp;</div>
	<div id="container">
		<!--header -->
		<div id="header" >
			<div class="logo-bg" >
				<!--logo -->
				<div class="logo">
					<img src="assets/images/logo.png" alt="Logo" width="202" height="52" border="0"  id="logo" />
				</div>
				
				<!--head right -->
				<div class="right">
				
					<!--// Navigation //-->
					<div class="menu_nav">
						<div id="nav-wrap">
							<ul class="arrowunderline" id="nav">
								<li class="home"><a href="index.cfm">Home</a></li>
								<li class="about"><a href="about.cfm">About</a></li>
								<li class="resume"><a href="resume.cfm">Resume</a></li>
								<li class="blog" id="selected"><a href="blog.cfm">Blog</a></li>
								<li class="portfolio"><a href="portfolio.cfm">Portfolio</a></li>
								<li class="contact"><a href="contact.cfm">Contact</a></li>	
							</ul>
						</div>
					</div>
					<!--// Navigation End //-->
				</div>
				<!--// -head right end //-->
			</div>
			<!--// logo bg end //-->
		</div>
		<!--header end -->
		
		<!-- Content Start -->
    
		<!--Card  -->
		<div id="content">
			<div class="card-pattern">
				<!-- blog -->
				<div id="blog">
					<div class="clr">
						<div class="top-bg1">
							<div class="top-left">
								<div><h1>Blog</h1></div>
							</div> 
						</div>
						<div class="clr">
							<div class="pat-bottomleft">&nbsp;</div>
							<div class="pat-bottomright">&nbsp;</div>
						</div>
					</div>
					<div class="blog-top">	
						<div class="clr">
							<div class="left">
								<!-- Blog Posts -->
								<cfoutput query="myBlog">
									<!-- Start Blog Post -->
									<h5>
										<span>#dateFormat(myBlog.datePosted,"mm/dd/yyyy")# </span>
									</h5>
									<h2>
										<a href="blogpost.cfm?id=">#myBlog.title#</a>
									</h2>
									<p>#myBlog.summary#</p>
									<p class="summary">
										<strong>Categories:</strong> ColdFusion <strong>Comments:</strong> 12
									</p>
									<!-- End Blog Post -->
								</cfoutput>
							</div>
							<div class="right" >
								<h2>Categories</h2>
								<!-- Blog Categories -->
								<div id="categories" align="center">
									<ul>
										<li><a href="#">ColdFusion</a></li>
										<li><a href="#">Development</a></li>
										<li><a href="#">HTML5</a></li>
										<li><a href="#">Javascript</a></li>
										<li><a href="#">jQuery</a></li>
										<li><a href="#">Misc</a></li>
										<li><a href="#">Video Games</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="clr"></div>
				</div> <!--blog end -->

				<div class="clr"></div>
			</div><!--card pattern end -->
			<div class="clr "></div>
		</div>		  <!--content end -->	
		<div class="bottom-shade"></div>
	</div>  <!--Container / wrapper end -->	
</body>
</html>