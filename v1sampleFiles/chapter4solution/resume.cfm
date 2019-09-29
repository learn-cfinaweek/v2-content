<cfquery name="mySkillSet" datasource="learncfinaweek">
	SELECT
		name
	FROM
		skillset
	ORDER BY
		name DESC
</cfquery>
<cfquery name="myResume" datasource="learncfinaweek">
	SELECT
		title,
		startDate,
		endDate,
		details,
		type
	FROM
		resume
	ORDER BY
		type,
		endDate,
		startDate
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
								<li class="resume" id="selected"><a href="resume.cfm">Resume</a></li>
								<li class="blog"><a href="blog.cfm">Blog</a></li>
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
			<!-- resume -->
				<div id="resume">
					<div class="clr">
						<div class="top-bg1">
							<div class="top-left">
								<div><h1>Resume</h1></div>
							</div> 
						</div>
						<div class="clr">
							<div class="pat-bottomleft">&nbsp;</div>
							<div class="pat-bottomright">&nbsp;</div>
						</div>
					</div>
					<div class="clr">
						<h6>
							<span>Experienced developer with over 10 years track record.</span> <br />  
							Professional web development and specializes in developing clean, effective and smart websites.
						</h6>
					</div>
					<div class="clr hline">&nbsp;</div>
					<div class="resume-top">	
						<div class="clr">
							<div class="left">
								<!-- Resume Listings -->
								<cfoutput query="myResume" group="type">
									<!-- Resume Listing Type -->
									<h2>#myResume.type# <span>&nbsp;</span></h2>
									<cfoutput>
										<!-- Start Resume Listing -->
										<h5>#myResume.title# <span>#dateFormat(myResume.startDate,"mm/dd/yyyy")# to <cfif len(myResume.endDate)>#dateFormat(myResume.endDate,"mm/dd/yyyy")#<cfelse>present</cfif> </span> </h5>
										<p>#myResume.details#</p>
										<!-- End Resume Listing -->
									</cfoutput>
								</cfoutput>
							</div>
							<div class="right" >
								<h2>My Skillset</h2>
								<!-- Skillset Graphic -->
								<div id="diagram" align="center">
									<div class="get">
										<div class="arc"> 
											<span class="text">HTML5</span>
											<input name="hidden" type="hidden" class="percent" value="80" />
											<input name="hidden" type="hidden" class="color" value="#93bf4f" />
										</div>
										<div class="arc"> 
											<span class="text">ColdFusion</span>
											<input name="hidden" type="hidden" class="percent" value="53" />
											<input name="hidden" type="hidden" class="color" value="#de6f96" />
										</div>
										<div class="arc"> 
											<span class="text">MySQL</span>
											<input name="hidden" type="hidden" class="percent" value="45" />
											<input name="hidden" type="hidden" class="color" value="#9bcedd" />
										</div>
										<div class="arc"> 
											<span class="text">JQuery</span>
											<input name="hidden" type="hidden" class="percent" value="95" />
											<input name="hidden" type="hidden" class="color" value="#aeaeae" />
										</div>
										<div class="arc"> 
											<span class="text">CSS3</span>
											<input name="hidden" type="hidden" class="percent" value="80" />
											<input name="hidden" type="hidden" class="color" value="#2caeb5" />
										</div>
									</div>
								</div>
								<!-- Skills Listing -->
								<div class="skills">
									<ul>
										<cfoutput>
											<cfloop query="mySkillset">
												<li class="#mySkillset.name#" is="#mySkillset.name#">#mySkillset.name#</li>
											</cfloop>
										</cfoutput>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="clr"></div>
				</div> <!--resume end -->
		
				<div class="clr"></div>
			</div><!--card pattern end -->
			<div class="clr "></div>
		</div>		  <!--content end -->	
		<div class="bottom-shade"></div>
	</div>  <!--Container / wrapper end -->	
</body>
</html>