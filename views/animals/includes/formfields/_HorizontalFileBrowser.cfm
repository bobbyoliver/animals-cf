<!---
-Can be empty: no variables can be empty

<!---FileUUIDAvatar--->
<cfset FormModelName = "Animal">
<cfset FormFieldName = "FileUUIDAvatar">
<cfset FormLabelDisplay = "Upload Avatar">
<cfset FormClasses = "col-12">
<cfset FormHelpText = "Must be an image file (bmp, gif, ico, jpeg, jpg, png).">
<cfset FormFieldRequired = true>
<cfinclude template="/views/animals/includes/formfields/_HorizontalFileBrowser.cfm">
--->
<cfoutput>
    <div class="#FormClasses#">
        <div class="form-group row mb-2">
            <label for="id_#FormFieldName#_#FormModelName#" class="col-12 col-lg-4 col-xl-2 text-left text-lg-right col-form-label<cfif FormSize NEQ ''> col-form-label-#FormSize#</cfif>"><cfif FormFieldRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FormLabelDisplay#</strong></label>
            <div class="col-12 col-lg-8 col-xl-6">
                <!---Not ajax validating with "AjaxValidateFieldBlur" since file needs to be uploaded to validate--->
                <input id="id_#FormFieldName#_#FormModelName#" class="form-control-file<cfif FormSize NEQ ''> form-control-#FormSize# pl-0</cfif><cfif IsDefined('ErrorArray')><cfloop array='#ErrorArray#' index='i'><cfif i.Property EQ FormFieldName> is-invalid</cfif></cfloop></cfif>" type="file" name="#FormFieldName#">
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