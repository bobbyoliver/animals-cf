<cfoutput>
    <a class="mr-1" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#ColumnField#&direction=#IIF(URL.Order NEQ ColumnField OR (URL.Order EQ ColumnField AND URL.Direction EQ 'desc'), DE('asc'), DE('desc'))#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#">#ColumnFieldDisplay#</a>
    <!---<br />--->
    <cfif URL.Order EQ ColumnField AND URL.Direction EQ "asc">
        <i class="fas fa-sort-up"></i>
    <cfelseif URL.Order EQ ColumnField AND URL.Direction EQ "desc">
        <i class="fas fa-sort-down"></i>
    <cfelse>
        <i class="fas fa-sort"></i>
    </cfif>
</cfoutput>