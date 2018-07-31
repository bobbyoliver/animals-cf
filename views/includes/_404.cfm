<!DOCTYPE html>
<html lang="en">
<head>
    <!---These first 3 meta tags must come first in the head, any other head content must come after these tags--->
    <meta charset="utf-8">
    <!---IE=edge means IE should use the latest "edge" version of its rendering engine--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!---Ensures proper rendering and touch zooming on mobile devices--->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <cfoutput>
        <!---AUTHOR--->
        <meta name="author" content="#APPLICATION.Display#">
    </cfoutput>
    <!---ROBOTS--->
    <meta name="robots" content="noindex,nofollow">
    <!---TITLE--->
    <title>404 - Page Not Found</title>
    <!---Sets status and sends code of 404--->
	<cfheader statuscode="404" statustext="Not Found">
	<!---Not loading a favicon, any CSS, or any JS--->
</head>
<body>
	<!---Logs the requested URL to AnimalsDemo404 log file--->
	<cflog file="AnimalsDemo404" text="#CGI.REQUEST_URL#">
	<p>404. This is an error.</p>
    <p>The requested URL below was not found on this server.</p>
    <p><cfoutput>#CGI.REQUEST_URL#</cfoutput></p>
</body>
</html>