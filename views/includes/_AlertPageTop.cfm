<!---
SESSION.AlertPageTop set as:
    -"col-12 col-lg-6~danger~You have experienced an error. Administrators have been notified."
--->
<!---Page top error message doesn't have a DefaultErrorMessage option and doesn't loop an array of errors--->
<cfif StructKeyExists(SESSION, "AlertPageTop")>
    <!---success, danger, warning, or info--->
    <!---Using tilda as delimiter since some of the BS4 alert class names have a "-" in them--->
    <!---Creates similar to: AlertPageTopArray[1]=col-12, AlertPageTopArray[2]=danger, AlertPageTopArray[3]=You have experienced an error....--->
    <cfset AlertPageTopArray = ListToArray(SESSION.AlertPageTop, "~")>
    <cfoutput>
        <!---"justify-content-center" will always center the message--->
        <div class="row justify-content-center mt-2 mb-1">
            <div class="#AlertPageTopArray[1]#">
                <!---"mb-0" allows message to completely collapse when user closes it--->
                <div class="alert alert-#AlertPageTopArray[2]# alert-dismissable fade show mb-0" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <small class="pr-3">#AlertPageTopArray[3]#</small>
                </div>
            </div>
        </div>
    </cfoutput>
</cfif>