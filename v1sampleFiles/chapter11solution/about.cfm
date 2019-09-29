<cfscript>
	personalInfo = {name='Simon Free', dob='7/18/1981', address='123 A Street', phonenumber='(919) 555- 3228', email='simon@simonfree.com', website='http://www.simonfree.com', skype='mySkypeName'};
</cfscript>	
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="about">	
<!-- Content Start -->

<!--Card  -->
<div id="content">
	<div class="card-pattern">
	<!-- about -->
		<div id="about">
			<div class="clr">
				<div class="top-bg1">
					<div class="top-left">
						<div><h1>About me</h1></div>
					</div> 
				</div>
				<div class="clr">
					<div class="pat-bottomleft">&nbsp;</div>
					<div class="pat-bottomright">&nbsp;</div>
				</div>
			</div>
			<div class="clr">
				<h6>
					<span>A little about myself, and the UI &amp; UX design services I provide. </span> <br />.If you are interested to know something about me then you can read the info below.
				</h6>
			</div>
			<div class="clr hline">&nbsp;</div>
			<div class="clr">
				<div class="left">
					<div id="SliderBackground">
						<div id="Slider" align="center" >
							<img src="assets/images/headshot/headshot.jpg" alt="photo" />
						</div><!-- #Slider -->   
					</div><!-- #SliderBackground -->
				</div>
				<div class="content">
					<h2>A brief info about me</h2>
					<p>
						Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nunc ante, feugiat molestie fringilla id, faucibus ut sem. Aenean vitae purus vel nibh porttitor adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum congue lectus eu magna porta consectetur. Duis in adipiscing nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac. 
					</p>
					<h2>Stay Connected</h2>
					<ul class="no-list social-list">
						<li class="social-list-twitter"> <span>Twitter Profile</span> <a href="http://twitter.com/username">http://twitter.com/username</a> </li>
						<li class="social-list-facebook"> <span>Facebook Profile</span> <a href="http://facebook.com/username">http://facebook.com/username</a> </li>
					</ul>
				</div>
				<!-- Personal Information Output -->
				<div class="right">
					<h2>Personal Info</h2>
					<cfoutput>
						<div class="clr"><div class="input-box">Name </div><span>#personalInfo.name#</span> </div>
						<div class="clr"><div class="input-box">Date of birth </div><span> #personalInfo.dob#</span></div>
						<div class="clr"><div class="input-box">Address</div><span> #personalInfo.address#</span></div>
						<div class="clr"><div class="input-box">Phone</div> <span>#personalInfo.phonenumber#</span>  </div>
						<div class="clr"><div class="input-box">E-mail</div><span><a href="##">#application.utilities.convertStringToASCII(personalInfo.email)#</a></span>  </div>
						<div class="clr"><div class="input-box">Website </div> <span><a href="##">#personalInfo.website#</a></span> </div> 
						<div class="clr"><div class="box1">Skype </div> <span><a href="##">#personalInfo.skype#</a></span> </div> 
					</cfoutput>
				</div>
			</div>
			<div class="clr"></div>
		</div><!--about end -->
</layout:page>