/*
IE10 in Windows Phone 8 workaround
https://timkadlec.com/2013/01/windows-phone-8-and-device-width/
-Internet Explorer 10 doesn't differentiate device width from viewport width, and thus doesn't properly apply the media queries in Bootstrap's CSS. To address this, optionally include the CSS and JS in the above post in all files to work around this problem until Microsoft issues a fix.
-Removed the JS from the ready function and put it at the bottom of the head section.
*/
//JSHint & JSPretty
(function()
{
    "use strict";
    if (navigator.userAgent.match(/IEMobile\/10\.0/))
    {
        var msViewportStyle = document.createElement("style");
        msViewportStyle.appendChild(document.createTextNode("@-ms-viewport{width:auto!important}"));
        document.head.appendChild(msViewportStyle);
    }
})();