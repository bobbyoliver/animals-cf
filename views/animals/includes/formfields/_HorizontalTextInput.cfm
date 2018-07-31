<!---
Can be empty: FormHelpText, FormAjaxClasses, FormAddOnLeft, FormAddOnRight, FormSize

<!---Name--->
<cfset FormModelName = "Animal">
<cfset FormFieldName = "Name">
<cfset FormLabelDisplay = "Name">
<cfset FormClasses = "col-12 SpecialDietBitSH d-none">
<cfset FormHelpText = "">
<cfset FormFieldRequired = true>
<cfset FormAjaxClasses = "AjaxValidateFieldBlur">
<cfset FormDisabled = false>
<cfset FormReadOnly = false>
<cfset FormMaxLength = 50>
<cfset FormAddOnLeft = "http://#getPageContext().getRequest().getServerName()#/">
<cfset FormAddOnRight = ".00">
<cfset FormSize = ""> sm|lg
<cfinclude template="/views/animals/includes/formfields/_HorizontalTextInput.cfm">
--->
<cfoutput>
    <div class="#FormClasses#">
        <div class="form-group row mb-2">
            <label for="id_#FormFieldName#_#FormModelName#" class="col-12 col-lg-4 col-xl-2 text-left text-lg-right col-form-label<cfif FormSize NEQ ''> col-form-label-#FormSize#</cfif>"><cfif FormFieldRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FormLabelDisplay#</strong></label>
            <div class="col-12 col-lg-8 col-xl-6">
                <cfif FormAddOnLeft NEQ "" OR FormAddOnRight NEQ "">
                    <div class="input-group<cfif FormSize NEQ ''> input-group-#FormSize#</cfif>">  
                </cfif>
                <cfif FormAddOnLeft NEQ "">
                    <div class="input-group-prepend">
                        <span class="input-group-text">#FormAddOnLeft#</span>
                    </div>
                </cfif>
                <input id="id_#FormFieldName#_#FormModelName#" class="form-control<cfif FormSize NEQ ''> form-control-#FormSize#</cfif><cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif><cfif IsDefined('ErrorArray')><cfloop array='#ErrorArray#' index='i'><cfif i.Property EQ FormFieldName> is-invalid</cfif></cfloop></cfif>" type="text" name="#FormFieldName#" value="#Evaluate("FORM." & FormFieldName)#" maxlength="#FormMaxLength#"<cfif FormReadOnly EQ true> readonly</cfif><cfif FormDisabled EQ true> disabled</cfif>>
                <cfif FormAddOnRight NEQ "">
                    <div class="input-group-append">
                        <span class="input-group-text">#FormAddOnRight#</span>
                    </div>
                </cfif>
                <cfif FormAddOnLeft NEQ "" OR FormAddOnRight NEQ "">
                    </div>
                </cfif>
                <cfif FormHelpText NEQ ""><small class="form-text text-muted">#FormHelpText#</small></cfif>
            </div>
            <div class="col-12 col-xl-4">
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