<!---
Init
SelectForGrid
--->
<cfcomponent displayname="Animal" output="false" hint="Animal DAL">

	<cfset Init()>



	<!---Init--->
	<cffunction name="Init" access="public" output="false" returntype="Animal" hint="Runs before all functions in this DAL">
		<cfset ThisDALModel = "Animal">
		<cfreturn this>
	</cffunction>



	<!---SelectForGrid--->
	<!---Arguments are passed in trimmed--->
    <cffunction name="SelectForGrid" access="public" output="false" returntype="query">
    	<!---Any SQL, e.g.: "Animals.Name ASC"--->
		<cfargument name="OrderBy" type="string" required="false" default="Animals.Name ASC">
		<!---Any positive integer--->
        <cfargument name="Start" type="numeric" required="false" default="1">
        <!---0|50|100|200|1000, 0 is all--->
        <cfargument name="PerPage" type="numeric" required="false" default="50">
        <!---Any search string--->
        <cfargument name="Search" type="string" required="false" default="">
        <!---Any integer, 0 is all--->
        <cfargument name="KeeperID" type="numeric" required="false" default="0">
        <!---Any integer, 0 is all--->
        <cfargument name="AreaID" type="numeric" required="false" default="0">
        <!---Any integer, 0 is all--->
        <cfargument name="TypeID" type="numeric" required="false" default="0">
        <!---Any integer, 0 is all--->
        <cfargument name="DOB" type="numeric" required="false" default="0">
		<cftry>
			<!---Order of columns matters to format the order of xlsx columns when generating spreadsheets--->
			<cfquery name="Query">
				SELECT
	                <!---MySQL technique used to get a row count in a 2nd query--->
	                SQL_CALC_FOUND_ROWS
	                Animals.Name,
	                Animals.CreatedAt,
	                Animals.UpdatedAt,
	                Animals.Species,
	                Keepers.FirstName AS FirstNameKeeper,
	                Keepers.LastName AS LastNameKeeper,
	                Types.Type,
	                Areas.Area,
	                Animals.DOB,
	                Animals.Gender,
	                Animals.FileCleanAvatar,
	                Animals.SpecialDietBit,
	                Animals.SpecialDiet,
	                Animals.FavoriteColor,
	                Animals.FavoriteColorExplain,
	                Animals.ArrivedAt,
	                Animals.Notes,
	                <!---DELETED COLUMNS IN SPREADSHEET--->
	                Animals.ID,
	                <!---Needed for dashboard charts--->
	                Keepers.ID AS KeeperID
	            FROM
	                Animals
	            <!---Type--->
                LEFT JOIN
                    Types ON Animals.TypeID = Types.ID AND
                    Types.DeletedAt IS Null
                <!---Keeper--->
	            LEFT JOIN
	                Keepers ON Animals.KeeperID = Keepers.ID AND
	                Keepers.DeletedAt IS Null
	            <!---Area--->
	            LEFT JOIN
	                Areas ON Animals.AreaID = Areas.ID AND
	                Areas.DeletedAt IS Null
	            WHERE
	                Animals.DeletedAt IS Null
	                <!---FILTERS--->
	                <cfif ARGUMENTS.TypeID NEQ 0>
	                    AND Animals.TypeID = <cfqueryparam value="#ARGUMENTS.TypeID#" cfsqltype="cf_sql_integer">
	                </cfif>
	                <cfif ARGUMENTS.KeeperID NEQ 0>
	                    AND Animals.KeeperID = <cfqueryparam value="#ARGUMENTS.KeeperID#" cfsqltype="cf_sql_integer">
	                </cfif>
	                <cfif ARGUMENTS.AreaID NEQ 0>
	                    AND Animals.AreaID = <cfqueryparam value="#ARGUMENTS.AreaID#" cfsqltype="cf_sql_integer">
	                </cfif>
	                <!---
	                -Can be: "0", "3", "7", "8" years
	                -Using MySQL DATEDIFF and DATE_FORMAT functions
	                -Number after < sign represents "within last x days"
	                -%H is 24 hour time: 00-23
	                --->
	                <cfif ARGUMENTS.DOB NEQ "0">
	                	<cfif ARGUMENTS.DOB EQ "3">
		                	AND DATEDIFF(DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(Animals.DOB,'%Y%m%d')) >= 0
		                	AND DATEDIFF(DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(Animals.DOB,'%Y%m%d')) < 1095
		                <cfelseif ARGUMENTS.DOB EQ "7">
		                	AND DATEDIFF(DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(Animals.DOB,'%Y%m%d')) >= 0
		                	AND DATEDIFF(DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(Animals.DOB,'%Y%m%d')) < 2555
		                <cfelseif ARGUMENTS.DOB EQ "8">
		                	AND DATEDIFF(DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(Animals.DOB,'%Y%m%d')) >= 0
		                	AND DATEDIFF(DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(Animals.DOB,'%Y%m%d')) < 2920
	                	</cfif>
	                </cfif>
	                <!---SEARCH--->
	                <cfif ARGUMENTS.Search NEQ "">
	                    AND (
	                        Animals.Name LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar"> OR
	                        Animals.Species LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar"> OR
	                        Types.Type LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar"> OR
	                        Areas.Area LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar"> OR
	                        <!---
	                        -Since keeper name is displayed as 1 field but is stored in 2 fields it make this search trickier
	                        -A first or last name could have spaces in it too, e.g.: "Mary Sue" could all be stored in the first name field
	                        -For this reason going to search string against:
	                        	-First name
	                        	-Last name
	                        	-First name concatenated to last name
	                        --->
                            Keepers.FirstName LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar"> OR
                            Keepers.LastName LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar"> OR
	                        CONCAT(Keepers.FirstName, ' ', Keepers.LastName) LIKE <cfqueryparam value="%#ARGUMENTS.Search#%" cfsqltype="cf_sql_varchar">
	                        )
	                </cfif>
				<!---ARGUMENTS.OrderBy doesn't work if in cfqueryparam tag--->
			    ORDER BY #ARGUMENTS.OrderBy#
			    <cfif ARGUMENTS.PerPage NEQ 0>
			    	<!---Using MySQL LIMIT & OFFSET to get select number of records--->
			    	LIMIT <cfqueryparam value="#ARGUMENTS.PerPage#" cfsqltype="cf_sql_integer">
			    	<!---ARGUMENTS.Start is record to start on but must always subtract 1 from it for OFFSET to work correctly--->
			    	OFFSET <cfqueryparam value="#ARGUMENTS.Start-1#" cfsqltype="cf_sql_integer">
			    </cfif>
			</cfquery>
			<!---Get record count total--->
			<cfinclude template="/dals/includes/_SelectForGrid01.cfm">
			<cfcatch>
				Would call custom error function here, but didn't move it over to this demo.
				<cfabort>
				<!---<cfinclude template="/dals/includes/_CatchAbortFalse.cfm">--->
			</cfcatch>
        </cftry>
		<cfreturn Query>
    </cffunction>

</cfcomponent>