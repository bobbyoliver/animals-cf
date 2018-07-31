//REL EXTERNAL - Add "rel=external" to "href" "a" tag and it will open in new window
$("a[rel*='external']").click(function(){this.target = "_blank";});



//Bootstrap 4 beta "Android stock browser" script to fix Android browser bug, from "Browsers & devices" section of BS docs
$(function () {
  var nua = navigator.userAgent
  var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
  if (isAndroid) {
    $('select.form-control').removeClass('form-control').css('width', '100%')
  }
})



//Thought this code wasn't needed after popper.js.min was added and that (data-toggle="tooltip" data-placement="top" title="Tooltip on top") was enough but this JS is needed to style and position the tooltip
//Makes it look cleaner and centered, much quicker dispaly on hover too
$(function(){$('[data-toggle="tooltip"]').tooltip()})



//Function called to get visitor's local browser time if SESSION.VisStr doesn't exist
function AjaxBrowserTime()
{
    "use strict";
    //var TimeZone = 'America/New_York'; //Hard code a specific time zone to do testing
    var TimeZone = moment.tz.guess();
    var AbbreviatedTimeZone = moment.tz(TimeZone).zoneAbbr();
    var HoursOffset = moment().tz(TimeZone).format('Z');
    var UTCOffset = moment.tz(TimeZone).utcOffset();
    $.ajax(
    {
        //cache: false,
        //ACF had to have dataType: "json" for ajax to be returned but not needed in Lucee
        //dataType: "json",
        type: "get",
        url: "/ajax.cfc",
        data:
        {
            Method: "AjaxBrowserTime",
            TimeZone: TimeZone,
            AbbreviatedTimeZone: AbbreviatedTimeZone,
            HoursOffset: HoursOffset,
            UTCOffset: UTCOffset
        },
        success: function(Response) {}
    });
}



//If form field has "AjaxValidateFieldBlur" or "AjaxValidateFieldClick" class then ajax validation is called on the field when it loses focus or is clicked
//Moved into function so forms that do JS field adds like phones can call this globally from inside the form field creating JS functions
//Blur events are triggered when the form field loses focus (so can be either by clicking away or tabbing away)
//Have click event too for radio buttons cause sometimes need validation state display to change upon click and not wait until the field loses focus
$(".AjaxValidateFieldBlur").blur(AjaxValidateFieldFunction);
$(".AjaxValidateFieldClick").click(AjaxValidateFieldFunction);
function AjaxValidateFieldFunction()
{
    "use strict";
    //Couldn't figure out how to access the "data" "Model" and "FormField" values below, best found solution was stack overflow post saying to put them in a data object
    //This prevented having to have CF "AjaxValidateField" function pass data back cause "Model" and "FormField" are needed in validation below
    //https://stackoverflow.com/questions/35385958/jquery-ajax-request-how-to-access-sent-data-in-success-function
    var PostData = {Model:$(this).attr("id").split("_").pop(), FormField:$(this).attr("name")};
    $.ajax(
    {
        //cache: false,
        //ACF had to have dataType: "json" for ajax to be returned but not needed in Lucee
        //dataType: "json",
        type: "get",
        url: "/ajax.cfc",
        data: {
            Method: "AjaxValidateField",
            //Would only pass "ValidationType" if doing debugging
            //ValidationType: "ajax",
            //Form field has id name like "id_FirstName_Animal" where "Animal" is the Model and "FirstName" is the attribute/form field
            //"split" splits string into an array on underscore and "pop" pops last element off the array to get "Animal"
            Model: $(this).attr("id").split("_").pop(),
            //Passing "IsRequired" to validation functions to allow DB to drive whether fields are required or not
            IsRequired: $(this).hasClass("IsRequired"),
            SerializedFormFields: $("form").serialize(),
            FormField: $(this).attr("name"),
            FormValue: $(this).val()
        },
        success: function (Response)
        {
            //If server side errors were displayed already this will hide errors for that field by settingtext to empty for server error
            $("#" + PostData.FormField + "ServerError").html("");
            if (Response.Message !== "")
            {
                //Every form field has an id name like "id_FirstName_Animal" etc. so add the "is-invalid" class
                $("#" + "id_" + PostData.FormField + "_" + PostData.Model).addClass("is-invalid");
                //Also add "invalid-feedback" class to div displaying error text, if "invalid-feedback" class is in markup then BS automatically collapses the div even if it has a height which causes a page jump
                $("#" + PostData.FormField + "Error").addClass("invalid-feedback");
                //Clear the "AjaxError" and add the message
                $("#" + PostData.FormField + "AjaxError").html("");
                $("#" + PostData.FormField + "AjaxError").html(Response.Message);
            }
            //No errors
            else
            {
                //Every form field has an id name like "id_FirstName_Animal" so remove the "is-invalid" class
                $("#" + "id_" + PostData.FormField + "_" + PostData.Model).removeClass("is-invalid");
                //Also remove the "invalid-feedback" class from div displaying error text, not adding "d-none" class here cause that causes a jump in the page due to div collapsing
                $("#" + PostData.FormField + "Error").removeClass("invalid-feedback");
                //Error must be cleared before the looping below using "each" cause it's counting the errors based on whether the ajax error text is empty or not
                $("#" + PostData.FormField + "AjaxError").html("");
            }
        }
    });
}