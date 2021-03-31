<!---If a user is not defined, make a clean user--->
<cfif not isdefined('session.user')>
    <cfset makeCleanUser()>
</cfif>

<!---Try to load user--->
<cfif isdefined('form.loginEmail')>

    <!---Check dB for proper uesr login credentials--->
    <cfquery name="access" datasource="#application.dsource#">
        select * from People
        inner join Passwords on People.people_id = Passwords.personId
        where email='#form.loginEmail#' and password='#hash(form.loginPass,"SHA-256")#'
    </cfquery>

    <!---Credentils are correct, user is found--->
    <cfif access.recordcount gt 0>
        <!---Load session user variables--->
        <cfset session.user.firstName=access.firstName[1]>
        <cfset session.user.lastName=access.lastName[1]>
        <cfset session.user.email=access.email[1]>
        <cfset session.user.acctnumber=access.people_id[1]>
        <cfset session.isloggedin=true>

        <!---Success. Redirect to carousel--->
        <cfset p="carousel">

        <!---If user is admin set the appropriate flag--->
        <cfif access.IsAdmin[1] neq ''>
            <cfset session.user.IsAdmin=access.IsAdmin[1]>
        </cfif>

    <!---Failure.  Credentials  do not match.  Display an error message--->
    <cfelse>
        <<cfset loginMessage="Sorry, that login doesn't match" />
    </cfif>
</cfif>

<!---Clear the current user session when logoff is selected--->
<cfif isdefined('url.p') and url.p eq 'logoff'>
    <cfset StructClear(session)>
    <cfset session.isLoggedIn=false>
    <cfset makeCleanUser()>
    <cfset p="carousel">
</cfif>

<cffunction name="makeCleanUser">
    <cfset session.isLoggedIn=false>
    <cfset session.user.IsAdmin=false>
    <cfset session.user={
        firstName:'',
        lastName:'',
        acctNumber:'',
        email:'',
        IsAdmin:0
        }>
</cffunction> 