<cfoutput>
    <!---
    PAGINATION - if there are not more records than what is shown per page then do not display pagination links
    -RecordsQuery.RecordCountTotal[1] - total number of records
    -RecordsQuery.RecordCount - number of records for this paginated page view
    --->
    <cfif URL.PerPage NEQ 0 AND (RecordsQuery.RecordCountTotal[1] GT URL.PerPage)>
        <div class="col-12 pt-2">
            <nav aria-label="Grid Navigation">
                <!---"justify-content-center" centers the pagination links--->
                <ul class="pagination pagination-sm justify-content-center mb-2">
                    <!---FIRST PAGE--->
                    <cfif URL.Start GT 1>
                        <li class="page-item">
                            <a class="page-link" aria-label="First" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=1&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#">
                                <span aria-hidden="true">&laquo;&laquo;</span>
                                <span class="sr-only">First</span>
                            </a>
                        </li>
                    <cfelse>
                        <li class="page-item disabled">
                            <span class="page-link" aria-label="First">
                                <span aria-hidden="true">&laquo;&laquo;</span>
                                <span class="sr-only">First</span>
                            </span>
                        </li>
                    </cfif>
                    <!---PREVIOUS PAGE--->
                    <cfif URL.Start GT 1>
                        <li class="page-item">
                            <a class="page-link" aria-label="Previous" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#Evaluate(URL.Start - URL.PerPage)#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                    <cfelse>
                        <li class="page-item disabled">
                            <span class="page-link" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </span>
                        </li>
                    </cfif>
                    <!---PAGE NUMBERS--->
                    <cfset PageStart = 1>
                    <cfset TotalPages = Ceiling(RecordsQuery.RecordCountTotal[1] / URL.PerPage)>
                    <cfloop from="1" to="#TotalPages#" index="i">
                        <cfif URL.Start EQ PageStart>
                            <!---Added inline style to turn background black instead of the default BS primary color--->
                            <li class="page-item active"><span class="page-link" style="background-color:##373A3C; border-top-color:##373A3C; border-right-color:##373A3C; border-bottom-color:##373A3C; border-left-color:##373A3C;">#i# <span class="sr-only">(current)</span></span></li>
                        <!---
                        -Only show 3 page links before and 3 after the current page
                        -Logic below prevents page links that are far out of that range from showing
                        -Needed for case where dealing with huge record sets and don't want to display dozens of page links
                        -"PageStart LT URL.Start" needed to only check before the current page
                        -"PageStart GT URL.Start" needed to only check after the current page
                        --->
                        <cfelseif ((PageStart LT URL.Start) AND (URL.Start - 3 * URL.PerPage LTE PageStart)) OR ((PageStart GT URL.Start) AND (URL.Start + 3 * URL.PerPage GTE PageStart))>
                            <li class="page-item">
                                <a class="page-link" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#PageStart#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#">#i#</a>
                            </li>
                        </cfif>
                        <cfset PageStart = PageStart + URL.PerPage>
                    </cfloop>
                    <!---NEXT PAGE--->
                    <cfif (URL.Start + URL.PerPage - 1) LT RecordsQuery.RecordCountTotal[1]>
                        <li class="page-item">
                            <a class="page-link" aria-label="Next" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#Evaluate(URL.Start + URL.PerPage)#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    <cfelse>
                        <li class="page-item disabled">
                            <span class="page-link" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </span>
                        </li>
                    </cfif>
                    <!---LAST PAGE--->
                    <cfif (URL.Start + URL.PerPage - 1) LT RecordsQuery.RecordCountTotal[1]>
                        <li class="page-item">
                            <a class="page-link" aria-label="Last" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#Evaluate(PageStart - URL.PerPage)#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#">
                                <span aria-hidden="true">&raquo;&raquo;</span>
                                <span class="sr-only">Last</span>
                            </a>
                        </li>
                    <cfelse>
                        <li class="page-item disabled">
                            <span class="page-link" aria-label="Last">
                                <span aria-hidden="true">&raquo;&raquo;</span>
                                <span class="sr-only">Last</span>
                            </span>
                        </li>
                    </cfif>
                </ul>
            </nav>
            <!---mb-2 needed to provide spacing between bottom of page legend--->
            <p class="small text-muted text-center mb-2">#TotalPages# Total Pages</p>
        </div>
    </cfif>
</cfoutput>