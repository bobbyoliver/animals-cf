<!---
-Not var scoping "GridFilenameUUID" or "GridFilenameClean" since they might be used in view
-Not checking for existing files with same name either since all files are stored in DB and can have the same clean name cause they'll be tracked/retreived by UUID
--->
<cfif URL.PageAction EQ "createspreadsheet">
    <cfset GridFilenameUUID = "#CreateUUID()#.xls">
    <cfset GridFilenameClean = "#LCase(ModelTypeDisplayPlural)#--#APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=REQUEST.ReqStr.UTCNow, Format='DateTimeForFilename')#.xls">
</cfif>