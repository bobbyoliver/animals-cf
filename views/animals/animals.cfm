<!---BODY ========================================================--->
<cfoutput>
    <div class="container-fluid" style="max-width:1600px;">
        <!---
        <div class="row">
            <div class="col-12 small">
                <span class="float-right">
                    <strong>Break:</strong>
                    <span class="d-none d-xl-inline">xl</span>
                    <span class="d-none d-lg-inline d-xl-none">lg</span>
                    <span class="d-none d-md-inline d-lg-none">md</span>
                    <span class="d-none d-sm-inline d-md-none">sm</span>
                    <span class="d-sm-none">xs</span>
                </span>
            </div>
        </div>
        --->
        <!---Alert page top display--->
        <cfif StructKeyExists(SESSION, "AlertPageTop")><cfinclude template="/views/includes/_AlertPageTop.cfm"></cfif>
        <!---SEARCH RESULTS ALERT DISPLAY--->
        <cfif URL.Search NEQ "">
            <div class="row justify-content-center mt-2">
                <div class="col-12">
                    <div class="alert alert-primary mb-0" role="alert">
                        <small class="pr-3">
                            Search results for <strong>"#FORM.SearchString#"</strong> in: <strong>#KeeperIDFormatted#, #AreaIDFormatted#, #TypeIDFormatted#, #DOBFormatted#</strong><cfif IsDefined("RecordsQuery") AND RecordsQuery.RecordCount EQ 0> returned no records</cfif>
                        </small>
                        <!---1 _GridView01.cfm clear search link--->
                        <cfinclude template="/views/animals/includes/_GridView01.cfm">
                    </div>
                </div>
            </div>
        </cfif>
        <!---2 _GridView02.cfm download grid file button, includes it's own "row"--->
        <cfinclude template="/views/animals/includes/_GridView02.cfm">
        <div class="row mt-1">
            <!---Always show filters and record count details cause even if there's no results still want to show dropdowns--->
            <div class="col-12 col-lg-9 mb-2 mt-1">
                <!---3 _GridView03.cfm perpage filter dropdown--->
                <cfinclude template="/views/animals/includes/_GridView03.cfm">
                <!---KeeperID--->
                <div class="btn-group" role="group">
                    <button id="sys-dropdown-keeper" class="btn dropdown-toggle pb-0 pt-1 btn-sm btn-dark" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        #KeeperIDFormatted#
                    </button>
                    <div class="dropdown-menu sys-dropdown-menu-dark" aria-labelledby="sys-dropdown-keeper">
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.KeeperID EQ '0'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=0&dob=#URL.DOB#">All Keepers</a>
                        <cfloop array="#REQUEST.KeeperArray#" index="i">
                            <a class="dropdown-item small pt-1 pb-0 small<cfif URL.KeeperID EQ i.getID()> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#i.getID()#&dob=#URL.DOB#">#i.getFirstName()# #i.getLastName()#</a>
                        </cfloop>
                    </div>
                </div>
                <!---AreaID--->
                <div class="btn-group" role="group">
                    <button id="sys-dropdown-area" class="btn dropdown-toggle pb-0 pt-1 btn-sm btn-dark" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        #AreaIDFormatted#
                    </button>
                    <div class="dropdown-menu sys-dropdown-menu-dark" aria-labelledby="sys-dropdown-area">
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.AreaID EQ '0'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=0&keeperid=#URL.KeeperID#&dob=#URL.DOB#">All Areas</a>
                        <cfloop array="#REQUEST.AreaArray#" index="i">
                            <a class="dropdown-item small pt-1 pb-0 small<cfif URL.AreaID EQ i.getID()> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#i.getID()#&keeperid=#URL.KeeperID#&dob=#URL.DOB#">#i.getArea()#</a>
                        </cfloop>
                    </div>
                </div>
                <!---Break xs and sm--->
                <div class="clearfix d-md-none mt-2"></div>
                <!---TypeID--->
                <div class="btn-group" role="group">
                    <button id="sys-dropdown-type" class="btn dropdown-toggle pb-0 pt-1 btn-sm btn-dark" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        #TypeIDFormatted#
                    </button>
                    <div class="dropdown-menu sys-dropdown-menu-dark" aria-labelledby="sys-dropdown-area">
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.TypeID EQ '0'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=0&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=#URL.DOB#">All Types</a>
                        <cfloop array="#REQUEST.TypeArray#" index="i">
                            <a class="dropdown-item small pt-1 pb-0 small<cfif URL.TypeID EQ i.getID()> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#i.getID()#&areaid=#URL.TypeID#&keeperid=#URL.KeeperID#&dob=#URL.DOB#">#i.getType()#</a>
                        </cfloop>
                    </div>
                </div>
                <!---DOB--->
                <div class="btn-group" role="group">
                    <button id="sys-dropdown-dob" class="btn dropdown-toggle pb-0 pt-1 btn-sm btn-dark" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        #DOBFormatted#
                    </button>
                    <div class="dropdown-menu sys-dropdown-menu-dark" aria-labelledby="sys-dropdown-dob">
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.DOB EQ '0'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=0&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=0">DOB Anytime</a>
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.DOB EQ '3'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=0&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=3">DOB Within Last 3 Years</a>
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.DOB EQ '7'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=0&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=7">DOB Within Last 7 Years</a>
                        <a class="dropdown-item small pt-1 pb-0 small<cfif URL.DOB EQ '8'> active</cfif>" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=0&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=8">DOB Within Last 8 Years</a>
                    </div>
                </div>
                <!---Download spreadsheet--->
                <cfif RecordsQuery.RecordCount GT 0>
                    <a class="btn pb-0 pt-1 btn-sm btn-outline-dark" data-toggle="tooltip" data-placement="top" title="Download Spreadsheet" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#&pageaction=createspreadsheet">Download <i class="fas fa-file-excel"></i></a>
                <cfelse>
                    <button class="btn pb-0 pt-1 btn-sm btn-lg btn-outline-dark" type="button" disabled>Download <i class="fas fa-file-excel"></i></button>
                </cfif>
                <!---Break xs and sm--->
                <div class="clearfix d-md-none mt-2"></div>
                <!---Break md and lg--->
                <div class="clearfix d-none d-md-block d-xl-none mt-2"></div>
                <!---On any new search submission "URL.Start" should always be set to 1--->
                <div style="display:inline-flex;">
                    <form class="" id="sys-form-search" name="sys-form-search" role="search" action="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=1&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#" method="post">
                        <!---Must have div for input group to work--->
                        <div class="input-group input-group-sm">
                            <!---Disable search input and button if there are no records returned--->
                            <!---"ModelTypeDisplayPlural" is set in controller--->
                            <input id="id_SearchString" class="form-control pb-0" style="padding-top:3px; width:250px;" type="text" name="SearchString" value="#FORM.SearchString#" maxlength="200" placeholder="Search #ModelTypeDisplayPlural#..." aria-label="Search #ModelTypeDisplayPlural#..."<cfif RecordsQuery.RecordCount LT 1 AND URL.Search EQ ""> disabled</cfif>>
                            <div class="input-group-append">
                                <button class="btn btn-dark sys-spinner pb-0" style="padding-top:3px;" type="submit" name="ButtonSubmitSearch"<cfif RecordsQuery.RecordCount LT 1 AND URL.Search EQ ""> disabled</cfif>>Go</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-12 col-lg-3 mb-2">
                <!---4 _GridView04.cfm previous and next links--->
                <cfinclude template="/views/animals/includes/_GridView04.cfm">
            </div>
            <div class="col-12">
                <!---SHOWING RECORDS--->
                <span class="small text-muted">    
                    <cfif RecordsQuery.RecordCount NEQ 0>
                        <!---only add "s" when more than one record--->
                        Showing #URL.Start#-#Evaluate(URL.Start + RecordsQuery.RecordCount - 1)# of #RecordsQuery.RecordCountTotal[1]# Record<cfif RecordsQuery.RecordCountTotal[1] GT 1>s</cfif>
                    <cfelseif RecordsQuery.RecordCount EQ 0>
                        No Records
                    </cfif>
                </span>
            </div>
            <!---Checking "RecordsQuery.RecordCount" since controller resets "URL.Start" to 1 if no records found when "URL.Start" isn't 1--->
            <cfif IsDefined("RecordsQuery") AND RecordsQuery.RecordCount GT 0>
                <div class="col-12">
                    <form id="sys-form-options" name="sys-form-options" role="form" method="post" action="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=#URL.DOB#&pageaction=options">
                        <!---BS4 responsive tables clip any y overflow so only doing responsive on md and smaller--->
                        <div class="table-responsive-md">
                            <!---"table-sm" classs cuts cell padding in half, but doesn't make text smaller so use "small" too, "sys-table-grid" is used to apply styles via "after-bootstrap.css"--->
                            <table class="table table-striped table-hover table-sm small sys-table-grid">
                                <thead class="thead-default">
                                    <tr>
                                        <th>
                                            <cfset ColumnField = "name">
                                            <cfset ColumnFieldDisplay = "Name">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <th>
                                            <cfset ColumnField = "updatedat">
                                            <cfset ColumnFieldDisplay = "Updated">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <th>
                                            <cfset ColumnField = "species">
                                            <cfset ColumnFieldDisplay = "Species">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <th>
                                            <cfset ColumnField = "keeper">
                                            <cfset ColumnFieldDisplay = "Keeper">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <th>
                                            <cfset ColumnField = "type">
                                            <cfset ColumnFieldDisplay = "Type">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <th>
                                            <cfset ColumnField = "area">
                                            <cfset ColumnFieldDisplay = "Area">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <th>
                                            <cfset ColumnField = "dob">
                                            <cfset ColumnFieldDisplay = "DOB">
                                            <!---5 _GridView05.cfm header column links--->
                                            <cfinclude template="/views/animals/includes/_GridView05.cfm">
                                        </th>
                                        <!---0X _GridView0X.cfm header columns for options--->
                                        <!---<cfinclude template="/views/animals/includes/_GridView0X.cfm">--->
                                        <!---USED TO BE INCLUDE - BEGIN--->
                                        <th class="text-center">
                                            <!---Dropdown options button, Archive, Delete, etc.--->
                                            <div class="btn-group" role="group">
                                                <button id="sys-dropdown-multiple" class="btn btn-sm btn-dark dropdown-toggle px-1 pb-0 pt-0" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-h"></i></button>
                                                <div class="dropdown-menu sys-dropdown-menu-dark dropdown-menu-right" aria-labelledby="sys-dropdown-multiple">
                                                    <button id="id_ButtonCheckAll" class="btn btn-link dropdown-item pt-1 pb-0 small btn-sm" type="button" name="ButtonCheckAll">Select All</button>
                                                    <button id="id_ButtonCheckNone" class="btn btn-link dropdown-item pt-1 pb-0 small btn-sm" type="button" name="ButtonCheckNone">Select None</button>
                                                    <div class="dropdown-divider"></div>
                                                    <button id="id_DeleteRecordsByButton" class="btn btn-link dropdown-item pt-1 pb-0 small btn-sm PassButtonValueToModal OptionsEditRecordsButton" type="button" name="ButtonMultipleRecordsDelete" data-toggle="modal" data-target="##sys-confirm-submit" disabled>Delete Selected</button>
                                                </div>
                                            </div>
                                        </th>
                                        <th>&nbsp;</th>
                                        <!---USED TO BE INCLUDE - END--->
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfloop query="RecordsQuery">
                                        <tr>
                                            <td>
                                                <a href="/index.cfm?controller=#REQUEST.controller#&action=animal&id=#RecordsQuery.ID#&pageaction=view&start=#URL.Start#">#RecordsQuery.Name#</a>
                                            </td>
                                            <td>
                                                #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=RecordsQuery.UpdatedAt, Format='DateTimeForDisplay')#
                                            </td>
                                            <td>
                                                <cfif RecordsQuery.Species EQ "">
                                                    <span class="text-muted">Not entered</span>
                                                <cfelse>
                                                    #RecordsQuery.Species#
                                                </cfif>
                                            </td>
                                            <td>
                                                #RecordsQuery.FirstNameKeeper# #RecordsQuery.LastNameKeeper#
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <!---Adding "py-0" class cuts down padding--->
                                                    <button id="sys-dropdown-type-animal" class="btn btn-sm btn-dark dropdown-toggle py-0" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        #RecordsQuery.Type#
                                                    </button>
                                                    <div class="dropdown-menu sys-dropdown-menu-dark" aria-labelledby="sys-dropdown-type-animal">
                                                        <cfloop array="#REQUEST.TypeArray#" index="i">
                                                            <cfif i.getType() NEQ RecordsQuery.Type>
                                                                <!---"py-0" rmoves padding to make dropdown better match size of sm button--->
                                                                <a class="dropdown-item small py-0" href="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=#URL.DOB#&pageaction=updatetypeid&newtypeid=#i.getID()#&id=#RecordsQuery.ID#">#i.getType()#</a>
                                                            </cfif>
                                                        </cfloop>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <cfif RecordsQuery.Area EQ "">
                                                    <span class="text-muted">Not entered</span>
                                                <cfelse>
                                                    #RecordsQuery.Area#    
                                                </cfif>
                                            </td>
                                            <td>
                                                <cfif RecordsQuery.DOB EQ "">
                                                    <span class="text-muted">Not entered</span>
                                                <cfelse>
                                                    #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=RecordsQuery.DOB, Format='DateForDisplay')#
                                                </cfif>
                                            </td>
                                            <!---0X _GridView0X.cfm checkbox and button rows--->
                                            <!---<cfinclude template="/views/animals/includes/_GridView0X.cfm">--->
                                            <!---USED TO BE INCLUDE - BEGIN--->
                                            <td class="text-center">
                                                <input id="id_OptionsRecordByCheck#Evaluate("RecordsQuery.#ModelID#")#" class="OptionsRecordsCheckbox" type="checkbox" name="OptionsRecordByCheck#Evaluate("RecordsQuery.#ModelID#")#" value="#Evaluate("RecordsQuery.#ModelID#")#">
                                            </td>
                                            <td class="text-center">
                                                <!---Dropdown options button, Active, Inactive, Archive, Delete, etc.--->
                                                <div class="btn-group">
                                                    <button id="sys-dropdown-single#Evaluate("RecordsQuery.#ModelID#")#" class="btn btn-sm btn-outline-dark dropdown-toggle px-1 py-0 sys-btn-bg-outline-dark" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-h"></i>
                                                    </button>
                                                    <div class="dropdown-menu dropdown-menu-right sys-dropdown-menu-dark" aria-labelledby="sys-dropdown-single#Evaluate("RecordsQuery.#ModelID#")#">
                                                        <!---Delete is always an option on all records--->
                                                        <button id="id_DeleteRecordByButton#Evaluate("RecordsQuery.#ModelID#")#" class="btn btn-link dropdown-item pt-1 pb-0 small btn-sm PassButtonValueToModal" type="button" name="ButtonSingleRecordDelete#Evaluate("RecordsQuery.#ModelID#")#" data-toggle="modal" data-target="##sys-confirm-submit">Delete #ModelTypeDisplaySingular#</button>
                                                    </div>
                                                </div>
                                            </td>
                                            <!---USED TO BE INCLUDE - END--->
                                        </tr>
                                    </cfloop>
                                </tbody>
                            </table>
                        </div>
                        <cfinclude template="/views/animals/includes/_ModalSubmit.cfm">
                        <!---Using JS to insert needed button name into this hidden field value cause of way modals work, they're triggered by a type="button" instead of type="submit"--->
                        <input name="IDToEdit" type="hidden" value="">
                    </form>
                </div>
                <!---6 _GridView06.cfm pagination at bottom of table--->
                <cfinclude template="/views/animals/includes/_GridView06.cfm">
                <div class="col-12 mb-3">
                    <ul class="list-group float-right small">
                        <li class="list-group-item py-1"><i class="fas fa-search mr-2"></i>Name, Species, Keeper, Type, Area</li>
                        <!---<li class="list-group-item list-group-item-warning py-1 ">Status: Saved for Later (Could be Locked <i class="fas fa-lock"></i>)</li>--->
                    </ul>
                </div>
            <!---Double checking that user is not doing a search--->
            <cfelseif URL.Search EQ "">
                <!---7 _GridView07.cfm no records to display message--->
                <cfinclude template="/views/animals/includes/_GridView07.cfm">
            </cfif>
        </div>
    </div>
</cfoutput>