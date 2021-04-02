<h1>Scheduled Events</h1>
<cfquery name="events" datasource="#application.dsource#">
    select * from Article where title like '%Event%'
</cfquery>

<ul class="nav nav-stacked">
    <cfoutput>
        <cfloop query="events">
            #Text# <br/>
        </cfloop>
</cfoutput>
</ul>
