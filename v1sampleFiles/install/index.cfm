<cflocation  url="insertDBdata.cfm">


<cfparam name="form.submitted" default="0">
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Import - Learn CF in a Week</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="../www/admin/assets/css/bootstrap.min.css" rel="stylesheet">

    <link href="../www/admin/assets/css/bootstrap-responsive.min.css" rel="stylesheet">

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>

  <body>
  	<div class="container">
		<div class="row">
			<div class="span12">
				<div class="well" style="margin-left:auto; margin-right:auto;width:700px;margin-top:100px;">
					
				
  	
<cfif !form.submitted>
<cfoutput>	
		<h2>
			Install
		</h2>
		<p>
			Please provide the following details:
		</p>
		<form class="form-horizontal" action="#cgi.script_name#" method="post">
			<div class="control-group">
				<label class="control-label" for="cfadmin">CF Administrator Password :<a class="pop" data-content="Use the password from step step 16 of Installing ColdFusion.  This is your ColdFUsion Administrator password." rel="popover" href="##" data-original-title="Which password to use?"><i class="icon-question-sign"></i></a></label>
				<div class="controls">
					<input type="password" id="cfadmin" placeholder="" name="cfadmin" tabindex="1">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="mysqlRoot">MySQL Root Password: <a class="pop" data-content="Use the password from step 15 of Installing MySQL.  This is your root password." rel="popover" href="##" data-original-title="Which password to use?"><i class="icon-question-sign"></i></a></label>
				<div class="controls">
					<input type="password" id="mysqlRoot" placeholder="" name="mysqlRoot" tabindex="2">
				</div>
			</div>
			<p>
				If you already had MySQL installed and did not follow the Installing MySQL instructions, you might need to update the information bellow.  If you followed the Installing MySQL Instructions then <strong>YOU DO NOT NEED TO MAKE ANY CHANGES</strong>
			</p>
			<div class="control-group">
				<label class="control-label" for="mysqlip">MySQL IP:</label>
				<div class="controls">
					<input type="text" id="mysqlip" placeholder="" name="mysqlip" value="localhost" tabindex="3">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="mysqlport">MySQL Port:</label>
				<div class="controls">
					<input type="text" id="mysqlport" placeholder="" name="mysqlport" value="3306" tabindex="4">
				</div>
			</div>
			 <div class="control-group">
				<div class="controls">
					<button type="submit" class="btn btn-primary" tabindex="5">Install</button>
				</div>
			</div>	
		
		
		<input type="hidden" name="submitted" value="1" />	
		
	</form>	
	
</cfoutput>	
<cfelse>
	<cfset systemName = CreateObject("java", "java.lang.System").getProperties()['os.name']>
	<cfset database = "learncfinaweek" />
	<cfset messageList='database,datasource,tables,data' />
	<cfset messages = {database={status='notPerformed', message='Database not created', detailedMessage=''}, datasource={status='notPerformed', message='Datasource not created', detailedMessage=''},tables={status='notPerformed', message='Tables not created', detailedMessage=''},data={status='notPerformed', message='Data not added', detailedMessage=''} } />
	<cfset dbCreated=false/>
	<!---
		Create Database
	--->
	
	<!---
		ToDo - Need to be able to check that the password is correct
	---->
	<cftry>
		
		<cfoutput>
			<cfif findnocase('mac',systemname)>
				<cfset checkbatchfilename = expandpath('checkDB.sh') />
				<cfset batchfilename = expandpath('createDB.sh') />
				
				<cfsavecontent variable="batchCheck">##!/bin/bash
				cd /usr/local/mysql/bin
				./mysql -u root -p#form.mysqlRoot# --execute="SHOW Databases" mysql
				</cfsavecontent>
				<cfsavecontent variable="batchContent">##!/bin/bash
				cd /usr/local/mysql/bin
				./mysql -uroot -p#form.mysqlRoot# -e "CREATE DATABASE #database#"
				</cfsavecontent>	
				
			<cfelseif findnocase('windows',systemname)>
				<cfset checkbatchfilename = expandpath('checkDB.bat') />
				<cfset batchfilename = expandpath('createDB.bat') />
				<cfsavecontent variable="batchCheck">cd C:\Program Files\MYSQL\MYSQL Server 5.5\bin
				mysql -u root -p#form.mysqlRoot# --execute="SHOW Databases" mysql
				</cfsavecontent>
				<cfsavecontent variable="batchContent">cd C:\Program Files\MYSQL\MYSQL Server 5.5\bin
				mysql -uroot -p#form.mysqlRoot# -e "CREATE DATABASE #database#"
				</cfsavecontent>		
			<cfelse>
				Operating system not found <cfdump var="#systemName#" abort />
			</cfif>			
				
			<cffile action="write" file="#checkbatchfilename#" output="#batchCheck#" mode="777">
			<cffile action="write" file="#batchfilename#" output="#batchContent#" mode="777">
			
			<cfexecute name="#checkbatchfilename#" arguments="" timeout="10" errorvariable="checkError" variable="checkOutput"></cfexecute>
			
			<cfif findnocase('Access denied for user',checkError)>
				<cfset messages['database'].message = 'Database - Incorrect MySQL Login Details' />
				<cfset messages['database'].status = 'bad' />
				<cfset messages['database'].detailedMessage = 'The password you provided for the Root user is not correct.  Go back to the previous page and re-enter your password.' />
				<cfthrow message = "Database creation failed">
			</cfif>
			<cfif findnocase('#database#',checkOutput)>
				<cfset messages['database'].message = 'Database already exists' />
				<cfset messages['database'].status = 'medium' />
			<cfelse>
				<cfexecute name="#batchfilename#" arguments="/c" timeout="10" errorvariable="batchError" variable="batchOutput"></cfexecute>
				
				<cfif len(batchError)>
					<cfif findnocase('command not found',batchError)>
						<cfset messages['database'].message = 'Database could not be created' />
						<cfset messages['database'].status = 'bad' />
						<cfset messages['database'].detailedMessage = 'Your copy of MySQL does not have the command line feature installed.  You must manually create  an empty database called learncfinaweek and retry the process.  To learn how to create a database click <a href="http://www.learncfinaweek.com/install/createdatabase/">here</a>.' />
					<cfelse>
						<cfset messages['database'].message = 'Database could not be created' />
						<cfset messages['database'].status = 'bad' />
						<cfset messages['database'].detailedMessage = 'We were not able to create the database.  Manually create an empty database called learncfinaweek and retry the process.  To learn how to create a database click <a href="http://www.learncfinaweek.com/install/createdatabase/">here</a>.' />
					</cfif>
						
					<cfthrow message = "Database creation failed">
				</cfif>	
				<cfset messages['database'].message = 'Database created successfully' />
				<cfset messages['database'].status = 'good' />	
			</cfif>	
		</cfoutput>
		<cfset dbCreated=true/>	
		<cfcatch type="any">
			<cfif messages['database'].status eq 'notPerformed'>
				<cfset messages['database'].message = 'Database could not be created' />
				<cfset messages['database'].status = 'bad' />
				<cfset messages['database'].detailedMessage = 'We were not able to create the database.  Manually create an empty database called learncfinaweek and retry the process.  To learn how to create a database click <a href="http://www.learncfinaweek.com/install/createdatabase/">here</a>.' />
			</cfif>
		</cfcatch>
	</cftry>
	
	<cfif dbCreated>
		<!---
			ToDo-Need to check that the admin password is correct
		--->
	<cftry>	
		<cfscript>
			try{
			    adminObj = createObject("component","cfide.adminapi.administrator");
			    adminObj.login(form.cfadmin);
			    
			    adminObj.isAdminUser();
			} catch(any exception){
				messages['database'].message = 'ColdFusion - Incorrect Administrator Login Details';
				messages['database'].detailedMessage = 'The password you provided for the ColdFusion Administrator is not correct.  Go back to the previous page and re-enter your password.';
				
				throw(message='ColdFusion Administrator Login Failed');
			}
		    // Instantiate the data source object.
		    myObj = createObject("component","cfide.adminapi.datasource");
			
			if(structKeyExists(myObj.getDatasources(),database)){
				messages['datasource'].message = 'Datasource already exists';
				messages['datasource'].status = 'medium';  
				
			}else{
				myObj.setMYSQL5(driver="MySQL5", 
			        name="#database#", 
			        host = "#form.mysqlip#", 
			        port = "#form.mysqlport#",
			        database = "#database#",
			        username = "root",
			        password = "#form.mysqlroot#",
			        login_timeout = "29",
			        timeout = "23",
			        interval = 6,
			        buffer = "64000",
			        blob_buffer = "64000",
			        setStringParameterAsUnicode = "false",
			        description = "learncfinaweek sample database",
			        pooling = true,
			        maxpooledstatements = 999,
			        enableMaxConnections = "true",
			        maxConnections = "299",
			        disable_clob = false,
			        disable_blob = false,
			        disable = false,
			        storedProc = false,
			        alter = true,
			        grant = false,
			        select = true,
			        update = true,
			        create = true,
			        delete = true,
			        drop = true,
			        revoke = false );
			        
			   messages['datasource'].message = 'Datasource created succesfully';
			   messages['datasource'].status = 'good';     
			}
		</cfscript>
		
		<!---
			Check that the Datasource connection is correct
		--->
		<cfset connectionSuccessfull = false />
		<cftry>
			<cfquery datasource="#database#" name="connectionTest">
				select * from information_schema.tables where table_schema = '#database#'
			</cfquery>
			<cfset connectionSuccessfull = true />
			<cfcatch type="any">
				<cfset messages['tables'].message = 'Database does not exist' />
				<cfset messages['tables'].detailedMessage = 'You must create a blank database called learncfinaweek.' />
				<cfset messages['tables'].status = 'bad' />	
			</cfcatch>	
		</cftry>	
		
		<!---
			Create Tables
		--->
		<cfif connectionSuccessfull>
			<cfset tableNames = valuelist(connectionTest.table_name) />
			
			<cftry>
				<cfif !listfindnocase(tableNames,'resume')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`resume` (
						  `id` INT NOT NULL AUTO_INCREMENT ,
						  `title` VARCHAR(100) NULL ,
						  `startDate` DATE NOT NULL ,
						  `endDate` DATE NULL ,
						  `details` TEXT NOT NULL ,
						  `type` VARCHAR(45) NOT NULL ,
						  PRIMARY KEY (`id`));
					</cfquery>	
				</cfif>	
				
				<cfif !listfindnocase(tableNames,'skillset')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`skillset` (
						  `id` INT NOT NULL AUTO_INCREMENT ,
						  `name` VARCHAR(45) NOT NULL ,
						  PRIMARY KEY (`id`) );
					</cfquery>	
				</cfif>
				
				<cfif !listfindnocase(tableNames,'portfolio')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`portfolio` (
							  `id` INT NOT NULL AUTO_INCREMENT ,
							  `title` VARCHAR(100) NOT NULL  ,
							  `summary` TEXT NULL ,
							  `website` VARCHAR(100) NULL ,
							  `image` VARCHAR(45) NULL ,
							  PRIMARY KEY (`id`) );
					</cfquery>	
				</cfif>
				
				<cfif !listfindnocase(tableNames,'category')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`category` (
							  `id` INT NOT NULL AUTO_INCREMENT ,
							  `name` VARCHAR(100) NOT NULL  ,
							  PRIMARY KEY (`id`) );
					</cfquery>	
				</cfif>
				
				<cfif !listfindnocase(tableNames,'post')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`post` (
							  `id` INT NOT NULL AUTO_INCREMENT ,
							  `title` VARCHAR(200) NOT NULL  ,
							  `summary` TEXT NULL  ,
							  `body` TEXT NULL  ,
							  `dateposted` DATE NULL  ,
							  `createddatetime` DATETIME NULL  ,
							  `modifieddatetime` DATETIME NULL  ,
							  `deleted` VARCHAR(100) NULL  ,
							  PRIMARY KEY (`id`) );
					</cfquery>	
				</cfif>	
				
				<cfif !listfindnocase(tableNames,'postcategoryjn')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`postcategoryjn` (
							  `postid` INT NOT NULL  ,
							  `categoryid` INT NOT NULL );
					</cfquery>	
				</cfif>
				
				<cfif !listfindnocase(tableNames,'administrator')>
					<cfquery datasource="#database#">
						CREATE  TABLE `#database#`.`administrator` (
							  `id` INT NOT NULL AUTO_INCREMENT ,
							  `firstname` VARCHAR(100) NOT NULL  ,
							  `lastname` VARCHAR(100) NOT NULL  ,
							  `emailaddress` VARCHAR(100) NOT NULL  ,
							  `password` VARCHAR(200) NOT NULL ,
							  `salt` VARCHAR(200) NULL, 
							  PRIMARY KEY (`id`) );
					</cfquery>		
				</cfif>			
				
				<cfif listfindnocase(tableNames,'resume') && listfindnocase(tableNames,'skillset') && listfindnocase(tableNames,'portfolio')>
					<cfset messages['tables'].message = 'Tables already exist' />
			   		<cfset messages['tables'].status = 'medium' />
				<cfelse>
					<cfset messages['tables'].message = 'Tables created succesfully' />
			   		<cfset messages['tables'].status = 'good' />	   
				</cfif>	
				   
				<cfcatch type="any">
					<cfset messages['tables'].message = 'Tables could not be created' />
					<cfset messages['tables'].detailedMessage = '' />
					<cfset messages['tables'].status = 'bad' />
				</cfcatch>
			</cftry>

			<cftry>
				<cfquery name="resumeCheck" datasource="#database#">
					SELECT
						count(id) as totalRows
					FROM
						resume
				</cfquery>
				
				<cfquery name="skillsetCheck" datasource="#database#">
					SELECT
						count(id) as totalRows
					FROM
						skillset
				</cfquery>
				
				<cfquery name="portfolioCheck" datasource="#database#">
					SELECT
						count(id) as totalRows
					FROM
						portfolio
				</cfquery>	
				
				<cfquery name="categoryCheck" datasource="#database#">
					SELECT
						count(id) as totalRows
					FROM
						category
				</cfquery>
				
				<cfquery name="postCheck" datasource="#database#">
					SELECT
						count(id) as totalRows
					FROM
						post
				</cfquery>	
				
				<cfquery name="postcategoryCheck" datasource="#database#">
					SELECT
						count(postid) as totalRows
					FROM
						postcategoryjn
				</cfquery>
				
				<cfquery name="administratorCheck" datasource="#database#">
					SELECT
						count(id) as totalRows
					FROM
						administrator
				</cfquery>			
				
				<cfif !resumeCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							resume (
							title,
							startDate,
							endDate,
							details,
							type
						) VALUES (
							'Junior Developer - Funkey Monkey Solutions',
							'2004-7-18',
							'2006-9-12',
							'Lorem ipsum dolor sit amet, habitasse pretium dolor sociis. Nulla et facilisis interdum elit amet erat, consectetuer condimentum eaque, ante maecenas Suspendisse libero diam.',
							'Work Experience'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							resume (
							title,
							startDate,
							endDate,
							details,
							type
						) VALUES (
							'Senior Developer - Hooligan Development',
							'2006-10-18',
							null,
							'Lorem ipsum dolor sit amet, habitasse pretium dolor sociis. Nulla et facilisis interdum elit amet erat, consectetuer condimentum eaque, ante maecenas.',
							'Work Experience'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							resume (
							title,
							startDate,
							endDate,
							details,
							type
						) VALUES (
							'NC State - Computer Science',
							'2000-9-7',
							'2004-4-5',
							'Lorem ipsum dolor sit amet, adipiscing elit. egestas.Vivamus sit amet ligula non lectus cursus egestas amet ligula non lectus cursus egestas.',
							'Education'
						);
					</cfquery>
				</cfif>
				
				<cfif !skillsetCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							skillset (
							name
						) VALUES (
							'ColdFusion'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							skillset (
							name
						) VALUES (
							'HTML5'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							skillset (
							name
						) VALUES (
							'CSS3'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							skillset (
							name
						) VALUES (
							'MySQL'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							skillset (
							name
						) VALUES (
							'JQuery'
						);
					</cfquery>
						
				</cfif>	
				
				<cfif !portfolioCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							portfolio (
							title,
							summary,
							website,
							image
						) VALUES (
							'Project Title 1',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisi erat, ornare vehicula convallis at, viverra quis sapien. Ut gravida risus in eros semper quis eleifend erat aliquet. Duis tincidunt urna sed quam tempus imperdiet. Aenean in cursus odio. Fusce ornare, elit vel malesuada commodo.',
							'http://www.project1.com',
							'portfolio1.png'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							portfolio (
							title,
							summary,
							website,
							image
						) VALUES (
							'Project Title 2',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisi erat, ornare vehicula convallis at, viverra quis sapien. Ut gravida risus in eros semper quis eleifend erat aliquet. Duis tincidunt urna sed quam tempus imperdiet. Aenean in cursus odio. Fusce ornare, elit vel malesuada commodo.',
							'http://www.project2.com',
							'portfolio2.png'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							portfolio (
							title,
							summary,
							website,
							image
						) VALUES (
							'Project Title 3',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisi erat, ornare vehicula convallis at, viverra quis sapien. Ut gravida risus in eros semper quis eleifend erat aliquet. Duis tincidunt urna sed quam tempus imperdiet. Aenean in cursus odio. Fusce ornare, elit vel malesuada commodo.',
							'http://www.project3.com',
							'portfolio3.png'
						);
					</cfquery>
						
					<cfquery datasource="#database#">
						INSERT INTO
							portfolio (
							title,
							summary,
							website,
							image
						) VALUES (
							'Project Title 4',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisi erat, ornare vehicula convallis at, viverra quis sapien. Ut gravida risus in eros semper quis eleifend erat aliquet. Duis tincidunt urna sed quam tempus imperdiet. Aenean in cursus odio. Fusce ornare, elit vel malesuada commodo.',
							'http://www.project4.com',
							'portfolio4.png'
						);
					</cfquery>	
				</cfif>		

				<cfif !categoryCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							category (
							name
						) VALUES (
							'ColdFusion'
						);
					</cfquery>	
					
					<cfquery datasource="#database#">
						INSERT INTO
							category (
							name
						) VALUES (
							'Development'
						);
					</cfquery>
					
					<cfquery datasource="#database#">
						INSERT INTO
							category (
							name
						) VALUES (
							'HTML5'
						);
					</cfquery>
					
					<cfquery datasource="#database#">
						INSERT INTO
							category (
							name
						) VALUES (
							'CSS3'
						);
					</cfquery>
					
					<cfquery datasource="#database#">
						INSERT INTO
							category (
							name
						) VALUES (
							'JQuery'
						);
					</cfquery>
				</cfif>	

				<cfif !postCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							post (
							title,
							summary,
							body,
							dateposted,
							createdDateTime,
							modifiedDateTime,
							deleted
						) VALUES (
							'WebSocket example with keyword highlighting',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce pulvinar erat eu metus egestas ut aliquet ante adipiscing. Maecenas eget laoreet dolor. Pellentesque sagittis nisl ac nulla semper facilisis pulvinar elit scelerisque. Nulla mollis fermentum eros a pulvinar. Mauris faucibus fringilla dolor, ut consectetur orci euismod eget. Phasellus ut dui ut tellus aliquam feugiat id at elit. Nulla facilisi. Suspendisse.',
							'<p>
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id dignissim nunc. Mauris a massa sit amet dui sagittis ullamcorper sed at purus. Cras enim massa, laoreet vitae egestas ac, viverra eget lacus. Nam ac turpis id libero fringilla tempus. Sed sem dolor, vestibulum vitae iaculis id, dapibus quis dui. Praesent vel felis nisl, eget accumsan mauris. Vivamus neque eros, accumsan elementum dapibus sit amet, placerat a felis. Aliquam eget eros magna. Morbi quis iaculis tortor. Fusce vitae elit vel nunc suscipit pellentesque. In hac habitasse platea dictumst. Mauris pharetra lacinia mauris eu auctor. Morbi vitae est euismod elit pretium fringilla a vitae sem. Nam lectus ante, rhoncus vitae malesuada quis, pellentesque vitae nibh. Etiam congue metus sed libero cursus vitae rhoncus felis pellentesque. Maecenas tincidunt commodo est, eget imperdiet nibh commodo vel.
							</p>
							<p>
								Sed augue arcu, bibendum sit amet viverra et, facilisis sed ipsum. Nullam orci quam, tincidunt a imperdiet at, lacinia vel risus. Aliquam quis scelerisque purus. Curabitur dui ligula, lobortis vitae viverra sit amet, eleifend id metus. Vivamus varius mi non quam interdum eu tincidunt arcu ullamcorper. In magna nisl, semper vitae ornare ac, bibendum vel lectus. Vivamus pulvinar urna vel libero scelerisque nec malesuada augue auctor. Morbi faucibus justo a odio sollicitudin scelerisque eu et diam. Nulla vel nisi quis augue egestas sollicitudin. Duis auctor libero eu massa volutpat dignissim. Phasellus commodo, arcu ac congue pretium, libero enim lobortis orci, id tempus libero nulla interdum lorem. Proin varius ipsum sit amet urna fermentum in laoreet leo faucibus. Mauris cursus, tellus eget auctor euismod, nunc dui rutrum urna, at auctor nunc mauris vel nisi. Etiam suscipit elit id nulla blandit ut faucibus felis interdum.
							</p>
							<p>	
								Integer auctor urna non nibh euismod elementum. Nullam velit nisi, bibendum in pulvinar sed, aliquet tempus tortor. Phasellus eleifend metus mauris. Phasellus at mi et ligula tincidunt malesuada eget ac est. Ut elementum, massa ac pulvinar tempor, est nisl lacinia nisl, sed ornare diam nibh vitae ipsum. Donec molestie consectetur nisi eget pretium. Quisque tincidunt eleifend vulputate. Vivamus eu ante vitae eros eleifend suscipit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc suscipit dolor egestas erat ornare sollicitudin. Nulla facilisi.
							</p>
							<p>
								Quisque id mi sapien, in tincidunt est. Proin metus metus, dignissim ultricies commodo at, scelerisque vel lectus. Vivamus nec auctor sapien. Nulla lobortis, neque vel pretium aliquet, diam metus congue dolor, eu aliquam ante ligula eget velit. Mauris vulputate, massa at ultricies tincidunt, est urna vehicula erat, eget consequat metus erat ut nisi. Vivamus dapibus mauris nec massa eleifend vitae adipiscing arcu cursus. Duis ac libero ante. Integer nec augue dolor. Suspendisse ligula urna, imperdiet et congue vitae, aliquet non nulla. Nunc dignissim justo vel leo sodales varius. Quisque malesuada ornare nisl, et eleifend lectus molestie ut. Vestibulum a risus eu felis elementum bibendum. Curabitur ac justo eu risus laoreet sagittis.
							</p>
							<p>
								Suspendisse ac felis lacus. Nulla facilisi. Curabitur porttitor sapien vel est sollicitudin commodo. Donec consectetur, orci in venenatis malesuada, purus orci gravida leo, ac sollicitudin nulla arcu eu nisi. Ut rutrum, nisl at condimentum varius, risus turpis aliquet risus, quis venenatis tellus velit eu orci. Maecenas aliquam nunc et purus tincidunt dictum. Donec tempus sodales turpis ac consectetur. Sed nibh turpis, ornare egestas rhoncus sed, rhoncus vel arcu. Cras sit amet accumsan justo. Mauris in nisl non lacus pellentesque scelerisque ut sed neque. Nulla et sollicitudin enim. Nam at nisi ante, ac sagittis purus.
							</p>',
							'2012-9-18',
							'2012-9-17 13:37:40',
							'2012-9-17 13:37:40',
							0
						);
					</cfquery>
					
					<cfquery datasource="#database#">
						INSERT INTO
							post (
							title,
							summary,
							body,
							dateposted,
							createdDateTime,
							modifiedDateTime,
							deleted
						) VALUES (
							'ColdFusion scheduled tasks',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce pulvinar erat eu metus egestas ut aliquet ante adipiscing. Maecenas eget laoreet dolor. Pellentesque sagittis nisl ac nulla semper facilisis pulvinar elit scelerisque. Nulla mollis fermentum eros a pulvinar. Mauris faucibus fringilla dolor, ut consectetur orci euismod eget. Phasellus ut dui ut tellus aliquam feugiat id at elit. Nulla facilisi. Suspendisse.',
							'<p>
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id dignissim nunc. Mauris a massa sit amet dui sagittis ullamcorper sed at purus. Cras enim massa, laoreet vitae egestas ac, viverra eget lacus. Nam ac turpis id libero fringilla tempus. Sed sem dolor, vestibulum vitae iaculis id, dapibus quis dui. Praesent vel felis nisl, eget accumsan mauris. Vivamus neque eros, accumsan elementum dapibus sit amet, placerat a felis. Aliquam eget eros magna. Morbi quis iaculis tortor. Fusce vitae elit vel nunc suscipit pellentesque. In hac habitasse platea dictumst. Mauris pharetra lacinia mauris eu auctor. Morbi vitae est euismod elit pretium fringilla a vitae sem. Nam lectus ante, rhoncus vitae malesuada quis, pellentesque vitae nibh. Etiam congue metus sed libero cursus vitae rhoncus felis pellentesque. Maecenas tincidunt commodo est, eget imperdiet nibh commodo vel.
							</p>
							<p>
								Sed augue arcu, bibendum sit amet viverra et, facilisis sed ipsum. Nullam orci quam, tincidunt a imperdiet at, lacinia vel risus. Aliquam quis scelerisque purus. Curabitur dui ligula, lobortis vitae viverra sit amet, eleifend id metus. Vivamus varius mi non quam interdum eu tincidunt arcu ullamcorper. In magna nisl, semper vitae ornare ac, bibendum vel lectus. Vivamus pulvinar urna vel libero scelerisque nec malesuada augue auctor. Morbi faucibus justo a odio sollicitudin scelerisque eu et diam. Nulla vel nisi quis augue egestas sollicitudin. Duis auctor libero eu massa volutpat dignissim. Phasellus commodo, arcu ac congue pretium, libero enim lobortis orci, id tempus libero nulla interdum lorem. Proin varius ipsum sit amet urna fermentum in laoreet leo faucibus. Mauris cursus, tellus eget auctor euismod, nunc dui rutrum urna, at auctor nunc mauris vel nisi. Etiam suscipit elit id nulla blandit ut faucibus felis interdum.
							</p>
							<p>	
								Integer auctor urna non nibh euismod elementum. Nullam velit nisi, bibendum in pulvinar sed, aliquet tempus tortor. Phasellus eleifend metus mauris. Phasellus at mi et ligula tincidunt malesuada eget ac est. Ut elementum, massa ac pulvinar tempor, est nisl lacinia nisl, sed ornare diam nibh vitae ipsum. Donec molestie consectetur nisi eget pretium. Quisque tincidunt eleifend vulputate. Vivamus eu ante vitae eros eleifend suscipit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc suscipit dolor egestas erat ornare sollicitudin. Nulla facilisi.
							</p>
							<p>
								Quisque id mi sapien, in tincidunt est. Proin metus metus, dignissim ultricies commodo at, scelerisque vel lectus. Vivamus nec auctor sapien. Nulla lobortis, neque vel pretium aliquet, diam metus congue dolor, eu aliquam ante ligula eget velit. Mauris vulputate, massa at ultricies tincidunt, est urna vehicula erat, eget consequat metus erat ut nisi. Vivamus dapibus mauris nec massa eleifend vitae adipiscing arcu cursus. Duis ac libero ante. Integer nec augue dolor. Suspendisse ligula urna, imperdiet et congue vitae, aliquet non nulla. Nunc dignissim justo vel leo sodales varius. Quisque malesuada ornare nisl, et eleifend lectus molestie ut. Vestibulum a risus eu felis elementum bibendum. Curabitur ac justo eu risus laoreet sagittis.
							</p>
							<p>
								Suspendisse ac felis lacus. Nulla facilisi. Curabitur porttitor sapien vel est sollicitudin commodo. Donec consectetur, orci in venenatis malesuada, purus orci gravida leo, ac sollicitudin nulla arcu eu nisi. Ut rutrum, nisl at condimentum varius, risus turpis aliquet risus, quis venenatis tellus velit eu orci. Maecenas aliquam nunc et purus tincidunt dictum. Donec tempus sodales turpis ac consectetur. Sed nibh turpis, ornare egestas rhoncus sed, rhoncus vel arcu. Cras sit amet accumsan justo. Mauris in nisl non lacus pellentesque scelerisque ut sed neque. Nulla et sollicitudin enim. Nam at nisi ante, ac sagittis purus.
							</p>',
							'2012-9-1',
							'2012-9-1 10:37:40',
							'2012-9-1 13:40:50',
							0
						);
					</cfquery>
					
					<cfquery datasource="#database#">
						INSERT INTO
							post (
							title,
							summary,
							body,
							dateposted,
							createdDateTime,
							modifiedDateTime,
							deleted
						) VALUES (
							'ColdFusion Developer Week Recordings',
							'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce pulvinar erat eu metus egestas ut aliquet ante adipiscing. Maecenas eget laoreet dolor. Pellentesque sagittis nisl ac nulla semper facilisis pulvinar elit scelerisque. Nulla mollis fermentum eros a pulvinar. Mauris faucibus fringilla dolor, ut consectetur orci euismod eget. Phasellus ut dui ut tellus aliquam feugiat id at elit. Nulla facilisi. Suspendisse.',
							'<p>
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id dignissim nunc. Mauris a massa sit amet dui sagittis ullamcorper sed at purus. Cras enim massa, laoreet vitae egestas ac, viverra eget lacus. Nam ac turpis id libero fringilla tempus. Sed sem dolor, vestibulum vitae iaculis id, dapibus quis dui. Praesent vel felis nisl, eget accumsan mauris. Vivamus neque eros, accumsan elementum dapibus sit amet, placerat a felis. Aliquam eget eros magna. Morbi quis iaculis tortor. Fusce vitae elit vel nunc suscipit pellentesque. In hac habitasse platea dictumst. Mauris pharetra lacinia mauris eu auctor. Morbi vitae est euismod elit pretium fringilla a vitae sem. Nam lectus ante, rhoncus vitae malesuada quis, pellentesque vitae nibh. Etiam congue metus sed libero cursus vitae rhoncus felis pellentesque. Maecenas tincidunt commodo est, eget imperdiet nibh commodo vel.
							</p>
							<p>
								Sed augue arcu, bibendum sit amet viverra et, facilisis sed ipsum. Nullam orci quam, tincidunt a imperdiet at, lacinia vel risus. Aliquam quis scelerisque purus. Curabitur dui ligula, lobortis vitae viverra sit amet, eleifend id metus. Vivamus varius mi non quam interdum eu tincidunt arcu ullamcorper. In magna nisl, semper vitae ornare ac, bibendum vel lectus. Vivamus pulvinar urna vel libero scelerisque nec malesuada augue auctor. Morbi faucibus justo a odio sollicitudin scelerisque eu et diam. Nulla vel nisi quis augue egestas sollicitudin. Duis auctor libero eu massa volutpat dignissim. Phasellus commodo, arcu ac congue pretium, libero enim lobortis orci, id tempus libero nulla interdum lorem. Proin varius ipsum sit amet urna fermentum in laoreet leo faucibus. Mauris cursus, tellus eget auctor euismod, nunc dui rutrum urna, at auctor nunc mauris vel nisi. Etiam suscipit elit id nulla blandit ut faucibus felis interdum.
							</p>
							<p>	
								Integer auctor urna non nibh euismod elementum. Nullam velit nisi, bibendum in pulvinar sed, aliquet tempus tortor. Phasellus eleifend metus mauris. Phasellus at mi et ligula tincidunt malesuada eget ac est. Ut elementum, massa ac pulvinar tempor, est nisl lacinia nisl, sed ornare diam nibh vitae ipsum. Donec molestie consectetur nisi eget pretium. Quisque tincidunt eleifend vulputate. Vivamus eu ante vitae eros eleifend suscipit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc suscipit dolor egestas erat ornare sollicitudin. Nulla facilisi.
							</p>
							<p>
								Quisque id mi sapien, in tincidunt est. Proin metus metus, dignissim ultricies commodo at, scelerisque vel lectus. Vivamus nec auctor sapien. Nulla lobortis, neque vel pretium aliquet, diam metus congue dolor, eu aliquam ante ligula eget velit. Mauris vulputate, massa at ultricies tincidunt, est urna vehicula erat, eget consequat metus erat ut nisi. Vivamus dapibus mauris nec massa eleifend vitae adipiscing arcu cursus. Duis ac libero ante. Integer nec augue dolor. Suspendisse ligula urna, imperdiet et congue vitae, aliquet non nulla. Nunc dignissim justo vel leo sodales varius. Quisque malesuada ornare nisl, et eleifend lectus molestie ut. Vestibulum a risus eu felis elementum bibendum. Curabitur ac justo eu risus laoreet sagittis.
							</p>
							<p>
								Suspendisse ac felis lacus. Nulla facilisi. Curabitur porttitor sapien vel est sollicitudin commodo. Donec consectetur, orci in venenatis malesuada, purus orci gravida leo, ac sollicitudin nulla arcu eu nisi. Ut rutrum, nisl at condimentum varius, risus turpis aliquet risus, quis venenatis tellus velit eu orci. Maecenas aliquam nunc et purus tincidunt dictum. Donec tempus sodales turpis ac consectetur. Sed nibh turpis, ornare egestas rhoncus sed, rhoncus vel arcu. Cras sit amet accumsan justo. Mauris in nisl non lacus pellentesque scelerisque ut sed neque. Nulla et sollicitudin enim. Nam at nisi ante, ac sagittis purus.
							</p>',
							'2012-8-23',
							'2012-8-3 08:02:00',
							'2012-8-19 22:54:12',
							0
						);
					</cfquery>
				</cfif>

				<cfif !postCategoryCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							postcategoryjn (
							postid,
							categoryid
						) VALUES (
							1,
							1
						);
					</cfquery>
					<cfquery datasource="#database#">
						INSERT INTO
							postcategoryjn (
							postid,
							categoryid
						) VALUES (
							1,
							2
						);
					</cfquery>
					<cfquery datasource="#database#">
						INSERT INTO
							postcategoryjn (
							postid,
							categoryid
						) VALUES (
							2,
							2
						);
					</cfquery>
					<cfquery datasource="#database#">
						INSERT INTO
							postcategoryjn (
							postid,
							categoryid
						) VALUES (
							3,
							1
						);
					</cfquery>
					<cfquery datasource="#database#">
						INSERT INTO
							postcategoryjn (
							postid,
							categoryid
						) VALUES (
							3,
							3
						);
					</cfquery>
					
				</cfif>		
				
				<cfif !administratorCheck.totalRows>
					<cfquery datasource="#database#">
						INSERT INTO
							administrator (
							firstname,
							lastname,
							emailaddress,
							password,
							salt
						) VALUES (
							'Your',
							'Name',
							'admin@mywebsite.com',
							'admin',
							''
						);
					</cfquery>
					
				</cfif>	
				
				<cfif resumeCheck.totalRows && skillsetCheck.totalRows && portfolioCheck.totalRows>
					<cfset messages['data'].message = 'Data was not imported' />
					<cfset messages['data'].detailedMessage = 'The tables already had data in them so no data was imported' />
					<cfset messages['data'].status = 'medium' />
				<cfelse>
					<cfset messages['data'].message = 'Data imported succesfully' />
			   		<cfset messages['data'].status = 'good' />
				</cfif>	

				<cfcatch type="any">
					<cfset messages['data'].message = 'Data could not be imported' />
					<cfset messages['data'].detailedMessage = '' />
					<cfset messages['data'].status = 'bad' />
				</cfcatch>
			</cftry>

		</cfif>
		
		<cfcatch type="any">
			<cfdump var="#cfcatch#" />
		</cfcatch>		
	</cftry>
	</cfif>	
	
	<h2>
		Install - Result
	</h2>
	<cfoutput>	
		<dl>
		<cfloop list="#messageList#" index="item">
			<dt><img src="../www/admin/assets/images/#messages[item].status#.png" border="0"> #messages[item].message#</dt>
			<cfif len(messages[item].detailedMessage)>
				<dd>#messages[item].detailedMessage#</dd>
			</cfif>
		</cfloop>	
		</dl>
	</cfoutput>
</cfif>
				</div>
			</div>
		</div>
	</div>		

   <script src="../www/admin/assets/js/jquery-1.7.min.js"></script>
    <script src="../www/admin/assets/js/bootstrap.min.js"></script>
	<script src="../www/admin/assets/js/custom.js"></script>

  </body>
</html>		