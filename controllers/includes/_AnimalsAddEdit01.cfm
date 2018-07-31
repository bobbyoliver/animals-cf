<!---ORM - ARRAYS--->
<cfset TypeArray = EntityLoad("Type", {DeletedAt=""}, "SortOrder ASC")>
<cfset AreaArray = EntityLoad("Area", {DeletedAt=""}, "SortOrder ASC")>
<cfset KeeperArray = EntityLoad("Keeper", {DeletedAt=""}, "FirstName ASC, LastName ASC")>