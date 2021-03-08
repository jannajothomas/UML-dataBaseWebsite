<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>UML Database Course - name</title>
</head>
<cfparam name="content" default="" />
<cfif content neq ''>
	<cffile action="read" file="#expandpath('/')#includes/#content#" variable="content" />
</cfif>
<cfinclude template="/includes/names.cfm" />
<cfdirectory directory="#expandpath('.')#" name="alldirs" recurse="no" type="dir">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link href="/includes/css/class.css" type="text/css" rel="stylesheet">
<script src="/includes/js/class.js" type="text/javascript"></script>
<body>
	<div id="wrapper" class="col-lg-12">
    	<cfoutput>
			<div id="adminnav" style="float:none; clear:both; height:50px; ">
				<ul class="nav nav-pills" style="margin-left:auto; display:block; ">
					<li style="float:right"><a class="nav-link">Welcome #session.firstname#</a></li>
					<li style="float:right"><a class="nav-link" href="https://uml.umassonline.net/" target="_blank">Class Blackboard Site</a> </li>
				</ul>
			</div>
		
        <div id="topheader">Class INFO 2480 Web Site Database Implementation - #trim(session.firstname)# #trim(session.lastname)#'s Table of Contents Page</div></cfoutput>
		<div id="mainarea" class="row">
			<div id="leftgutter" class="col-2">
				<ul class="nav flex-column">
					<li class="nav-item" style="cursor:pointer"><a onclick="getarticle('aboutpage.cfm')" target="_blank">What is this page?</a></li>
					<cfoutput query="alldirs">
						<cfif name neq 'includes'>
							<li><a class="nav-link" href="#name#" target="_blank">#name#</a></li>
						</cfif>
					</cfoutput>
				<li><hr/></li>
                <!---
					Add your custom links below this line.
					To keep the same formatting as the above items, use this format:
					 <li><a href="link to folder/file">Name of link </a></li>
					
				--->

				</ul>
			</div>
			<div id="center" class="col-9">
            	<cfoutput>
					<cfif content neq ''>
    	            	#content#
        	        </cfif>
				</cfoutput>
            </div>
		</div>
	</div>
</body>
</html>

