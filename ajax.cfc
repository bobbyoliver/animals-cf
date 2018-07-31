<!---
AjaxValidateField
AjaxBrowserTime
--->

<cfcomponent displayname="Ajax" output="false" hint="Web accessible ajax functions.">

    <!---AjaxValidateField--->
	<!---
	-Must have returnformat attribute set to "json" for ajax calls
	-Only time using numbers in form field names is when adding several of the same field types like phones & addresses and then a number is appended
	    -So strip all appended numbers from form field names to ensure correct validate function is called
	--->
	<cffunction name="AjaxValidateField" access="remote" returntype="struct" output="false" returnformat="json" hint="Called by AjaxValidateFieldBlur and AjaxValidateFieldClick in global after-bootstrap.js to ajax validate form fields.">
	    <cfargument name="Model" required="true">
	    <!---Didn't need to pass "ValidationType" via ajax but can use it to be visible in ajax params in firebug for testing--->
	    <!---<cfargument name="ValidationType" required="true">--->
	    <cfargument name="SerializedFormFields" required="true">
	    <cfargument name="FormField" required="true">
	    <cfargument name="FormValue" required="true">
	    <!---Create struct to be returned--->
	    <cfset var AjaxReturnStruct = {}>
	    <!---Send "FormField" back in struct cause ajax success call needs it, was unable to reference "FormField" name in JS file via "this" scope--->
	    <cfset AjaxReturnStruct["FormField"] = ARGUMENTS.FormField>
	    <!---
	    -"Model" and "FormField" are passed as arguments so we know which model to call validation function in for the field
	    -Add "Message" to "AjaxReturnStruct", returnvariable "AjaxReturnStruct['Message']" is always returned even if blank
	        -If blank the JS success call uses this info to display or not display error message
	    -Using REReplace to strip all appended numbers so ajax makes correct form validation call
	        -Must be sure to never use numbers in form field names except on end to represent multiple of same type of form field
	    --->
	    <cfinvoke component="/models/#ARGUMENTS.Model#" method="Validate#ReReplace(ARGUMENTS.FormField, "[0-9]", "", "All")#" returnvariable="AjaxReturnStruct['Message']">
	        <!---Passed argument via ajax call to be visible in firebug so we can test if validation is ajax called or server side called--->
	        <!---<cfinvokeargument name="ValidationType" value="#ARGUMENTS.ValidationType#">--->
	        <!---No need to call "Trim", will "Trim" in GetFormFieldsAndFieldValueStruct and individual validation functions--->
	        <cfinvokeargument name="SerializedFormFields" value="#ARGUMENTS.SerializedFormFields#">
	        <!---Pass form field for cases like checkboxes where value is always passed whether checked or not so function needs field name to check against--->
	        <cfinvokeargument name="FormField" value="#Trim(ARGUMENTS.FormField)#">
	        <!---Calling "Trim" on argument before passing it prevents having to call "Trim" in individual functions--->
	        <cfinvokeargument name="FormValue" value="#Trim(ARGUMENTS.FormValue)#">
	    </cfinvoke>
	    <!---"AjaxReturnStruct" contains 2 elements: "FormField" and "Message"--->
	    <cfreturn AjaxReturnStruct>
	</cffunction>



	<!---AjaxBrowserTime--->
	<cffunction name="AjaxBrowserTime" access="remote" returntype="void" output="false" returnformat="json" hint="Gets browser time of visitor for time zone setting">
	    <cfargument name="TimeZone" type="string" required="true">
	    <cfargument name="AbbreviatedTimeZone" type="string" required="true">
	    <cfargument name="HoursOffset" type="string" required="true">
	    <cfargument name="UTCOffset" type="string" required="true">
	    <!---America/New_York|Australia/Melbourne|Australia/Sydney--->
        <cfset SESSION.VisStr.TimeZone = ARGUMENTS.TimeZone>
        <!---EDT|EST|AEDT|AEST--->
        <cfset SESSION.VisStr.AbbreviatedTimeZone = ARGUMENTS.AbbreviatedTimeZone>
        <!--- -05:00|-04:00|+11:00|+10:00 --->
        <cfset SESSION.VisStr.HoursOffset = ARGUMENTS.HoursOffset>
        <!--- -300|-240|660|600 --->
        <cfset SESSION.VisStr.UTCOffset = ARGUMENTS.UTCOffset>
	</cffunction>

</cfcomponent>