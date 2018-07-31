<cfif !StructKeyExists(COOKIE, "#GridName#PerPage")>
    <cfcookie name="#GridName#PerPage" value="0" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
</cfif>
<cfif !StructKeyExists(COOKIE, "#GridName#Direction")>
    <cfcookie name="#GridName#Direction" value="asc" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
</cfif>