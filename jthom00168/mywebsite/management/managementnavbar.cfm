<!---Late in the I realized maintaining both of these menu bars was problematic, so I combined them and put
checks on permissions to decide what gets displayed--->

<!---This is just left in place for legacy purposes--->

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#myNav">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../index.cfm">
                <img src="../images/climbing.png" alt=""/>
            </a>
        </div>

<!---Navbar left--->
        <div class="collapse navbar-collapse navbar-left" id="myNav">
            <ul class="nav navbar-nav px-1">
                <cfoutput>
                    <li><a href="../index.cfm">Home</a></li>
                    <li><a href="../index.cfm?p=storeInfo">Store Info</a></li>
                    <li><a href="../index.cfm?p=staffFavorites">Staff Favorites</a></li>
                    <li><a href="../index.cfm?p=events">Events</a></li>
                    <li>
                            <form class="navbar-form navbar-left" role="search" action="../index.cfm?p=details"
                                  method="post">
                                <div class="form-group">
                                    <label for="siteSearch" class="sr-only">Search</label>
                                    <input type="text" id="siteSearch" name="searchMe" class="form-control"
                                    placeholder="Search"/>
                                </div>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form>

                    </li>
                </cfoutput>
            </ul>
        </div>
<!---Navbar right--->
        <div class="collapse navbar-collapse navbar-right" id="myNav">
            <ul class="nav navbar-nav">
                <cfoutput>
                    <li><a href="#cgi.script_name#?tool=content">Edit Content</a></li>
                    <li><a href="#cgi.script_name#?tool=createUUIDs">UUIDs</a></li>
                    <cfif session.user.IsAdmin>

                            <li><a href="index.cfm">Edit Books</a></li>
                    </cfif>
                    <cfif session.isloggedin>
                        <li><a>Welcome #session.user.firstname#</a></li>
                    <li><a href="../index.cfm?p=logoff">logout</a></li>
                    <cfelse>
                            <li><a href="#cgi.SCRIPT_NAME#?p=login"><span class="glyphicon
                            glyphicon-log-in"></span>Login</a></li>
                    </cfif>
                </cfoutput>
            </ul>
        </div>
    </div>
</nav>
