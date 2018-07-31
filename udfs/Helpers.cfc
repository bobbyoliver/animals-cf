<!---
TrimFormFields
RandDateRange
CheckValidURLParameter
DisplayMessage
ListToStruct
CreateUniqueFileName
--->

<cfcomponent displayname="Helpers" output="false" hint="Controller of generic helper functions.">

    <!---TrimFormFields--->
    <cffunction name="TrimFormFields" access="public" returntype="void" output="false" hint="Loops and Trims all FORM scope form fields.">
        <cfloop collection="#FORM#" item="FormField">
            <cfset FORM[FormField] = Trim(FORM[FormField])>
        </cfloop>
    </cffunction>



    <!---RandDateRange--->
    <!---From Ben Nadel post - https://www.bennadel.com/blog/682-getting-a-random-date-between-two-given-dates-in-coldfusion.htm--->
    <cffunction name="RandDateRange" access="public" returntype="date" output="false" hint="Returns a random date between the two passed in dates, if either of the two dates has a time value, the resultant time will also be randomized">
        <cfargument name="DateFrom" type="date" required="true" hint="The min date of the date range.">
        <cfargument name="DateTo" type="date" required="true" hint="The max date of the date range.">
        <cfargument name="IncludeRandomTime" type="boolean" required="false" default="false" hint="Will include the time in the date randomization even if neither passed-in dates have a time.">
        <cfset var LOCAL = StructNew()>
        <!---Check to see if we are going to randomize time. If either of the passed in dates has a non-12 AM time, then we are going to include a random time. We will know if a date is include if the either date does not equal its Fixed value.--->
        <cfif ((ARGUMENTS.DateFrom NEQ Fix(ARGUMENTS.DateFrom)) OR (ARGUMENTS.DateTo NEQ Fix(ARGUMENTS.DateTo)) OR ARGUMENTS.IncludeRandomTime)>
            <!---Get the difference in seconds between the two given dates. Once we have this value, we can pick a random mid point in this span of seconds.--->
            <cfset LOCAL.DiffSeconds = DateDiff("s", ARGUMENTS.DateFrom, ARGUMENTS.DateTo)>
            <!---Now that we know the second difference between the two dates, we can easily use RandRange() to get a random second span that we will add to the start date to give us a random mid date.--->
            <cfset LOCAL.Date = (ARGUMENTS.DateFrom + CreateTimeSpan(0, 0, 0, RandRange(0, LOCAL.DiffSeconds)))>
            <!---Now that we have the randome date/time value, we need to format it using both the date and the time. We cannot just send back the DateFormat() (as in the other case) since that would strip out the time.--->
            <cfreturn DateFormat(LOCAL.Date, "yyyy-mm-dd") & " " & TimeFormat(LOCAL.Date)>
        <cfelse>
            <!---We are not going to include a random time. Therefore, we can just get a random integer to represent the date (no time). Since date/time values can be represented as float values, we can just use RandRange() to get a random integer which we will then convert back to a date/time value. DateFormat() will convert it back to a date value with zero time.--->
            <cfreturn DateFormat(RandRange(ARGUMENTS.DateFrom, ARGUMENTS.DateTo))>
        </cfif>
    </cffunction>



    <!---CheckValidURLParameter--->
    <cffunction name="CheckValidURLParameter" access="public" returntype="void" hint="Checks if URL parameter exists and passes integer or string validation, redirects if not.">
        <!---Set to "Integer" or "String"--->
        <cfargument name="ParamType" type="string" required="true">
        <cfargument name="ParamName" type="string" required="true">
        <!---Set to true by default but if any of the conditions below are false then redirect to message page will occur--->
        <cfset var SuccessBit = true>
        <!---Check if URL varialbe exists, do not use Evaluate because variable name needs to be in quotes so URL.#ARGUMENTS.ParamName# becomes "URL.id" etc.--->
        <cfif NOT IsDefined("URL.#ARGUMENTS.ParamName#")>
            <cfset SuccessBit = false>
        <!---URL variable exists so do the rest of our checks--->
        <cfelse>
            <!---Checks both strings & integers to make sure they are not empty since a URL variable could pass IsDefined check above if it's an empty string--->
            <cfif Trim(Evaluate("URL." & ARGUMENTS.ParamName)) EQ "">
                <cfset SuccessBit = false>
            </cfif>
            <!---Special Integer checks--->
            <cfif ARGUMENTS.ParamType EQ "Integer">
                <cfif NOT IsValid("Integer", Trim(Evaluate("URL." & ARGUMENTS.ParamName))) OR Trim(Evaluate("URL." & ARGUMENTS.ParamName)) LT 1>
                    <cfset SuccessBit = false>
                </cfif>
            <!---Special String checks--->
            <cfelseif ARGUMENTS.ParamType EQ "String">
                <cfif NOT IsSimpleValue(Trim(Evaluate("URL." & ARGUMENTS.ParamName)))>
                    <cfset SuccessBit = false>
                </cfif>
            </cfif>
        </cfif>
        <!---If "SuccessBit" is "false" then redirect, otherwise do nothing--->
        <cfif SuccessBit EQ false>
            <!---ALERT PAGE TOP CALL--->
            <cfinvoke component="/udfs/Helpers" method="DisplayMessage">
                <cfinvokeargument name="MessageType" value="InvalidURL">
            </cfinvoke>
        </cfif>
    </cffunction>



    <!---DisplayMessage--->
    <cffunction name="DisplayMessage" access="public" returntype="void" output="false" hint="Redirects user to message homepage to display message.">
        <!---Pass "MessageType" argument to determine message display: InvalidURL, DBError, etc.--->
        <cfargument name="MessageType" type="string" required="true">
        <!---Delete "SESSION.AlertPageTop" as a precaution since going to set it again here--->
        <cfset StructDelete(SESSION, "AlertPageTop")>
        <!---ALERT PAGE TOP SET--->
        <cfif ARGUMENTS.MessageType EQ "InvalidURL">
            <cfset SESSION.AlertPageTop = "col-12~danger~You have requested an invalid URL.">
        <cfelseif ARGUMENTS.MessageType EQ "Error">
            <cfset SESSION.AlertPageTop = "col-12~danger~You have experienced an error.">
        <cfelseif ARGUMENTS.MessageType EQ "DBError">
            <cfset SESSION.AlertPageTop = "col-12~danger~You have experienced a database error.">
        </cfif>
        <!---"DisplayMessage" always sends user to "message" action of Main controller--->
        <cflocation url="/index.cfm?controller=main&action=message" addtoken="false">
    </cffunction>



    <!---ListToStruct--->
    <!---
    -Function is from cflib
    -Pass a List such as a URL variable string "requestid=1&empid=2&showform=true", string will be converted to a structure and returned
    -IMPORTANT - made a noted change below to add "true" to "ListLast"
        -Added "true" to ensure empty values are included in returned structure, otherwise a value was placed where an empty string should be for blank URL variables
    --->
    <cfscript>
        /* Converts a delimited List of key/value pairs to a structure.
         * v2 mod by James Moberg
         * @param List      List of key/value pairs to initialize the structure with.  Format follows key=value. (Required)
         * @param Delimiter      Delimiter seperating the key/value pairs.  Default is the comma. (Optional)
         * @return Returns a structure. 
         * @author Rob Brooks-Bilson (rbils@amkor.com)
         * @version 2, April 1, 2010 
         */
        function ListToStruct(List){
           var MyStruct = StructNew();
           var i = 0;
           var Delimiter = ",";
           var TempList = ArrayNew(1);
           if (ArrayLen(ARGUMENTS) GT 1) {Delimiter = ARGUMENTS[2];}
           TempList = ListToArray(List, Delimiter);
           for (i=1; i LTE ArrayLen(TempList); i=i+1){
               if (NOT StructKeyExists(MyStruct, Trim(ListFirst(TempList[i], "=")))) {
                   /*
                   IMPORTANT - Added "true" to ensure empty values are included in returned structure, otherwise a value was placed where an empty string should be for blank URL variables
                   */
                   StructInsert(MyStruct, Trim(ListFirst(TempList[i], "=")), Trim(ListLast(TempList[i], "=", true)));
               }
           }
           return MyStruct;
        }
    </cfscript>



    <!---CreateUniqueFileName--->
    <!---Pass a full file path to this function; if the file exists, the function will return a new, unique file name---> 
    <cfscript>
        /**
        * Creates a unique file name; used to prevent overwriting when moving or copying files from one location to another.
        * v2, bug found with dots in path, bug found by joseph
        * v3 - missing dot in extension, bug found by cheesecow
        *
        * @param fullpath      Full path to file. (Required)
        * @return Returns a string.
        * @author Marc Esher (marc.esher@cablespeed.com)
        * @version 3, July 1, 2008
        */
        function CreateUniqueFileName(fullPath){
        var extension = "";
        var thePath = "";
        var newPath = arguments.fullPath;
        var counter = 0;
        if(listLen(arguments.fullPath,".") gte 2) extension = listLast(arguments.fullPath,".");
        thePath = listDeleteAt(arguments.fullPath,listLen(arguments.fullPath,"."),".");
        while(fileExists(newPath)){
        counter = counter+1;
        newPath = thePath & "-" & counter & "." & extension;
        }
        return newPath;
        }
    </cfscript>

</cfcomponent>