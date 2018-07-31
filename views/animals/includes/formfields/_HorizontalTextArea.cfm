<!---
Can be empty: FormHelpText, FormAjaxClasses, FormSize

<!---Notes--->
<cfset FormModelName = "Animal">
<cfset FormFieldName = "Notes">
<cfset FormLabelDisplay = "Special Notes">
<cfset FormClasses = "col-12 SpecialDietBitSH d-none">
<cfset FormHelpText = "1000 characters available for special notes.">
<cfset FormFieldRequired = true>
<cfset FormAjaxClasses = "AjaxValidateFieldBlur">
<cfset FormRows = 5>
<cfset FormSize = ""> sm|lg
<cfset FormFullWidth = false>
<cfinclude template="/views/animals/includes/formfields/_HorizontalTextArea.cfm">
--->
<cfoutput>
    <!---<div class="col-12">--->
    <div class="#FormClasses#">
        <div class="form-group row mb-2">
            <label for="id_#FormFieldName#_#FormModelName#" class="col-12<cfif FormFullWidth EQ false> col-lg-4 col-xl-2 text-left text-lg-right</cfif> col-form-label<cfif FormSize NEQ ''> col-form-label-#FormSize#</cfif>"><cfif FormFieldRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FormLabelDisplay#</strong></label>
            <div class="<cfif FormFullWidth EQ false>col-12 col-lg-8 col-xl-6<cfelseif FormFullWidth EQ true>col-12 col-lg-8</cfif>">
                <textarea id="id_#FormFieldName#_#FormModelName#" class="form-control<cfif FormSize NEQ ''> form-control-#FormSize#</cfif><cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif><cfif IsDefined('ErrorArray')><cfloop array='#ErrorArray#' index='i'><cfif i.Property EQ FormFieldName> is-invalid</cfif></cfloop></cfif>" name="#FormFieldName#" rows="#FormRows#">#Evaluate("FORM." & FormFieldName)#</textarea>
                <cfif FormHelpText NEQ ""><small class="form-text text-muted">#FormHelpText#</small></cfif>
            </div>
            <div class="col-12<cfif FormFullWidth EQ false> col-xl-4</cfif>">
                <!---Using text-danger and small here cause the built in BS "invalid-feedback" class wasn't working with horizontal forms--->
                <div id="#FormFieldName#Error" class="d-inline text-danger<cfif FormSize EQ 'sm'> small</cfif>">
                    <span id="#FormFieldName#AjaxError"></span>
                    <cfif IsDefined("ErrorArray")>
                        <cfloop array="#ErrorArray#" index="i">
                            <cfif i.Property EQ FormFieldName>
                                <span id="#FormFieldName#ServerError">#i.Message#</span>
                            </cfif>
                        </cfloop>
                    </cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>