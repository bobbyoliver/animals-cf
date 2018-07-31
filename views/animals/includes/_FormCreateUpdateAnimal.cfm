<cfoutput>
    <!---FORM DISPLAY--->
    <!---"form" tag must be outside "form-row" or "row" tags--->
    <cfif REQUEST.Action EQ "addanimal">
        <form id="FormCreateUpdateAnimal" role="form" action="/index.cfm?controller=animals&action=addanimal" method="post" enctype="multipart/form-data">
    <cfelseif REQUEST.Action EQ "animal">
        <form id="FormCreateUpdateAnimal" role="form" action="/index.cfm?controller=animals&action=animal&id=#Model.getID()#&pageaction=edit&start=#URL.Start#" method="post" enctype="multipart/form-data">
    </cfif>
        <div class="form-row">
            <!---
            -Using "CSRFGenerateToken" here and "CSRFVerifyToken" in validation to protect against cross-site request forgery (CSRF) attacks
            -"true" parameter tells function to create a new token even if one exists, "APPLICATION.Key" is used to salt the token
            --->
            <input name="CSFRTokenToCheck" type="hidden" value="#CSRFGenerateToken(APPLICATION.Key, true)#">
            <div class="col-12 col-lg-4 col-xl-2 mt-2">
                <p><cfif REQUEST.Action EQ "addanimal">Add<cfelseif REQUEST.Action EQ "animal">Edit</cfif> Animal</p>
            </div>
            <!---Buttons--->
            <div class="col-12 col-lg-8 col-xl-6 mb-1 mt-1 mb-lg-3 mt-lg-2 text-right">
                <button class="btn btn-outline-danger btn-sm py-0" type="button" name="ButtonCancel" data-toggle="modal" data-target="##sys-confirm-cancel">Cancel</button>
                <button class="btn btn-outline-success btn-sm py-0 ml-3 mr-xl-2" type="button" name="ButtonSubmit" data-toggle="modal" data-target="##sys-confirm-submit">Submit</button>
            </div>

            <!---Name--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "Name">
            <cfset FormLabelDisplay = "Animal Name">
            <cfset FormClasses = "col-12">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormMaxLength = 50>
            <cfset FormAddOnLeft = "">
            <cfset FormAddOnRight = "">
            <cfset FormSize = "sm">
            <cfinclude template="/views/animals/includes/formfields/_HorizontalTextInput.cfm">

            <!---KeeperID--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "KeeperID">
            <cfset FormLabelDisplay = "Keeper">
            <cfset FormClasses = "col-12">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormSize = "sm">
            <cfset FormFullWidth = false>
            <cfset FormAutoSubmit = false>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalSelect1.cfm">
            <option value="">Select:</option>
            <cfloop array="#KeeperArray#" index="i">
                <option value="#i.getID()#"<cfif FORM.KeeperID EQ i.getID()> selected</cfif>>#i.getFirstName()# #i.getLastName()#</option>
            </cfloop>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalSelect2.cfm">

            <!---AreaID--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "AreaID">
            <cfset FormLabelDisplay = "Area">
            <cfset FormClasses = "col-12">
            <cfset FormHelpText = "Is not required.">
            <cfset FormFieldRequired = false>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormSize = "sm">
            <cfset FormFullWidth = false>
            <cfset FormAutoSubmit = false>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalSelect1.cfm">
            <option value="">Select:</option>
            <cfloop array="#AreaArray#" index="i">
                <option value="#i.getID()#"<cfif FORM.AreaID EQ i.getID()> selected</cfif>>#i.getArea()#</option>
            </cfloop>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalSelect2.cfm">

            <!---Species--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "Species">
            <cfset FormLabelDisplay = "Species">
            <cfset FormClasses = "col-12">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormMaxLength = 50>
            <cfset FormAddOnLeft = "">
            <cfset FormAddOnRight = "">
            <cfset FormSize = "sm">
            <cfinclude template="/views/animals/includes/formfields/_HorizontalTextInput.cfm">

            <!---DOB--->
            <!---"_HorizontalDateTime.cfm" is different than inline and isn't already in it's own div col, but inline selects are used within the "_HorizontalDateTime.cfm" include--->
            <cfset FieldGroupModelName = "Animal">
            <cfset FieldGroupLabelDisplay = "DOB">
            <cfset FieldGroupFieldName = "DOB">
            <cfset FieldGroupYearsFrom = Year(DateConvert("local2utc", Now()))>
            <cfset FieldGroupYearsTo = Year(DateAdd('yyyy', -19, DateConvert("local2utc", Now())))>
            <cfset FieldGroupYearsStep = -1>
            <cfset FieldGroupIncludeTime = false>
            <cfset FieldGroupSize = "sm">
            <cfset FieldGroupRequired = true>
            <cfinclude template="/views/animals/includes/formfieldgroups/_HorizontalDateTime.cfm">

            <!---Gender--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "Gender">
            <cfset FormLabelDisplay = "Gender">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldClick">
            <cfset FormSize = "sm">
            <cfset FormValue1 = "m">
            <cfset FormLabel1 = "Male">
            <cfset FormValueDisabled1 = false>
            <cfset FormValue2 = "f">
            <cfset FormLabel2 = "Female">
            <cfset FormValueDisabled2 = false>
            <cfset FormFullWidth = false>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalRadio5ButtonsInline.cfm">

            <!---TypeID--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "TypeID">
            <cfset FormLabelDisplay = "Type">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldClick">
            <cfset FormSize = "sm">
            <cfset counter = 1>
            <cfloop array="#TypeArray#" index="i">
                <cfset "FormValue#counter#" = i.getID()>
                <cfset "FormLabel#counter#" = "#i.getType()#">
                <cfset "FormValueDisabled#counter#" = false>
                <cfset counter = counter + 1>
            </cfloop>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalRadio5ButtonsBlock.cfm">

            <!---Notes--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "Notes">
            <cfset FormLabelDisplay = "Notes">
            <cfset FormClasses = "col-12">
            <cfset FormHelpText = "1000 characters available for special notes.">
            <cfset FormFieldRequired = false>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormRows = 2>
            <cfset FormSize = "sm">
            <cfset FormFullWidth = false>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalTextArea.cfm">
            
            <!---SpecialDietBit--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "SpecialDietBit">
            <cfset FormLabelDisplay = "Special Diet">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldClick">
            <cfset FormSize = "sm">
            <cfset FormValue1 = 1>
            <cfset FormLabel1 = "Yes">
            <cfset FormValueDisabled1 = false>
            <cfset FormValue2 = 0>
            <cfset FormLabel2 = "No">
            <cfset FormValueDisabled2 = false>
            <cfset FormFullWidth = false>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalRadio5ButtonsInline.cfm">

            <!---SpecialDiet--->
            <!---d-none class is not initially required but helps prevent the flicker on refresh--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "SpecialDiet">
            <cfset FormLabelDisplay = "Diet Instructions">
            <cfset FormClasses = "col-12 SpecialDietBitSH d-none">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormMaxLength = 200>
            <cfset FormAddOnLeft = "">
            <cfset FormAddOnRight = "">
            <cfset FormSize = "sm">
            <cfinclude template="/views/animals/includes/formfields/_HorizontalTextInput.cfm">

            <!---FavoriteColor--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "FavoriteColor">
            <cfset FormLabelDisplay = "Favorite Color">
            <cfset FormClasses = "col-12">
            <cfset FormHelpText = "Is not required.">
            <cfset FormFieldRequired = false>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormSize = "sm">
            <cfset FormFullWidth = false>
            <cfset FormAutoSubmit = false>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalSelect1.cfm">
            <option value="">Select:</option>
            <option value="Blue"<cfif FORM.FavoriteColor EQ "Blue"> selected</cfif>>Blue</option>
            <option value="Green"<cfif FORM.FavoriteColor EQ "Green"> selected</cfif>>Green</option>
            <option value="Orange"<cfif FORM.FavoriteColor EQ "Orange"> selected</cfif>>Orange</option>
            <option value="Pink"<cfif FORM.FavoriteColor EQ "Pink"> selected</cfif>>Pink</option>
            <option value="Red"<cfif FORM.FavoriteColor EQ "Red"> selected</cfif>>Red</option>
            <option value="Yellow"<cfif FORM.FavoriteColor EQ "Yellow"> selected</cfif>>Yellow</option>
            <cfinclude template="/views/animals/includes/formfields/_HorizontalSelect2.cfm">

            <!---FavoriteColorExplain--->
            <!---d-none class is not initially required but helps prevent the flicker on refresh--->
            <cfset FormModelName = "Animal">
            <cfset FormFieldName = "FavoriteColorExplain">
            <cfset FormLabelDisplay = "Explain Color Choice">
            <cfset FormClasses = "col-12 FavoriteColorSH d-none">
            <cfset FormHelpText = "">
            <cfset FormFieldRequired = true>
            <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
            <cfset FormDisabled = false>
            <cfset FormReadOnly = false>
            <cfset FormMaxLength = 200>
            <cfset FormAddOnLeft = "">
            <cfset FormAddOnRight = "">
            <cfset FormSize = "sm">
            <cfinclude template="/views/animals/includes/formfields/_HorizontalTextInput.cfm">

            <!---ArrivedAt--->
            <cfset FieldGroupModelName = "Animal">
            <cfset FieldGroupLabelDisplay = "Arrival"><!---Arrival Date &amp; Time--->
            <cfset FieldGroupFieldName = "ArrivedAt">
            <cfset FieldGroupYearsFrom = Year(DateConvert("local2utc", Now()))>
            <cfset FieldGroupYearsTo = Year(DateAdd('yyyy', -5, DateConvert("local2utc", Now())))>
            <cfset FieldGroupYearsStep = -1>
            <cfset FieldGroupIncludeTime = true>
            <cfset FieldGroupSize = "sm">
            <cfset FieldGroupRequired = true>
            <cfinclude template="/views/animals/includes/formfieldgroups/_HorizontalDateTime.cfm">

            <!---ADD--->
            <cfif REQUEST.Action EQ "addanimal">
                <!---FileUUIDAvatar--->
                <cfset FormModelName = "Animal">
                <cfset FormFieldName = "FileUUIDAvatar">
                <cfset FormLabelDisplay = "Select Avatar">
                <cfset FormClasses = "col-12">
                <cfset FormHelpText = "Must be an image file (gif, jpeg, jpg, png).">
                <cfset FormFieldRequired = false>
                <cfset FormSize = "sm">
                <cfinclude template="/views/animals/includes/formfields/_HorizontalFileBrowser.cfm">
            <!---EDIT--->
            <cfelseif REQUEST.Action EQ "animal">
                <!---No avatar exists--->
                <cfif Model.getFileUUIDAvatar() EQ "">
                    <!---FileUUIDAvatar--->
                    <cfset FormModelName = "Animal">
                    <cfset FormFieldName = "FileUUIDAvatar">
                    <cfset FormLabelDisplay = "Select Avatar">
                    <cfset FormClasses = "col-12">
                    <cfset FormHelpText = "Must be an image file (gif, jpeg, jpg, png).">
                    <cfset FormFieldRequired = false>
                    <cfset FormSize = "sm">
                    <cfinclude template="/views/animals/includes/formfields/_HorizontalFileBrowser.cfm">
                <!---Avatar exists--->
                <cfelse>
                    <!---KeepReplaceDeleteFile--->
                    <cfset FormModelName = "Animal">
                    <cfset FormFieldName = "KeepReplaceDeleteFile">
                    <cfset FormLabelDisplay = "Avatar Image">
                    <cfset FormHelpText = "">
                    <cfset FormFieldRequired = true>
                    <cfset FormAjaxClasses = "AjaxValidateFieldClick">
                    <cfset FormSize = "sm">
                    <cfset FormValue1 = "Keep">
                    <cfset FormLabel1 = "Keep">
                    <cfset FormValueDisabled1 = false>
                    <cfset FormValue2 = "Delete">
                    <cfset FormLabel2 = "Delete">
                    <cfset FormValueDisabled2 = false>
                    <cfset FormValue3 = "Replace">
                    <cfset FormLabel3 = "Replace">
                    <cfset FormValueDisabled3 = false>
                    <cfset FormFullWidth = false>
                    <!---<cfinclude template="/views/animals/includes/formfields/_HorizontalRadio5ButtonsInline.cfm">--->
                    <!---Not using include to allow for it to be easier to put avatar download link in alignment with radio buttons--->
                    <div class="col-12">
                        <div class="form-group row mb-2">
                            <label for="id_#FormFieldName#_#FormModelName#" class="col-12 col-lg-4 col-xl-2 text-left text-lg-right col-form-label<cfif FormSize NEQ ''> col-form-label-#FormSize#</cfif>"><cfif FormFieldRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FormLabelDisplay#</strong></label>
                            <div class="col-12 col-lg-8 col-xl-6">
                                <!---Custom link to avatar that didn't work with _HorizontalRadio5ButtonsInline.cfm include above--->
                                <a class="btn btn-sm btn-outline-dark pb-0 mr-4" data-toggle="tooltip" data-placement="top" title="Download" href="/index.cfm?controller=#REQUEST.controller#&action=getfile&filename=#Model.getFileCleanAvatar()#"><i class="fas fa-download"></i></a>
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
                    <!---Set FormValueX, FormLabelX, and FormValueDisabledX back to empty to not disrupt any future included radio form fields--->
                    <cfloop from="1" to="5" index="i">
                        <cfset "FormValue#i#" = "">
                        <cfset "FormLabel#i#" = "">
                        <cfset "FormValueDisabled#i#" = "">    
                    </cfloop>

                    <!---FileUUIDAvatar--->
                    <cfset FormModelName = "Animal">
                    <cfset FormFieldName = "FileUUIDAvatar">
                    <cfset FormLabelDisplay = "Select New Avatar">
                    <cfset FormClasses = "col-12 KeepReplaceDeleteFileSH d-none">
                    <cfset FormHelpText = "Must be an image file (gif, jpeg, jpg, png).">
                    <cfset FormFieldRequired = true>
                    <cfset FormSize = "sm">
                    <cfinclude template="/views/animals/includes/formfields/_HorizontalFileBrowser.cfm">
                </cfif>
            </cfif>

            <!---Buttons--->
            <div class="col-12 col-xl-8 my-3 text-right">
                <button class="btn btn-outline-danger btn-sm py-0" type="button" name="ButtonCancel" data-toggle="modal" data-target="##sys-confirm-cancel">Cancel</button>
                <button class="btn btn-outline-success  btn-sm py-0 ml-3 mr-xl-2" type="button" name="ButtonSubmit" data-toggle="modal" data-target="##sys-confirm-submit">Submit</button>
            </div>

        </div>
        <cfinclude template="/views/animals/includes/_ModalSubmit.cfm">
        <cfinclude template="/views/animals/includes/_ModalCancel.cfm">
    </form>
</cfoutput>