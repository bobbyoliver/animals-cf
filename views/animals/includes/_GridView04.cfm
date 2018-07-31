<cfoutput>
    <!---Previous and Next buttons for pagination--->
    <cfif URL.PerPage NEQ 0 AND (RecordsQuery.RecordCountTotal[1] GT URL.PerPage)>
        <!---NEXT PAGE--->
        <cfif (URL.Start + URL.PerPage - 1) LT RecordsQuery.RecordCountTotal[1]>
            <a class="btn pb-0 pt-1 btn-sm float-lg-right btn-outline-dark" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#Evaluate(URL.Start + URL.PerPage)#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#">Next&nbsp;&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
        <cfelse>
            <button class="btn pb-0 pt-1 btn-sm float-lg-right btn-outline-dark" type="button" disabled>Next&nbsp;&nbsp;<i class="fas fa-arrow-circle-right"></i></button>
        </cfif>
        <!---PREVIOUS PAGE--->
        <cfif URL.Start LTE 1>
            <button class="btn pb-0 pt-1 mr-2 btn-sm float-lg-right btn-outline-dark" type="button" disabled><i class="fas fa-arrow-circle-left"></i>&nbsp;&nbsp;Previous</button>
        <cfelse>
            <a class="btn pb-0 pt-1 mr-2 btn-sm float-lg-right btn-outline-dark" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#Evaluate(URL.Start - URL.PerPage)#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#"><i class="fas fa-arrow-circle-left"></i>&nbsp;&nbsp;Previous</a>
        </cfif>
    </cfif>
</cfoutput>