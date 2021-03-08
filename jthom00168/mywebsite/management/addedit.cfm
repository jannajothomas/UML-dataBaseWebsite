<cftry>
    <!--  Case of no inputs -->
    <cfparam name="book" default="">
    <cfparam name="qterm" default="">

    <!--  Process Forms -->
    <cfset processForms()>

    <!--  Display Data -->
    <div id="main" class="col-lg-9 col-lg-push-3">
    <cfoutput>#mainForm()#</cfoutput>
    </div>

    <div id="leftgutter" class="col-lg-3 col-lg-pull-9">
    <cfoutput>#sideNav()#</cfoutput>
    </div>

    <cfcatch type="any">
        <cfoutput>
            #cfcatch.Message#
        </cfoutput>
    </cfcatch>
</cftry>
<!-- ----------------------------------Main Form------------------------------------------>
<cffunction name="mainForm">
    <cfif book neq ''> <!--If title isn't blank-->
        <cfquery name="thisBook" datasource="#application.dsource#">
            select * from books where isbn13='#book#'
        </cfquery>

        <cfquery name="allPubs" datasource="#application.dsource#">
            select * from publishers order by name
        </cfquery>

        <cfoutput>
            <form action="#cgi.script_name#?tool=addedit" method="post" enctype="multipart/form-data" >

                <input type="hidden" name="qterm" value="#qterm#" />
        <div class="form-group row">
            <label for="isbn13" class="col-sm-2 control-label">ISBN13</label>
        <div class="col-sm-10">

                <input type="text"
                       class="form-control"
                       id="isbn13"
                       name="isbn13"
                       placeholder="ISBN13"
                value="#thisBook.isbn13[1]#"/>

        </div>
        </div>
<!--- Title --->
                <div class="form-group row">
                    <label for="title" class="col-sm-2 col-form-label"> Book Title </label>
                <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="title"
                                name="title"
                                placeholder="Book Title"
                        value="#thisBook.title[1]#"

            /><br/>
            </div>
            </div>
<!--- Year --->
                <div class="form-group row">
                    <label for="year" class="col-sm-2 col-form-label"> Year </label>
                <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="year"
                                name="year"
                                placeholder="Year of Publication"
                        value="#thisBook.year[1]#"
            /><br/>
            </div>
            </div>

<!--- Weight --->
                <div class="form-group row">
                    <label for="weight" class="col-sm-2 col-form-label"> Weight </label>
                <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="weight"
                                name="weight"
                                placeholder="Book Weight (lbs)"
                        value="#thisBook.weight[1]#"
            /><br/>
            </div>
            </div>

<!--- ISBN --->
                <div class="form-group row">
                    <label for="isbn" class="col-sm-2 col-form-label"> ISBN </label>
                <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="isbn"
                                name="isbn"
                                placeholder="ISBN 10"
                        value="#thisBook.isbn[1]#"
            /><br/>
            </div>
            </div>


<!--- Pages --->
                <div class="form-group row">
                    <label for="pages" class="col-sm-2 col-form-label">Pages</label>
                <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="pages"
                                name="pages"
                                placeholder="No. Pages"
                        value="#thisBook.pages[1]#"
            /><br/>
            </div>
            </div>

<!--- Publisher --->
                <div class="form-group row">
                    <label for="publisher" class="col-sm-2 col-form-label">Publisher</label>
                <div class="col-sm-10">
                <select class="form-control" id="publisher" name="publisher">
                    <option value=""></option>
                <cfloop query="allPubs">
                    <cfset sel = "">
                    <cfif publisher_ID eq thisBook.publisher[1]>
                        <cfset sel = "selected">
                    </cfif>
                        <option value="#trim(publisher_ID)#" #sel#>#trim(name)#</option>
                </cfloop>
                </select>
                </div>
                </div>

<!--- Cover Image --->
                <div class="form-group row">
                    <label for="coverImage" class="col-sm-2 col-form-label">Cover</label>
                <div class="col-sm-10">
                <cfif thisBook.image[1] neq "">
                        <img src="/jthom00168/mywebsite/images/#trim(thisBook.image[1])#" height="150">
                </cfif>
                    <input type="file" class="form-control" id="coverimage" name="uploadimage"/>
                        <input type="hidden"
                               name="image"
                        value="#thisBook.image[1]#" />
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

<!-- -----------------------------------------------Side Nav --------------------------------->
<cffunction name="sideNav">
    <cftry>
        <cfoutput>
            <form action="#cgi.script_name#?tool=addedit" method="post" class="form-inline">
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

        <div>Book List</div>
        <cfoutput>

            <ul class="nav flex-column">

            <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?tool=addedit&book=new">Add a Book</a>
        </li>
            <cfif isdefined('allBooks')>

                <cfloop query="allBooks">
                        <li class="nav-item">
                                <a class="nav-link" href="#cgi.script_name#?tool=addedit&book=#trim(isbn13)
                            #&qterm=#qterm#">#trim
                    (title)#</a>
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
        image='#form.uploadimage#',
        publisher='#form.publisher#',
        description='#form.description#'
        where isbn13='#form.isbn13#'
        </cfquery>
    </cfif>

    <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq ''>
        <cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#jthom00168/mywebsite/images"
                nameconflict="makeunique"/>
        <cfset form.image = '#cffile.serverfile#'>

        <cftry>

            <cfquery name="putin" datasource="#application.dsource#">
                update books set

                title='#form.title#',
                image='#form.image#',
                description='#form.description#',
            publisher='#form.publisher#'
            where isbn13='#form.isbn13#'
            </cfquery>

            <cfcatch type="any">
                <cfdump var="#cfcatch#">
            </cfcatch>
        </cftry>
    </cfif>
</cffunction>

