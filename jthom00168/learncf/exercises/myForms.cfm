<cfoutput>
    <form action="#cgi.script_name#?#cgi.query_string#" method="post">

</cfoutput>
<div class="form-group">

    <div class=""col-sm-10">
        <input type="text" class="form-control" id="title" name="title" placeholder="title"
    </div>
    <label for="inputTitle" class=""col-sm-2 control-label">Title</label>

    <div class=""col-sm-10">
        <input type="text" class="form-control" id="weight" name="weight" placeholder="0.0"
    </div>
    <label for="inputWeight" class=""col-sm-2 control-label">Weight</label>

    <div class=""col-sm-10">
        <input type="text" class="form-control" id="year" name="year" placeholder="year"
    </div>
    <label for="inputYear" class=""col-sm-2 control-label">Year</label>

    <div class=""col-sm-10">
        <input type="text" class="form-control" id="binding" name="binding" placeholder="binding"
    </div>
    <label for="inputBiding" class=""col-sm-2 control-label">Binding</label>

    <div class=""col-sm-10">
        <input type="text" class="form-control" id="language" name="language" placeholder="language"
    </div>
    <label for="inputLanguage" class=""col-sm-2 control-label">Language</label>
</div>
    <input type="submit" value="save" />

<cfdump var="#form#" label="The Form Data" />


</form>
