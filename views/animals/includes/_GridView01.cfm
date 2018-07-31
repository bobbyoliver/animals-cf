<cfoutput>
	<small class="float-right">
        <!---When results are cleared "start" is set to 1, direction and order are kept, and "URL.Search" is set to empty--->
        <i class="fas fa-times mr-2"></i><a class="alert-link" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=1&order=#URL.Order#&direction=#URL.Direction#&search=&#DefaultCustomParams#">Clear Search</a>
    </small>
</cfoutput>