<cfparam name="searchme" default="">

<cfquery name="bookinfo" datasource="#application.dsource#">
    select * from books
    inner join publishers on books.publisher = publishers.publisher_id
    where title like '%#trim(searchme)#%' or isbn13='#searchme#'
</cfquery>


<cfoutput>
    <cfif bookinfo.recordcount eq 0>
        #noResults()#
        <cfelseif bookinfo.recordcount eq 1>
        #oneResult()#
    <cfelse>
        #manyResults()#
    </cfif>
</cfoutput>



<cffunction name="noResults">
    We did not find anything with that term. Please Try Again.
</cffunction>

<cffunction name="oneResult">
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

<cffunction name="manyResults">
    <ol class="nav nav-stacked">
        <cfoutput query="bookinfo">
                <li><a href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a></li>
        </cfoutput>
    </ol>
</cffunction>