<!---
-Can be empty: FormLabelDisplay, FormHelpText, FormAjaxClasses, FormSize
-Checking if "FormLabelDisplay" is empty for rare case where displaying a single label above a set of dropdowns such as date selections of day, month, and year etc.

<!---AreaID--->
<cfset FormModelName = "Animal">
<cfset FormFieldName = "AreaID">
<cfset FormLabelDisplay = "Area">
<cfset FormClasses = "col-12 SpecialDietBitSH d-none">
<cfset FormHelpText = "Area is NOT required.">
<cfset FormFieldRequired = false>
<cfset FormAjaxClasses = "AjaxValidateFieldBlur">
<cfset FormDisabled = false>
<cfset FormReadOnly = false>
<cfset FormSize = ""> sm|lg
<cfset FormFullWidth = false>
<cfset FormAutoSubmit = false>
<cfinclude template="/views/animals/includes/formfields/_HorizontalSelect1.cfm">
<option value="">Select</option>
<cfloop array="#AreaArray#" index="i">
    <option value="#i.getAreaID()#"<cfif FORM.AreaID EQ i.getAreaID()> selected</cfif>>#i.getArea()#</option>
</cfloop>
<cfinclude template="/views/animals/includes/formfields/_HorizontalSelect2.cfm">
--->
<cfoutput>
    <div class="#FormClasses#">
        <div class="form-group row mb-2">
        	<cfif FormLabelDisplay NEQ ""><label for="id_#FormFieldName#_#FormModelName#" class="col-12<cfif FormFullWidth EQ false> col-lg-4 col-xl-2 text-left text-lg-right</cfif> col-form-label<cfif FormSize EQ 'sm'> col-form-label-sm</cfif>"><cfif FormFieldRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FormLabelDisplay#</strong></label></cfif>
        	<div class="<cfif FormFullWidth EQ false>col-12 col-lg-8 col-xl-6<cfelseif FormFullWidth EQ true>col-12 col-lg-8</cfif><cfif FormLabelDisplay EQ ''> offset-sm-2</cfif>">
        		<select id="id_#FormFieldName#_#FormModelName#" class="form-control<cfif FormSize NEQ ''> form-control-#FormSize#</cfif><cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif><cfif IsDefined('ErrorArray')><cfloop array='#ErrorArray#' index='i'><cfif i.Property EQ FormFieldName> is-invalid</cfif></cfloop></cfif><cfif FormAutoSubmit EQ true> sys-submit-on-select</cfif>" name="#FormFieldName#"<cfif FormReadOnly EQ true> readonly</cfif><cfif FormDisabled EQ true> disabled</cfif>>
        	
</cfoutput>