<!doctype html>
<html lang="eng">
        <head>
            <meta charset="utf-8">
            <title>Book Store Manager View</title>
            <!--- Link to Bootstrap ....--->
            <link href="/CodeBase/includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
            <link href="../../includes/css/mycss.css" rel="stylesheet"/>
            <!--- Link to jQuery and the bootstrap Javascript --->
                <script src="/CodeBase/includes/js/jQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
                <script src="/CodeBase/includes/bootstrap/js/bootstrap.js" type="text/javascript"></script>

            <script src="/includes/ckeditor/ckeditor.js"></script>
        </head>

        <cfparam name="tool" default="addedit">
    <body>
<div id="wrapper" class="container">
            <div id="topHeader" class="row">
                <cfinclude template="../header.cfm">
            </div>

            <div id="hoizontalnav" class="row">
                <cfinclude template="managementnavbar.cfm" />
            </div>

            <div id="maincontent" class="row">
                <cfinclude template="#tool#.cfm">
            </div>

            <div id="footer" class="row">
                <cfinclude template="../footer.cfm">
            </div>
        </div>
    </body>
</html>