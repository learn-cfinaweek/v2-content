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
								<!-- Start Blog Post -->
								<h5>
									<span>8/6/2012 </span>
								</h5>
								<h2>
									<a href="blogpost.cfm?id=">WebSocket example with keyword highlighting</a>
								</h2>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce pulvinar erat eu metus egestas ut aliquet ante adipiscing. Maecenas eget laoreet dolor. Pellentesque sagittis nisl ac nulla semper facilisis pulvinar elit scelerisque. Nulla mollis fermentum eros a pulvinar. Mauris faucibus fringilla dolor, ut consectetur orci euismod eget. Phasellus ut dui ut tellus aliquam feugiat id at elit. Nulla facilisi. Suspendisse.</p>
								<p class="summary">
									<strong>Categories:</strong> ColdFusion <strong>Comments:</strong> 12
								</p>
								<!-- End Blog Post -->
								
								<h5>
									<span>8/6/2012 </span>
								</h5>
								<h2>
									<a href="blogpost.cfm?id=">ColdFusion scheduled tasks</a>
								</h2>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus urna in turpis eleifend vel faucibus eros sodales. Donec gravida nunc a metus semper tincidunt. Quisque porttitor ullamcorper massa et vestibulum. Aenean vulputate commodo placerat. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam sit amet suscipit lectus. Nunc convallis imperdiet bibendum. Nullam eu orci ut magna laoreet sodales ac id purus. Integer dapibus velit sit amet mi commodo ut hendrerit augue facilisis. Etiam rhoncus porta.</p>
								<p class="summary">
									<strong>Categories:</strong> ColdFusion <strong>Comments:</strong> 9
								</p>
				
								<h5>
									<span>8/6/2012 </span>
								</h5>
								<h2>
									<a href=blogpost.cfm?id="">ColdFusion Developer Week Recordings</a>
								</h2>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisi erat, ornare vehicula convallis at, viverra quis sapien. Ut gravida risus in eros semper quis eleifend erat aliquet. Duis tincidunt urna sed quam tempus imperdiet. Aenean in cursus odio. Fusce ornare, elit vel malesuada commodo, magna ipsum tempus sapien, et tempus urna enim eu diam. Aliquam accumsan, ante ut pharetra malesuada, mi nunc facilisis sem, non dictum massa ipsum sed diam. Phasellus.</p>
								<p class="summary">
									<strong>Categories:</strong> ColdFusion <strong>Comments:</strong> 1
								</p>
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