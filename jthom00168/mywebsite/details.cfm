<cfparam name="searchme" default="">
<cfparam name="genre" default="">
<cfparam name="publisher" default="">
<cfset bookInfo=makeQuery()>



<!---Display view based on number of results--->
<cfoutput>
    <legend>#bookInfo.label#</legend>
    <cfif bookinfo.booksQuery.recordcount eq 0> #noResults()#
        <cfelseif bookInfo.booksQuery.recordcount eq 1> #oneResult(bookInfo.booksQuery)#
        <cfelse> #manyResults(bookInfo.booksQuery)#
    </cfif>
</cfoutput>

<!---No Results--->
<cffunction name="noResults">
    We did not find anything with that term. Please Try Again.
</cffunction>

<!--- One Result --->
<cffunction name="oneResult">
    <cfargument name="bookInfo" type="query" required="true">
    <div>
        <cfoutput>
            <img src="images/#bookInfo.image[1]#" style="float:right; width:200px;
                height:250px;">
            <span><h2><strong></strong>#bookInfo.title[1]#</h2></span>
            <span><h4><strong>Publisher: </strong>#bookInfo.name[1]#</h4></span>
            <span><h4><strong>Year Published: </strong>#bookInfo.year[1]#</h4></span>
            <span><h4><strong>Description: </strong>#bookInfo.description[1]#</h4></span>
            <span><h4><strong>Pages: </strong>#bookInfo.pages[1]#</h4></span>
            <span><h4><strong>Language: </strong>#bookInfo.language[1]#</h4></span>
        </cfoutput>
    </div>
</cffunction>

<!--- More than one result --->
<cffunction name="manyResults">
    <cfargument name="bookQ" type="query" required="true">
    <ol class="nav nav-stacked">
        <cfoutput query="arguments.bookQ">
            <li><a href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a></li>
        </cfoutput>
    </ol>
</cffunction>

<cffunction name="makeQuery">
    <cfset bookInfo={booksQuery:queryNew("title")}>

    <cfif genre neq ''>
    <!---Search comes from Genre--->
        <cfquery name="whatGenre" datasource="#application.dsource#">
            select * from Genres where genreid='#genre#'
        </cfquery>

        <!--- Get the books that match the genre --->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from Books
            inner join Publishers on Books.publisher = Publishers.publisher_ID
            inner join GenresToBooks on Books.isbn13 = GenresToBooks.bookid
            where genreid='#genre#'
        </cfquery>
        <cfset bookInfo.label="Genre:#whatGenre.genrename[1]#">


    <cfelseif searchme neq ''>
    <!--- Search comes from search box --->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from Books
            inner join Publishers on Books.publisher = Publishers.publisher_ID
            where title like '%#trim(searchme)#%' or isbn13='#searchme#'
        </cfquery>
        <cfset bookInfo.label="Keyword:#searchme#">

    <cfelseif publisher neq ''>
        <!--- Search comes from publisher --->
            <cfquery name="booksQuery" datasource="#application.dsource#">
                select * from books
                inner join Publishers on Books.publisher = Publishers.publisher_ID
                where Publishers.publisher_ID ='#publisher#'
            </cfquery>
        <cfset bookInfo.label="Publisher:#booksQuery.name#">
    </cfif>

    <cfset bookInfo.booksQuery=booksquery>
    <cfreturn bookInfo>
</cffunction>