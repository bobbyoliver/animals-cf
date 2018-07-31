<!---BODY ========================================================--->
<cfoutput>
    <div class="container">
        <cfif StructKeyExists(SESSION, "AlertPageTop")><cfinclude template="/views/includes/_AlertPageTop.cfm"></cfif>
        <cfif StructKeyExists(SESSION, "AlertForm")><cfinclude template="/views/includes/_AlertForm.cfm"></cfif>
        <!---Form add animal include--->
        <cfinclude template="/views/animals/includes/_FormCreateUpdateAnimal.cfm">
    </div>
</cfoutput>