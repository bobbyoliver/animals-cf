<!---
OnApplicationStart
OnRequestStart
OnRequestEnd
OnError

-Avoiding use of APPLICATION scope variables in Application.cfc when possible
-Avoiding use of mappings such as "/code" in "Application.cfc" when possible


http://animals.bobbyoliverlocal.com?reloadapp=ftc9e9qcqzjouo6hmqk4
http://animals.bobbyoliverlocal.com?reloadappanddb=ftc9e9qcqzjouo6hmqk4



http://animals.bobbyoliver.com?reloadapp=ftc9e9qcqzjouo6hmqk4
http://animals.bobbyoliver.com?reloadappanddb=ftc9e9qcqzjouo6hmqk4



TO DO:
-add spinner
-add some sort of row warning item like turn row warning color if a certain age etc.
-text of delete buttons isn't sized properly

--->

<cfcomponent displayname="Application" output="false" hint="Application.cfc file for Animals.">

	<!---THIS scope variables--->
	<cfset THIS.Name = "sites_animals_bobbyoliver_com">
	<!---Datasource--->
	<cfset THIS.Datasource = "animals">
	<!---APPLICATION scope variables persist for 2 days--->
	<cfset THIS.ApplicationTimeout = CreateTimeSpan(2, 0, 0, 0)>
	<!---Enable sessions--->
	<cfset THIS.SessionManagement = true>
	<!---SESSION scope variables persist for 1 hour--->
	<cfset THIS.SessionTimeout = CreateTimeSpan(0, 1, 0, 0)>
	<!---Enable compression (GZip) for the Lucee response stream for text-based responses when supported by client browser--->
	<cfset THIS.Compression = true>
	<!---Enable ORM--->
	<cfset THIS.ORMEnabled = true>
	<!---
	ORM Settings
	-"CFCLocation" tells ORM where to look for persistent CFC models
	-"EventHandling" enables ORM event handling methods (PreLoad, PostLoad, PreInsert, PostInsert, PreUpdate, PostUpdate, PreDelete, PostDelete)
	-"FlushAtRequestEnd" set to "false" prevents setter calls from instantly writing to DB
		-Allows form data to be set to object properties, then model validate calls can validate data before writing to DB
		-Causes need to call <cfset ORMFlush()> after all sets and updates, but not for new inserts like <cfset EntitySave(Animal, true)>
	-"DBCreate" set to "None" by default so DB is not dropped or updated unless triggered to do so
	-"UseDBForMapping" set to "false" to prevent ORM from inspecting DB for settings, instead it will get settings from the models
	-"Dialect" if set to MySQL5 instead of MySQL it uses exact lengths on varchar fields versus setting type to "longtext", probably additional differences
	-Not setting a specific schema, by default the "public" schema is used if using PG DB
	--->
	<cfset THIS.ORMSettings = {CFCLocation="/models", EventHandling=true, FlushAtRequestEnd=false, DBCreate="None", UseDBForMapping=false, Dialect="MySQL5"}>
	<!---
	-Override "DBCreate" set above in "ORMSettings" based on URL reload variable passed
	-"THIS.ORMSettings.DBCreate" can be set to "None", "DropCreate", or "Update"
	-Records are not inserted here
	-This is just setting "THIS.ORMSettings.DBCreate" to determine what DB action CF should take
	--->
	<cfif StructKeyExists(URL, "ReloadAppAndDB") AND URL.ReloadAppAndDB EQ "ftc9e9qcqzjouo6hmqk4">
		<cfset THIS.ORMSettings.DBCreate = "DropCreate">
	</cfif>



	<!---OnApplicationStart--->
	<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Runs first time Application is loaded.">
		<!---Prevents Application and/or DB reloads unless "URL" variable is "APPLICATION.ReloadKey"--->
		<cfset APPLICATION.ReloadKey = "ftc9e9qcqzjouo6hmqk4">
		<cfset APPLICATION.LogFile = "AnimalsLog">
		<cfset APPLICATION.Display = "Animals">
		<cfset APPLICATION.Debug = true>
		<cfset APPLICATION.DefaultDateFormat = "dd/mm/yyyy">
		<!---
		-Hardcoded "APPLICATION.Key", used GenerateSecretKey("AES", 128) to create it
		-Used for URL encrypt/decrypt and CSRFGenerateToken cross-site request forgery (CSRF) attack security on forms
		--->
		<cfset APPLICATION.Key = "RFB2TLKCxExocNJvsGZLQg==">
		<!---
        -Global instantiated controller for functions like: BuildLink, LinkTo, Dec, Inc, etc. that can be called anywhere
            -<cfset APPLICATION.Inst.FunctionName(FunctionArg1, FunctionArg2)>
            -<cfset SomeVar = APPLICATION.Inst.FunctionName(FunctionArg1, FunctionArg2)>
        --->
        <cfset APPLICATION.Inst = CreateObject("Component", "/udfs/Inst")>
		<cfreturn true>
	</cffunction>



	<!---OnRequestStart--->
	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Runs before every request.">
		<cfargument name="TargetPage" type="string" required="true">
		<!---Create REQUEST.ReqStr struct used for all requests, set here in OnRequestStart so REQUEST.ReqStr.UTCNow can be used during the build process--->
        <cfset REQUEST.ReqStr = StructNew()>
        <!---UTC Now() time--->
        <cfset REQUEST.ReqStr.UTCNow = DateConvert("local2utc", Now())>
		<!---
		-If "URL.ReloadApp" or "URL.ReloadAppAndDB" exists and is equal to "APPLICATION.ReloadKey":
			-Stop application to clear out any changed/unneeded APPLICATION scope variables
			-Start application
			-Clear ORM session
			-"ORMReload" call inspects the models and rebuilds/updates the DB tables
			-Delete all cookies
		--->
		<cfif (StructKeyExists(URL, "ReloadApp") AND URL.ReloadApp EQ "ftc9e9qcqzjouo6hmqk4") OR (StructKeyExists(URL, "ReloadAppAndDB") AND URL.ReloadAppAndDB EQ "ftc9e9qcqzjouo6hmqk4")>
			<cfset ApplicationStop()>
			<cfset OnApplicationStart()>
			<cfset ORMClearSession()>
			<cfset ORMReload()>
			<!---Clear entire SESSION--->
            <cfset StructClear(SESSION)>
			<!---"OnApplicationStart()" doesn't clear cookies so loop COOKIE scope and delete cookies, "StructClear" doesn't work to clear cookies either--->
			<cfif StructCount(COOKIE) GT 0>
				<cfloop collection="#COOKIE#" item="i">
					<cfset StructDelete(COOKIE, "#i#")>
				</cfloop>
			</cfif>
			<!---DB is getting dropped and recreated so insert DB records--->
		    <cfif StructKeyExists(URL, "ReloadAppAndDB") AND URL.ReloadAppAndDB EQ "ftc9e9qcqzjouo6hmqk4">
		        <cfset ORMClearSession()>
		        <cfinclude template="/config/_InsertRecords.cfm">
		    </cfif>
		</cfif>
		<!---If in "local" environment "OnError" function doesn't run, forces dump of error message to screen in "local" only--->
		<cfif Trim(getPageContext().getRequest().getServerName()) EQ "animalss.bobbyoliverlocal.com">
			<cfset StructDelete(THIS, "OnError")>
			<cfset StructDelete(VARIABLES, "OnError")>
		</cfif>
		<!---
        -Set default SESSION.VisStr variables in case this is visitor's first request before SESSION.VisStr exists
        -Will then set REQUEST.ReqStr.ReloadVisStr to true to trigger moment js to get visitor's time zone via browser ajax call in _Footer.cfm
        -Placed here because of reload call above that clears entire SESSION with StructClear(SESSION)
        -Cannot manually set these values since must account for daylight savings time change each year, so use CF GetTimeZoneInfo().utcHourOffset (GetTimeZoneInfo() is a struct))
            -GetTimeZoneInfo().utcHourOffset = 5|4|-11|-10 depending on time of year
                -Even though Australia/Melbourne is +11, GetTimeZoneInfo().utcHourOffset is returned as -11 with a minus sign
            -GetTimeZoneInfo().id = America/New_York|Australia/Melbourne|Australia/Sydney
            -GetTimeZoneInfo().name = Australian Eastern Standard Time (Victoria)
                -This is incorrectly returning "Australian Eastern Standard Time (Victoria)" during daylight saving time which is preferably displayed as "AEDT" and then "AEST" when it's not daylight saving time
                -Needed SESSION.VisStr.HoursOffset and SESSION.VisStr.UTCOffset aren't available either
                -So going to use GetTimeZoneInfo().utcHourOffset to conditionally set SESSION.VisStr.AbbreviatedTimeZone, SESSION.VisStr.HoursOffset, and SESSION.VisStr.UTCOffset
        --->
        <cfif !StructKeyExists(SESSION, "VisStr")>
            <cfset SESSION.VisStr = StructNew()>
            <!---America/New_York|Australia/Melbourne|Australia/Sydney--->
            <cfset SESSION.VisStr.TimeZone = GetTimeZoneInfo().id>
            <!---EDT|EST|AEDT|AEST--->
            <!--- -05:00|-04:00|+11:00|+10:00 --->
            <!--- -300|-240|660|600 --->
            <cfif GetTimeZoneInfo().utcHourOffset EQ "-11">
                <cfset SESSION.VisStr.AbbreviatedTimeZone = "AEDT">    
                <cfset SESSION.VisStr.HoursOffset = "+11:00">
                <cfset SESSION.VisStr.UTCOffset = "660">
            <cfelseif GetTimeZoneInfo().utcHourOffset EQ "-10">
                <cfset SESSION.VisStr.AbbreviatedTimeZone = "AEST">
                <cfset SESSION.VisStr.HoursOffset = "+10:00">
                <cfset SESSION.VisStr.UTCOffset = "600">
            <cfelseif GetTimeZoneInfo().utcHourOffset EQ "5">
                <cfset SESSION.VisStr.AbbreviatedTimeZone = "EDT">
                <cfset SESSION.VisStr.HoursOffset = "-05:00">
                <cfset SESSION.VisStr.UTCOffset = "-300">
            <cfelseif GetTimeZoneInfo().utcHourOffset EQ "4">
                <cfset SESSION.VisStr.AbbreviatedTimeZone = "EST">
                <cfset SESSION.VisStr.HoursOffset = "-04:00">
                <cfset SESSION.VisStr.UTCOffset = "-240">
            <!---Need this condition cause on prod server GetTimeZoneInfo() probably doesn't return anything, so SESSION.VisStr vars weren't getting set on first page visit--->
            <cfelse>
                <!---
                For EC2 server in Sydney
                Overkill, but manually calculating if DST or not for Sydney from 2018 to 2022 to set initial SESSION.VisStr vars on first page load in case GetTimeZoneInfo() returns nothing on prod
                    2018 - 04010300, 10070200
                    2019 - 04070300, 10060200
                    2020 - 04050300, 10040200
                    2021 - 04040300, 10030200
                    2022 - 04030300, 10020200
                SESSION.VisStr.TimeZone will be empty if GetTimeZoneInfo() didn't return anything so overwrite it and manually set it to "Australia/Sydney" where EC2 is
                --->
                <cfset SESSION.VisStr.TimeZone = "Australia/Sydney">
                <cfif (DateTimeFormat(Now(), "yyyymmddHHnn") GT "04010300" AND DateTimeFormat(Now(), "yyyymmddHHnn") LT "10070200") OR
                        (DateTimeFormat(Now(), "yyyymmddHHnn") GT "04070300" AND DateTimeFormat(Now(), "yyyymmddHHnn") LT "10060200") OR
                        (DateTimeFormat(Now(), "yyyymmddHHnn") GT "04050300" AND DateTimeFormat(Now(), "yyyymmddHHnn") LT "10040200") OR
                        (DateTimeFormat(Now(), "yyyymmddHHnn") GT "04040300" AND DateTimeFormat(Now(), "yyyymmddHHnn") LT "10030200") OR
                        (DateTimeFormat(Now(), "yyyymmddHHnn") GT "04030300" AND DateTimeFormat(Now(), "yyyymmddHHnn") LT "10020200")>
                    <cfset SESSION.VisStr.AbbreviatedTimeZone = "AEDT">
                    <cfset SESSION.VisStr.HoursOffset = "+11:00">
                    <cfset SESSION.VisStr.UTCOffset = "660">
                <cfelse>
                    <cfset SESSION.VisStr.AbbreviatedTimeZone = "AEST">
                    <cfset SESSION.VisStr.HoursOffset = "+10:00">
                    <cfset SESSION.VisStr.UTCOffset = "600">
                </cfif>
            </cfif>
            <!---First request by visitor so set REQUEST.ReqStr.ReloadVisStr to true--->
            <cfset REQUEST.ReqStr.ReloadVisStr = true>
        <cfelse>
            <cfset REQUEST.ReqStr.ReloadVisStr = false>
        </cfif>
        <!---
        For testing
        <cfset SESSION.VisStr.TimeZone = "America/New_York">
        <cfset SESSION.VisStr.AbbreviatedTimeZone = "EDT">
        <cfset SESSION.VisStr.HoursOffset = "-05:00">
        <cfset SESSION.VisStr.UTCOffset = "-300">
        <cfset REQUEST.ReqStr.ReloadVisStr = false>
        --->
		<!---
	    -All requests call "VerifyActionRequest" function in "verify" controller to validate request
	    -If valid, "index.cfm" calls "HandleRequest" in the correct controller
	        -This controller is set in "VerifyActionRequest"
	    --->
	    <cfinvoke component="/controllers/verify" method="VerifyActionRequest">
		<cfreturn true>
	</cffunction>



	<!---OnRequestEnd--->
	<cffunction name="OnRequestEnd" access="public" returntype="void" hint="Runs at end of every request, used to delete message displays from SESSION scope.">
	    <cfargument name="TargetPage" type="string" required="true">
	    <!---Delete page top display from SESSION if it exists--->
	    <cfif StructKeyExists(SESSION, "AlertPageTop")>
	        <cfset StructDelete(SESSION, "AlertPageTop")>
	    </cfif>
	    <!---Delete form display from SESSION if it exists--->
	    <cfif StructKeyExists(SESSION, "AlertForm")>
	        <cfset StructDelete(SESSION, "AlertForm")>
	    </cfif>
	</cffunction>


	
	<!---OnError--->
	<cffunction name="OnError" access="public" returntype="void" output="true">
		<cfargument name="Exception" required="true">
		<cfargument name="Eventname" type="string" required="true">
		<cfset var ErrorText = "">
		<cflog file="AnimalsLog" text="OnError:#ARGUMENTS.Exception.message#">
		<!---
		Typically email and/or save the info below to a file for error catching
		<cfsavecontent variable="ErrorText">
			<cfoutput>
				An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
				Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br />
				<cfdump var="#ARGUMENTS.Exception#" label="Error">
				<cfdump var="#FORM#" label="FORM">
				<cfdump var="#URL#" label="URL">
			</cfoutput>
		</cfsavecontent>
		--->
        <cfinvoke component="/udfs/Helpers" method="DisplayMessage">
            <cfinvokeargument name="MessageType" value="Error">
        </cfinvoke>
	</cffunction>

</cfcomponent>