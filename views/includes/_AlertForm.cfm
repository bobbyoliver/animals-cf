<!---
SESSION.AlertForm set as:
    -"col-12 col-lg-6~danger~DisplayErrorArray" - Displays all errors by looping "ErrorArray"
    -"col-12 col-lg-6~danger~DefaultErrorMessage" - Displays a form top message but does not loop the "ErrorArray"
--->
<cfif StructKeyExists(SESSION, "AlertForm")>
    <!---success, danger, warning, or info--->
    <!---Using tilda as delimiter since some of the BS4 alert class names have a "-" in them--->
    <!---Creates similar to: AlertFormArray[1]=col-12, AlertFormArray[2]=danger, AlertFormArray[3]=You have experienced an error....--->
    <cfset AlertFormArray = ListToArray(SESSION.AlertForm, "~")>
    <cfoutput>
        <!---"justify-content-center" will always center the message--->
        <div class="row justify-content-center mt-2 mb-1">
            <div class="#AlertFormArray[1]#">
                <!---"mb-0" allows message to completely collapse when user closes it--->
                <div class="alert alert-#AlertFormArray[2]# alert-dismissable fade show mb-0" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <!---If SESSION.AlertForm isn't "DisplayErrorArray" & "DefaultErrorMessage" then it's custom text (success, danger, warning, info)--->
                    <cfif AlertFormArray[3] NEQ "DisplayErrorArray" AND AlertFormArray[3] NEQ "DefaultErrorMessage">
                        <small class="pr-3">#AlertFormArray[3]#</small>
                    <!---Default form top error message used for forms where form fields will be set to red by looping array and only a form top message is needed--->
                    <cfelseif AlertFormArray[3] EQ "DefaultErrorMessage" AND IsDefined("ErrorArray")>
                        <small class="pr-3">Please correct any errors below and try again.</small>
                    <!---If SESSION.AlertForm is "DisplayErrorArray" then loop and show the array of errors after the "Please try again" message--->
                    <cfelseif AlertFormArray[3] EQ "DisplayErrorArray" AND IsDefined("ErrorArray")>
                        <small>Please try again.</small>
                        <ul class="small">
                            <cfloop array="#ErrorArray#" index="i">
                                <li>#i.Message#</li>
                            </cfloop>
                        </ul>
                    </cfif>
                </div>
            </div>
        </div>
    </cfoutput>
</cfif>