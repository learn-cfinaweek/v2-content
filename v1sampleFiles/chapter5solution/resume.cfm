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
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="resume">	
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
</layout:page>