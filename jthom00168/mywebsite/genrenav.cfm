<cfquery name="allgenres" datasource="#application.dsource#">
    select distinct Genres.genreid,Genres.genrename from GenresToBooks
    inner join Genres on Genres.genreid = GenresToBooks.genreid
    order by Genres.genrename
</cfquery>
<ul class="nav nav-stacked">
    <cfoutput query="allgenres">
        <li><a href="#cgi.script_name#?p=details&genre=#genreid#">#genrename#</a></li>
    </cfoutput>
</ul>