<!---Delete file(s) that might have been uploaded--->
<!---FILE - FileUUIDAvatar--->
<cfif IsDefined("REQUEST.FileUUIDAvatarResult") AND REQUEST.FileUUIDAvatarResult.FileWasSaved>
    <cftry>
        <cffile action="delete" file="#ExpandPath('./')#/files/#Trim(REQUEST.FileUUIDAvatarResult.ServerFileName)#.#Trim(REQUEST.FileUUIDAvatarResult.ServerFileExt)#">
        <cfcatch></cfcatch>
    </cftry>
    <!---This file isn't a required upload so only set reminder if user attempted a file upload, if file upload WAS required then this block would be outside this if statement checking if FileWasSaved--->
    <!---Set reminder if there weren't other file upload errors like extension or file size etc. so loop errors and check if there's an error for this file field, if not, set reselect reminder as an error--->
    <cfset var ReselectFile = true>
    <cfloop array="#ErrorArray#" index="j">
        <!---Means there is already an error so no need to set the reselect to true--->
        <cfif j.Property EQ "FileUUIDAvatar">
            <cfset ReselectFile = false>
            <cfbreak>
        </cfif>
    </cfloop>
    <!---If ReselectFile is true insert message into array since there is no error message in array for this file field--->
    <cfif ReselectFile EQ true>
        <cfset ErrorStruct.Property = "FileUUIDAvatar">
        <cfset ErrorStruct.Message = "Please reselect Avatar to upload.">
        <cfset ArrayAppend(ErrorArray, Duplicate(ErrorStruct))>
    </cfif>
</cfif>
<!---CONDITIONAL FORM FIELD RESETS--->
<cfif FORM.SpecialDietBit NEQ 1>
    <cfset FORM.SpecialDiet = "">
</cfif>
<cfif FORM.FavoriteColor EQ "">
    <cfset FORM.FavoriteColorExplain = "">
</cfif>
<cfset StructDelete(SESSION, "AlertForm")>
<cfset SESSION.AlertForm = "col-12~danger~DefaultErrorMessage">