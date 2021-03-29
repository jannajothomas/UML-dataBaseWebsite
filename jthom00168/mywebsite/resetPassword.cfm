<!---Set default view--->
<cfparam name="view" default="validateView"/>

<!--- Create a param to display messages --->
<cfparam name="Message" default=""/>
<cfparam name="personid" default=""/>

<!---Decide what view to present--->
<cfset view = processForms()>

<!--- JS to make sure passwords are the same.  Same as login page ---->

<script type="text/javascript">
    function validateNewPassword() {
        var originalPassword = document.getElementById('newPassword').value;
        var confirmPassword = document.getElementById('newPasswordConfirm').value;
        console.dir(originalPassword);
        console.dir(confirmPassword);
        if (originalPassword === confirmPassword && originalPassword !== '') {
            document.getElementById('submitNewPassword').click();
            document.getElementById('Message').innerHTML = "";
        } else {
            document.getElementById('Message').innerHTML = "The two passwords do not match";
        }
    }
</script>

<!---Select and  Display View--->
<cfoutput>
    <cfif view eq 'validateView'>
        #authenticateForm()#
        <cfelseif view eq 'changePassword'>
        #newPasswordForm()#
    </cfif>
    <div id="Message">&nbsp;#Message#</div>
</cfoutput>

<!---Process Forms--->
<cffunction name="processForms">
<!---Authenication Form Was Submitted--->
    <cfif isdefined('form.lastname')>
        <cfquery name="doLastNameAndEmailPairExist" datasource="#application.dsource#">
            select * from people where lastname='#form.lastname#' and email='#form.email#'
        </cfquery>
        <cfif doLastNameAndEmailPairExist.recordcount gt 0>
            <cfset foundPerson = #doLastNameAndEmailPairExist.people_id[1]#>
            <cfreturn "changePassword">
        <cfelse>
            <cfset Message = "That name and email do not match">
        </cfif>
    </cfif>

<!--- Password Form Submitted --->
    <cfif isdefined('form.password')>
        <cfquery name="updatePassword" datasource="#application.dsource#">
            update passwords
            set password='#hash(form.password, "SHA-256")#'
        where personid='#form.personid#'
        </cfquery>
<!--- Send the user to the login page--->
        <cflocation url="index.cfm?p=login"/>
    </cfif>
    <cfreturn "validateView">
</cffunction>

<cffunction name="authenticateForm">
    <cfoutput>
        <form action="#cgi.script_name#?p=resetPassword" method="post" class="form-horizontal">
        <div class="form-group">
            <label class="col-lg-3 control-label">Email Address:</label>
            <div class="col-lg-9">
                <input type="text" name="email" placeholder="Email" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-3 control-label">Last Name:</label>
            <div class="col-lg-9">
                <input type="text" name="lastname" placeholder="Last Name" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-3 control-label">&nbsp;</label>
            <div class="col-lg-9">
                <input type="submit" value="Authenticate"/>
            </div>
        </div>
    </form>
    </cfoutput>
</cffunction>

<cffunction name="newPasswordForm">
    <cfoutput>
        <form action="#cgi.script_name#?p=resetPassword" method="post" class="form-horizontal">
            <!--- Hidden button for after text validates--->
            <input type="hidden" name="personid" value="#personid#">
            <!---First Password Entry --->
            <div class="form-group">
                <label class="col-lg-3 control-label">Password</label>
                <div class="col-lg-9">
                    <input type="password" class="form-control" name="password" id="newPassword" required/>
                </div>
            </div>
            <!---Password Confirmation --->
            <div class="form-group">
                <label class="col-lg-3 control-label">Confirm Password</label>
                <div class="col-lg-9">
                    <input type="password" class="form-control" id="newPasswordConfirm" required/>
                </div>
            </div>
            <!---  Submit for verificatiq                                                       1on button --->
            <div class="form-group">
                <label class="col-lg-3 control-label">&nbsp;</label>
                <div class="col-lg-9">
                    <button type="button" id="newPasswordButton" class="btn btn-warning" onclick="validateNewPassword()">
                        Change
                        Password
                    </button>
                    <input type="submit" id="submitNewPassword" style="display:none"/>
                </div>
            </div>
        </form>
    </cfoutput>
</cffunction> 