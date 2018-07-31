<!---URL.Search and FORM.SearchString contain same search string but have different names to help prevent collision--->
<cfparam name="URL.Search" default="">
<cfparam name="FORM.SearchString" default="">
<cfif StructKeyExists(FORM, "ButtonSubmitSearch")>
    <!---Encoding URL.Search for passing it via URL but will be decoded when querying DB, calling Trim instead of helper TrimFormFields--->
    <cfset URL.Search = URLEncodedFormat(Trim(FORM.SearchString))>
<!---If search button wasn't clicked and URL.Search isn't empty, user is paging/sorting results so put URL.Search back in FORM.SearchString to display--->
<cfelseif URL.Search NEQ "">
    <cfset FORM.SearchString = URLDecode(Trim(URL.Search))>
</cfif>