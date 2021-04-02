<h1>Store Info</h1>
<cfquery name="store" datasource="#application.dsource#">
    select * from Article where title like '%Store%'
</cfquery>

<ul class="nav nav-stacked">
<cfoutput>
    <cfloop query="store">
        #Text# <br/>
    </cfloop>
</cfoutput>
</ul>
