<cfcomponent extends="/models/Parent" persistent="true" table="Animals" entityname="Animal" hint="Animal model">

    <!---PK identity--->
    <cfproperty name="ID" fieldtype="id" ormtype="integer" generator="identity">
    <cfproperty name="TypeID" fieldtype="column" ormtype="integer" notnull="true">
    <cfproperty name="KeeperID" fieldtype="column" ormtype="integer" notnull="true">
    <cfproperty name="AreaID" fieldtype="column" ormtype="integer">
    <cfproperty name="Name" fieldtype="column" ormtype="string" length="50" notnull="true">
    <cfproperty name="Species" fieldtype="column" ormtype="string" length="50" default="">
    <cfproperty name="Gender" fieldtype="column" ormtype="string" length="1" default="">
    <cfproperty name="DOB" fieldtype="column" ormtype="timestamp">
    <cfproperty name="Notes" fieldtype="column" ormtype="string" length="1000" default="">
    <cfproperty name="FileUUIDAvatar" fieldtype="column" ormtype="string" length="50" default="">
    <!---Using Name field as animal's clean filename so make it a little longer than 55 to handle extension--->
    <cfproperty name="FileCleanAvatar" fieldtype="column" ormtype="string" length="55" default="">
    <cfproperty name="SpecialDietBit" fieldtype="column" ormtype="boolean" default="false" dbdefault="false">
    <cfproperty name="SpecialDiet" fieldtype="column" ormtype="string" length="200" default="">
    <cfproperty name="FavoriteColor" fieldtype="column" ormtype="string" length="50" default="">
    <cfproperty name="FavoriteColorExplain" fieldtype="column" ormtype="string" length="200" default="">
    <cfproperty name="ArrivedAt" fieldtype="column" ormtype="timestamp">
    <cfproperty name="CreatedAt" fieldtype="column" ormtype="timestamp" notnull="true">
    <cfproperty name="UpdatedAt" fieldtype="column" ormtype="timestamp" notnull="true">
    <cfproperty name="DeletedAt" fieldtype="column" ormtype="timestamp">



    <!---FK relationships--->
    <cfproperty name="Type" fieldtype="many-to-one" cfc="Type" fkcolumn="TypeID" lazy="false" insert="false" update="false" missingrowignored="false">
    <cfproperty name="Keeper" fieldtype="many-to-one" cfc="Keeper" fkcolumn="KeeperID" lazy="false" insert="false" update="false" missingrowignored="false">
    <cfproperty name="Area" fieldtype="many-to-one" cfc="Area" fkcolumn="AreaID" lazy="false" insert="false" update="false" missingrowignored="false">



    <!---
    ValidateBase Notes:

    Arguments:
    <cfargument name="FormValue" required="true">
    <cfargument name="Required" required="false" default="false">
    <cfargument name="MaxLength" required="false" default="">
    <cfargument name="IsValidType" required="false" default=""> Integer|Email|Date
    <cfargument name="OptionsList" required="false" default="">
    
    Sample Calls:
    <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=true, MaxLength=50)>
    <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=true, IsValidType="Integer")>
    <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=true, OptionsList="m,f")>
    <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, MaxLength=5, OptionsList="Mr.,Miss,Mrs.,Ms.")>
    <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=true, IsValidType="Email", MaxLength=100)>
    --->
    <!---VALIDATION--->
    <!---Name--->
    <cffunction name="ValidateName" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, MaxLength=50)>
        <cfreturn Message>
    </cffunction>
    <!---KeeperID--->
    <cffunction name="ValidateKeeperID" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---AreaID--->
    <cffunction name="ValidateAreaID" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="false">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---Species--->
    <cffunction name="ValidateSpecies" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, MaxLength=50)>
        <cfreturn Message>
    </cffunction>
    <!---DOB--->
    <cffunction name="ValidateDOB" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset ThisDOBYear = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="DOBYear")>
        <cfset ThisDOBMonth = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="DOBMonth")>
        <cfset ThisDOBDay = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="DOBDay")>
        <!---If one of the three year, month, or day is entered then user is trying to enter DOB so make sure all three are entered then--->
        <cfif ThisDOBYear EQ "" OR ThisDOBMonth EQ "" OR ThisDOBDay EQ "">
            <!---<cfset var Message = "Day, Month, & Year must all be selected.">--->
        </cfif>
        <cfreturn Message>
    </cffunction>
    <!---Keeping DOBYear, DOBMonth, & DOBDay validation functions cause form A uses these still--->
    <!---DOBYear--->
    <cffunction name="ValidateDOBYear" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---DOBMonth--->
    <cffunction name="ValidateDOBMonth" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---DOBDay--->
    <cffunction name="ValidateDOBDay" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---Gender--->
    <cffunction name="ValidateGender" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, OptionsList="m,f")>
        <cfreturn Message>
    </cffunction>
    <!---TypeID--->
    <cffunction name="ValidateTypeID" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <!---Getting TypeArray again as ThisTypeArray cause it'll be needed or ajax validation---><cfset var ThisTypeArray = EntityLoad("Type", {DeletedAt=""}, "SortOrder ASC")>
        <cfset var ThisTypeArray = EntityLoad("Type", {DeletedAt=""}, "SortOrder ASC")>
        <cfset var ThisOptionsList = "">
        <cfloop array="#ThisTypeArray#" index="i">
            <cfset ThisOptionsList = ListAppend(ThisOptionsList, i.getID())>
        </cfloop>
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, OptionsList=ThisOptionsList)>
        <cfreturn Message>
    </cffunction>
    <!---Notes--->
    <cffunction name="ValidateNotes" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="false">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, MaxLength=1000)>
        <cfreturn Message>
    </cffunction>
    <!---SpecialDietBit--->
    <cffunction name="ValidateSpecialDietBit" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, OptionsList="1,0")>
        <cfreturn Message>
    </cffunction>
    <!---SpecialDiet--->
    <cffunction name="ValidateSpecialDiet" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <!---Get "SpecialDietBit"--->
        <!---Even though it's already passed from controller whether to validate this field or not based on SpecialDietBit for server validation, still must do this check for ajax validation--->
        <cfset ThisSpecialDietBit = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="SpecialDietBit")>
        <!---Validate if "ThisSpecialDietBit" is 1--->
        <cfif ThisSpecialDietBit EQ 1>
            <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, MaxLength=50)>
        </cfif>
        <cfreturn Message>
    </cffunction>
    <!---FavoriteColor--->
    <cffunction name="ValidateFavoriteColor" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="false">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, OptionsList="Blue,Green,Orange,Pink,Red,Yellow")>
        <cfreturn Message>
    </cffunction>
    <!---FavoriteColorExplain--->
    <cffunction name="ValidateFavoriteColorExplain" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <!---Get "FavoriteColor"--->
        <!---Even though it's already passed from controller whether to validate this field or not based on FavoriteColor for server validation, still must do this check for ajax validation--->
        <cfset ThisFavoriteColor = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="FavoriteColor")>
        <!---Validate if "ThisFavoriteColor" NEQ ""--->
        <cfif ThisFavoriteColor NEQ "">
            <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, MaxLength=200)>
        </cfif>
        <cfreturn Message>
    </cffunction>
    <!---FileUUIDAvatar--->
    <cffunction name="ValidateFileUUIDAvatar" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="false">
        <cfset var Message = "">
        <!---Call parent model ValidateFileUpload function--->
        <cfset var Message = ValidateFileUpload(
            FileFormField=ARGUMENTS.FormField,
            FileFormValue=ARGUMENTS.FormValue,
            FileUploadPath="#ExpandPath('./')#/files",
            <!---Correct MIME Types are checked in ValidateFileUpload function based on this ExtensionList argument--->
            ExtensionList="gif,jpeg,jpg,png",
            FileIsRequired=ARGUMENTS.IsRequired)>
        <cfreturn Message>
    </cffunction>
    <!---ArrivedAt--->
    <cffunction name="ValidateArrivedAt" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset ThisArrivedAtYear = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="ArrivedAtYear")>
        <cfset ThisArrivedAtMonth = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="ArrivedAtMonth")>
        <cfset ThisArrivedAtDay = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="ArrivedAtDay")>
        <cfset ThisArrivedAtTime = GetSpecificField(SerializedFormFields=ARGUMENTS.SerializedFormFields, RequestedField="ArrivedAtTime")>
        <!---If one of the three year, month, or day is entered then user is trying to enter DOB so make sure all three are entered then--->
        <cfif ThisArrivedAtYear EQ "" OR ThisArrivedAtMonth EQ "" OR ThisArrivedAtDay EQ "" OR ThisArrivedAtTime EQ "">
            <!---<cfset var Message = "Day, Month, Year, & Time must all be selected.">--->
        </cfif>
        <cfreturn Message>
    </cffunction>
    <!---Keeping ArrivedAtYear, ArrivedAtMonth, ArrivedAtDay, & ArrivedAtTime validation functions cause form A uses these still--->
    <!---ArrivedAtYear--->
    <cffunction name="ValidateArrivedAtYear" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---ArrivedAtMonth--->
    <cffunction name="ValidateArrivedAtMonth" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---ArrivedAtDay--->
    <cffunction name="ValidateArrivedAtDay" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, IsValidType="Integer")>
        <cfreturn Message>
    </cffunction>
    <!---ArrivedAtTime--->
    <cffunction name="ValidateArrivedAtTime" access="public" returntype="string" output="false" hint="Validation function for server side and ajax call">
        <cfargument name="FormField" required="true">
        <cfargument name="FormValue" required="true">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="IsRequired" required="true" default="true">
        <cfset var Message = "">
        <cfset var Message = ValidateBase(FormValue=ARGUMENTS.FormValue, Required=ARGUMENTS.IsRequired, OptionsList="00:00,00:30,01:00,01:30,02:00,02:30,03:00,03:30,04:00,04:30,05:00,05:30,06:00,06:30,07:00,07:30,08:00,08:30,09:00,09:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00,21:30,22:00,22:30,23:00,23:30")>
        <cfreturn Message>
    </cffunction>

</cfcomponent>