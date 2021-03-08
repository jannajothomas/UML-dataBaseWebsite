<cfoutput>
    <p>Here are the tables in my database dumped out.</p>
    <cftry>
        <cfdbinfo type="tables" datasource="#application.dsource#" name="yo">
        <cfdump var="#yo#"/>
        <cfcatch type="any">Sorry, We couldn't show your tables because #cfcatch.message#</cfcatch>
    </cftry>
    <p>Here are the fields in your books table dumped out:</p>
    <cftry>
        <cfdbinfo type="columns" table="books" datasource="#application.dsource#" name="yo">
        <cfdump var="#yo#" />
        <cfcatch type="any">Sorry, We couldn't show your tables because #cfcatch.message#</cfcatch></cftry>
</cfoutput>
