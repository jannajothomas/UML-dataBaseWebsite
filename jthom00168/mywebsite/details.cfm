<cfparam name="searchme" default="">
<cfparam name="genre" default="">
<cfparam name="publisher" default="">
<cfset bookinfo=makeQuery()>






<cffunction name="noResults">
    We did not find anything with that term. Please Try Again.
</cffunction>

<!--- If there is one result --->
<cffunction name="oneResult">
    <cfargument name="bookQ" type="query" required="true">
    <div>
        <cfoutput>
            <img src="/jthom00168/mywebsite/images/#bookinfo.image[1]#" style="float:right; width:200px;
                height:250px;">
            <span><h2><strong></strong>#bookinfo.title[1]#</h2></span>
            <span><h4><strong>Publisher: </strong>#bookinfo.name[1]#</h4></span>
            <span><h4><strong>Description: </strong>#bookinfo.description[1]#</h4></span>
            <span><h4><strong>Pages: </strong>#bookinfo.pages[1]#</h4></span>
            <span><h4><strong>Language: </strong>#bookinfo.language[1]#</h4></span>
        </cfoutput>
    </div>
</cffunction>

<!‐‐‐ Display the correct view based on the number of results ‐‐‐> 
<cfoutput>
    <legend>#bookinfo.label#</legend>
    <cfif bookinfo.booksQuery.recordcount eq 0> #noResults()#
        <cfelseif bookinfo.booksQuery.recordcount eq 1> #oneResult(bookinfo.booksQuery)#
	
	    <cfelse> #manyResults(bookinfo.booksQuery)#
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
    <!‐‐‐ We're going to return a struct with two keys: booksQuery and Label. booksQu ery is going to be the results. The label is to label the page as to what we searched for. ‐‐‐>
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
        <cfset bookinfo.label="Genre:#whatGenre.genrename[1]#">

    <!--- If the request comes from the search box in the Nav --->
    <cfelseif searchme neq ''>
        <!--- Search for any hits in the DB based on the submitted search term --->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = publishers.id
            where title like '%#trim(searchme)#%' or isbn13='#searchme#'
        </cfquery>
        <!--- Create the label for this search type --->
        <cfset bookinfo.label="Keyword:#searchme#">
    <cfelseif publisher neq ''>
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from books
            inner join publishers on books.publisher = publishers.id
            where publishers.ID ='#publisher#'
        </cfquery>
<!--- Create the label for this search type --->
        <cfset bookinfo.label="Publisher:#booksQuery.name#">
    </cfif>

    <cfset bookinfo.booksQuery=booksquery>
    <cfreturn bookinfo>
</cffunction>