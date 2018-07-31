<script type="text/javascript">
//Enables or disables "Delete" button when checkboxes for records are checked, called in ready function for page loads too
//Using button name instead of id, but if wanted to use id, would be: $("#ButtonDeleteRecords").prop("disabled", false);
$(".DeleteRecordsCheckbox").click(DeleteRecordsCheckboxClick);
function DeleteRecordsCheckboxClick()
{
    "use strict";
    //"DeleteRecordsCheckbox" class is assigned to all checkboxes
    if ($(".DeleteRecordsCheckbox").is(":checked"))
    {
        $("[name='ButtonDeleteRecords']").prop("disabled", false);
    }
    else
    {
        $("[name='ButtonDeleteRecords']").prop("disabled", true);
    }
}


//Anchor id "DeleteRecordsNo" used to cancel delete of multiple records
$("#DeleteRecordsNo").click(DeleteRecordsNo);
//Using event argument to help keep page in place instead of jumping to top when user clicks "No"
function DeleteRecordsNo(event)
{
    "use strict";
    //If no then uncheck all checkboxes, uncheck "id_CheckAll" if checked, and set "Delete" button back to disabled state
    $(".DeleteRecordsCheckbox").prop("checked", false);
    $("#id_CheckAll").prop("checked", false);
    $("[name='ButtonDeleteRecords']").prop("disabled", true);
    event.preventDefault();
}


//Anchor class "DeleteRecordNo" used to cancel delete of a single record
$(".DeleteRecordNo").click(DeleteRecordNo);
//Using event argument to help keep page in place instead of jumping to top when user clicks "No"
function DeleteRecordNo(event)
{
    "use strict";
    event.preventDefault();
}


//Toggles all checkboxes to be checked/unchecked based on main id_CheckAll checkbox
//Must use prop("checked", true); instead of attr("checked", true); otherwise check/uncheck only works first click
$("#id_CheckAll").click(DeleteRecordsCheckAllClick);
function DeleteRecordsCheckAllClick()
{
    "use strict";
    //"DeleteRecordsCheckbox" class is assigned to all checkboxes
    if ($("#id_CheckAll").is(":checked"))
    {
        $(".DeleteRecordsCheckbox").prop("checked", true);
        $("[name='ButtonDeleteRecords']").prop("disabled", false);
    }
    else
    {
        $(".DeleteRecordsCheckbox").prop("checked", false);
        $("[name='ButtonDeleteRecords']").prop("disabled", true);
    }
}


$(document).ready(function ()
{
    "use strict";
    //Called in ready function in case user refreshes browser
    DeleteRecordsCheckboxClick();
});
</script>