<!---
-Can be empty: FieldGroupSize
-FieldGroupYearsStep must always be set to 1 or -1

<!---DOB--->
<!---"_HorizontalDateTime.cfm" is different than inline and isn't already in it's own div col, but inline selects are used within the "_HorizontalDateTime.cfm" include--->
<cfset FieldGroupModelName = "User">
<cfset FieldGroupLabelDisplay = "DOB <i class='fas fa-check-square'></i>">
<cfset FieldGroupFieldName = "DOB">
<cfset FieldGroupYearsFrom = Year(DateConvert("local2utc", Now()))>
<cfset FieldGroupYearsTo = Year(DateAdd('yyyy', -19, DateConvert("local2utc", Now())))>
<cfset FieldGroupYearsStep = -1>
<cfset FieldGroupIncludeTime = false>
<cfset FieldGroupSize = "sm">
<cfset FieldGroupRequired = false>
<cfinclude template="/views/animals/includes/formfields/_HorizontalDateTime.cfm">
--->
<cfoutput>
    <div class="col-12">
        <div class="form-group row mb-2">
            <label for="id_#FieldGroupFieldName#Day_#FieldGroupModelName#" class="col-12 col-lg-4 col-xl-2 text-left text-lg-right col-form-label<cfif FieldGroupSize EQ 'sm'> col-form-label-sm</cfif>"><cfif FieldGroupRequired EQ true><span class="text-danger">*</span> </cfif><strong>#FieldGroupLabelDisplay#</strong></label>
            <div class="col-12 col-lg-8 col-xl-6">
                <div class="form-row">
                    <!---#FieldGroupFieldName#Day--->
                    <cfset FormModelName = "#FieldGroupModelName#">
                    <cfset FormFieldName = "#FieldGroupFieldName#Day">
                    <cfset FormLabelDisplay = "">
                    <cfset FormClasses = "col-#IIF(FieldGroupIncludeTime EQ true, 3, 4)#">
                    <cfset FormHelpText = "">
                    <cfset FormFieldRequired = false>
                    <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
                    <cfset FormDisabled = false>
                    <cfset FormReadOnly = false>
                    <cfset FormSize = "#FieldGroupSize#">
                    <cfset FormErrorDisplay = false>
                    <cfinclude template="/views/animals/includes/formfields/_InlineSelect1.cfm">
                    <option value="">Day:</option>
                    <cfloop from="1" to="31" index="i">
                        <option value="#i#"<cfif Evaluate("FORM." & FieldGroupFieldName & "Day") EQ i> selected</cfif>>#i#</option>
                    </cfloop>
                    <cfinclude template="/views/animals/includes/formfields/_InlineSelect2.cfm">

                    <!---#FieldGroupFieldName#Month--->
                    <cfset FormModelName = "#FieldGroupModelName#">
                    <cfset FormFieldName = "#FieldGroupFieldName#Month">
                    <cfset FormLabelDisplay = "">
                    <cfset FormClasses = "col-#IIF(FieldGroupIncludeTime EQ true, 3, 4)#">
                    <cfset FormHelpText = "">
                    <cfset FormFieldRequired = false>
                    <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
                    <cfset FormDisabled = false>
                    <cfset FormReadOnly = false>
                    <cfset FormSize = "#FieldGroupSize#">
                    <cfset FormErrorDisplay = false>
                    <cfinclude template="/views/animals/includes/formfields/_InlineSelect1.cfm">
                    <option value="">Month:</option>
                    <option value="01"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "01"> selected</cfif>>January</option>
                    <option value="02"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "02"> selected</cfif>>February</option>
                    <option value="03"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "03"> selected</cfif>>March</option>
                    <option value="04"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "04"> selected</cfif>>April</option>
                    <option value="05"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "05"> selected</cfif>>May</option>
                    <option value="06"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "06"> selected</cfif>>June</option>
                    <option value="07"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "07"> selected</cfif>>July</option>
                    <option value="08"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "08"> selected</cfif>>August</option>
                    <option value="09"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "09"> selected</cfif>>September</option>
                    <option value="10"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "10"> selected</cfif>>October</option>
                    <option value="11"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "11"> selected</cfif>>November</option>
                    <option value="12"<cfif Evaluate("FORM." & FieldGroupFieldName & "Month") EQ "12"> selected</cfif>>December</option>
                    <cfinclude template="/views/animals/includes/formfields/_InlineSelect2.cfm">

                    <!---#FieldGroupFieldName#Year--->
                    <cfset FormModelName = "#FieldGroupModelName#">
                    <cfset FormFieldName = "#FieldGroupFieldName#Year">
                    <cfset FormLabelDisplay = "">
                    <cfset FormClasses = "col-#IIF(FieldGroupIncludeTime EQ true, 3, 4)#">
                    <cfset FormHelpText = "">
                    <cfset FormFieldRequired = false>
                    <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
                    <cfset FormDisabled = false>
                    <cfset FormReadOnly = false>
                    <cfset FormSize = "#FieldGroupSize#">
                    <cfset FormErrorDisplay = false>
                    <cfinclude template="/views/animals/includes/formfields/_InlineSelect1.cfm">
                    <option value="">Year:</option>
                    <cfloop from="#FieldGroupYearsFrom#" to="#FieldGroupYearsTo#" index="i" step="#FieldGroupYearsStep#">
                        <option value="#i#"<cfif Evaluate("FORM." & FieldGroupFieldName & "Year") EQ i> selected</cfif>>#i#</option>
                    </cfloop>
                    <cfinclude template="/views/animals/includes/formfields/_InlineSelect2.cfm">

                    <!---#FieldGroupFieldName#Time--->
                    <cfif FieldGroupIncludeTime EQ true>
                        <cfset FormModelName = "#FieldGroupModelName#">
                        <cfset FormFieldName = "#FieldGroupFieldName#Time">
                        <cfset FormLabelDisplay = "">
                        <cfset FormClasses = "col-#IIF(FieldGroupIncludeTime EQ true, 3, 4)#">
                        <cfset FormHelpText = "">
                        <cfset FormFieldRequired = false>
                        <cfset FormAjaxClasses = "AjaxValidateFieldBlur">
                        <cfset FormDisabled = false>
                        <cfset FormReadOnly = false>
                        <cfset FormSize = "#FieldGroupSize#">
                        <cfset FormErrorDisplay = false>
                        <cfinclude template="/views/animals/includes/formfields/_InlineSelect1.cfm">
                        <option value="">Time:</option>
                        <option value="00:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "00:00"> selected</cfif>>12:00am</option>
                        <option value="00:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "00:30"> selected</cfif>>12:30am</option>
                        <option value="01:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "01:00"> selected</cfif>>1:00am</option>
                        <option value="01:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "01:30"> selected</cfif>>1:30am</option>
                        <option value="02:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "02:00"> selected</cfif>>2:00am</option>
                        <option value="02:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "02:30"> selected</cfif>>2:30am</option>
                        <option value="03:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "03:00"> selected</cfif>>3:00am</option>
                        <option value="03:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "03:30"> selected</cfif>>3:30am</option>
                        <option value="04:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "04:00"> selected</cfif>>4:00am</option>
                        <option value="04:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "04:30"> selected</cfif>>4:30am</option>
                        <option value="05:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "05:00"> selected</cfif>>5:00am</option>
                        <option value="05:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "05:30"> selected</cfif>>5:30am</option>
                        <option value="06:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "06:00"> selected</cfif>>6:00am</option>
                        <option value="06:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "06:30"> selected</cfif>>6:30am</option>
                        <option value="07:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "07:00"> selected</cfif>>7:00am</option>
                        <option value="07:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "07:30"> selected</cfif>>7:30am</option>
                        <option value="08:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "08:00"> selected</cfif>>8:00am</option>
                        <option value="08:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "08:30"> selected</cfif>>8:30am</option>
                        <option value="09:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "09:00"> selected</cfif>>9:00am</option>
                        <option value="09:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "09:30"> selected</cfif>>9:30am</option>
                        <option value="10:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "10:00"> selected</cfif>>10:00am</option>
                        <option value="10:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "10:30"> selected</cfif>>10:30am</option>
                        <option value="11:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "11:00"> selected</cfif>>11:00am</option>
                        <option value="11:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "11:30"> selected</cfif>>11:30am</option>
                        <option value="12:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "12:00"> selected</cfif>>12:00pm</option>
                        <option value="12:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "12:30"> selected</cfif>>12:30pm</option>
                        <option value="13:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "13:00"> selected</cfif>>1:00pm</option>
                        <option value="13:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "13:30"> selected</cfif>>1:30pm</option>
                        <option value="14:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "14:00"> selected</cfif>>2:00pm</option>
                        <option value="14:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "14:30"> selected</cfif>>2:30pm</option>
                        <option value="15:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "15:00"> selected</cfif>>3:00pm</option>
                        <option value="15:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "15:30"> selected</cfif>>3:30pm</option>
                        <option value="16:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "16:00"> selected</cfif>>4:00pm</option>
                        <option value="16:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "16:30"> selected</cfif>>4:30pm</option>
                        <option value="17:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "17:00"> selected</cfif>>5:00pm</option>
                        <option value="17:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "17:30"> selected</cfif>>5:30pm</option>
                        <option value="18:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "18:00"> selected</cfif>>6:00pm</option>
                        <option value="18:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "18:30"> selected</cfif>>6:30pm</option>
                        <option value="19:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "19:00"> selected</cfif>>7:00pm</option>
                        <option value="19:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "19:30"> selected</cfif>>7:30pm</option>
                        <option value="20:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "20:00"> selected</cfif>>8:00pm</option>
                        <option value="20:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "20:30"> selected</cfif>>8:30pm</option>
                        <option value="21:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "21:00"> selected</cfif>>9:00pm</option>
                        <option value="21:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "21:30"> selected</cfif>>9:30pm</option>
                        <option value="22:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "22:00"> selected</cfif>>10:00pm</option>
                        <option value="22:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "22:30"> selected</cfif>>10:30pm</option>
                        <option value="23:00"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "23:00"> selected</cfif>>11:00pm</option>
                        <option value="23:30"<cfif Evaluate("FORM." & FieldGroupFieldName & "Time") EQ "23:30"> selected</cfif>>11:30pm</option>
                        <cfinclude template="/views/animals/includes/formfields/_InlineSelect2.cfm">
                    </cfif>
                </div>
            </div>
            <!---Error display for group if it exists--->
            <div class="col-12 col-xl-4">
                <!---Using text-danger and small here cause the built in BS "invalid-feedback" class wasn't working with horizontal forms--->
                <div id="#FieldGroupFieldName#Error" class="d-inline text-danger<cfif FormSize EQ 'sm'> small</cfif>">
                    <span id="#FieldGroupFieldName#AjaxError"></span>
                    <cfif IsDefined("ErrorArray")>
                        <cfloop array="#ErrorArray#" index="i">
                            <cfif i.Property EQ FieldGroupFieldName>
                                <span id="#FieldGroupFieldName#ServerError">#i.Message#</span>
                            </cfif>
                        </cfloop>
                    </cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>