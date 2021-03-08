<!---
  Created by djcar on 2/13/2017.
--->
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Learn CF</title>
        <link href="../../includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
    </head>
<cfparam name="p" default="introPage"/>
<body>
    <div class="container">
        <div id="header" class="row">
            <legend><h1>My CF Exercises</h1></legend>
        </div>
        <div id="maincontent" class="row">
            <div class="col-md-3" style="height:300px; border-right:thin solid gray">
                <cfinclude template="toc.cfm">
            </div>
            <div class="col-md-9">
                <cfif isdefined('p')>
                    <!--- Pssst! Look at introPage.cfm. Seeifyou can figure out what the cfinclude tag does
                     how it knows to open introPage.cfm.---->
                    <cfinclude template="#p#.cfm" />
                </cfif>
            </div>
        </div>
        <div id="footer" class="row">
            Janna Thomas * Website Database Development  * Week 4 Exercies
        </div>
    </div>
</body>
</html>