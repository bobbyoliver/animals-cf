<!DOCTYPE html>
<html lang="en">
<head>
    <!---Required meta tags--->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!---Author--->
    <meta name="author" content="Bobby Oliver">
    <cfoutput>
        <!---Description, Robots, and Title are set in controller--->
        <cfif IsDefined("HeaderVariablesStruct.Description")>
            <meta name="description" content="#HeaderVariablesStruct.Description#">
        </cfif>
        <cfif IsDefined("HeaderVariablesStruct.Robots")>
            <meta name="robots" content="#HeaderVariablesStruct.Robots#">
        </cfif>
        <cfif IsDefined("HeaderVariablesStruct.Title")>
            <title>#HeaderVariablesStruct.Title#</title>
        </cfif>
    </cfoutput>
    <!---FAVICON--->
    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <!---Bootstrap CSS--->
    <link href="/css/bootstrap.min.css?d=20180720" rel="stylesheet">
    <!---Custom css on top of bootstrap--->
    <link href="/css/after-bootstrap.css" rel="stylesheet">
    <!---IE10 on Windows Phone 8 workaround JS--->
    <script src="/js/ie10-viewport-bug-workaround.js?d=20180720"></script>
    <!---Font Awesome - Version 5, no CSS or fonts needed, everything is in this one JS file--->
    <script src="/js/fontawesome-all.min.js?d=20180720"></script>
</head>
<body>
    <!---Two wrapper divs "wrapper-outter" and "wrapper-inner" needed to add flushing footer--->
    <!---Closing divs are at the top of "_Footer.cfm" include--->
    <div id="wrapper-outter">
        <div id="wrapper-inner">
            <cfoutput>
                <!---Only include navs if not building a PDF--->
                <cfif REQUEST.ReqStr.BuildPDF EQ false>
                    <!---Moved navbar inside wrapper divs to ensure flushing footer works correctly with default top nav--->
                    <div class="container-fluid px-0" style="background-color:##343A40; border-bottom:##B8B8B8 1px solid;">
                        <div class="container px-0" style="background-color:##343A40;">
                            <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="background-color:##343A40;">
                                <a class="navbar-brand" href="/">README</a>
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                    <!---Bad hack, but have to have an empty ul with "navbar-nav mr-auto" classes to push 2nd ul to far right side--->
                                    <ul class="navbar-nav mr-auto">
                                        <li class="nav-item">
                                            <a class="nav-link<cfif REQUEST.Action EQ 'animals'> active</cfif>" href="/index.cfm?controller=animals&action=animals">Animals</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link<cfif REQUEST.Action EQ 'addanimal'> active</cfif>" href="/index.cfm?controller=animals&action=addanimal">Add Animal</a>
                                        </li>
                                    </ul>
                                    <ul class="navbar-nav justify-content-end">
                                        <li class="nav-item">
                                            <a class="nav-link" href="http://www.bobbyoliver.com">Bobby Oliver</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </cfif>
            </cfoutput>
            <!---"noscript" hides content in wrapper-main div and shows message if JS is disabled--->
            <noscript>
                <style type="text/css">#wrapper-main {display:none;}</style>
                <div class="container">
                    <!---No JS close button or fading close cause it wouldn't work with JS disabled--->
                    <div class="row justify-content-center">
                        <div class="col-12 col-lg-8 col-xl-6">
                            <div class="alert alert-warning small mt-3" role="alert">
                                Javascript must be enabled to use this website.
                            </div>
                        </div>
                    </div>
                </div>
            </noscript>
            <!---"wrapper-main" id is required so noscript code knows what page content to hide when JS is disabled--->
            <div id="wrapper-main">