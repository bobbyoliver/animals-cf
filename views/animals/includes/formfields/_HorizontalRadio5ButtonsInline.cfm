<!---
-Can be empty: FormHelpText, FormAjaxClasses, FormSize
-"FormAjaxClasses" is mainly set to "AjaxValidateFieldClick" to help remove the error message via ajax when the radio has been validated server side, if radio is set to a default can then leave "FormAjaxClasses" empty
-First 2 radio buttons are required, but starting with the third we're checking for existence
-If "FormValueDisabledX" is true then going to mute the radio label too
-For booleans use 1|0 instead of true, false or t|f etc. for the actual "FormValue" values

<!---Gender--->
<cfset FormModelName = "Animal">
<cfset FormFieldName = "Gender">
<cfset FormLabelDisplay = "Gender">
<cfset FormHelpText = "">
<cfset FormFieldRequired = true>
<cfset FormAjaxClasses = "AjaxValidateFieldClick">
<cfset FormSize = ""> sm|lg
<cfset FormValue1 = "m">
<cfset FormLabel1 = "Male">
<cfset FormValueDisabled1 = false>
<cfset FormValue2 = "f">
<cfset FormLabel2 = "Female">
<cfset FormValueDisabled2 = false>
<cfset FormFullWidth = false>
<cfinclude template="/views/animals/includes/formfields/_HorizontalRadio5ButtonsInline.cfm">
--->
<cfoutput>
    <div class="col-12">
        <div class="form-group row mb-2">
            <label for="id_#FormFieldName#_#FormModelName#" class="col-12<cfif FormFullWidth EQ false> col-lg-4 col-xl-2 text-left text-lg-right</cfif> col-form-label<cfif FormSize NEQ ''> col-form-label-#FormSize#</cfif>"><cfif FormFieldRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FormLabelDisplay#</strong></label>
            <div class="col-12<cfif FormFullWidth EQ false> col-lg-8 col-xl-6</cfif>">
                <div class="form-check form-check-inline">
                    <input id="id_#FormFieldName#_#FormValue1#_#FormModelName#" class="form-check-input<cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif>" type="radio" name="#FormFieldName#" value="#FormValue1#"<cfif Evaluate("FORM." & FormFieldName) EQ FormValue1> checked</cfif><cfif FormValueDisabled1 EQ true> disabled</cfif>>
                    <label class="form-check-label" for="id_#FormFieldName#_#FormValue1#_#FormModelName#">
                        <cfif FormValueDisabled1 EQ true><span class="text-muted"></cfif><cfif FormSize EQ "sm"><small></cfif>#FormLabel1#<cfif FormSize EQ "sm"></small></cfif><cfif FormValueDisabled1 EQ true></span></cfif>
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <input id="id_#FormFieldName#_#FormValue2#_#FormModelName#" class="form-check-input<cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif>" type="radio" name="#FormFieldName#" value="#FormValue2#"<cfif Evaluate("FORM." & FormFieldName) EQ FormValue2> checked</cfif><cfif FormValueDisabled2 EQ true> disabled</cfif>>
                    <label class="form-check-label" for="id_#FormFieldName#_#FormValue2#_#FormModelName#">
                        <cfif FormValueDisabled2 EQ true><span class="text-muted"></cfif><cfif FormSize EQ "sm"><small></cfif>#FormLabel2#<cfif FormSize EQ "sm"></small></cfif><cfif FormValueDisabled2 EQ true></span></cfif>
                    </label>
                </div>
                <!---3 is optional--->
                <cfif IsDefined("FormValue3") AND FormValue3 NEQ "" AND IsDefined("FormLabel3") AND FormLabel3 NEQ "">
                    <div class="form-check form-check-inline">
                        <input id="id_#FormFieldName#_#FormValue3#_#FormModelName#" class="form-check-input<cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif>" type="radio" name="#FormFieldName#" value="#FormValue3#"<cfif Evaluate("FORM." & FormFieldName) EQ FormValue3> checked</cfif><cfif FormValueDisabled3 EQ true> disabled</cfif>>
                        <label class="form-check-label" for="id_#FormFieldName#_#FormValue3#_#FormModelName#">
                            <cfif FormValueDisabled3 EQ true><span class="text-muted"></cfif><cfif FormSize EQ "sm"><small></cfif>#FormLabel3#<cfif FormSize EQ "sm"></small></cfif><cfif FormValueDisabled3 EQ true></span></cfif>
                        </label>
                    </div>
                </cfif>
                <!---4 is optional--->
                <cfif IsDefined("FormValue4") AND FormValue4 NEQ "" AND IsDefined("FormLabel4") AND FormLabel4 NEQ "">
                    <div class="form-check form-check-inline">
                        <input id="id_#FormFieldName#_#FormValue4#_#FormModelName#" class="form-check-input<cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif>" type="radio" name="#FormFieldName#" value="#FormValue4#"<cfif Evaluate("FORM." & FormFieldName) EQ FormValue4> checked</cfif><cfif FormValueDisabled4 EQ true> disabled</cfif>>
                        <label class="form-check-label" for="id_#FormFieldName#_#FormValue4#_#FormModelName#">
                            <cfif FormValueDisabled4 EQ true><span class="text-muted"></cfif><cfif FormSize EQ "sm"><small></cfif>#FormLabel4#<cfif FormSize EQ "sm"></small></cfif><cfif FormValueDisabled4 EQ true></span></cfif>
                        </label>
                    </div>
                </cfif>
                <!---5 is optional--->
                <cfif IsDefined("FormValue5") AND FormValue5 NEQ "" AND IsDefined("FormLabel5") AND FormLabel5 NEQ "">
                    <div class="form-check form-check-inline">
                        <input id="id_#FormFieldName#_#FormValue5#_#FormModelName#" class="form-check-input<cfif FormFieldRequired EQ true> IsRequired</cfif><cfif FormAjaxClasses NEQ ''> #FormAjaxClasses#</cfif>" type="radio" name="#FormFieldName#" value="#FormValue5#"<cfif Evaluate("FORM." & FormFieldName) EQ FormValue5> checked</cfif><cfif FormValueDisabled5 EQ true> disabled</cfif>>
                        <label class="form-check-label" for="id_#FormFieldName#_#FormValue5#_#FormModelName#">
                            <cfif FormValueDisabled5 EQ true><span class="text-muted"></cfif><cfif FormSize EQ "sm"><small></cfif>#FormLabel5#<cfif FormSize EQ "sm"></small></cfif><cfif FormValueDisabled5 EQ true></span></cfif>
                        </label>
                    </div>
                </cfif>
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
<!---Set FormValueX, FormLabelX, and FormValueDisabledX back to empty to not disrupt any future included radio form fields--->
<cfloop from="1" to="5" index="i">
    <cfset "FormValue#i#" = "">
    <cfset "FormLabel#i#" = "">
    <cfset "FormValueDisabled#i#" = "">    
</cfloop>