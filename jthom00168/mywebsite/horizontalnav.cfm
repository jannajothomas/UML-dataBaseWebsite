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
        <a class="navbar-brand" href="index.html">
            <img src="images/climbing.png"/>
        </a>
    </div>

    <div class="collapse navbar-collapse" id="myNav">
        <ul class="nav navbar-nav">
            <li class="active"><a href="index.cfm">Home</a></li>
            <li><a>Store Information</a></li>
            <li><a>Featured Destinations</a></li>
            <li><a>Events</a></li>
            <li>
                <cfoutput>
                    <form class="navbar-form navbar-left" role="search" action="#cgi.SCRIPT_NAME#?p=details" method="post">
                        <div class="form-group">
                            <input type="text" name="searchme" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </cfoutput>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">

        <cfoutput>
            <cfif session.isloggedin>
                <li><a>Welcome #session.user.firstname#</a></li>
            <li><a href="#cgi.SCRIPT_NAME#?p=logoff ">logout</a></li>
            <cfelse>
                    <li><a href="#cgi.SCRIPT_NAME#?p=login">Login</a></li>
            </cfif>
            <cfif session.user.IsAdmin>
                    <li><a href="management/index.cfm"><span class="glyphicon glyphicon-log-in"></span>Add/Edit</a></li>
            </cfif>
        </cfoutput>




            <!---<li><a>Login</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
            <li><a href=#cgi.script_name#?p=login"><span class="glyphicon glyphicon-log-in"></span>Login</a></li>
            <li>session.user.name</li>
            <li><a href="management/index.cfm"><span class="glyphicon glyphicon-log-in"></span>Logout</a></li>
            <cfif session.user.isAdmin>
                    <li><a href="management/index.cfm"><span class="glyphicon glyphicon-log-in"></span>Add/Edit</a></li>
            </cfif>--->
        </ul>
    </div>
  </div>
</nav>