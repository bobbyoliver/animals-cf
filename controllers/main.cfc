<!---
Init
GetHeaderVariablesMain
home (page action)
help (page action)
--->

<cfcomponent displayname="Main" output="false" extends="/controllers/Global" hint="Controller handles all Main actions.">
    
    <!---Called every time a function in this controller is called--->
    <cfset Init()>


    <!---Init--->
    <cffunction name="Init" access="public" returntype="void" output="false" hint="Runs before all functions in this controller.">
        <!---Calls Init function of parent controller--->
        <!---<cfset Super.Init()>--->
        <cfset REQUEST.ReqStr.BuildPDF = false>
    </cffunction>


    <!---GetHeaderVariablesMain--->
    <cffunction name="GetHeaderVariablesMain" access="public" returntype="struct" output="false" hint="Sets header variables for view.">
        <cfset var HeaderVariablesStruct = StructNew()>
        <cfset HeaderVariablesStruct.Robots = "noindex,nofollow">
        <cfswitch expression="#REQUEST.Action#">
            <cfcase value="home">
                <cfset HeaderVariablesStruct.Title = "Animals Demo">
                <cfset HeaderVariablesStruct.Description = "Animals Demo home.">
            </cfcase>
            <cfcase value="help">
                <cfset HeaderVariablesStruct.Title = "Help">
                <cfset HeaderVariablesStruct.Description = "Animals Demo help.">
            </cfcase>
            <cfcase value="message">
                <cfset HeaderVariablesStruct.Title = "Message">
                <cfset HeaderVariablesStruct.Description = "Message">
            </cfcase>
            <cfdefaultcase>
                <cfset HeaderVariablesStruct.Title = "Animals Demo">
                <cfset HeaderVariablesStruct.Description = "Animals Demo">
            </cfdefaultcase>
        </cfswitch>
        <!---No matter which controller in need to return "HeaderVariablesStruct" struct so _Header.cfm include can use the struct variables--->
        <cfreturn HeaderVariablesStruct>
    </cffunction>


    <!---home--->
    <cffunction name="home" access="public" returntype="void" output="false" hint="Home...">
    </cffunction>


    <!---help--->
    <cffunction name="help" access="public" returntype="void" output="false" hint="Help...">
    </cffunction>


    <!---message--->
    <cffunction name="message" access="public" returntype="void" output="false" hint="Message page to display various messeages.">
    </cffunction>

</cfcomponent>