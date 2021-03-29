<!--- This is a variable to store any messages about the new account --->
<cfparam name="accountMessage" default="">
<!--- This is a variable to store any messages about logging in --->
<cfparam name="loginMessage" default="">

<!--- This JS checks whether the password and the confirm password match before trying to submit the form ---->
<script type="text/javascript">
    function validateNewAccount(){
        let originalPassword=document.getElementById('newAccountPassword').value;
        let confirmPassword=document.getElementById('newAccountPasswordConfirm').value;
        console.dir(originalPassword);
        console.dir(confirmPassword);
        if(originalPassword===confirmPassword && originalPassword!=='' && confirmPassword !== ''){
            document.getElementById('submitNewAccountForm').click();
            document.getElementById('newAccountMessage').innerHTML="";
        }
        else{
            document.getElementById('newAccountMessage').innerHTML="The two passwords do not match";
        }
    }
</script>
<cfset preProcess()>

<!---Left side of page --->
<div class="col-lg-6">
<cfoutput>
        #newUserForm()#
    </cfoutput>
</div>

<!---Right side of the page--->
<div class="col-lg-6">
    <cfoutput>
        #loginForm()#

    </cfoutput>
</div>

<cffunction name="preProcess">
    <cfif isdefined('form.newPersonId')>
        <cfset newId=createUUID()>
        <cfquery name="getEmail" datasource="#application.dsource#">
            select * from people where email='#form.email#'
        </cfquery>
        <cfif getEmail.recordcount eq 0>
            <cfquery name="putin" datasource="#application.dsource#">
                insert into People (people_id,firstname,lastname,email,IsAdmin) values ('#newid#','#form.firstName#',
            '#form.lastName#','#form.email#','0')
            </cfquery>
            <cfdump var="#form#">
            <cfquery name="passw" datasource="#application.dsource#">
                insert into Passwords (personId,password) values ('#newid#','#hash(form.newPassword, "SHA-256")#')
            </cfquery>
        <cfelse>
            <cfset accountMessage="That Email Account is Already in our System. Please login.">
        </cfif>
    </cfif>
</cffunction>

<cffunction name="newUserForm">
    <cfoutput>
        <legend>New User</legend>
        <div id="newAccountMessage">#accountMessage#</div>
            <form action="#cgi.script_name#?p=login" class="form-horizontal" method="post">
            <input type="hidden" name="newPersonId" value="">
            <div class="form-group">
                <label class="col-lg-3 control-label">First Name*</label>
                <div class="col-lg-9">
                    <input type="text" class="form-control" name="firstName" required />
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3 control-label">Last Name*</label>
                <div class="col-lg-9">
                    <input type="text" class="form-control" name="lastName" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-lg-3 control-label">Email*</label>
                <div class="col-lg-9">
                    <input type="email" class="form-control" name="email" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-lg-3 control-label">Password*</label>
                <div class="col-lg-9">
                    <input type="password" name="newPassword" class="form-control" id="newAccountPassword" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-lg-3 control-label">Confirm Password*</label>
                <div class="col-lg-9">
                    <input type="password" class="form-control" id="newAccountPasswordConfirm" required/>
                </div>
            </div>
<!---Input button--->
            <div class="form-group">
                <label class="col-lg-3 control-label">&nbsp;</label>
                <div class="col-lg-9">
                    <button type="button" id="newAccountButton" class="btn btn-warning" onclick="validateNewAccount()">Create
                        New Account</button>
                    <input type="submit" id="submitNewAccountForm" style="display:none" />
                </div>
            </div>
<!---/Input button--->
        </form>
    </cfoutput>
</cffunction>

<cffunction name="loginForm">
    <cfoutput>
        <div id="loginMessage">#loginMessage#</div>
            <form action="#cgi.script_name#?p=login" method="post" class="form-horizontal">
        <legend>Login</legend>
        <div class="form-group">
            <label class="col-lg-3 control-label">
                Username:
            </label>
            <div class="col-lg-9">
                <input type="text" name="loginEmail" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-3 control-label">
                Password:
            </label>
            <div class="col-lg-9">
                <input type="password" name="loginPass" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-3 control-label">
                &nbsp;
            </label>
            <div class="col-lg-9">
                <button class="btn btn-primary" type="submit">Login</button>
            </div>
        <!---  Reset password  --->
            <div>
                <a href="#cgi.script_name#?p=resetPassword">Reset Password</a>
            </div>
        </div>
    </form>
    </cfoutput>
</cffunction>
