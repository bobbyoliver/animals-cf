<!---
DateTimeUTCToTimeZone
DateTimeTimeZoneToUTC

-Functions can use scopes such as REQUEST, URL, SESSION, etc. for variables instead of receiving the variables as arguments
--->
<cfcomponent displayname="Inst" output="false" hint="Inst UDF, stored in APPLICATION scope, called without invoking">

    <!---DateTimeUTCToTimeZone--->
    <!---
    Tricky part was that actually had to set a time zone of UTC for the UTC times and then chain .tz to convert to user's stored session time zone
    Assumes that the DateTime value passed is UTC time and will be converted to local time based on stored SESSION.VisStr.TimeZone variable, uses momentcfc to convert correctly accounting for DST
    Returns a struct with: Time, LocalTime, and UTCTime
        -Time - is var want to use, takes the UTC time and uses momentcfc to adjust UTC time to user's time zone time
        -LocalTime=UTCtoTZ - Is going to return adjusted time based on local server time so won't be using this var
        -UTCTime=TZtoUTC - Would return a time zone time passed to UTC time but strictly using this function to pass UTC times to get user's time zone times
    --->
    <cffunction name="DateTimeUTCToTimeZone" access="public" returntype="string" output="false" hint="Formats dates and/or times">
        <cfargument name="DateTime" required="true" type="string">
        <cfargument name="Format" required="true" type="string">
        <cfset var ThisDateTimeStruct = new libraries.momentcfc.moment(ARGUMENTS.DateTime, "UTC").tz(SESSION.VisStr.TimeZone)>
        <cfset var ThisDateTime = "">
        <!---DateForDisplay, DateForFilename, DateNumbersOnly, DateTimeForDisplay, DateTimeLinkBreakForDisplay, DateTimeForFilename, DateTimeNumbersOnly, DateTimeDBFormat--->
        <cfswitch expression="#ARGUMENTS.Format#">
            <!---DateForDisplay - 25/12/2017, 25/12/17, 2017-12-25, etc. whatever default of FQDN is set to--->
            <cfcase value="DateForDisplay">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, APPLICATION.DefaultDateFormat)>
            </cfcase>
            <!---DateForFilename - 2017-12-25 makes sense for filenames to help with sorting in directories--->
            <cfcase value="DateForFilename">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, "yyyy-mm-dd")>
            </cfcase>
            <!---DateNumbersOnly - 20171225 makes sense for filenames to help with sorting in directories--->
            <cfcase value="DateNumbersOnly">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, "yyyymmdd")>
            </cfcase>
            <!---DateTimeForDisplay - 25/12/2017  5:30pm AEDT, 25/12/17  5:30pm AEDT, 2017-12-25  5:30pm AEDT, etc. whatever default of FQDN is set to--->
            <cfcase value="DateTimeForDisplay">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, APPLICATION.DefaultDateFormat) & "  " & LCase(TimeFormat(ThisDateTimeStruct.Time, "h:mmtt")) & " " & SESSION.VisStr.AbbreviatedTimeZone>
            </cfcase>
            <!---DateTimeLinkBreakForDisplay - 25/12/2017<br />5:30pm AEDT, 25/12/17<br />5:30pm AEDT, 2017-12-25<br />5:30pm AEDT, etc. whatever default of FQDN is set to--->
            <cfcase value="DateTimeLinkBreakForDisplay">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, APPLICATION.DefaultDateFormat) & "<br />" & LCase(TimeFormat(ThisDateTimeStruct.Time, "h:mmtt")) & " " & SESSION.VisStr.AbbreviatedTimeZone>
            </cfcase>
            <!---DateTimeForFilename - 2017-12-25--17-30-et makes sense for filenames to help with sorting in directories, et is SESSION.VisStr.AbbreviatedTimeZone converted to LCase, Lucee usess mm for minutes instead of nn like ACF, not getting am/pm since using 24 hour clock--->
            <cfcase value="DateTimeForFilename">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, "yyyy-mm-dd") & "--" & TimeFormat(ThisDateTimeStruct.Time, "HH-mm") & "-" & LCase(SESSION.VisStr.AbbreviatedTimeZone)>
            </cfcase>
            <!---DateTimeNumbersOnly - 201712251730et makes sense for filenames to help with sorting in directories, et is SESSION.VisStr.AbbreviatedTimeZone converted to LCase--->
            <cfcase value="DateTimeNumbersOnly">
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, "yyyymmdd") & TimeFormat(ThisDateTimeStruct.Time, "HHmm") & LCase(SESSION.VisStr.AbbreviatedTimeZone)>
            </cfcase>
            <!---DateTimeDBFormat--->
            <cfcase value="DateTimeDBFormat">
                <cfset ThisDateTime = DateTimeFormat(ThisDateTimeStruct.Time, "yyyy-mm-dd HH:nn:ss")>
            </cfcase>
            <!---Defaults to DateTimeForDisplay--->
            <cfdefaultcase>
                <cfset ThisDateTime = DateFormat(ThisDateTimeStruct.Time, APPLICATION.DefaultDateFormat) & "  " & LCase(TimeFormat(ThisDateTimeStruct.Time, "h:mmtt")) & " " & SESSION.VisStr.AbbreviatedTimeZone>
            </cfdefaultcase>
        </cfswitch>
        <cfreturn ThisDateTime>
    </cffunction>



    <!---DateTimeTimeZoneToUTC--->
    <cffunction name="DateTimeTimeZoneToUTC" access="public" returntype="string" output="false" hint="Formats dates and/or times">
        <cfargument name="DateTime" required="true" type="string">
        <cfargument name="Format" required="true" type="string">
        <cfset var ThisDateTimeStruct = new libraries.momentcfc.moment(ARGUMENTS.DateTime, SESSION.VisStr.TimeZone).tz("UTC")>
        <cfset var ThisDateTime = "">
        <!---DateTimeForDB--->
        <cfswitch expression="#ARGUMENTS.Format#">
            <!---DateTimeForDB - 2017-06-16 07:25:59--->
            <cfcase value="DateTimeForDB">
                <cfset ThisDateTime = DateTimeFormat(ThisDateTimeStruct.UTCTime, "yyyy-mm-dd HH:nn:ss")>
            </cfcase>
            <!---Defaults to DateTimeForDB--->
            <cfdefaultcase>
                <cfset ThisDateTime = DateTimeFormat(ThisDateTimeStruct.UTCTime, "yyyy-mm-dd HH:nn:ss")>
            </cfdefaultcase>
        </cfswitch>
        <cfreturn ThisDateTime>
    </cffunction>

</cfcomponent>