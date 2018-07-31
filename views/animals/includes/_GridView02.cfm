<cfoutput>
    <!---DOWNLOAD GRID FILE BUTTON--->
    <!---If user generated a file then "GridFilenameUUID" variable exists--->
    <cfif IsDefined("GridFilenameUUID")>
        <div class="row justify-content-center mt-2">
            <div class="col-12">
                <!---"mb-0" allows message to completely collapse when user closes it--->
                <div class="alert alert-primary alert-dismissable fade show mb-0" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <small class="pr-3">
                        Spreadsheet
                        <a class="alert-link" href="/index.cfm?controller=#REQUEST.controller#&action=getfile&filename=#GridFilenameUUID#">Ready for Download</a>
                    (#APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=REQUEST.ReqStr.UTCNow, Format='DateTimeForDisplay')#)
                        <a class="alert-link ml-2" href="/index.cfm?controller=#REQUEST.controller#&action=getfile&filename=#GridFilenameUUID#"><i class="fas fa-download"></i></a>
                    </small>
                </div>
            </div>
        </div>
    </cfif>
</cfoutput>