<!---BODY ========================================================--->
<cfoutput>
    <div class="container">
        <cfif StructKeyExists(SESSION, "AlertPageTop")><cfinclude template="/views/includes/_AlertPageTop.cfm"></cfif>
    </div>
</cfoutput>