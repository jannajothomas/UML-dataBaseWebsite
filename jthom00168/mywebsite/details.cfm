<cfparam name="searchme" default="">
<cfparam name="genre" default="">
<cfparam name="publisher" default="">
<cfset bookInfo=makeQuery()>

<cffunction name="noResults">
    We did not find anything with that term. Please Try Again.
</cffunction>

<!--- If there is one result --->
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

<!‐‐‐ Display the correct view based on the number of results ‐‐‐> 
<cfoutput>
    <legend>#bookInfo.label#</legend>
    <cfif bookinfo.booksQuery.recordcount eq 0> #noResults()#
        <cfelseif bookInfo.booksQuery.recordcount eq 1> #oneResult(bookInfo.booksQuery)#
	
	    <cfelse> #manyResults(bookInfo.booksQuery)#
    </cfif>
</cfoutput>

<!--- If there are many result --->
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

    <!--- If we've submitted a genre --->
    <cfif genre neq ''>
        <!--- Get the name of the genre for the label --->
        <cfquery name="whatGenre" datasource="#application.dsource#">
            select * from Genres where genreid='#genre#'
        </cfquery>
        <!--- Get the search results for this genre submission --->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join Publishers on books.publisher = Publishers.publisher_ID
            inner join GenresToBooks on books.isbn13 = GenresToBooks.bookid
            where genreid='#genre#'
        </cfquery>
        <!--- Create the label from the Genre search --->
        <cfset bookInfo.label="Genre:#whatGenre.genrename[1]#">

    <!--- If the request comes from the search box in the Nav --->
    <cfelseif searchme neq ''>
        <!--- Search for any hits in the DB based on the submitted search term --->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = Publishers.publisher_ID
            where title like '%#trim(searchme)#%' or isbn13='#searchme#'
        </cfquery>
        <!--- Create the label for this search type --->
        <cfset bookInfo.label="Keyword:#searchme#">
    <cfelseif publisher neq ''>
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = publishers.id
            where publishers.ID ='#publisher#'
        </cfquery>
<!--- Create the label for this search type --->
        <cfset bookInfo.label="Publisher:#booksQuery.name#">
    </cfif>

    <cfset bookInfo.booksQuery=booksquery>
    <cfreturn bookInfo>
</cffunction>