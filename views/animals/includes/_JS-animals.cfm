<script type="text/javascript">
//JSHint & JSPretty
//Used for dropdowns at end of row to pass name of button which indicates what action should be done to what record, issue is that to use the modal confirm must use buttons of type "button" and not "submit" then the modal submits
//So this technique passes the button's name that's clicked to a waiting empty hidden form field
$(".PassButtonValueToModal").click(function()
{
    "use strict";
    //IDToEdit is an empty hidden form field, when the single record button is clicked with an action then the button name is passed to the hidden form field which dictates the needed action
    $("input[name=IDToEdit]").val(this.name);
});



//JSHint & JSPretty
//Two separate button click functions used to check/uncheck all records in grid
$("[name='ButtonCheckAll']").click(ButtonCheckAllClick);
function ButtonCheckAllClick()
{
    "use strict";
    $(".OptionsRecordsCheckbox").prop("checked", true);
    OptionsRecordsCheckboxClick();
}
$("[name='ButtonCheckNone']").click(ButtonCheckNoneClick);
function ButtonCheckNoneClick()
{
    "use strict";
    $(".OptionsRecordsCheckbox").prop("checked", false);
    OptionsRecordsCheckboxClick();
}



//JSHint & JSPretty
//Enables or disables buttons in dropdown when checkboxes for records are checked, called in ready function for page loads too
$(".OptionsRecordsCheckbox").click(OptionsRecordsCheckboxClick);
function OptionsRecordsCheckboxClick()
{
    "use strict";
    //"OptionsRecordsCheckbox" class is assigned to all checkboxes, this checks if any of them are checked
    if ($(".OptionsRecordsCheckbox").is(":checked"))
    {
        $(".OptionsEditRecordsButton").prop("disabled", false);
    }
    else
    {
        $(".OptionsEditRecordsButton").prop("disabled", true);
    }
}



//JSHint & JSPretty
$(document).ready(function ()
{
    "use strict";
    //Called in ready function in case user refreshes browser
    OptionsRecordsCheckboxClick();
});
</script>