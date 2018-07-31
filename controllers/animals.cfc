<!---
Init
GetHeaderVariablesAnimals
animals (page action)
addanimal (page action)
animal (page action)
--->

<cfcomponent displayname="Animals" output="false" extends="/controllers/Global" hint="Controller handles all Animals actions.">
    
    <!---Called every time a function in this controller is called--->
    <cfset Init()>



    <!---Init--->
    <cffunction name="Init" access="public" returntype="void" output="false" hint="Runs before all functions in this controller.">
        <!---Calls Init function of parent controller--->
        <!---<cfset Super.Init()>--->
        <!---Defaults to false--->
        <cfset REQUEST.ReqStr.BuildPDF = false>
    </cffunction>



    <!---GetHeaderVariablesAnimals--->
    <cffunction name="GetHeaderVariablesAnimals" access="public" returntype="struct" output="false" hint="Sets header variables for view.">
        <cfset var HeaderVariablesStruct = StructNew()>
        <cfset HeaderVariablesStruct.Robots = "noindex,nofollow">
        <cfswitch expression="#REQUEST.Action#">
            <cfcase value="animals">
                <cfset HeaderVariablesStruct.Title = "Animals">
                <cfset HeaderVariablesStruct.Description = "Grid of animals.">
            </cfcase>
            <cfcase value="addanimal">
                <cfset HeaderVariablesStruct.Title = "Add Animal">
                <cfset HeaderVariablesStruct.Description = "Form to create a new animal.">
            </cfcase>
            <cfcase value="animal">
                <cfif StructKeyExists(URL, "PageAction") AND URL.PageAction EQ "view">
                    <cfset HeaderVariablesStruct.Title = "View Animal">
                <cfelseif StructKeyExists(URL, "PageAction") AND URL.PageAction EQ "edit">
                    <cfset HeaderVariablesStruct.Title = "Edit Animal">
                <cfelse>
                    <cfset HeaderVariablesStruct.Title = "View/Edit Animal">
                </cfif>
                <cfset HeaderVariablesStruct.Description = "Animal view/edit details page.">
            </cfcase>
            <cfcase value="keepers">
                <cfset HeaderVariablesStruct.Title = "Keepers">
                <cfset HeaderVariablesStruct.Description = "Grid of keepers.">
            </cfcase>
            <cfcase value="addkeeper">
                <cfset HeaderVariablesStruct.Title = "Add Keeper">
                <cfset HeaderVariablesStruct.Description = "Form to create a new keeper.">
            </cfcase>
            <cfcase value="keeper">
                <cfif StructKeyExists(URL, "PageAction") AND URL.PageAction EQ "view">
                    <cfset HeaderVariablesStruct.Title = "View Keeper">
                <cfelseif StructKeyExists(URL, "PageAction") AND URL.PageAction EQ "edit">
                    <cfset HeaderVariablesStruct.Title = "Edit Keeper">
                <cfelse>
                    <cfset HeaderVariablesStruct.Title = "View/Edit Keeper">
                </cfif>
                <cfset HeaderVariablesStruct.Description = "Keeper view/edit details page.">
            </cfcase>
            <cfdefaultcase>
                <cfset HeaderVariablesStruct.Title = "Animals">
                <cfset HeaderVariablesStruct.Description = "Animals">
            </cfdefaultcase>
        </cfswitch>
        <!---No matter which controller in need to return "HeaderVariablesStruct" struct so _Header.cfm include can use the struct variables--->
        <cfreturn HeaderVariablesStruct>
    </cffunction>



    <!---animals--->
    <cffunction name="animals" access="public" returntype="void" output="false" hint="Grid">
        <!---
        LINK:
            -/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=#URL.DOB#
            -/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#
        URL PARAMS REQUIRED:
            PerPage: all, 50, 100, 200, 1000 (1000 is only used when there are more than 1000 records)
            Start: positive integer not greater than the total number of records
            Order: updatedat, name, species, keeper, type, area, dob
            Direction: asc, desc
            Search: search string entered by user
        URL PARAMS CUSTOM REQUIRED:
            KeeperID: ID in Keepers table or "0"
            AreaID: ID in Areas table or "0"
            TypeID: ID in Types table or "0"
            DOB: DOB in Animlals table, 0, 3, 7, 8 for years
        URL PARAMS OPTIONAL:
            PageAction: updatetypeid
                NewTypeID = new TypeID
                ID = AnimalID of record being updated
            PageAction: options
            PageAction: createspreadsheet
        COOKIES:
            PerPage, Direction, Order
        COOKIES CUSTOM (Usually for filters):
            TypeID, AreaID, KeeperID, DOB
        FILTERS:
            PerPage, TypeID, AreaID, KeeperID, DOB
        --->
        <cfset VARIABLES.Title = "Animals">
        <!---Variables to help move more grid code into global grid includes--->
        <!---GridName, ModelType, ModelID, ModelMainColumn1 (FirstName), ModelMainColumn2 (LastName), ModelTypeDisplaySingular, ModelTypeDisplayPlural--->
        <cfset GridName = "Animals">
        <cfset ModelType = "Animal">
        <cfset ModelID = "ID">
        <cfset ModelMainColumn1 = "Name">
        <cfset ModelMainColumn2 = "">
        <cfset ModelTypeDisplaySingular = "Animal">
        <cfset ModelTypeDisplayPlural = "Animals">
        <!---1 _Grid01.cfm include, search params and submission handling--->
        <cfinclude template="/controllers/includes/_Grid01.cfm">
        <!---COOKIES - part 1--->
        <!---If cookie doesn't exist set it to default, otherwise do nothing since cookie must be a validated string set after URL variable check on prior request--->
        <!---2 _Grid02.cfm PerPage and Direction cookies--->
        <cfinclude template="/controllers/includes/_Grid02.cfm">
        <cfif !StructKeyExists(COOKIE, "#GridName#Order")>
            <cfcookie name="#GridName#Order" value="name" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        </cfif>
        <cfif !StructKeyExists(COOKIE, "#GridName#KeeperID")>
            <cfcookie name="#GridName#KeeperID" value="0" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        </cfif>
        <cfif !StructKeyExists(COOKIE, "#GridName#AreaID")>
            <cfcookie name="#GridName#AreaID" value="0" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        </cfif>
        <cfif !StructKeyExists(COOKIE, "#GridName#TypeID")>
            <cfcookie name="#GridName#TypeID" value="0" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        </cfif>
        <cfif !StructKeyExists(COOKIE, "#GridName#DOB")>
            <cfcookie name="#GridName#DOB" value="0" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        </cfif>
        <!---URL VARIABLES FOR PAGING & SORTING - default values don't override what's requested by user so still do URL varialbe validation below--->
        <!---3 _Grid03.cfm url variable params--->
        <cfinclude template="/controllers/includes/_Grid03.cfm">
        <cfparam name="URL.KeeperID" default="#Evaluate("COOKIE.#GridName#KeeperID")#">
        <cfparam name="URL.AreaID" default="#Evaluate("COOKIE.#GridName#AreaID")#">
        <cfparam name="URL.TypeID" default="#Evaluate("COOKIE.#GridName#TypeID")#">
        <cfparam name="URL.DOB" default="#Evaluate("COOKIE.#GridName#DOB")#">
        <cfparam name="URL.PageAction" default="">
        <!---URL VARIABLES VALIDATION--->
        <!---4 _Grid04.cfm url variable validation for "URL.PerPage", "URL.Start", and "URL.Direction"--->
        <cfinclude template="/controllers/includes/_Grid04.cfm">
        <!---URL.Order - try to make these match DB column names if possible--->
        <cfif URL.Order NEQ "name" AND URL.Order NEQ "updatedat" AND URL.Order NEQ "species" AND URL.Order NEQ "keeper" AND URL.Order NEQ "type" AND URL.Order NEQ "area" AND URL.Order NEQ "dob">
            <cfset URL.Order = "name">
        </cfif>
        <!---URL.KeeperID--->
        <cfset REQUEST.KeeperArray = EntityLoad("Keeper", {DeletedAt=""}, "FirstName ASC")>
        <!---If value isn't "0" loop array or query & make sure it's a valid ID, if not set it to "0"--->
        <cfif URL.KeeperID NEQ 0>
            <!---"var" scope "IsValidIDBit" since it won't be needed in view--->
            <cfset var IsValidIDBit = false>
            <cfloop array="#REQUEST.KeeperArray#" index="i">
                <cfif i.getID() EQ URL.KeeperID>
                    <cfset IsValidIDBit = true>
                    <cfbreak>
                </cfif>
            </cfloop>
            <!---If IsValidIDBit is still false then default value to "0"--->
            <cfif IsValidIDBit EQ false>
                <cfset URL.KeeperID = 0>
            </cfif>
        </cfif>
        <!---URL.AreaID--->
        <cfset REQUEST.AreaArray = EntityLoad("Area", {DeletedAt=""}, "SortOrder ASC")>
        <cfif URL.AreaID NEQ 0>
            <cfset var IsValidIDBit = false>
            <cfloop array="#REQUEST.AreaArray#" index="i">
                <cfif i.getID() EQ URL.AreaID>
                    <cfset IsValidIDBit = true>
                    <cfbreak>
                </cfif>
            </cfloop>
            <cfif IsValidIDBit EQ false>
                <cfset URL.AreaID = 0>
            </cfif>
        </cfif>
        <!---URL.TypeID--->
        <cfset REQUEST.TypeArray = EntityLoad("Type", {DeletedAt=""}, "SortOrder ASC")>
        <cfif URL.TypeID NEQ 0>
            <cfset var IsValidIDBit = false>
            <cfloop array="#REQUEST.TypeArray#" index="i">
                <cfif i.getID() EQ URL.TypeID>
                    <cfset IsValidIDBit = true>
                    <cfbreak>
                </cfif>
            </cfloop>
            <cfif IsValidIDBit EQ false>
                <cfset URL.TypeID = 0>
            </cfif>
        </cfif>
        <!---URL.DOB--->
        <!---Using 3, 7, and 8 years--->
        <cfif URL.DOB NEQ 0 AND URL.DOB NEQ 3 AND URL.DOB NEQ 7 AND URL.DOB NEQ 8>
            <cfset URL.DOB = 0>
        </cfif>
        <!---COOKIES part 2--->
        <!---Set cookies to URL variables every time after URL variables validation--->
        <!---5 _Grid05.cfm PerPage, order, and direction cookies--->
        <cfinclude template="/controllers/includes/_Grid05.cfm">
        <cfcookie name="#GridName#KeeperID" value="#URL.KeeperID#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        <cfcookie name="#GridName#AreaID" value="#URL.AreaID#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        <cfcookie name="#GridName#TypeID" value="#URL.TypeID#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        <cfcookie name="#GridName#DOB" value="#URL.DOB#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
        <!---Set "DefaultCustomParams" after cookies and url params, used in delete records include and throughout controller & view--->
        <cfset DefaultCustomParams = "typeid=#URL.TypeID#&areaid=#URL.AreaID#&keeperid=#URL.KeeperID#&dob=#URL.DOB#">
        <!---PAGE ACTIONS - run before RecordsQuery call since they often require redirects--->
        <!---0X _Grid0X.cfm delete multiple records or a single record--->
        <!---<cfinclude template="/controllers/includes/_Grid0X.cfm">--->
        <!---USED TO BE INCLUDE - BEGIN--->
        <!---PAGE ACTION - options================================================================================================--->
        <!---Handles options for both main option button at top of grid that edits multiple records and individual x option buttons per record--->
        <cfif URL.PageAction EQ "options">
            <!---"var" scoping cause these variables are only used inside this "delete" condition--->
            <cfset var OptionsSuccessBit = false>
            <cfset var MessageText = "">
            <cfset var Counter = 0>
            <!---Probably an unneeded check, but an extra precaution, it should always exist and will never be empty--->
            <cfif StructKeyExists(FORM, "IDToEdit") AND FORM.IDToEdit NEQ "">
                <!---If "Model" is returned make edit, set OptionsSuccessBit to true, and Counter to 1 cause only one record is edited, if no "Model" don't set "OptionsSuccessBit", ensures "cannot be edited" info message is displayed--->
                <!---DELETE SINGLE RECORD--->
                <cfif Mid(FORM.IDToEdit, 1, 24) EQ "ButtonSingleRecordDelete">
                    <cfset Model = EntityLoad("#ModelType#", {"#ModelID#"=Mid(FORM.IDToEdit, 25, Len(FORM.IDToEdit)), DeletedAt=""}, true)>
                    <cfif !IsNull(Model)>
                        <cfset Model.setDeletedAt(REQUEST.ReqStr.UTCNow)>
                        <cfset OptionsSuccessBit = true>
                        <cfset MessageText = "deleted">
                        <cfset Counter = 1>
                    </cfif>
                <!---Probably didn't have to pass the button name for cases where updating multiple records but keeps things consistent--->
                <!---DELETE MULTIPLE RECORDS--->
                <cfelseif FORM.IDToEdit EQ "ButtonMultipleRecordsDelete">
                    <cfloop collection="#FORM#" item="i">
                        <cfif Mid(i, 1, 20) EQ "OptionsRecordByCheck">
                            <cfset Model = EntityLoad("#ModelType#", {"#ModelID#"=Mid(i, 21, Len(i)), DeletedAt=""}, true)>
                            <cfif !IsNull(Model)>
                                <!---Delete--->
                                <cfif FORM.IDToEdit EQ "ButtonMultipleRecordsDelete">
                                    <cfset Model.setDeletedAt(REQUEST.ReqStr.UTCNow)>
                                    <cfset MessageText = "deleted">
                                </cfif>
                                <cfset OptionsSuccessBit = true>
                                <cfset Counter = Counter + 1>
                            </cfif>
                        </cfif>
                    </cfloop>
                </cfif>
            </cfif>
            <cfset StructDelete(SESSION, "AlertPageTop")>
            <!---If "OptionsSuccessBit" true then at least one record was edited so flush and set success message--->
            <cfif OptionsSuccessBit EQ true>
                <cfset ORMFlush()>    
                <!---Check that "Model" exists cause there's a chance it doesn't exist before user submits form, Model is returned for every call so if "Counter" is 1 then use Model to display details since it's a single record--->
                <cfif Counter EQ 1 AND !IsNull(Model)>
                    <!---Check if working with 1 or 2 ModelMainColumn variables, "ModelMainColumn1" will always exist--->
                    <cfif IsDefined("ModelMainColumn2") AND ModelMainColumn2 NEQ "">
                        <cfset SESSION.AlertPageTop = "col-12~success~#ModelTypeDisplaySingular# <strong>#Evaluate("Model.get#ModelMainColumn1#()")# #Evaluate("Model.get#ModelMainColumn2#()")#</strong> successfully #MessageText#.">
                    <cfelse>
                        <cfset SESSION.AlertPageTop = "col-12~success~#ModelTypeDisplaySingular# <strong>#Evaluate("Model.get#ModelMainColumn1#()")#</strong> successfully #MessageText#.">
                    </cfif>
                <cfelseif Counter GT 1>
                    <cfset SESSION.AlertPageTop = "col-12~success~#ModelTypeDisplayPlural# successfully #MessageText#.">
                </cfif>
            <!---Catches case where a record was edited by another user while current user attempted to edit the record as well but was 2nd to do so, rare but could happen if two users are editing records at the same time--->
            <cfelse>
                <cfset SESSION.AlertPageTop = "col-12~info~The record(s) you attempted to edit cannot be edited.">
            </cfif>
            <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#" addtoken="false">
        </cfif>
        <!---USED TO BE INCLUDE - END--->
        <!---PAGE ACTION - updatetypeid=====================--->
        <cfif URL.PageAction EQ "updatetypeid">
            <cfset Model = EntityLoad("Animal", {ID=URL.ID, DeletedAt=""}, true)>
            <cfif !IsNull(Model)>
                <cfset ORMExecuteQuery("UPDATE Animal SET TypeID=:NewTypeID WHERE ID=:ID AND DeletedAt IS Null", {NewTypeID=URL.NewTypeID, ID=URL.ID}, true)>
                <cfset EntityReload(Model)>
                <cfset StructDelete(SESSION, "AlertPageTop")>
                <cfset SESSION.AlertPageTop = "col-12~success~Successfully updated type to <strong>#Model.getType().getType()#</strong> for <strong>#Model.getName()#</strong>.">
            <cfelse>
                <cfset StructDelete(SESSION, "AlertPageTop")>
                <cfset SESSION.AlertPageTop = "col-12~danger~The record you are attempting to update no longer exists.">
            </cfif>
            <!---"cflocation" clears out URL variables that trigger request, prevents calling the update again & continuing to show alert if user refreshes page--->
            <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#" addtoken="false">
        </cfif>
        <!---FORMAT FILTER DISPLAYS - also used for generated grid files--->
        <!---KeeperIDFormatted--->
        <cfif URL.KeeperID EQ 0>
            <cfset KeeperIDFormatted = "All Keepers">
        <cfelse>
            <!---Query or array was already created above so use it here and loop over it in the grid view for dropdown--->
            <cfloop array="#REQUEST.KeeperArray#" index="i">
                <cfif i.getID() EQ URL.KeeperID>
                    <cfset KeeperIDFormatted = i.getFirstName() & " " & i.getLastName()>
                    <cfbreak>
                </cfif>
            </cfloop>
        </cfif>
        <!---AreaIDFormatted--->
        <cfif URL.AreaID EQ 0>
            <cfset AreaIDFormatted = "All Areas">
        <cfelse>
            <cfloop array="#REQUEST.AreaArray#" index="i">
                <cfif i.getID() EQ URL.AreaID>
                    <cfset AreaIDFormatted = i.getArea()>
                    <cfbreak>
                </cfif>
            </cfloop>
        </cfif>
        <!---TypeIDFormatted--->
        <cfif URL.TypeID EQ 0>
            <cfset TypeIDFormatted = "All Types">
        <cfelse>
            <cfloop array="#REQUEST.TypeArray#" index="i">
                <cfif i.getID() EQ URL.TypeID>
                    <cfset TypeIDFormatted = i.getType()>
                    <cfbreak>
                </cfif>
            </cfloop>
        </cfif>
        <!---DOBFormatted--->
        <cfif URL.DOB EQ 0>
            <cfset DOBFormatted = "DOB Anytime">
        <cfelseif URL.DOB EQ 3>
            <cfset DOBFormatted = "DOB Within Last 3 Years">
        <cfelseif URL.DOB EQ 7>
            <cfset DOBFormatted = "DOB Within Last 7 Years">
        <cfelseif URL.DOB EQ 8>
            <cfset DOBFormatted = "DOB Within Last 8 Years">
        </cfif>
        <!---ORDER BY--->
        <!---
        -Order: name, updatedat, species, keeper, type, area, dob
        -URL.Order is only variable that needs edited for RecordsQuery call since rest of pagination URL variables are set correctly in their URL variables
        -Variable passed to query is named "OrderBy" to prevent collision
        -Setting "OrderByFormatted" here for grid file generation too since we already have to go through the conditions to set the "OrderBy" clause variable
        --->
        <!---name--->
        <cfif URL.Order EQ "name">
            <cfset OrderBy = "Animals.Name " & URL.Direction & ", Animals.UpdatedAt " & URL.Direction>
            <cfset OrderByFormatted = "Name">
        <!---updatedat--->
        <cfelseif URL.Order EQ "updatedat">
            <cfset OrderBy = "Animals.UpdatedAt " & URL.Direction & ", Animals.Name " & URL.Direction>
            <cfset OrderByFormatted = "Updated">
        <!---species--->
        <cfelseif URL.Order EQ "species">
            <cfset OrderBy = "Animals.Species " & URL.Direction & ", Animals.Name " & URL.Direction>
            <cfset OrderByFormatted = "Species">
        <!---keeper--->
        <cfelseif URL.Order EQ "keeper">
            <cfset OrderBy = "FirstNameKeeper " & URL.Direction & ", LastNameKeeper " & URL.Direction & ", Animals.Name " & URL.Direction>
            <cfset OrderByFormatted = "Keeper">
        <!---type--->
        <cfelseif URL.Order EQ "type">
            <cfset OrderBy = "Type " & URL.Direction & ", Animals.Name " & URL.Direction>
            <cfset OrderByFormatted = "Type">
        <!---area--->
        <cfelseif URL.Order EQ "area">
            <cfset OrderBy = "Areas.Area " & URL.Direction & ", Animals.Name " & URL.Direction>
            <cfset OrderByFormatted = "Area">
        <!---dob--->
        <cfelseif URL.Order EQ "dob">
            <cfset OrderBy = "Animals.DOB " & URL.Direction & ", Animals.Name " & URL.Direction>>
            <cfset OrderByFormatted = "DOB">
        </cfif>
        <!---Set query name to RecordsQuery since only one grid on the page, trim arguments so we don't need to trim in the function--->
        <cfinvoke component="/dals/Animal" method="SelectForGrid" returnvariable="RecordsQuery">
            <cfinvokeargument name="OrderBy" value="#Trim(OrderBy)#">
            <!---No need to subtract 1 from start, it's done in SelectForGrid function--->
            <cfinvokeargument name="Start" value="#Trim(URL.Start)#">
            <cfinvokeargument name="PerPage" value="#Trim(URL.PerPage)#">
            <!---Decode search string before passing it to "SelectForGrid"--->
            <cfinvokeargument name="Search" value="#Trim(URLDecode(URL.Search))#">
            <cfinvokeargument name="KeeperID" value="#Trim(URL.KeeperID)#">
            <cfinvokeargument name="AreaID" value="#Trim(URL.AreaID)#">
            <cfinvokeargument name="TypeID" value="#Trim(URL.TypeID)#">
            <cfinvokeargument name="DOB" value="#Trim(URL.DOB)#">
        </cfinvoke>
        <!---
        -A couple checks here
        -1) In case "RecordsQuery" call does not return any records and "URL.Start" was not 1 then we still need to do another check. No way of checking if "URL.Start" is a valid integer, but yet invalid cause the integer is larger than the record set. We can't know this yet cause we have to get the record set first, so if no records are returned we'll double check by setting "URL.Start" back to 1 and calling "SelectForGrid" again. This is almost impossible, would only happen in a paginated display where a user is on a view while another user removes records from that view and then the "URL.Start" value of the next page link isn't valid anymore. this check won't take place during search submissions cause search submissions will always have "URL.Start" set to 1. Won't slow processing either cause only executes when there's no record count which should basically be never.
        -2) Ensures "URL.PerPage" didn't get set to "0" when "RecordsQuery.RecordCountTotal[1]" is greater than 1000, if so rerun query, should be rare.
        --->
        <cfif (!RecordsQuery.RecordCount AND URL.Start NEQ 1) OR (RecordsQuery.RecordCountTotal[1] GT 1000 AND URL.PerPage EQ 0)>
            <cfif !RecordsQuery.RecordCount AND URL.Start NEQ 1>
                <!---Set URL.Start back to 1 and double check that we can't get a record set--->
                <cfset URL.Start = 1>
            <cfelseif RecordsQuery.RecordCountTotal[1] GT 1000 AND URL.PerPage EQ 0>
                <!---Set URL.PerPage back to 1000--->
                <cfset URL.PerPage = 1000>
            </cfif>
            <cfinvoke component="/dals/Animal" method="SelectForGrid" returnvariable="RecordsQuery">
                <cfinvokeargument name="OrderBy" value="#Trim(OrderBy)#">
                <!---No need to subtract 1 from start, it's done in SelectForGrid function--->
                <cfinvokeargument name="Start" value="#Trim(URL.Start)#">
                <cfinvokeargument name="PerPage" value="#Trim(URL.PerPage)#">
                <!---Decode search string before passing it to "SelectForGrid"--->
                <cfinvokeargument name="Search" value="#Trim(URLDecode(URL.Search))#">
                <cfinvokeargument name="KeeperID" value="#Trim(URL.KeeperID)#">
                <cfinvokeargument name="AreaID" value="#Trim(URL.AreaID)#">
                <cfinvokeargument name="TypeID" value="#Trim(URL.TypeID)#">
                <cfinvokeargument name="DOB" value="#Trim(URL.DOB)#">
            </cfinvoke>
        </cfif>
        <!---FILE CREATION--->
        <!---RecordsQuery.RecordCountTotal[1] is LTE 1000 records so the file is created instantly--->
        <cfif URL.PageAction EQ "createspreadsheet" AND RecordsQuery.RecordCountTotal[1] LTE 1000>
           <!---
            -Files should contain all records, so if "URL.PerPage" is not set to "0" run query again, but if it is "0" no need to run again
            -Can't overwrite "RecordsQuery" cause it still needs to be used for grid display
            --->
            <cfif URL.PerPage NEQ 0>
                <!---Calling "SelectForGrid" for file creation a 2nd time cause user might not be viewing all records due to "PerPage" filter, still using same query name of RecordsQuery--->
                <cfinvoke component="/dals/Animal" method="SelectForGrid" returnvariable="RecordsQuery">
                    <cfinvokeargument name="OrderBy" value="#Trim(OrderBy)#">
                    <!---No need to subtract 1 from start, it's done in SelectForGrid function--->
                    <cfinvokeargument name="Start" value="0">
                    <cfinvokeargument name="PerPage" value="0">
                    <!---Decode search string before passing it to "SelectForGrid"--->
                    <cfinvokeargument name="Search" value="#Trim(URLDecode(URL.Search))#">
                    <cfinvokeargument name="KeeperID" value="#Trim(URL.KeeperID)#">
                    <cfinvokeargument name="AreaID" value="#Trim(URL.AreaID)#">
                    <cfinvokeargument name="TypeID" value="#Trim(URL.TypeID)#">
                    <cfinvokeargument name="DOB" value="#Trim(URL.DOB)#">
                </cfinvoke>
            </cfif>
            <!---6 _Grid06.cfm grid file names, "NewLineToAdd" variable, and create directory and rename file if necessary--->
            <cfinclude template="/controllers/includes/_Grid06.cfm">
            <!---Top line info used for all file types--->
            <cfset var TopLineInfo = "Created:#APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=REQUEST.ReqStr.UTCNow, Format='DateTimeForFilename')#, App:Animals, Page:Animals, Sorted By:#OrderByFormatted#, Filters:Keeper=#KeeperIDFormatted#; Area=#AreaIDFormatted#; Type=#TypeIDFormatted#; DOB=#DOBFormatted##IIF(FORM.SearchString NEQ '', DE('; Search String=#FORM.SearchString#'), '')#">
            <!---Create the "Spreadsheet"--->
            <cfset Spreadsheet = New libraries.spreadsheet.Spreadsheet()>
            <!---Duplicate "RecordsQuery" so we don't interfere with the grid display--->
            <cfset DupRecordsQuery = Duplicate(RecordsQuery)>
            <!---Looping over duplicated query to do some formatting before creating spreadsheet, can't format 1|0, yyyy-mm-dd, spreadsheets will format those columns how they like and can't be overridden--->
            <cfloop query="DupRecordsQuery">
                <cfset DupRecordsQuery.CreatedAt = APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=DupRecordsQuery.CreatedAt, Format='DateTimeForDisplay')>
                <cfset DupRecordsQuery.UpdatedAt = APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=DupRecordsQuery.UpdatedAt, Format='DateTimeForDisplay')>
                <cfif DupRecordsQuery.FileCleanAvatar NEQ "">
                    <cfset DupRecordsQuery.FileCleanAvatar = "Yes">
                <cfelse>
                    <cfset DupRecordsQuery.FileCleanAvatar = "Not entered">
                </cfif>
                <cfif DupRecordsQuery.FavoriteColor EQ "">
                    <cfset DupRecordsQuery.FavoriteColor = "Not entered">
                </cfif>
                <cfset DupRecordsQuery.ArrivedAt = APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=DupRecordsQuery.ArrivedAt, Format='DateTimeForDisplay')>
            </cfloop>
            <!---Create workbook from the query, set "addheaderrow" to "false" so we can add our own formatted header row--->
            <cfset Workbook = Spreadsheet.WorkbookFromQuery(data=DupRecordsQuery, addheaderrow=false)>
            <!---Delete any columns that contain query data columns the user shouldn't view, e.g.: ID values etc. also be sure to delete last column that contains total record count--->
            <cfset Spreadsheet.DeleteColumns(Workbook, "18-20")>
            <!---Add column headers row to format it as needed instead of displaying the exact DB column name, tried using "autoSizeColumns" but didn't seem to work, formatted widths of all columns below anyhow in "SetColumnWidth" calls--->
            <cfset Spreadsheet.AddRow(workbook=Workbook, data="Name|Created|Updated|Species|Keeper First Name|Keeper Last Name|Type|Area|DOB|Gender|Avatar|Has Special Diet|Special Diet|Favorite Color|Favorite Color Explained|Arrived|Notes", row=1, column=1, delimiter="|")>
            <!---Add a blank row to be displayed between top line query info and column header values--->
            <cfset Spreadsheet.AddRow(workbook=Workbook, data="", row=1)>
            <!---Add the query info column to the top line of the spreadsheet, if for example the first 3 columns of workbook were hidden would then set column to 4, set delimiter to pipe instead of comma--->
            <cfset Spreadsheet.AddRow(workbook=Workbook, data="#TopLineInfo#", row=1, column=1, delimiter="|")>
            <!---Format the header row to be bold, uses ACF format struct: http://help.adobe.com/en_US/ColdFusion/9.0/CFMLRef/WSc3ff6d0ea77859461172e0811cbec22c24-6747.html--->
            <cfset Spreadsheet.FormatCellRange(workbook=Workbook, format={bold=true}, startrow=3, endrow=3, startcolumn=1, endcolumn=17)>
            <!---Loop to create each column, if different widths are needed then don't use a loop, 30 is a little wider than default--->
            <cfloop from="1" to="17" index="i">
                <cfset Spreadsheet.SetColumnWidth(workbook=Workbook, column=#i#, width=30)>
            </cfloop>
            <!---Write the spreadsheet, use "ExpandPath" instead of a mapping--->
            <cfset Spreadsheet.Write(workbook=Workbook, filepath="#ExpandPath('./')#/files/#GridFilenameUUID#", overwrite=true)>
        <!---RecordsQuery.RecordCountTotal[1] is GT 1000 records so a task is created and the file will be created by the task server--->
        <cfelseif URL.PageAction EQ "createspreadsheet" AND RecordsQuery.RecordCountTotal[1] GT 1000>
            <cfset StructDelete(SESSION, "AlertPageTop")>
            <cfset SESSION.AlertPageTop = "col-12~danger~Spreadsheets cannot be generated for more than 1000 records, please filter your results to be less than 1000 records.">
            <!---"cflocation" clears out URL variables that trigger request, prevents calling the update again & continuing to show alert if user refreshes page--->
            <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&perpage=#URL.PerPage#&start=#URL.Start#&order=#URL.Order#&direction=#URL.Direction#&search=#URL.Search#&#DefaultCustomParams#" addtoken="false">
        </cfif>
    </cffunction>



    <!---addanimal--->
    <cffunction name="addanimal" access="public" returntype="void" output="false" hint="Form to create a new animal.">
        <!---CANCEL FORM--->
        <cfif StructKeyExists(FORM, "ButtonModalCancel")>
            <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=animals" addtoken="false">
        </cfif>
        <cfinclude template="/controllers/includes/_AnimalsAddEdit01.cfm">
        <!---FORM PARAMS--->
        <cfparam name="FORM.Name" default="">
        <cfparam name="FORM.KeeperID" default="">
        <cfparam name="FORM.AreaID" default="">
        <cfparam name="FORM.Species" default="">
        <cfparam name="FORM.DOB" default="">
        <cfparam name="FORM.DOBYear" default="">
        <cfparam name="FORM.DOBMonth" default="">
        <cfparam name="FORM.DOBDay" default="">
        <cfparam name="FORM.Gender" default="">
        <cfparam name="FORM.TypeID" default="">
        <cfparam name="FORM.Notes" default="">
        <cfparam name="FORM.SpecialDietBit" default="">
        <cfparam name="FORM.SpecialDiet" default="">
        <cfparam name="FORM.FavoriteColor" default="">
        <cfparam name="FORM.FavoriteColorExplain" default="">
        <cfparam name="FORM.FileUUIDAvatar" default="">
        <cfparam name="FORM.ArrivedAt" default="">
        <cfparam name="FORM.ArrivedAtYear" default="">
        <cfparam name="FORM.ArrivedAtMonth" default="">
        <cfparam name="FORM.ArrivedAtDay" default="">
        <cfparam name="FORM.ArrivedAtTime" default="">
        <!---SUBMIT FORM--->
        <cfif StructKeyExists(FORM, "ButtonModalSubmit")>
            <cfinclude template="/controllers/includes/_AnimalsAddEdit02.cfm">
            <!---ERRORS--->
            <cfif !ArrayIsEmpty(ErrorArray)>
                <cfinclude template="/controllers/includes/_AnimalsAddEdit03.cfm">
            <!---NO ERRORS--->
            <cfelse>
                <cfinclude template="/controllers/includes/_AnimalsAddEdit04.cfm">
                <cfset Model = EntityNew("Animal", {
                    <!---Storing name decrypted for testing purposes--->
                    Name=FORM.Name,
                    KeeperID=FORM.KeeperID,
                    <!---AreaID isn't required, is an int so write null if form field is empty--->
                    AreaID=IIF(FORM.AreaID EQ "", "JavaCast('Null', '')", "FORM.AreaID"),
                    Species=FORM.Species,
                    <!---Not formatting to UTC since this is a user entered date only and not a time field so they'll correctly pick their own DOB--->
                    DOB=FORM.DOBYear & "-" & FORM.DOBMonth & "-" & FORM.DOBDay,
                    Gender=FORM.Gender,
                    TypeID=FORM.TypeID,
                    <!---Notes aren't required, is varchar so write "" empty string if form field is empty--->
                    Notes=IIF(FORM.Notes EQ "", "", "FORM.Notes"),
                    SpecialDietBit=FORM.SpecialDietBit,
                    SpecialDiet=IIF(FORM.SpecialDietBit EQ 1, "FORM.SpecialDiet", ""),
                    FavoriteColor=IIF(FORM.FavoriteColor NEQ "", "FORM.FavoriteColor", ""),
                    FavoriteColorExplain=IIF(FORM.FavoriteColor NEQ "", "FORM.FavoriteColorExplain", ""),
                    <!---No need to clean the filename since always setting it to Avatar.ext for every animal, more secure than setting filename to AnimalID value or something--->
                    FileUUIDAvatar=IIF(FORM.FileUUIDAvatar EQ "", "", "ThisFileUUIDAvatar"),
                    FileCleanAvatar=IIF(FORM.FileUUIDAvatar EQ "", "", "ThisFileCleanAvatar"),
                    <!---User is selecting their time zone time that animal arrived so convert it to UTC using their current SESSION.VisStr.TimeZone var, adding :00 to represent seconds--->
                    ArrivedAt=APPLICATION.Inst.DateTimeTimeZoneToUTC(DateTime=FORM.ArrivedAtYear & "-" & FORM.ArrivedAtMonth & "-" & FORM.ArrivedAtDay & " " & FORM.ArrivedAtTime & ":00", Format="DateTimeForDB")})>
                <cfset EntitySave(Model, true)>
                <cfset StructDelete(SESSION, "AlertPageTop")>
                <cfset SESSION.AlertPageTop = "col-12~success~New animal <strong>#Model.getName()#</strong> has been added.">
                <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=animals" addtoken="false">
            </cfif>
        </cfif>
    </cffunction>



    <!---animal--->
    <cffunction name="animal" access="public" returntype="void" output="false" hint="View/Edit Animal">
        <!---URL PARAM CHECK - function will redirect if there is an error--->
        <cfinvoke component="/udfs/Invoke" method="CheckValidURLParameter">
            <cfinvokeargument name="ParamType" value="Integer">
            <cfinvokeargument name="ParamName" value="id">
        </cfinvoke>
        <cfset Model = EntityLoad("Animal", {ID=URL.ID, DeletedAt=""}, true)>
        <!---MODEL EXISTENCE CHECK--->
        <cfif IsNull(Model)>
            <cfinvoke component="/udfs/Invoke" method="DisplayMessage">
                <cfinvokeargument name="MessageType" value="RecordNoLongerExists">
            </cfinvoke>
        </cfif>
        <cfset VARIABLES.PageActionList = "view,edit,delete,buildpdf">
        <!---Setting URL.Start value here to be able to pass back to grid no matter which page the user returns from--->
        <cfparam name="URL.Start" default="1">
        <cfparam name="URL.PageAction" default="">
        <cfif !ListFindNoCase(VARIABLES.PageActionList, URL.PageAction)>
            <cfset URL.PageAction = "view">
        </cfif>
        <!---Setting title after URL.PageAction is checked and Model is set and decrypted--->
        <cfif URL.PageAction EQ "view">
            <cfset VARIABLES.Title = "View Animal - #Model.getName()#">
        <cfelseif URL.PageAction EQ "edit">
            <cfset VARIABLES.Title = "Edit Animal - #Model.getName()#">
        <cfelse>
            <cfset VARIABLES.Title = "Animal">
        </cfif>
        <cfinclude template="/controllers/includes/_AnimalsAddEdit01.cfm">
        <!---EDIT===================================================================================================--->
        <cfif URL.PageAction EQ "edit">
            <!---CANCEL FORM--->
            <cfif StructKeyExists(FORM, "ButtonModalCancel")>
                <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=animal&id=#Model.getID()#&pageaction=view&start=#URL.Start#" addtoken="false">
            </cfif>
            <!---Params - only used when FORM scope variables don't exist, so when form is submitted, doesn't pass validation, and needs reloaded, whatever is typed into form fields is kept--->
            <!---If Model property is an optional integer and doesn't exist then need to use IIF to prevent an error for the default, e.g.: AreaID--->
            <cfparam name="FORM.Name" default="#Model.getName()#">
            <cfparam name="FORM.KeeperID" default="#Model.getKeeperID()#">
            <cfparam name="FORM.AreaID" default="#IIF(Model.getAreaID() EQ "", "", "Model.getAreaID()")#">
            <cfparam name="FORM.Species" default="#Model.getSpecies()#">
            <cfparam name="FORM.DOB" default="">
            <cfparam name="FORM.DOBYear" default="#DatePart('yyyy', Model.getDOB())#">
            <cfparam name="FORM.DOBMonth" default="#DatePart('m', Model.getDOB())#">
            <cfparam name="FORM.DOBDay" default="#DatePart('d', Model.getDOB())#">
            <cfparam name="FORM.Gender" default="#Model.getGender()#">
            <cfparam name="FORM.TypeID" default="#Model.getTypeID()#">
            <cfparam name="FORM.Notes" default="#Model.getNotes()#">
            <cfparam name="FORM.SpecialDietBit" default="#Model.getSpecialDietBit()#">
            <cfparam name="FORM.SpecialDiet" default="#Model.getSpecialDiet()#">
            <cfparam name="FORM.FavoriteColor" default="#Model.getFavoriteColor()#">
            <cfparam name="FORM.FavoriteColorExplain" default="#Model.getFavoriteColorExplain()#">
            <!---Only default field to Keep if an existing Avatar actually exists, otherwise default it to empty, this will help prevent issues when writing an edit to DB--->
            <cfparam name="FORM.KeepReplaceDeleteFile" default="#IIF(Model.getFileUUIDAvatar() NEQ '', DE('Keep'), '')#">
            <cfparam name="FORM.FileUUIDAvatar" default="">
            <!---Convert from UTC time in DB to user's time zone--->
            <cfset ThisArrivedAt = APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getArrivedAt(), Format="DateTimeDBFormat")>
            <cfparam name="FORM.ArrivedAt" default="">
            <cfparam name="FORM.ArrivedAtYear" default="#DatePart('yyyy', ThisArrivedAt)#">
            <cfparam name="FORM.ArrivedAtMonth" default="#DatePart('m', ThisArrivedAt)#">
            <cfparam name="FORM.ArrivedAtDay" default="#DatePart('d', ThisArrivedAt)#">
            <!---Disabled form fields where data is pulled from DB but these fiels aren't submitted or validated obviously, only displayed on edit form too, not the add form--->
            <cfset ThisCreatedAt = APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getCreatedAt(), Format="DateTimeForDisplay")>
            <cfparam name="FORM.CreatedAt" default="#ThisCreatedAt#">
            <cfset ThisUpdatedAt = APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getUpdatedAt(), Format="DateTimeForDisplay")>
            <cfparam name="FORM.UpdatedAt" default="#ThisUpdatedAt#">
            <!--- isn't an editable form field, but setting it in FORM scope cause it's displayed as a disabled form in top section when in edit mode--->
            <!---Didn't use IIF cause there's 3 conditions--->
            <cfif DateDiff("yyyy", Model.getDOB(), Now()) EQ 0>
                <cfset ThisAge = "Less than 1 year of age">
            <cfelseif DateDiff("yyyy", Model.getDOB(), Now()) EQ 1>
                <cfset ThisAge = "1 year of age">
            <cfelse>
                <cfset ThisAge = DateDiff("yyyy", Model.getDOB(), Now()) & " years of age">
            </cfif>
            <cfparam name="FORM.Age" default="#ThisAge#">
            <!---No TimePart function exists, so using NumberFormat and DatePart together to get 02:00, 21:30, etc.--->
            <cfparam name="FORM.ArrivedAtTime" default="#NumberFormat(DatePart('h', ThisArrivedAt), '00')#:#NumberFormat(DatePart('n', ThisArrivedAt), '00')#">
            <!---FORM.LockedBit field not needed for edits, can only lock form when adding for first time--->
            <!---SUBMIT FORM--->
            <cfif StructKeyExists(FORM, "ButtonModalSubmit")>
                <cfinclude template="/controllers/includes/_AnimalsAddEdit02.cfm">
                <!---ERRORS--->
                <cfif !ArrayIsEmpty(ErrorArray)>
                    <cfinclude template="/controllers/includes/_AnimalsAddEdit03.cfm">
                <!---NO ERRORS--->
                <cfelse>
                    <cfinclude template="/controllers/includes/_AnimalsAddEdit04.cfm">
                    <!---If it's a Replace or Delete then delete the old file, Model will still have the older file set since the set calls below have yet to be called--->
                    <cfif FORM.KeepReplaceDeleteFile EQ "Delete" OR FORM.KeepReplaceDeleteFile EQ "Replace">
                        <cftry>
                            <cffile action="delete" file="#ExpandPath('./')#/files/#Model.getFileUUIDAvatar()#">
                            <cfcatch></cfcatch>
                        </cftry>
                    </cfif>
                    <!---Already have the "UserModel" so set the updated form values to the model--->
                    <cfset Model.setName(FORM.Name)>
                    <cfset Model.setKeeperID(FORM.KeeperID)>
                    <cfset Model.setAreaID(IIF(FORM.AreaID NEQ "", "FORM.AreaID", "JavaCast('Null', '')"))>
                    <cfset Model.setSpecies(FORM.Species)>
                    <cfset Model.setDOB(FORM.DOBYear & "-" & FORM.DOBMonth & "-" & FORM.DOBDay)>
                    <cfset Model.setGender(FORM.Gender)>
                    <cfset Model.setTypeID(FORM.TypeID)>
                    <cfset Model.setNotes(IIF(FORM.Notes EQ "", "", "FORM.Notes"))>
                    <cfset Model.setSpecialDietBit(FORM.SpecialDietBit)>
                    <cfset Model.setSpecialDiet(IIF(FORM.SpecialDietBit EQ 1, "FORM.SpecialDiet", ""))>
                    <cfset Model.setFavoriteColor(IIF(FORM.FavoriteColor NEQ "", "FORM.FavoriteColor", ""))>
                    <cfset Model.setFavoriteColorExplain(IIF(FORM.FavoriteColor NEQ "", "FORM.FavoriteColorExplain", ""))>
                    <!---Not using IIF cause if it's a Keep then no need to do a set call on FileUUIDAvatar or FileCleanAvatar--->
                    <cfif FORM.KeepReplaceDeleteFile EQ "Delete">
                        <cfset Model.setFileUUIDAvatar("")>
                        <cfset Model.setFileCleanAvatar("")>
                    <!---Checking for file result and FileWasSaved covers both cases of a replace and a new file for the first time since it's not required--->
                    <cfelseif IsDefined("REQUEST.FileUUIDAvatarResult") AND REQUEST.FileUUIDAvatarResult.FileWasSaved>
                        <cfset Model.setFileUUIDAvatar(ThisFileUUIDAvatar)>
                        <cfset Model.setFileCleanAvatar(ThisFileCleanAvatar)>
                    </cfif>
                    <!---User will be selecting date time in their current time zone so convert to UTC--->
                    <cfset Model.setArrivedAt(APPLICATION.Inst.DateTimeTimeZoneToUTC(DateTime=FORM.ArrivedAtYear & "-" & FORM.ArrivedAtMonth & "-" & FORM.ArrivedAtDay & " " & FORM.ArrivedAtTime & ":00", Format="DateTimeForDB"))>
                    <!---Flush ORM for sets and updates--->
                    <cfset ORMFlush()>
                    <cfset StructDelete(SESSION, "AlertPageTop")>
                    <cfset SESSION.AlertPageTop = "col-12~success~Animal <strong>#Model.getName()#</strong> has been edited.">
                    <!---Make sure to add "URL.Start" to cflocation params--->
                    <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=animal&id=#Model.getID()#&pageaction=view&start=#URL.Start#" addtoken="false">
                </cfif>
            </cfif>
        <!---BUILD PDF==============================================================================================--->
        <cfelseif URL.PageAction EQ "buildpdf">
            <!---Setting REQUEST.ReqStr.BuildPDF to true to tell "_Header.cfm" and "_Footer.cfm" files to leave navs off since building a report--->
            <cfset REQUEST.ReqStr.BuildPDF = true>
            <!---Used to name the pdf file--->
            <cfset FileUUIDProfile = CreateUUID()>
            <!---Use "cfsavecontent" to put the report into "HTML" format which will then be converted to "PDF" by "wkhtmltopdf"--->
            <cfsavecontent variable="HTMLReport">
                <cfinclude template="/views/includes/_Header.cfm">
                <div class="container">
                    <cfinclude template="/views/animals/includes/_ViewAnimal.cfm">
                </div>
                <cfinclude template="/views/includes/_Footer.cfm">
            </cfsavecontent>
            <!---Writing to tmp S3 public directory to access URL to convert "HTML" to "PDF"--->
            <cffile action="write" mode="664" file="#ExpandPath('./')#/files/#FileUUIDProfile#.html" addnewline="true" output="#HTMLReport#">
            <!---
            -Have to use "ExpandPath", mapping doesn't work for "cfexecute"
            -"APPLICATION.MainFQDNTopLevelDomain" is "pushpullit.com" or "pushpullitlocal.com" so use "ListFirst" to get "pushpullit" or "pushpullitlocal" which corresponds to file name cause image paths are hard coded
            -Some of the parameters include:
                -Header file to use which contains a hardcoded path to the header image
                    --header-html #APPLICATION.Protocol##APPLICATION.BucketPublicCNAME#/#REQUEST.ReqStr.FQDNDetailQuery.FQDNID#/html/#ListFirst(APPLICATION.MainFQDNTopLevelDomain, '.')#-v02.html
                -S3 tmp directory where the temporary HTML version of the report is stored before converting it to PDF
                    -#APPLICATION.Protocol##APPLICATION.BucketPublicCNAME#/#REQUEST.ReqStr.FQDNDetailQuery.FQDNID#/tmp/#FileUUIDProfile#.html
                -Local EC2 server path to the generated PDF which is in a tmp folder before it gets pushed to it's final private S3 bucket location
                    -#ExpandPath('.././')#codebase/files/#REQUEST.ReqStr.FQDNDetailQuery.FQDNID#/tmp/#FileUUIDProfile#.pdf
            -Can also pass parameters such as size by doing:
                --viewport-size 1200x1080
                --image-quality 100
                etc.
            --->
            <cfexecute name="wkhtmltopdf" arguments="-B 0 -L 0 -R 0 -T 29 --header-spacing 3 --header-line --title 'Animal' --disable-smart-shrinking --header-html http://#getPageContext().getRequest().getServerName()#/pdfheader.html http://#getPageContext().getRequest().getServerName()#/files/#FileUUIDProfile#.html #ExpandPath('./')#/files/#FileUUIDProfile#.pdf" timeout="999"></cfexecute>
            <!---Now delete the local HTML copy of the report used to make the PDF--->
            <cffile action="delete" file="#ExpandPath('./')#/files/#FileUUIDProfile#.html">
            <!---Set REQUEST.ReqStr.BuildPDF back to false since user might be redirected to a view page after PDF generation is complete--->
            <cfset REQUEST.ReqStr.BuildPDF = false>
        <!---DELETE RECORD==========================================================================================--->
        <cfelseif URL.PageAction EQ "delete">
            <!---SUBMIT FORM--->
            <cfif StructKeyExists(FORM, "ButtonModalSubmit")>
                <!---Should also delete any avatar files here, but not doing that yet--->
                <!---Set DeletedAt to REQUEST.ReqStr.UTCNow--->
                <cfset Model.setDeletedAt(REQUEST.ReqStr.UTCNow)>
                <!---Update--->
                <cfset EntitySave(Model)>
                <!---Flush ORM for sets and updates--->
                <cfset ORMFlush()>
                <cfset StructDelete(SESSION, "AlertPageTop")>
                <cfset SESSION.AlertPageTop = "col-12~success~Animal <strong>#Model.getName()#</strong> has been successfully deleted.">
                <cflocation url="/index.cfm?controller=#REQUEST.controller#&action=animals&start=#URL.Start#" addtoken="false">
            </cfif>
        </cfif>
    </cffunction>

</cfcomponent>