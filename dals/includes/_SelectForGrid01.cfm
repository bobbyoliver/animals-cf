<!---RECORD COUNT TOTAL--->
<!---2nd MySQL query to get RecordCountTotalNumber--->
<cfquery name="RecordCountTotalQuery">
    SELECT FOUND_ROWS() as RecordCountTotalNumber
</cfquery>
<!---Add RecordCountTotal column whether records or not, but if no records then add column without the array to ensure row count stays at 0--->
<cfif Query.RecordCount GT 0>
    <!---Empty array needed for QueryAddColumn call--->
    <cfset var RecordCountTotalArray = ArrayNew(1)>
    <!---Append RecordCountTotalNumber to RecordCountTotalArray--->
    <cfset ArrayAppend(RecordCountTotalArray, RecordCountTotalQuery.RecordCountTotalNumber)>
    <!---Add the column--->
    <cfset QueryAddColumn(Query, "RecordCountTotal", RecordCountTotalArray)>
<cfelse>
    <cfset QueryAddColumn(Query, "RecordCountTotal")>
</cfif>
<!---Setting numer of records found in search to a variable cause Query.RecordCount changes when doing pagination--->
<cfif ARGUMENTS.Search NEQ "">
	<cfset SearchRecordCountTotalNumber = RecordCountTotalQuery.RecordCountTotalNumber>
</cfif>
<!---Overwrite record count total number with record count total number from search--->
<cfif ARGUMENTS.Search NEQ "" AND SearchRecordCountTotalNumber GT 0>
    <cfset Query.RecordCountTotal[1] = SearchRecordCountTotalNumber>
</cfif>