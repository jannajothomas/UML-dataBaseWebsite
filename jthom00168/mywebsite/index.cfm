

<!doctype html>
<html lang="eng">
<head>
    <title>Red Point Books Home</title>
<!--- Links to Bootstrap and our custom CSS. You'll have /username/includes....--->
    <link href="/CodeBase/includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="../includes/css/mycss.css" rel="stylesheet"/>
<!--- Link to jQuery and the bootstrap Javascript --->
    <script src="/CodeBase/includes/js/jQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="/CodeBase/includes/bootstrap/js/bootstrap.js" type="text/javascript"></script>
</head>

<body>
    <cfparam name="p" default="carousel" />
    <div id="wrapper" class="container">
        <div id="topHeader" class="row">
            <cfinclude template="header.cfm">
        </div>
        <div id="horizontalnav" class="row">
            <cfinclude template="horizontalnav.cfm">
        </div>
        <div id="maincontent" class="row">

            <div id="center" class="col-sm-7 col-lg-7 col-md-7 col-sm-push-3">
                <cfinclude template="#p#.cfm">
            </div>

            <div id="leftgutter" class="col-sm-3 col-lg-3 col-md-3 col-sm-pull-7">
                <cfinclude template="genrenav.cfm">
            </div>
        </div>

        <div id="footer" class="row">
            <cfinclude template="footer.cfm">
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

    </body>
</html>