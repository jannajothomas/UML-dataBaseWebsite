
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                data-target="#myNav">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.cfm">
            <img src="images/climbing.png"/>
        </a>
    </div>
<!---Navbar Left--->
    <div class="collapse navbar-collapse navbar-left" id="myNav">
        <ul class="nav navbar-nav">
            <cfoutput>
                <li><a href="index.cfm">Home</a></li>
                <li><a href="#cgi.SCRIPT_NAME#?p=storeinfo">Store Info</a></li>
                <li><a href="#cgi.SCRIPT_NAME#?p=staffFavorites">Staff Favorites</a></li>
                <li><a href="#cgi.SCRIPT_NAME#?p=events">Events</a></li>
                <li>
                        <form class="navbar-form navbar-left" role="search" action="#cgi.SCRIPT_NAME#?p=details" method="post">
                            <div class="form-group">
                                <input type="text" name="searchme" class="form-control" placeholder="Search">
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                </li>
            </cfoutput>
        </ul>
    </div>

<!---Navbar Right--->
    <div class="collapse navbar-collapse navbar-right" id="myNav">
        <ul class="nav navbar-nav">
            <cfoutput>
                <cfif session.user.IsAdmin>
                        <li><a href="management/index.cfm">Add/Edit</a></li>
                </cfif>
                <cfif session.isloggedin>
                    <li><a>Welcome #session.user.firstname#</a></li>
                <li><a href="#cgi.SCRIPT_NAME#?p=logoff ">logout</a></li>
                <cfelse>
                        <li><a href="#cgi.SCRIPT_NAME#?p=login">
                        <span class="glyphicon glyphicon-log-in"></span>
                        Login</a></li>
                </cfif>
            </cfoutput>
        </ul>
    </div>
  </div>
</nav>