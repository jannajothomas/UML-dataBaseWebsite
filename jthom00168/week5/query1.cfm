<cftry>
    <cfquery name="allbooks" datasource="#application.dsource#">
        select * from books order by title
    </cfquery>

    <cfdump var="#allbooks#">

    <cfcatch type="any">
            <cfoutput>#cfcatch.Message#</cfoutput>
    </cfcatch>
</cftry>