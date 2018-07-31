<!---
CheckValidURLParameter
--->
<cfcomponent displayname="Invoke" output="false" hint="Invoke UDF">

    <!---CheckValidURLParameter--->
    <cffunction name="CheckValidURLParameter" access="public" returntype="void" output="false" hint="Checks if URL parameter exists and passes integer or string validation, redirects if not">
        <!---Set to "Integer" or "String"--->
        <cfargument name="ParamType" type="string" required="true">
        <cfargument name="ParamName" type="string" required="true">
        <!---Set to true by default but if any of the conditions below are false then redirect to message page--->
        <cfset var SuccessBit = true>
        <!---Check if URL varialbe exists, don't use "Evaluate" because variable name needs to be in quotes so URL.#ARGUMENTS.ParamName# becomes "URL.id" etc.--->
        <cfif !IsDefined("URL.#ARGUMENTS.ParamName#")>
            <cfset SuccessBit = false>
        <!---URL variable exists so do the rest of our checks--->
        <cfelse>
            <!---Checks both strings & integers to make sure they are not empty since a URL variable could pass "IsDefined" check above if it's an empty string--->
            <cfif Trim(Evaluate("URL." & ARGUMENTS.ParamName)) EQ "">
                <cfset SuccessBit = false>
            </cfif>
            <!---Special Integer checks--->
            <cfif ARGUMENTS.ParamType EQ "Integer">
                <cfif !IsValid("Integer", Trim(Evaluate("URL." & ARGUMENTS.ParamName))) OR Trim(Evaluate("URL." & ARGUMENTS.ParamName)) LT 1>
                    <cfset SuccessBit = false>
                </cfif>
            <!---Special String checks--->
            <!---
            -Believe this is working, but had a difficult time testing it cause couldn't figure out how to pass value that was not simple in URL string
            -It might not even be possible to pass anything but a simple value so this could be a wasted check, but isn't causing any issues
            --->
            <cfelseif ARGUMENTS.ParamType EQ "String">
                <cfif !IsSimpleValue(Trim(Evaluate("URL." & ARGUMENTS.ParamName)))>
                    <cfset SuccessBit = false>
                </cfif>
            </cfif>
        </cfif>
        <!---If "SuccessBit" is "false" then redirect, otherwise do nothing--->
        <cfif SuccessBit EQ false>
            <cfinvoke component="/udfs/Invoke" method="DisplayMessage">
                <cfinvokeargument name="MessageType" value="InvalidURL">
            </cfinvoke>
        </cfif>
    </cffunction>



    <!---DisplayMessage--->
    <cffunction name="DisplayMessage" access="public" returntype="void" output="false" hint="Redirects user to message homepage to display message">
        <!---Pass MessageType argument to determine message display: InvalidURL, CustomError, RecordNoLongerExists, etc.--->
        <cfargument name="MessageType" type="string" required="true">
        <!---Delete SESSION.AlertPageTop as a precaution since going to set it again here--->
        <cfset StructDelete(SESSION, "AlertPageTop")>
        <cfif ARGUMENTS.MessageType EQ "InvalidURL">
            <cfset SESSION.AlertPageTop = "col-12~danger~You have requested an invalid URL.">
        <cfelseif ARGUMENTS.MessageType EQ "CustomError">
            <cfset SESSION.AlertPageTop = "col-12~danger~You have experienced an error. Administrators have been notified.">
        <cfelseif ARGUMENTS.MessageType EQ "RecordNoLongerExists">
            <cfset SESSION.AlertPageTop = "col-12~danger~The record you are trying to view no longer exists.">
        </cfif>
        <cflocation url="/index.cfm?controller=animals&action=animals" addtoken="false">
    </cffunction>

</cfcomponent>