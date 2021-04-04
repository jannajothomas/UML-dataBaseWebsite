<!doctype html>
<html lang="eng">
    <head>
        <title>Red Point Books Home</title>
        <meta charset="utf-8">
    <!--- Links to Bootstrap and my custom CSS --->
        <link href="/CodeBase/includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
        <link href="../includes/css/mycss.css" rel="stylesheet"/>
    <!--- Link to jQuery and the bootstrap Javascript --->
        <script src="/CodeBase/includes/js/jQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="/CodeBase/includes/bootstrap/js/bootstrap.js" type="text/javascript"></script>
    </head>

    <body>
        <cfparam name="p" default="carousel" />
        <cfinclude template="stateinfo.cfm" />
        <div id="wrapper" class="container">
            <!---Top Header--->
            <div id="topHeader" class="row">
                <cfinclude template="header.cfm">
            </div>

            <!---Horizontal Nav--->
            <div id="horizontalnav" class="row">
                <cfinclude template="horizontalnav.cfm">
            </div>

            <!---Main Content--->
            <div id="maincontent" class="row">

                <div id="center" class="col-sm-7 col-lg-7 col-md-7 col-sm-push-3">
                    <cfinclude template="#p#.cfm">
                </div>

                <div id="leftgutter" class="col-sm-3 col-lg-3 col-md-3 col-sm-pull-7">
                    <cfinclude template="genrenav.cfm">
                </div>
            </div>

            <!---Footer--->
            <div id="footer" class="row">
                <cfinclude template="footer.cfm">
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

    </body>
</html>