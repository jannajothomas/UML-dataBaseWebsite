<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#myNav">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">
                <img src="../images/climbing.png"/>
            </a>
        </div>

        <cfoutput>
        <div class="collapse navbar-collapse" id="myNav">
            <ul class="nav navbar-nav">
                <li><a href="../index.cfm">Home</a></li>
                <li><a href="#cgi.script_name#?tool=createuuids"">Create UUIDs</a></li>
            </ul>
        </div>
        </cfoutput>
    </div>
</nav>
