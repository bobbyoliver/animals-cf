<script type="text/javascript">
//JSHint & JSPretty
$("input[name=SpecialDietBit]").bind("click keyup", SpecialDietBitClick);
function SpecialDietBitClick()
{
    "use strict";
    if ($("input[name=SpecialDietBit]:checked").val() === "1")
    {
        $(".SpecialDietBitSH").removeClass("d-none");
    }
    else
    {
        $(".SpecialDietBitSH").addClass("d-none");
    }
}



//JSHint & JSPretty
$("select[name=FavoriteColor]").bind("click keyup", FavoriteColorClick);
function FavoriteColorClick()
{
    "use strict";
    if ($("select[name=FavoriteColor]").val() === "")
    {
        $(".FavoriteColorSH").addClass("d-none");
    }
    else if ($("select[name=FavoriteColor]").val() != "")
    {
        $(".FavoriteColorSH").removeClass("d-none");
    }
}



//JSHint & JSPretty
$(document).ready(function ()
{
    "use strict";
    //Called in ready function in case user refreshes browser
    SpecialDietBitClick();
    FavoriteColorClick();
});
</script>