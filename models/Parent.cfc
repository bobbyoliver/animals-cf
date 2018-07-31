<!---
PreInsert
PreUpdate
ServerValidateFields
ValidateBase
ValidateFileUpload
GetMIMETypeList
StripTrailingNumbersFromString
GetSpecificField
--->

<cfcomponent displayname="ParentModel" output="false" hint="Parent model inherited by some of the models.">

    <!---PreInsert--->
    <cffunction name="PreInsert" access="public" returntype="void" output="false" hint="ORM event handling that runs before entity is inserted">
        <cfset THIS.setCreatedAt(REQUEST.ReqStr.UTCNow)>
        <cfset THIS.setUpdatedAt(REQUEST.ReqStr.UTCNow)>
        <cfreturn>
    </cffunction>



    <!---PreUpdate--->
    <cffunction name="PreUpdate" access="public" returntype="void" output="false" hint="ORM event handling that runs before entity is updated">
        <cfset THIS.setUpdatedAt(REQUEST.ReqStr.UTCNow)>
        <cfreturn>
    </cffunction>



    <!---ServerValidateFields--->
    <!---
    -FormFieldsToValidateList - list of form fields to be validated
    -FormFieldsRequiredList - list of fields that are required, passed as an argument cause sometimes the same field in different forms is required or not required
    -FormFieldsExtraList - list of fields that need passed to assist in validation but not calling validation on these fields
    -Returns an array of structures, each structure has ErrorStruct.Property and ErrorStruct.Message
    --->
    <cffunction name="ServerValidateFields" access="public" returntype="array" output="false" hint="Server side validation function that calls individual form field validation functions">
        <cfargument name="FormFieldsToValidateList" type="string" required="true">
        <cfargument name="FormFieldsRequiredList" type="string" required="false" default="">
        <cfargument name="FormFieldsExtraList" type="string" required="false" default="">
        <!---Check CSRFVerifyToken to protect against cross site scripting attacks--->
        <cfif !CSRFVerifyToken(FORM.CSFRTokenToCheck, APPLICATION.Key)>
            <cfinvoke component="/udfs/Invoke" method="DisplayMessage">
                <cfinvokeargument name="MessageType" value="InvalidURL">
            </cfinvoke>
        </cfif>
        <cfset var ErrorArray = ArrayNew(1)>
        <cfset var ErrorStruct = StructNew()>
        <!---Variable name for combined form fields serialized string--->
        <cfset var SerializedFormFieldString = "">
        <!---Combine "ToValidate" and "Extra" arguments lists to loop over and serialize entire list--->
        <cfset var CombinedLists = ListAppend(ARGUMENTS.FormFieldsToValidateList, ARGUMENTS.FormFieldsExtraList)>
        <!---Loop "CombinedLists" list to create serialized form field string to match same format of serialized string ajax JS validation sends--->
        <cfloop list="#CombinedLists#" index="i">
            <!---URL encode and Trim each form field separately to maintain ampersand that separates each field, no need to encode form field name--->
            <cfset SerializedFormFieldString = SerializedFormFieldString & i & "=" & URLEncodedFormat(Trim(FORM[i])) & "&">
        </cfloop>
        <!---Remove last unneeded ampersand character which will always be added above--->
        <cfset SerializedFormFieldString = Mid(SerializedFormFieldString, 1, Len(SerializedFormFieldString)-1)>
        <!---At one point used "j" here instead of "i" in Railo cause "i" was passing the same property over and over, seems like it was a Railo bug--->
        <!---IMPORTANT! - still exists in Lucee, 2016-01-13 - switched back to "j" to fix some server side error message display errors--->
        <cfloop list="#ARGUMENTS.FormFieldsToValidateList#" index="j">
            <!---
            -Calling custom StripTrailingNumbersFromString function here in Parent Model instead of REReplace to only strip numbers from end of form field names allowing form fields to have numbers within their names just not on the end
            -Form fields can use numbers on the ends of the names to represent multiple of same type of form field and the number will be stripped to call validation
            -Message=.... are function calls: e.g.: ValidateFirstName(), ValidateLastName(), etc. for form fields that are passed via the FormFieldsToValidateList argument
            -Calling Trim on form field argument before passing it prevents having to call Helpers TrimFormFields function and from having to trim in individual fields
            -Removed ValidationType='server' argument, was used for testing at one time
            -Old REReplace Code: <cfset Message = Evaluate("Validate#REReplace(j, '[0-9]', '', 'All')#(FormField=j, FormValue=Trim(FORM[j]), SerializedFormFields=SerializedFormFieldString, IsRequired=IIF(ListFindNoCase(ARGUMENTS.FormFieldsRequiredList, j), true, false))")>
            --->
            <cfset Message = Evaluate("Validate#StripTrailingNumbersFromString(j)#(FormField=j, FormValue=Trim(FORM[j]), SerializedFormFields=SerializedFormFieldString, IsRequired=IIF(ListFindNoCase(ARGUMENTS.FormFieldsRequiredList, j), true, false))")>
            <!---If Message isn't empty then we have an error so add the error to the error array--->
            <cfif Message NEQ "">
                <cfset ErrorStruct.Property = j>
                <cfset ErrorStruct.Message = Message>
                <cfset ArrayAppend(ErrorArray, Duplicate(ErrorStruct))>
            </cfif>
        </cfloop>
        <cfreturn ErrorArray>
    </cffunction>



    <!---ValidateBase--->
    <cffunction name="ValidateBase" access="public" returntype="string" output="false" hint="Base validation function for server side and ajax call">
        <cfargument name="FormValue" required="true">
        <cfargument name="Required" required="false" default="false">
        <cfargument name="MaxLength" required="false" default="">
        <cfargument name="IsValidType" required="false" default="">
        <cfargument name="OptionsList" required="false" default="">
        <cfset var Message = "">
        <!---Required--->
        <cfif ARGUMENTS.Required EQ true>
            <cfif !Len(ARGUMENTS.FormValue)>
                <cfset Message = "Field is required.">
            </cfif>
        </cfif>
        <!---MaxLength--->
        <!---Checking if Message is "" cause only want to return one error at a time--->
        <cfif Message EQ "" AND ARGUMENTS.MaxLength NEQ "">
            <cfif Len(ARGUMENTS.FormValue) GT ARGUMENTS.MaxLength>
                <cfset Message = "Field must be #ARGUMENTS.MaxLength# characters or less.">
            </cfif>
        </cfif>
        <!---IsValidType--->
        <!---Checking if Message is "" cause only want to return one error at a time--->
        <!---If ARGUMENTS.Required is false then the selection can be "" in addition to a valid type--->
        <!---If ARGUMENTS.Required is true then error has already been handled above, so if it is required it's not empty here--->
        <cfif Message EQ "" AND ARGUMENTS.IsValidType NEQ "">
            <cfif (ARGUMENTS.Required EQ true AND ARGUMENTS.IsValidType EQ "Integer" AND !IsValid("Integer", ARGUMENTS.FormValue)) OR (ARGUMENTS.Required EQ false AND ARGUMENTS.IsValidType EQ "Integer" AND !IsValid("Integer", ARGUMENTS.FormValue) AND ARGUMENTS.FormValue NEQ "")>
                <cfset Message = "Field is an invalid selection.">
            <cfelseif (ARGUMENTS.Required EQ true AND ARGUMENTS.IsValidType EQ "Email" AND !IsValid("Email", ARGUMENTS.FormValue)) OR (ARGUMENTS.Required EQ false AND ARGUMENTS.IsValidType EQ "Email" AND !IsValid("Email", ARGUMENTS.FormValue) AND ARGUMENTS.FormValue NEQ "")>
                <cfset Message = "Must be a valid email address.">
            <cfelseif (ARGUMENTS.Required EQ true AND ARGUMENTS.IsValidType EQ "Date" AND !IsValid("Date", ARGUMENTS.FormValue)) OR (ARGUMENTS.Required EQ false AND ARGUMENTS.IsValidType EQ "Date" AND !IsValid("Date", ARGUMENTS.FormValue) AND ARGUMENTS.FormValue NEQ "")>
                <cfset Message = "Must be a valid date.">
            </cfif>
        </cfif>
        <!---OptionsList--->
        <!---Checking if Message is "" cause only want to return one error at a time--->
        <!---If ARGUMENTS.Required is false then the selection can be "" in addition to any value in ARGUMENTS.OptionsList--->
        <!---If ARGUMENTS.Required is true then error has already been handled above, so if it is required it's not empty here--->
        <cfif Message EQ "" AND ARGUMENTS.OptionsList NEQ "">
            <cfif (ARGUMENTS.Required EQ true AND !ListFindNoCase(ARGUMENTS.OptionsList, ARGUMENTS.FormValue)) OR (ARGUMENTS.Required EQ false AND !ListFindNoCase(ARGUMENTS.OptionsList, ARGUMENTS.FormValue) AND ARGUMENTS.FormValue NEQ "")>
                <cfset Message = "Field is an invalid selection.">
            </cfif>
        </cfif>
        <cfreturn Message>
    </cffunction>



    <!---ValidateFileUpload--->
    <cffunction name="ValidateFileUpload" access="public" returntype="string" output="false" hint="Validates uploaded files across models">
        <cfargument name="FileFormField" required="true">
        <cfargument name="FileFormValue" required="true">
        <cfargument name="FileUploadPath" required="true">
        <!---Max file size, e.g.: 7mb=7340032, 12mb=12582912, 15mb=15728640, 20mb=20971520--->
        <cfargument name="MaxSize" required="false" default="12582912,12mb">
        <!---Default list of allowed extensions--->
        <cfargument name="ExtensionList" required="false" default="7z,csv,doc,docx,gif,html,ico,jpeg,jpg,pdf,png,pps,ppsx,ppt,pptx,rar,rtf,tif,txt,xls,xlsx,zip">
        <!---File is not required by default, but if true is passed then check that user selected a file--->
        <cfargument name="FileIsRequired" required="false" default="false">
        <cfset var Message = "">
        <cfif ARGUMENTS.FileIsRequired EQ true AND !Len(ARGUMENTS.FileFormValue)>
            <cfset Message = "Please select a file.">
        <cfelse>
            <!---Call GetMIMETypeList to build correct MIME Type list based on ExtensionList argument--->
            <!---Put file in REQUEST scope to access info in controller, variable naming convention will be "REQUEST.FileUUIDAvatarResult" where "FileUUIDAvatar" is the form field name--->
            <cftry>
                <!---664 gives the file proper permissions but the owner is still root--->
                <cffile action="upload" mode="664" filefield="#ARGUMENTS.FileFormField#" destination="#ARGUMENTS.FileUploadPath#" nameconflict="makeunique" result="REQUEST.#ARGUMENTS.FileFormField#Result" accept="#GetMIMETypeList(#ARGUMENTS.ExtensionList#)#">
                <cfcatch>
                    <!---More accurate to check MIME Type versus only checking the extension so if CFCatch.Message contains the below phrases we know it's an incrorrect file type based on the MIME type--->
                    <cfif FindNoCase("The MIME type of the uploaded file", CFCatch.Message) AND FindNoCase("was not accepted by the server", CFCatch.Message)>
                        <cfset Message = "File type is not allowed, invalid MIME type.">
                    <!---This is more serious programming error so going to send an email and redirect user to message page--->
                    <cfelse>
                        Would call custom error function here, but didn't move it over to this demo.
                        <cfabort>
                        <!---
                        <cfinvoke component="/udfs/Error" method="CustomError">
                            <cfinvokeargument name="ErrorType" value="FileUploadError">
                            <cfinvokeargument name="FilePath" value="/models/Parent">
                            <cfinvokeargument name="FunctionName" value="ValidateFileUpload">
                            <cfinvokeargument name="CFCatch" value="#CFCatch#">
                        </cfinvoke>
                        --->
                    </cfif>
                </cfcatch>
            </cftry>
            <!---Only need to check additional errors of extension and file size if Message is still empty, file was uploaded and saved--->
            <cfif Message EQ "" AND IsDefined("REQUEST." & ARGUMENTS.FileFormField & "Result") AND Evaluate("REQUEST." & ARGUMENTS.FileFormField & "Result.FileWasSaved") EQ true>
                <!---Check attachment size is not larger than allowed size--->
                <cfif Evaluate("REQUEST." & ARGUMENTS.FileFormField & "Result.FileSize") GT ListFirst(ARGUMENTS.MaxSize)>
                    <cfset Message = "File size cannot be larger than #ListLast(ARGUMENTS.MaxSize)#.">
                <!---Leaving this check in for valid extension, but this should be caught by the MIME Type check above 99.9% of the time--->
                <cfelseif !ListFindNoCase(ARGUMENTS.ExtensionList, Evaluate('REQUEST.' & ARGUMENTS.FileFormField & 'Result.ServerFileExt'))>
                    <cfset Message = "File type is not allowed, invalid extension.">
                </cfif>
            <!---No need for an additional check cause file should always have been uploaded by this point, if it wasn't the cfcatch above with the upload would've handled it--->
            </cfif>
            <!---Could delete file here if there were errors with the upload, but makes more sense to delete file after complete form validation in case other fields had errors and a successful upload still needs deleted--->
        </cfif>
        <!---Returning Message whether it's empty or not--->
        <cfreturn Message>
    </cffunction>



    <!---GetMIMETypeList--->
    <!---
    -Used this site to pull all MIME Types for the file types below: http://filext.com/
    -Multiple of the types are overlapping and duplicated within the list, but that's fine, makes it easier to maintain this commented out list of the MIME Types over time
    -Added application/x-tika-ooxml to docx and xlsx for linux upload issue, http://filext.com/ didn't have this listed to go with docx and xlsx
    -MIME Types
    7z   - application/x-7z-compressed
    csv  - text/comma-separated-values,text/csv,application/csv,application/excel,application/vnd.ms-excel,application/vnd.msexcel,text/anytext
    doc  - application/msword,application/doc,appl/text,application/vnd.msword,application/vnd.ms-word,application/winword,application/word,application/x-msw6,application/x-msword
    docx - application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/x-tika-ooxml
    gif  - image/gif,image/x-xbitmap,image/gi_
    html - text/html,text/plain
    ico  - image/ico,image/x-icon,application/ico,application/x-ico,application/x-win-bitmap,image/x-win-bitmap,application/octet-stream
    jpeg - image/jpeg,image/jpg,image/jpe_,image/pjpeg,image/vnd.swiftview-jpeg
    jpg  - image/jpeg,image/jpg,image/jp_,application/jpg,application/x-jpg,image/pjpeg,image/pipeg,image/vnd.swiftview-jpeg,image/x-xbitmap
    pdf  - application/pdf,application/x-pdf,application/acrobat,applications/vnd.pdf,text/pdf,text/x-pdf
    png  - image/png,application/png,application/x-png
    pps  - application/vnd.ms-powerpoint
    ppsx - application/vnd.openxmlformats-officedocument.presentationml.slideshow
    ppt  - application/vnd.ms-powerpoint,application/mspowerpoint,application/ms-powerpoint,application/mspowerpnt,application/vnd-mspowerpoint,application/powerpoint,application/x-powerpoint,application/x-m
    pptx - application/vnd.openxmlformats-officedocument.presentationml.presentation
    rar  - application/x-rar-compressed,application/octet-stream
    rtf  - application/rtf,application/x-rtf,text/rtf,text/richtext,application/msword,application/doc,application/x-soffice
    tif  - image/tif,image/x-tif,image/tiff,image/x-tiff,application/tif,application/x-tif,application/tiff,application/x-tiff
    txt  - text/plain,application/txt,browser/internal,text/anytext,widetext/plain,widetext/paragraph
    xls  - application/vnd.ms-excel,application/msexcel,application/x-msexcel,application/x-ms-excel,application/vnd.ms-excel,application/x-excel,application/x-dos_ms_excel,application/xls
    xlsx - application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/x-tika-ooxml
    zip  - application/zip,application/x-zip,application/x-zip-compressed,application/octet-stream,application/x-compress,application/x-compressed,multipart/x-zip
    --->
    <cffunction name="GetMIMETypeList" access="public" returntype="string" output="false" hint="Creates a MIME Type list based on ExtensionList argument">
        <cfargument name="ExtensionList" required="true">
        <cfset var MIMETypeList = "">
        <cfloop list="#ARGUMENTS.ExtensionList#" index="i">
            <cfif i EQ "7z">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/x-7z-compressed")>
            <cfelseif i EQ "csv">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "text/comma-separated-values,text/csv,application/csv,application/excel,application/vnd.ms-excel,application/vnd.msexcel,text/anytext")>
            <cfelseif i EQ "doc">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/msword,application/doc,appl/text,application/vnd.msword,application/vnd.ms-word,application/winword,application/word,application/x-msw6,application/x-msword")>
            <cfelseif i EQ "docx">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/x-tika-ooxml")>
            <cfelseif i EQ "gif">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "image/gif,image/x-xbitmap,image/gi_")>
            <cfelseif i EQ "html">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "text/html,text/plain")>
            <cfelseif i EQ "ico">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "image/ico,image/x-icon,application/ico,application/x-ico,application/x-win-bitmap,image/x-win-bitmap,application/octet-stream")>
            <cfelseif i EQ "jpeg">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "image/jpeg,image/jpg,image/jpe_,image/pjpeg,image/vnd.swiftview-jpeg")>
            <cfelseif i EQ "jpg">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "image/jpeg,image/jpg,image/jp_,application/jpg,application/x-jpg,image/pjpeg,image/pipeg,image/vnd.swiftview-jpeg,image/x-xbitmap")>
            <cfelseif i EQ "pdf">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/pdf,application/x-pdf,application/acrobat,applications/vnd.pdf,text/pdf,text/x-pdf")>
            <cfelseif i EQ "png">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "image/png,application/png,application/x-png")>
            <cfelseif i EQ "pps">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.ms-powerpoint")>
            <cfelseif i EQ "ppsx">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.openxmlformats-officedocument.presentationml.slideshow")>
            <cfelseif i EQ "ppt">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.ms-powerpoint,application/mspowerpoint,application/ms-powerpoint,application/mspowerpnt,application/vnd-mspowerpoint,application/powerpoint,application/x-powerpoint,application/x-m")>
            <cfelseif i EQ "pptx">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.openxmlformats-officedocument.presentationml.presentation")>
            <cfelseif i EQ "rar">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/x-rar-compressed,application/octet-stream")>
            <cfelseif i EQ "rtf">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/rtf,application/x-rtf,text/rtf,text/richtext,application/msword,application/doc,application/x-soffice")>
            <cfelseif i EQ "tif">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "image/tif,image/x-tif,image/tiff,image/x-tiff,application/tif,application/x-tif,application/tiff,application/x-tiff")>
            <cfelseif i EQ "txt">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "text/plain,application/txt,browser/internal,text/anytext,widetext/plain,widetext/paragraph")>
            <cfelseif i EQ "xls">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.ms-excel,application/msexcel,application/x-msexcel,application/x-ms-excel,application/vnd.ms-excel,application/x-excel,application/x-dos_ms_excel,application/xls,application/x-tika-msoffice")>
            <cfelseif i EQ "xlsx">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/x-tika-ooxml")>
            <cfelseif i EQ "zip">
                <cfset MIMETypeList = ListAppend(MIMETypeList, "application/zip,application/x-zip,application/x-zip-compressed,application/octet-stream,application/x-compress,application/x-compressed,multipart/x-zip")>
            </cfif>
        </cfloop>
        <cfreturn MIMETypeList>
    </cffunction>



    <!---StripTrailingNumbersFromString--->
    <!---Created function so form fields could contain numbers within their names, but trailing numbers would still be stripped to help with validation calls--->
    <!---Function is in this ParentModel so ServerValidateFields can call it shorthand without having to call cfinvoke--->
    <cffunction name="StripTrailingNumbersFromString" access="public" returntype="string" output="false" hint="Strips integers from end of string by looping each character in reverse">
        <cfargument name="Str" type="string" required="true">
        <!---Set a new string to the original string to return--->
        <cfset var NewString = ARGUMENTS.Str>
        <cfset var StringChar = "">
        <!---Looping the string in reverse by using step -1--->
        <cfloop index="i" to="1" from="#Len(ARGUMENTS.Str)#" step="-1">
            <!---Get first character which is actually last character--->
            <cfset StringChar = Mid(ARGUMENTS.Str, i, 1)>
            <!---If character is numeric then strip it--->
            <cfif IsNumeric(StringChar)>
                <cfset NewString = Mid(NewString, 1, Len(NewString)-1)>
            <!---As soon as come to a character that's not numeric then break loop--->
            <cfelse>
                <cfbreak>
            </cfif>
        </cfloop>
        <cfreturn NewString>
    </cffunction>



    <!---GetSpecificField--->
    <cffunction name="GetSpecificField" access="public" returntype="string" output="false" hint="Returns value of a specific requested form field">
        <cfargument name="SerializedFormFields" required="true">
        <cfargument name="RequestedField" required="true">
        <!---Set ThisRequestedField to empty cause it's returned no matter what--->
        <cfset var ThisRequestedField = "">
        <!---Call ListToStruct on form fields--->
        <cfinvoke component="/udfs/Helpers" method="ListToStruct" returnvariable="FormFieldsStruct">
            <!---URL decode the entire string at once to replace characters like "%2B", which is a space, with their character equivalent--->
            <cfinvokeargument name="List" value="#URLDecode(ARGUMENTS.SerializedFormFields)#">
            <cfinvokeargument name="Delimiter" value="&">
        </cfinvoke>
        <!---Loop FormFieldsStruct to get the other form field value needed for validation--->
        <cfloop collection="#FormFieldsStruct#" item="i">
            <cfif i EQ ARGUMENTS.RequestedField>
                <cfset ThisRequestedField = Trim(FormFieldsStruct[i])>
                <cfbreak>
            </cfif>
        </cfloop>
        <cfreturn ThisRequestedField>
    </cffunction>

</cfcomponent>