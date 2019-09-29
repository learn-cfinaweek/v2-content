<cfset myName="Simon" />
<cfset myPosition="A Developer" />
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="home">  	
<!-- Content Start -->

<!--Card  -->
<div id="content">
	<div class="card-pattern">
		<!--home -->
		<div id="home">
			<div class="clr">
				<div class="top-bg">
					<div class="top-left" >
						<!-- Data Output -->
						<!---This is where the name and position are output--->
						<div class="tag">HELLO, <span>I'M <cfoutput>#myName#</cfoutput>,</span></div>
						<div class="sub-tag"><cfoutput>#myPosition#</cfoutput></div>
					</div> 
				</div>
			</div>
			<div class="clr">
				<div class="pat-topleft">&nbsp;</div>
				<div class="middle"></div>
				<div class="pat-topright">&nbsp;</div>
			</div>
			<div class="clr pat" >
				<p>Professional Web design and Development and specializes in developing <span>clean, effective and smart&nbsp;&nbsp;</span>websites.</p>
			</div>
			<div class="clr">
				<div class="pat-bottomleft">&nbsp;</div>
				<div class="pat-bottomright">&nbsp;</div>
			</div>
			<div class="clr">
				<h2>Specialising in</h2>
				<div class="special">
					Lorem ipsum dolor sit amet, habitasse pretium dolor sociis. Nulla et facilisis interdum elit amet.
				</div>
			</div>
			<div class="clr">
				<div> 
					<div class="coldfusion">
						<img src='assets/images/coldfusion-image.png'  border="0" height="" alt=" "  />
						<h3>ColdFusion<br />Coding</h3>
					</div>
					<div class="jquery">
						<img src='assets/images/jquery-image.png'  border="0" height="" alt=" " />
						<h3>jQuery <br />Customisation</h3>
					</div>
					<div class="css">
						<img src='assets/images/css-image.png'  border="0" height="" alt=" "  />
						<h3>CSS 3<br />Customisation</h3>
					</div>
					<div class="html">
						<img src='assets/images/html-image.png' alt=" " height=""  border="0" />
						<h3>HTML 5<br /> Customisation</h3>
					</div>
				</div>
			</div>
			<div class="clr bottom-space"></div>
		</div>
		<!--home end -->
</layout:page>