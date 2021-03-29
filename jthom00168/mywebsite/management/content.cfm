<cftry>
    <!---  Case of no inputs --->
    <cfparam name="article" default="">
    <cfparam name="qterm" default="">

    <!--  Process Forms -->
    <cfset processForms()>

    <!--  Display Data -->
    <div id="main" class="col-lg-9 col-lg-push-3">
    <cfoutput>#editContent()#</cfoutput>
    </div>

    <div id="leftgutter" class="col-lg-3 col-lg-pull-9">
    <cfoutput>#sideContentNav()#</cfoutput>
    </div>

    <cfcatch type="any">
        <cfoutput>
            #cfcatch.Message#
        </cfoutput>
    </cfcatch>
</cftry>
<!---Redirect to index if user doesn't have admin privilidges--->
<cfif session.user.IsAdmin neq 1>
    <cflocation url = "../index.cfm">
</cfif>

<!-- ----------------------------------Edit Content------------------------------------------>
<cffunction name="editContent">
    <!--Decide if an article should be shown -->
    <cfif article neq ''>
        <cfquery name="thisArticle" datasource="#application.dsource#">
            select * from article where id='#thisArticle#'
        </cfquery>
        <cfoutput>
            <form action="#cgi.script_name#?tool=content" method="post" enctype="multipart/form-data" >
                <input type="hidden" name="qterm" value="#qterm#" />

                <!--- Title --->
                <div class="form-group row">
                    <label for="title" class="col-sm-2 col-form-label"> Book Title </label>
                    <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="title"
                                name="title"
                                placeholder="Book Title"
                        value="#thisBook.title[1]#"/><br/>
                    </div>
                </div>

                <!--- Description--->
                <div class="form-group row">
                    <label for="bookDesc" class="col-sm-2 col-form-label" style="text-align: left">Description</label>
                    <div class="col-sm-10">
                        <textarea id="bookDesc" name="description">
                            #trim(thisBook.description[1])#
                        </textarea>
                        <script>
                            CKEDITOR.replace("bookDesc")
                        </script>
                    </div>
                </div>
                <!--- Button --->
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">&nbsp;</label>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Add Book</button>
                    </div>
                </div>
            </form>
        </cfoutput>
    </cfif>
</cffunction>


<!--- -----------------------------------------------Side Nav --------------------------------->

<cffunction name="sideContentNav">

    <cftry>
        <cfoutput>
            <form action="#cgi.script_name#?tool=content" method="post" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" id="qterm" name="qterm" value="#qterm#">
                    <button type="submit" class="btn btn-xs btn-primary">Search</button>
                </div>
            </form>
        </cfoutput>

        <cfif qterm neq ''>
            <cfquery name="allBooks" datasource="#application.dsource#">
                select * from books
                where title like '%#qterm#%'
            order by title
            </cfquery>
        </cfif>

        <div>Content List</div>
        <cfoutput>
            <ul class="nav flex-column">
            <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?tool=content&article=new">Add Content</a>
        </li>
            <cfif isdefined('allBooks')>
                <cfloop query="allBooks">
                        <li class="nav-item">
                                <a class="nav-link" href="#cgi.script_name#?tool=content&book=#trim(isbn13)
                            #&qterm=#qterm#">#trim(title)#
                        </a>
                        </li>
                </cfloop>
            <cfelse>
                    No Search Term Entered (Try climb)
            </cfif>
            </ul>
        </cfoutput>
            <cfcatch type="any">
                <cfdump var="#cfcatch#">
            </cfcatch>

    </cftry>

</cffunction>

<!-- ---------------------------------------- Process Forms ------------------------------>
<cffunction name="processForms">
    <!---
    <cfif form.keyExists("isbn13")>

        <cfquery name="putBookIn" datasource="#application.dsource#">
            if not exists(select * from books where isbn13='#form.isbn13#')
        insert into books (isbn13,title) values ('#form.isbn13#','#form.title#');
        update books SET
        title='#form.title#',
        weight='#form.weight#',
        year='#form.year#',
        isbn='#form.isbn#',
        pages='#form.pages#',
        language='#form.language#',
        image='#form.image#',
        publisher='#form.publisher#',
        description='#form.description#'
        where isbn13='#form.isbn13#'
        </cfquery>
    </cfif>
    --->
</cffunction>
