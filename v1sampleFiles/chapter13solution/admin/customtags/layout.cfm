<cfparam name="attributes.section" default="" />
<cfparam name="url.message" default="" />
<cfif thisTag.executionMode eq "start">
<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name)/>
<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>#attributes.section#: My Personal Website</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="#adminPath#/assets/css/bootstrap.min.css" rel="stylesheet">
	<link href="#adminPath#/assets/css/datepicker.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link href="#adminPath#/assets/css/bootstrap-responsive.min.css" rel="stylesheet">

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#adminPath#/index.cfm">My Website Admin</a>
          <div class="nav-collapse collapse">
            <p class="navbar-text pull-right">
             <cfif structKeyExists(session,'emailaddress') && len(session.emailaddress)> Logged in as <a href="#adminPath#/logout.cfm" class="navbar-link">#session.emailAddress#</a></cfif>
            </p>
            <ul class="nav">
              <li <cfif attributes.section eq "home">class="active"</cfif>><a href="#adminPath#/index.cfm">Home</a></li>
              <li <cfif attributes.section eq "resume">class="active"</cfif>><a href="#adminPath#/content/resume/listworkexperience.cfm">Resume</a></li>
			  <li <cfif attributes.section eq "blog">class="active"</cfif>><a href="#adminPath#/content/blog/listblogpost.cfm">Blog</a></li>
			  <li <cfif attributes.section eq "portfolio">class="active"</cfif>><a href="#adminPath#/content/portfolio/listportfolio.cfm">Portfolio</a></li>
			  <li <cfif attributes.section eq "system">class="active"</cfif>><a href="#adminPath#/content/system/listadministrator.cfm">System</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
      	<cfif len(trim(url.message))>
		  	<div class="alert alert-success">
		  		#url.message#
		  	</div>
		</cfif>	
</cfoutput>	      	
<cfelse>
		</div><!--/row-->


    </div><!--/.fluid-container-->
	<cfoutput>
    <script src="#adminPath#/assets/js/jquery-1.7.min.js"></script>
    <script src="#adminPath#/assets/js/bootstrap.min.js"></script>
	<script src="#adminPath#/assets/js/bootstrap-datepicker.js"></script>
	<script src="#adminPath#/assets/js/custom.js"></script>
	<script type="text/javascript" src="#adminPath#/../../ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="#adminPath#/../../ckeditor/adapters/jquery.js"></script>
	</cfoutput>
  </body>
</html>

</cfif>	