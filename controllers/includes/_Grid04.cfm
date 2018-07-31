<!---"URL.PerPage" - "1000" is only an option when there are over 1000 records, in that case user cannot select "all" since it's too many records for one page--->
<cfif URL.PerPage NEQ 50 AND URL.PerPage NEQ 100 AND URL.PerPage NEQ 200 AND URL.PerPage NEQ 1000 AND URL.PerPage NEQ 0>
    <cfset URL.PerPage = 50>
</cfif>
<!---"URL.Start" - Also checking to make sure "URL.Start" is not greater than number of records in query later after query is returned--->
<cfif !IsNumeric(URL.Start) OR URL.Start LT 1 OR Round(URL.Start) NEQ URL.Start>
    <cfset URL.Start = 1>
</cfif>
<!---"URL.Direction" - Must be "asc" or "desc"--->
<cfif URL.Direction NEQ "asc" AND URL.Direction NEQ "desc">
    <cfset URL.Direction = "asc">
</cfif>