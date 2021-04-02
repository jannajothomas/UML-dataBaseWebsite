<cfparam name="contentid" default="">

<cfquery name="getContent" datasource="#application.dsource#">
    select * from Article where id='#contentid#'
</cfquery>

<cfif contentid neq '' and getContent.recordcount gt 0>
    <cfoutput>
        <legend>#getContent.title[1]#</legend>
    <div>#getContent.Text[1]#</div>
    </cfoutput>
<cfelse>
    Sorry, we couldn't find what you were looking for. Please Try again.
</cfif>
