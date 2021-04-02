<cftry>
    <!---  Case of no inputs --->
    <cfparam name="articleId" default="">
    <cfparam name="qTerm" default="">

    <!--  Process Forms -->
    <cfset processForms()>

    <!--  Display Data -->
    <div id="main" class="col-lg-9 col-lg-push-3">
    <cfoutput>#editContent()#</cfoutput>
    </div>

    <div id="leftGutter" class="col-lg-3 col-lg-pull-9">
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
    <cfif articleId neq ''>
        <cfquery name="thisArticle" datasource="#application.dsource#">
            select * from article where id='#articleId#'
        </cfquery>
        <cfoutput>
            <form action="#cgi.script_name#?tool=content" method="post" enctype="multipart/form-data" >
                <input type="hidden" name="qterm" value="#qTerm#" />

                <!--- Title --->
                <div class="form-group row">
                    <label for="title" class="col-sm-2 col-form-label"> Article Title </label>
                    <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="title"
                                name="title"
                                value="#thisArticle.Title[1]#"
                                readonly
                                /><br/>
                    </div>
                </div>

                <!--- Description--->
                <div class="form-group row">
                    <label for="bookDesc" class="col-sm-2 col-form-label" style="text-align: left">Description</label>
                    <div class="col-sm-10">
                        <textarea id="bookDesc" name="description">
                            #trim(thisArticle.text[1])#
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
    <cfoutput>
        <cftry>
            <cfquery name="allContent" datasource="#application.dsource#">
                select * from Article
                order by title
            </cfquery>

            <div>Content List</div>
            <ul class="nav flex-column">
                <cfif isdefined('allContent')>
                    <cfloop query="allContent">
                            <li class="nav-item">
                                    <a class="nav-link"
                                    href="#cgi.script_name#?tool=content&articleid=#trim(id)#&qterm=#qterm#">#trim
                        (Title)#
                            </a>
                            </li>
                    </cfloop>
                <cfelse>
                       No Content Found
                </cfif>
            </ul>
            <cfcatch type="any">
                <cfdump var="#cfcatch#">
            </cfcatch>
        </cftry>
    </cfoutput>
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
