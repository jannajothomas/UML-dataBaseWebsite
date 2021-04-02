<h1>Staff Favorites</h1>
<cfquery name="favorites" datasource="#application.dsource#">
    select * from Article where title like '%Favorites%'
</cfquery>

<ul class="nav nav-stacked">
<cfoutput>
    <cfloop query="favorites">
        #Text# <br/>
    </cfloop>
</cfoutput>
</ul>
