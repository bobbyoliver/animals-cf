<cfoutput>
                </select>
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