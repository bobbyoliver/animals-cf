<cfoutput>
            </select>
            <cfif FormHelpText NEQ ""><small class="form-text text-muted">#FormHelpText#</small></cfif>
            <!---"small" tag and/or class didn't work in any way shape or form here so set font-size to 80% to match the help text size--->
            <cfif FormErrorDisplay NEQ false>
                <div id="#FormFieldName#Error" class="my-0<cfif IsDefined('ErrorArray')><cfloop array='#ErrorArray#' index='i'><cfif i.Property EQ FormFieldName> invalid-feedback</cfif></cfloop></cfif>" style="height:20px; font-size:80%;">
                    <span id="#FormFieldName#AjaxError"></span>
                    <cfif IsDefined("ErrorArray")>
                        <cfloop array="#ErrorArray#" index="i">
                            <cfif i.Property EQ FormFieldName>
                                <span id="#FormFieldName#ServerError">#i.Message#</span>
                            </cfif>
                        </cfloop>
                    </cfif>
                </div>
            </cfif>
        </div>
    </div>
</cfoutput>