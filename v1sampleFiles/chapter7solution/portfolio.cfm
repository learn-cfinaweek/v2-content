<cfquery name="myPortfolio">
	SELECT
		title,
		summary,
		website,
		image
	FROM
		portfolio
	ORDER BY
		title
</cfquery>
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="portfolio">		
<!-- Content Start -->

<!--Card  -->
<div id="content">
	<div class="card-pattern">
	<!-- portfolio -->
		<div id="portfolio">
			<div class="clr">
				<div class="top-bg1">
					<div class="top-left">
						<div>
							<h1>Portfolio</h1>
						</div>
					</div> 
				</div>
				<div class="clr">
					<div class="pat-bottomleft">&nbsp;</div>
					<div class="pat-bottomright">&nbsp;</div>
				</div>
			</div>
			<div class="clr">
				<h6>
					<span> I build great sites <br /></span>Hello, thanks for visiting this section. Here’s a collection of some of my work.
				</h6>
			</div>
			<div class="clr hline">&nbsp;</div>
			<div class="clr">
				<div>
					<ul id="portfolio-list">
						<!-- Start Portfolio -->
						<cfoutput>
							<cfloop query="myPortfolio">
								<li>
									<div class="left">
										<a href="#myPortfolio.website#" title="#myPortfolio.title#" class="viewDetail ">
											<img src="assets/images/portfolio/#myPortfolio.image#"   alt=" " border="0" />
											<h5>#myPortfolio.title#</h5>
										</a>
									</div>
									<div class="right">
										<p>
											#myPortfolio.summary#
										</p>
									</div>
								</li>  
							</cfloop>  
						</cfoutput>
						<!-- End Portfolio -->
					</ul>
				</div>
				<!-- demowrap end-->       
			</div>
			<!-- clr end -->
			<div class="clr"></div>
		</div>
		<!-- portfolio end -->
</layout:page>