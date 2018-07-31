<!---
HandleRequest
getfile
--->

<cfcomponent displayname="Global" output="false" hint="Controller inherited by Main and Animals controllers.">

    <!---HandleRequest--->
    <cffunction name="HandleRequest" access="public" returntype="void" output="yes" hint="Action request has been verified so now the proper action and includes are called to handle request.">
        <!---This function is always called by the controller that inherits this "Global" controller so "HeaderVariablesStruct" always gets set in it's controller--->
        <cfset HeaderVariablesStruct = Evaluate("GetHeaderVariables" & REQUEST.Controller & "()")>
        <cfinclude template="/views/includes/_Header.cfm">
        <cfset Evaluate(REQUEST.Action & "()")>
        <cfinclude template="/views/#REQUEST.Controller#/#REQUEST.Action#.cfm">
        <cfinclude template="/views/includes/_Footer.cfm">
    </cffunction>



    <!---getfile--->
    <!---In a true production environment would have some additional needed checks done here--->
    <cffunction name="getfile" access="public" returntype="void" output="false" hint="Gets a file for a user.">
    	<cflocation url="/files/#URL.Filename#" addtoken="false">
    </cffunction>

</cfcomponent>