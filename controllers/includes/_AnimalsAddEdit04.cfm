<!---TRIM--->
<cfinvoke component="/udfs/Helpers" method="TrimFormFields">
<!---ParentModel already checks that file was successfully uploaded if it's required, but checking here since the avatar isn't a requiured field--->
<!---Put new UUID FileUUIDAvatar name in ThisFileUUIDAvatar variable with extension included to use on Model save if a file is selected for upload--->
<!---If this is an edit and not an add then checking for file result and FileWasSaved covers both cases of a replace and if a new file for the first time is being uploaded since it's not required--->
<cfif IsDefined("REQUEST.FileUUIDAvatarResult") AND REQUEST.FileUUIDAvatarResult.FileWasSaved>
    <cfset ThisFileUUIDAvatar  = CreateUUID() & "." & Trim(REQUEST.FileUUIDAvatarResult.ServerFileExt)>
    <cfset ThisFileCleanAvatar  = "Avatar." & Trim(REQUEST.FileUUIDAvatarResult.ServerFileExt)>
    <!---Rename file to UUID--->
    <cffile action="rename" mode="664" source="#ExpandPath('./')#/files/#Trim(REQUEST.FileUUIDAvatarResult.ServerFileName)#.#Trim(REQUEST.FileUUIDAvatarResult.ServerFileExt)#" destination="#ExpandPath('./')#/files/#ThisFileUUIDAvatar#">
</cfif>