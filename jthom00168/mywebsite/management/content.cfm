<!---  Case of no inputs --->
<cfparam name="thisId" default="">

<!--  Process Forms -->
<cfset processForms()>

<!--  Display Data -->
<div id="main" class="col-lg-9 col-lg-push-3">
    <cfoutput>#editContent()#</cfoutput>
</div>

<div id="leftGutter" class="col-lg-3 col-lg-pull-9">
    <cfoutput>#sideContentNav()#</cfoutput>
</div>

<!---Redirect to index if user doesn't have admin privileges--->
<cfif session.user.IsAdmin neq 1>
    <cflocation url = "../index.cfm">
</cfif>

<!--- ----------------------------------Edit Content------------------------------------------>

<cffunction name="editContent">
    <cfoutput>
        <!---Decide if an article should be shown --->
        <cfif thisId neq ''>

            <cfquery name="editArticle" datasource="#application.dsource#">
                select * from Article where id='#thisId#'
            </cfquery>

            <form action="#cgi.script_name#?tool=content" method="post" enctype="multipart/form-data" >
                <input type="hidden" name="contentForm" value="#editArticle.id[1]#" />

                <!--- UUID --->
                <div class="form-group row">
                    <label for="title" class="col-sm-2 col-form-label"> UUID </label>
                <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="id"
                                name="id"
                        value="#editArticle.id[1]#"
                                readonly

                            /><br/>
            </div>
            </div>

                    <!--- Title --->
                    <div class="form-group row">
                        <label for="title" class="col-sm-2 col-form-label"> Content Type </label>
                        <div class="col-sm-10">
                            <cfif thisID neq 'new'>
                                    <input  type="text"
                                            class="form-control"
                                            id="title"
                                            name="title"
                                            value="#editArticle.Title[1]#"
                                            readonly
                                />
                                <cfelse>
                                    <input  type="text"
                                            class="form-control"
                                            id="title"
                                            name="title"
                                            value="#editArticle.Title[1]#"
                                />
                            </cfif>


                            <br/>
                        </div>
                    </div>

                <!--- Description--->
                <div class="form-group row">
                    <label for="text" class="col-sm-2 col-form-label" style="text-align: left">Description</label>
                    <div class="col-sm-10">
                        <textarea id="description" name="description">
                            #trim(editArticle.text[1])#
                        </textarea>
                        <script>
                            CKEDITOR.replace("description")
                        </script>
                    </div>
                </div>
                <!--- Button --->
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">&nbsp;</label>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Update Content</button>
                    </div>
                </div>
            </form>

    </cfif>
</cfoutput>
</cffunction>


<!--- -----------------------------------------------Side Nav --------------------------------->

<cffunction name="sideContentNav">
    <cfoutput>
        <cftry>
            <cfquery name="allContent" datasource="#application.dsource#">
                select * from Article
                order by Title
            </cfquery>

            <div>Content List</div>

            <ul class="nav flex-column">
                <li class="nav-item">
                        <a class="nav-link" href="#cgi.script_name#?tool=content&thisId=new">Add New Content</a>
                </li>
                <cfif isdefined('allContent')>
                    <cfloop query="allContent">
                            <li class="nav-item">
                                    <a class="nav-link"
                                    href="#cgi.script_name#?tool=content&thisId=#trim(id)#">
                                    #trim(Title)#
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
    <cfoutput>
        <cfif isdefined('form.id')>
            <!---If form id has not been created, create new UUID for it--->
            <cfif form.id eq ''>
                <cfset form.id=createuuid()>
            </cfif>
            <cfquery name="addContent" datasource="#application.dsource#">
                if not exists(select * from Article where id='#form.id#')
                    insert into Article (id, Title) values ('#form.id#','#form.title#');
                update Article
                set title='#form.title#', Text='#form.description#'
                where id='#form.id#'

            </cfquery>
        </cfif>
    </cfoutput>
</cffunction>
