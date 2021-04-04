<cfparam name="searchme" default="">
<cfparam name="genre" default="">
<cfparam name="publisher" default="">
<cfparam name="booksQuery" default="">

<cfset bookInfo=makeQuery()>

<!---Display view based on number of results--->
<cfoutput>
    <!---<legend>#bookInfo.label#</legend>--->
    <cfif bookinfo.booksQuery.recordcount eq 0> #noResults()#
        <cfelseif bookInfo.booksQuery.recordcount eq 1>
            #oneResult(bookInfo.booksQuery)#
        <cfelse>
            #manyResults(bookInfo.booksQuery)#
    </cfif>
</cfoutput>

<!---No Results--->
<cffunction name="noResults">
    We did not find anything with that term. Please Try Again.
</cffunction>

<!--- One Result --->
<cffunction name="oneResult">
    <cfargument name="bookInfo" type="query" required="true">

    <cfquery name="getAuthor" datasource="#application.dsource#">
        select * from Books
            inner join PersonToRole on Books.ISBN13 = PersonToRole.bookid
            inner join Person on PersonToRole.personid = Person.id
        where Books.ISBN13='#Bookinfo.ISBN13#'
    </cfquery>

    <div>
        <cfoutput>
            <img src="images/#bookInfo.image[1]#" style="float:right; width:200px;
                height:250px;">
            <span><h2><strong></strong>#bookInfo.title[1]#</h2></span>

            <span><h4><strong>By: </strong>
                <cfloop query = "getAuthor">
                    <cfquery name="thisAuthorsBooks" datasource="#application.dsource#">
                        select * from Person
                            inner join PersonToRole on Person.id = PersonToRole.personid
                            inner join Books on PersonToRole.bookid = Books.ISBN13
                        where Person.id='#getAuthor.id#'
                    </cfquery>

                    <cfif #thisAuthorsBooks.recordcount# gt 1>
                        <a href="index.cfm?p=details&searchme=#id#">#firstName# #lastName# </a>
                        <cfelse>
                        <cfoutput>#firstName# #lastName#</cfoutput>
                    </cfif>

                    <cfif getAuthor.currentrow lt getAuthor.recordcount >
                        ,
                    </cfif>
                </cfloop>
            </h4></span>
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

    <!---Search comes from Genre id--->
    <cfif genre neq ''>
        <!---Get the genre name--->
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

    <!--- Search comes from search box --->
    <cfelseif searchme neq ''>

        <!---Look for content that matches.  --->
        <cfquery name="contentQuery" datasource="#application.dsource#">
            select * from Article
            where id like '%#trim(searchme)#%'
        </cfquery>

        <!---Look for books that match--->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from Books
            inner join Publishers on Books.publisher = Publishers.publisher_ID
            where title like '%#trim(searchme)#%' or isbn13='#searchme#'
        </cfquery>

        <!--- Look for genre name that matches --->
        <cfquery name="whatGenre" datasource="#application.dsource#">
            select * from Genres
            where genrename like '%#trim(searchme)#%'
        </cfquery>

        <!--- Look for author id that matches--->
        <cfquery name="whatAuthorid" datasource="#application.dsource#">
            select * from Person
            where id like '%#trim(searchme)#%'
        </cfquery>

        <!--- Look for author first name that matches--->
        <cfquery name="whatAuthorname" datasource="#application.dsource#">
            select * from Person
            where '#searchme#' LIKE CONCAT('%',firstName, '%')
            or '#searchme#' LIKE CONCAT('%',lastName, '%')
        </cfquery>

        <!---Search was for content UUID.  Redirect search output to content page --->
        <cfif contentQuery.recordcount neq 0>
            <cflocation url="index.cfm?p=content&contentid=#searchme#"/>
        </cfif>

        <!---Seach was for book Title--->
        <cfif booksQuery.recordcount neq 0>
            <cfset bookInfo.label="Keyword:#searchme#">
        </cfif>

        <!---Search was for genre name--->
        <cfif whatGenre.recordcount neq 0>
            <cfquery name="booksQuery" datasource="#application.dsource#">
                select * from Books
                inner join Publishers on Books.publisher = Publishers.publisher_ID
                inner join GenresToBooks on Books.isbn13 = GenresToBooks.bookid
                where genreid='#whatGenre.genreid#'
            </cfquery>
            <cfset bookInfo.label="Genre:#searchme#">
        </cfif>

        <!---Search was for authorid--->
        <cfif #whatAuthorid.recordcount# neq 0>
            <cfquery name="booksQuery" datasource="#application.dsource#">
                select * from Person
                inner join PersonToRole on Person.id = PersonToRole.personid
                inner join Books on PersonToRole.bookid = Books.ISBN13
                inner join Publishers on Books.publisher = Publishers.publisher_ID
                where Person.id='#searchme#'
            </cfquery>
            <cfset bookInfo.label="Author: #whatAuthorid.firstName# #whatAuthorid.lastName#">
        </cfif>

        <!---Search was for author name--->
        <cfif #whatAuthorname.recordcount# neq 0>
            <cfquery name="booksQuery" datasource="#application.dsource#">
                select * from Person
                inner join PersonToRole on Person.id = PersonToRole.personid
                inner join Books on PersonToRole.bookid = Books.ISBN13
                inner join Publishers on Books.publisher = Publishers.publisher_ID
                where '#searchme#' LIKE CONCAT('%', firstName, '%')
                or '#searchme#' LIKE CONCAT('%', lastName, '%')
            </cfquery>
            <cfset bookInfo.label="Author: #whatAuthorid.firstName# or #whatAuthorid.lastName#">
        </cfif>

    </cfif>

    <cfset bookInfo.booksQuery=booksquery>
    <cfreturn bookInfo>
</cffunction>