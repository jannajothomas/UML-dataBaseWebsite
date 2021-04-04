<cftry>
    <!---  Case of no inputs --->
    <cfparam name="book" default="">
    <cfparam name="qterm" default="">
    <cfparam name="allowISBNEdit" default="">

    <!---  Process Forms --->
    <cfset processForms()>

    <!---  Display Data --->
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
<cfif session.user.IsAdmin neq 1>
    <cflocation
            url = "../index.cfm">
</cfif>

<!------------------------------------Main Form------------------------------------------>
<cffunction name="mainForm">
    <!---Decide if a book should be shown --->
    <cfif book neq ''>

        <!---Select all the genres in Genres and order them by genre name--->
        <cfquery name="allgenres" datasource="#application.dsource#">
            select * from Genres order by 'genrename'
        </cfquery>

        <!---Selects all of the rows in GenresToBooks where bookid is the same as the
        book that was submitted--->
        <cfquery name="bookgenres" datasource="#application.dsource#">
            select * from GenresToBooks where bookid='#book#'
        </cfquery>

        <cfquery name="thisBook" datasource="#application.dsource#">
            select * from books where isbn13='#book#'
        </cfquery>

        <cfquery name="allPubs" datasource="#application.dsource#">
            select * from publishers order by name
        </cfquery>

        <cfoutput>
            <form action="#cgi.script_name#?tool=addedit" method="post" enctype="multipart/form-data" >
            <!---ISBN13--->
            <div class="custom-control custom-switch">
                <input type="checkbox" class="custom-control-input" id="customSwitch1">
                <label class="custom-control-label" for="customSwitch1">Toggle this switch element</label>
            </div>

                <input type="hidden" name="qterm" value="#qterm#" />
                <div class="form-group row">

                    <label for="isbn13" class="col-sm-2 control-label">ISBN13</label>
                    <div class="col-sm-10">
                    <cfif (allowISBNEdit neq '') OR (#thisBook.isbn13[1]# eq '')>
                            <input type="text"
                                   class="form-control"
                                   id="isbn13"
                                   name="isbn13"
                                   placeholder="ISBN13"
                                    value="#thisBook.isbn13[1]#"
                                />
                    <cfelse>
                            <input type="text"
                                   class="form-control"
                                   id="isbn13"
                                   name="isbn13"
                                   placeholder="ISBN13"
                                    value="#thisBook.isbn13[1]#"
                                    readonly
                        />
                    </cfif>

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

             <!--- Genres --->
                <div class="form-group row">
                    <label for="title" class="col-sm-2 col-form-label"> Genres </label>
                    <div class="col-sm-10">
                        <!---Loop over teh allgenres query--->
                            <cfloop query="allgenres">
                                <label for="Genre#genreid#" class="sr-only">"Genre#genreid#"</label>
                                <input  type="checkbox"
                                        class="form-control"
                                        id="Genre#genreid#"
                                        name="genre"
                                        placeholder="Book Title"
                                        value="#genreid#"
                                />#genrename#<br/>
                            </cfloop>
                        <!---Loop over the bookgenres query--->
                        <cfloop query="bookgenres">
                            <script>document.getElementById('Genre#genreid#').checked=true;</script>
                        </cfloop>

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

                <!--- Language --->
                <div class="form-group row">
                    <label for="language" class="col-sm-2 col-form-label">Language</label>
                    <div class="col-sm-10">
                        <input  type="text"
                                class="form-control"
                                id="language"
                                name="language"
                                placeholder="Language"
                                value="#thisBook.language[1]#"
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
                        <input type="file" name="uploadimage" class="col-sm-6"/>
                        <input type="hidden" name="image" value="#trim(thisBook.image[1])#"/>
                        <cfif thisBook.image[1] neq ''>
                                <img style="width:100px" src="../images/#trim(thisBook.image[1])#" alt="">
                        </cfif>

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

<!-------------------------------------------------Side Nav --------------------------------->
<cffunction name="sideNav">
    <cfoutput>
        <ul class="nav flex-column">
            <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?tool=addedit&book=new">Add a Book</a>
            </li>
            <form action="#cgi.script_name#?tool=addedit" method="post" class="form-inline">
                <div class="form-group">
                    <label for="qterm" class="sr-only">"#qterm#"</label>
                    <input type="text" class="form-control" id="qterm" name="qterm" value="#qterm#">
                    <button type="submit" class="btn btn-xs btn-primary">Search</button>
                </div>
            </form>

            <cfif qterm neq ''>
                <cfquery name="allBooks" datasource="#application.dsource#">
                    select * from Books
                    where title like '%#qterm#%'
                    order by title
                </cfquery>
            </cfif>

                <cfif isdefined('allBooks')>
                    <div>Search Results</div>
                    <cfloop query="allBooks">
                        <li class="nav-item">
                            <a class="nav-link"
                                href="#cgi.script_name#?tool=addedit&book=#trim(isbn13)#&qterm=#qterm#">
                                #trim(title)#
                            </a>
                        </li>
                    </cfloop>
                </cfif>

                <div> A selection of 5 books</div>
                <cfquery name="fiveBookQuery" datasource="#application.dsource#">
                        select * from Books
                        ORDER BY ISBN13
                        OFFSET 0 rows
                        FETCH next 5 rows only;

                </cfquery>

                <cfloop query="fiveBookQuery">
                    <li>
                        <a class="nav-link"
                            href="#cgi.script_name#?tool=addedit&book=#trim(isbn13)#&qterm=#qterm#">
                            #trim(title)#
                    </a>
                    </li>
                </cfloop>
            </ul>
    </cfoutput>
</cffunction>

<!------------------------------------------ Process Forms ------------------------------>
<cffunction name="processForms">
    <cfoutput>
        <cfif isdefined('form.isbn13')>
            <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq ''>
                <cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#jthom00168/mywebsite/images"
                        nameconflict="makeunique"/>
                <cfset form.image = '#cffile.serverfile#'>
            </cfif>

                <cfif form.keyExists("isbn13")>
                    <cfquery name="putBookIn" datasource="#application.dsource#">
                        if not exists(select * from Books where ISBN13='#form.isbn13#')
                    insert into Books (ISBN13,title) values ('#form.isbn13#','#form.title#');
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

                <cfquery name="putin" datasource="#application.dsource#">
                    update books
                    set title='#form.title#', image='#form.image#', description='#form.description#',  publisher='#form.publisher#'
                    where isbn13='#form.isbn13#'
                </cfquery>

<!--- Delete all the genres in the genrestobooks --->
            <cfquery datasource="#application.dsource#">
                delete from GenresToBooks where bookid='#form.isbn13#'
            </cfquery>

<!--- Loop over all the submitted genres and insert each into the database --->
            <cfloop list="#form.genre#" index="i">
                <cfquery name="putingenres" datasource="#application.dsource#">
                    insert into GenresToBooks (bookid, genreid) values ('#form.isbn13#','#i#')
                </cfquery>
            </cfloop>
        </cfif>
    </cfoutput>
</cffunction>