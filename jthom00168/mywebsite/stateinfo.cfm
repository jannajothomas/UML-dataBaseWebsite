<cfif isdefined('url.p') and url.p eq 'logoff'>
    <cfset StructClear(session)>
    <cfset session.isLoggedIn=false>
    <cfset makeCleanUser()>
    <cfset p="carousel">
</cfif>



<cfif not isdefined('session.user')>
    <cfset makeCleanUser()>
</cfif>

<cfif isdefined('form.loginEmail')>

    <cfquery name="access" datasource="#application.dsource#">
        select * from People
        inner join Passwords on People.people_id = Passwords.personId
        where email='#form.loginEmail#' and password='#hash(form.loginPass,"SHA-256")#'
    </cfquery>

    <cfif access.recordcount gt 0>
        <cfset session.user.firstName=access.firstName[1]>
        <cfset session.user.lastName=access.lastName[1]>
        <cfset session.user.email=access.email[1]>
        <cfset session.user.acctnumber=access.people_id[1]>
        <cfset session.isloggedin=true>
        <cfset p="carousel">
        <cfif access.IsAdmin[1] neq ''>
            <cfset session.user.IsAdmin=access.IsAdmin[1]>
        </cfif>
    <cfelse>
        <<cfset loginMessage="Sorry, that login doesn't match" />
    </cfif>
</cfif>

<!--- Handle the logoff link.--->
<cfif isdefined('url.p') and url.p eq 'logoff'>
    <cfset structClear(session)>
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