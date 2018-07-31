<!---ConditionalValidateList--->
<cfset ConditionalValidateList = "">
<!---ConditionalValidateList--->
<cfif FORM.SpecialDietBit EQ 1>
    <cfset ConditionalValidateList = ListAppend(ConditionalValidateList, "SpecialDiet")>
</cfif>
<cfif FORM.FavoriteColor NEQ "">
    <cfset ConditionalValidateList = ListAppend(ConditionalValidateList, "FavoriteColorExplain")>
</cfif>
<cfif FORM.FileUUIDAvatar NEQ "">
    <cfset ConditionalValidateList = ListAppend(ConditionalValidateList, "FileUUIDAvatar")>
</cfif>
<!---ConditionalRequiredList--->
<cfset ConditionalRequiredList = "">
<cfif FORM.SpecialDietBit EQ 1>
    <cfset ConditionalRequiredList = ListAppend(ConditionalRequiredList, "SpecialDiet")>
</cfif>
<cfif FORM.FavoriteColor NEQ "">
    <cfset ConditionalRequiredList = ListAppend(ConditionalRequiredList, "FavoriteColorExplain")>
</cfif>
<!---Fields are trimmed in ServerValidateFields call--->
<cfinvoke component="/models/Animal" method="ServerValidateFields" returnvariable="ErrorArray">
	<cfinvokeargument name="FormFieldsToValidateList" value="Name,KeeperID,AreaID,Species,DOB,Gender,TypeID,Notes,SpecialDietBit,FavoriteColor,ArrivedAt,#ConditionalValidateList#,DOBYear,DOBMonth,DOBDay,ArrivedAtYear,ArrivedAtMonth,ArrivedAtDay,ArrivedAtTime">
	<cfinvokeargument name="FormFieldsRequiredList" value="Name,KeeperID,Species,DOB,Gender,TypeID,SpecialDietBit,ArrivedAt,#ConditionalRequiredList#,DOBYear,DOBMonth,DOBDay,ArrivedAtYear,ArrivedAtMonth,ArrivedAtDay,ArrivedAtTime">
	<!---<cfinvokeargument name="FormFieldsExtraList" value="DOBYear,DOBMonth,DOBDay,ArrivedAtYear,ArrivedAtMonth,ArrivedAtDay,ArrivedAtTime">--->
</cfinvoke>