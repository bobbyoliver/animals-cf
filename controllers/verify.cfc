<!---
VerifyActionRequest
CheckControllerAndAction
--->

<cfcomponent displayname="Verify" output="false" hint="Verifies action request via OnRequestStart VerifyActionRequest call and aborts with 404 if invalid.">
        
    <!---VerifyActionRequest--->
    <cffunction name="VerifyActionRequest" access="public" returntype="void" output="false" hint="Called from OnRequestStart, verifies all action requests to continue to index.cfm or abort with 404.">
        <!---/index.cfm & /ajax.cfc ========================================================================================--->
        <!---All requests should be for "/index.cfm" or "/ajax.cfc"--->
        <cfif Trim(getPageContext().getRequest().getServletPath()) NEQ "/index.cfm" AND Trim(getPageContext().getRequest().getServletPath()) NEQ "/ajax.cfc">
            <cfinclude template="/views/includes/_404.cfm">
            <cfabort>
        <!---homepage, reloading app, or reloading app and DB ==============================================================--->
        <!---
            /
            /index.cfm?reloadapp=ReloadKey
            /index.cfm?reloadappanddb=ReloadKey
        --->
        <cfelseif Trim(getPageContext().getRequest().getQueryString()) EQ "" OR
                Trim(getPageContext().getRequest().getQueryString()) EQ "reloadapp=#APPLICATION.ReloadKey#" OR
                Trim(getPageContext().getRequest().getQueryString()) EQ "reloadappanddb=#APPLICATION.ReloadKey#">
            <cfset REQUEST.Controller = "main">
            <cfset REQUEST.Action = "home">
        <!---homepage, reloading app, or reloading app and DB ==============================================================--->
        <cfelseif StructKeyExists(URL, "Controller") AND
                URL.Controller NEQ "" AND
                StructKeyExists(URL, "Action") AND
                URL.Action NEQ "">
            <!---Check to make sure both Controller and Action exist, no return variable cause CheckControllerAndAction handles the 404 if necessary--->
            <cfinvoke component="/controllers/Verify" method="CheckControllerAndAction">
                <cfinvokeargument name="Controller" value="#URL.Controller#">
                <cfinvokeargument name="Action" value="#URL.Action#">
            </cfinvoke>
            <cfset REQUEST.Controller = URL.Controller>
            <cfset REQUEST.Action = URL.Action>
        </cfif>
    </cffunction>



    <!---CheckControllerAndAction--->
    <cffunction name="CheckControllerAndAction" access="public" returntype="void" output="false" hint="Checks that controller exists and contains a matching function (action) of the request, returns true if request is valid and aborts wiht 404 if invalid.">
        <cfargument name="Controller" type="string" required="true">
        <cfargument name="Action" type="string" required="true">
        <cfset var ControllerMetadataStruct = "">
        <cfset var ValidControllerAndActionBit = false>
        <cfif FileExists(ExpandPath("/") & "/controllers/" & ARGUMENTS.Controller & ".cfc")>
            <!---"GetMetadata" returns a structure with a "Functions" key which is an array of structures, one of those structure keys is "Name" (function name)--->
            <cfset ControllerMetadataStruct = GetMetadata(CreateObject("Component", "/controllers/#ARGUMENTS.Controller#"))>
            <!---Loop controller functions to see if "ARGUMENTS.Action" exists in it--->
            <cfloop array="#ControllerMetadataStruct.Functions#" index="i">
                <cfif i.Name EQ ARGUMENTS.Action>
                    <cfset ValidControllerAndActionBit = true>
                    <cfbreak>
                </cfif>
            </cfloop>
            <!---All controllers inherit the Global controller so we need to loop "Extends.Funtions" too if "ValidControllerAndActionBit" is still false--->
            <cfif ValidControllerAndActionBit EQ false>
                <cfloop array="#ControllerMetadataStruct.Extends.Functions#" index="i">
                    <cfif i.Name EQ ARGUMENTS.Action>
                        <cfset ValidControllerAndActionBit = true>
                        <cfbreak>
                    </cfif>
                </cfloop>
            </cfif>
        </cfif>
        <!---Have now looped controller and the "Global" controller too, so if still "false", include 404 and abort--->
        <cfif ValidControllerAndActionBit EQ false>
            <cfinclude template="/views/includes/_404.cfm">
            <cfabort>
        </cfif>
    </cffunction>

</cfcomponent>