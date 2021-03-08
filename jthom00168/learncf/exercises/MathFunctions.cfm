<h1>Bonus Exercise</h1>

<cfoutput>
    <form action="#cgi.script_name#?#cgi.query_string#" method="get">
    <cfset num1="enternumber1">
    <cfset num2="enternumber2">
    <cfif isdefined('number1')>
        <cfset num1=#number1#>
    </cfif>
    <cfif isdefined('number2')>
        <cfset num2=#number2#>
    </cfif>
</cfoutput>

        <div class="form-group">
            <div class="col-sm-10">
                <cfoutput>
                <input type="text" class="form-control" id="number1" name="number1" placeholder=#num1#>
                </cfoutput>
            </div>
            <label for="number1" class="col-sm-2 control-label">First Number</label>

            <div class="col-sm-10">
                <cfoutput>
                <input type="text" class="form-control" id="number2" name="number2" placeholder=#num2#>
                </cfoutput>
            </div>
            <label for="number2" class="col-sm-2 control-label">Second Number</label>

            <input type="submit" value="Get The Sum!" />
        </div>
    </form>
<cfoutput>
    <cfif isdefined('number1')>
        <cfif isdefined('number2')>
                The sum of the number is:
                #addNumbers(number1,number2)#
        </cfif>
    </cfif>
</cfoutput>
    <br/>
    <br/>
<h1>URLs and forms Exercise</h1>
<cfoutput>
    #addNumbers(5,3)# is the result of addNumbers(5,3)<br/>
    #addNumbers(100,223)# is the result of addNumbers(100,223)<br/>
    #addNumbers(4,40)# is the result of addNumbers(4,40)<br/>
</cfoutput>



<cffunction name="addNumbers" access="private" returntype="numeric">
    <cfargument name="firstnum" type="numeric">
    <cfargument name="secondnum" type="numeric">
    <cfreturn #firstnum#+#secondnum#>
</cffunction>



