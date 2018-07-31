<cfoutput>
    <!---perpage--->
    <div class="btn-group" role="group">
        <button id="sys-dropdown-perpage" class="btn dropdown-toggle pb-0 pt-1 btn-sm btn-dark" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <cfif URL.PerPage EQ 50>50<cfelseif URL.PerPage EQ 100>100<cfelseif URL.PerPage EQ 200>200<cfelseif URL.PerPage EQ 1000>1000<cfelseif URL.PerPage EQ "0">All</cfif>
        </button>
        <div class="dropdown-menu sys-dropdown-menu-dark py-1" aria-labelledby="sys-dropdown-perpage">
            <a class="dropdown-item small pt-1 pb-0 small<cfif URL.PerPage EQ 50> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=50&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#">50</a>
            <a class="dropdown-item small pt-1 pb-0 small<cfif URL.PerPage EQ 100> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=100&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#">100</a>
            <a class="dropdown-item small pt-1 pb-0 small<cfif URL.PerPage EQ 200> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=200&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#">200</a>
            <cfif RecordsQuery.RecordCount GT 1000>
                <a class="dropdown-item small pt-1 pb-0 small<cfif URL.PerPage EQ 1000> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=1000&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#">1000</a>
            <cfelse>
                <a class="dropdown-item small pt-1 pb-0 small<cfif URL.PerPage EQ 1000> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=0&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#">All</a>
            </cfif>
        </div>
    </div>
</cfoutput>