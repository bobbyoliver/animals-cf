<!---
-Can be empty: FormLabelDisplay, FormHelpText, FormAjaxClasses, FormSize
-Checking if "FormLabelDisplay" is empty for rare case where displaying a single label above a set of dropdowns such as date selections of day, month, and year etc.

<!---AreaID--->
<cfset FormModelName = "Animal">
<cfset FormFieldName = "AreaID">
<cfset FormLabelDisplay = "Area">
<cfset FormClasses = "col-12 col-md-6 col-xl-4">
<cfset FormHelpText = "Area is NOT required.">
<cfset FormFieldRequired = false>
<cfset FormAjaxClasses = "AjaxValidateFieldBlur">
<cfset FormDisabled = false>
<cfset FormReadOnly = false>
<cfset FormSize = ""> sm|lg
<cfset FormErrorDisplay = false>
<cfinclude template="/views/animals/includes/formfields/_InlineSelect1.cfm">
<option value="">Select</option>
<cfloop array="#AreaArray#" index="i">
    <option value="#i.getAreaID()#"<cfif FORM.AreaID EQ i.getAreaID()> selected</cfif>>#i.getArea()#</option>
</cfloop>
<cfinclude template="/views/animals/includes/formfields/_InlineSelect2.cfm">
--->
<cfoutput>
    <div class="#FormClasses#">
        <div class="form-group<cfif FormSize EQ 'sm'> mb-0</cfif>">
            <cfif FormLabelDisplay NEQ ""><label for="id_#FormFieldName#_#FormModelName#"<cfif FormSize EQ "sm"> class="small mb-0"</cfif>><cfif FormFieldRequired EQ true><span class="text-danger">*</span> <cfelse>&nbsp;&nbsp;</cfif><strong>#FormLabelDisplay#</strong></label></cfif>
            <select id="id_#FormFieldName#_#FormModelName#" class="form-control<cfif FormSize NEQ ''> form-control-#FormSize#</cfif><cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif><cfif IsDefined('ErrorArray')><cfloop array='#ErrorArray#' index='i'><cfif i.Property EQ FormFieldName> is-invalid</cfif></cfloop></cfif>" name="#FormFieldName#"<cfif FormReadOnly EQ true> readonly</cfif><cfif FormDisabled EQ true> disabled</cfif>>
</cfoutput>