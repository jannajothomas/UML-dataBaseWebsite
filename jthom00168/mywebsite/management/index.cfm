<!doctype html>
    <html>
        <head>
            <meta charset="utf-8"> <title>Book Store Manager View</title>
        <!--- Links to Bootstrap ....--->
            <link href="/CodeBase/includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
          <!--  <link href="../../includes/css/mycss.css" rel="stylesheet"/>  -->
        </head>

        <cfparam name="tool" default="addedit">

    <body>
        <div class="container">
            <div id="topHeader" class="row">
                <cfinclude template="../header.cfm">
            </div>

            <div class="col-lg-12 row">
                <cfinclude template="managementnavbar.cfm" />
            </div>

            <div class="col-lg-12 row">
                <cfinclude template="#tool#.cfm">
            </div>

            <div id="footer" class="row">
                <cfinclude template="../footer.cfm">
            </div>
        </div>
    </body>
</html>