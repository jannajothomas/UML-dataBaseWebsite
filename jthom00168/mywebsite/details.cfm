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
                        <a href="index.cfm?p=details&searchme=#id#"> #firstName# #lastName# </a>
                        <cfelse>
                        <cfoutput>#firstName# #lastName# </cfoutput>
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
        <!---Look for books  that match--->
        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from Books
            inner join Publishers on Books.publisher = Publishers.publisher_ID
            where title like '%#trim(searchme)#%' or isbn13='#searchme#'
        </cfquery>
        <cfif booksQuery.recordcount neq 0>
            <cfset bookInfo.label="Keyword:#searchme#">
        </cfif>

        <!---Look for content that matches --->
        <cfquery name="contentQuery" datasource="#application.dsource#">
            select * from Article
            where id like '%#trim(searchme)#%'
        </cfquery>
        <cfif contentQuery.recordcount neq 0>
            <cflocation url="index.cfm?p=content&contentid=#searchme#"/>
        </cfif>

        <!---Look for genres that match--->

        <!--- Get the id of the genre from the genre name --->
        <cfquery name="whatGenre" datasource="#application.dsource#">
            select * from Genres
            where genrename like '%#trim(searchme)#%'
        </cfquery>

        <cfif whatGenre.recordcount neq 0>
            <cfquery name="booksQuery" datasource="#application.dsource#">
                select * from Books
                inner join Publishers on Books.publisher = Publishers.publisher_ID
                inner join GenresToBooks on Books.isbn13 = GenresToBooks.bookid
                where genreid='#whatGenre.genreid#'
            </cfquery>
            <cfset bookInfo.label="Genre:#searchme#">
        </cfif>

        <!---Start test code--->
        <!---Get the id of the auth--->
        Searchterm = <cfoutput>#trim(searchme)#</cfoutput> </br>
        <cfquery name="whatAuthor" datasource="#application.dsource#">
            select * from Person
            where id like '%#trim(searchme)#%'
        </cfquery>

        <cfquery name="booksQuery" datasource="#application.dsource#">
            select * from Person
            inner join PersonToRole on Person.id = PersonToRole.personid
            inner join Books on PersonToRole.bookid = Books.ISBN13
            where Person.id='#searchme#'
        </cfquery>

       <!--- It looks like this author has  <cfoutput>#thisAuthorsBooks.recordcount#</cfoutput> books<br/>--->

    <!---<cfoutput>#getAuthor.id#</cfoutput>
    <cfloop query = "thisAuthorsBooks">
        book: <cfoutput>#thisAuthorsBooks.title#</cfoutput> <br/>
    </cfloop>--->
<!---End test code--->










        <cfif #whatAuthor.recordcount# neq 0>
            Recordcount was not zero.  This means the author was found in the db <br/>
            <!---<cfquery name="booksQuery" datasource="#application.dsource#">--->

<!---
             select * from Books
             inner join PersonToRole on Books.ISBN13 = PersonToRole.bookid
             inner join Person on PersonToRole.personid = Person.id
             where Books.ISBN13='#Bookinfo.ISBN13#'


             select * from Books
             inner join PersonToRole on Books.ISBN13 = PersonToRole.bookid
             inner join Person on PersonToRole.personid = PersonToRole.bookid
             where personid='#whatAuthor.id#'
            </cfquery>--->
            bookquery size was <cfoutput>#whatAuthor.recordcount#</cfoutput>
            <cfset bookInfo.label="Author: #whatAuthor.firstName#">
        </cfif>
        <!---end test code--->

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