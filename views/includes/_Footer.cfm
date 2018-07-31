    <cfoutput>
                <!---Closing div for "wrapper-main" id, needed so noscript code knows what page content to hide when JS is disabled--->
                </div>
            <!---Closing div for "wrapper-inner", needed for flushing footer--->
            </div>
        <!---Closing div for "wrapper-outter", needed for flushing footer--->
        </div>
        <!---Hardcoded a similar basic footer (minus a site name) as sites and portals use, just the domain name and a copyright notice are displayed--->
        <div id="wrapper-footer" class="d-none d-sm-block">
            <div class="container">
                <div class="row">
                    <div class="col-12 mt-2 text-center text-muted small">
                        <nav class="nav justify-content-center">
                            <a class="nav-link" href="/index.cfm?controller=animals&action=animals">Animals</a>
                            <a class="nav-link" href="/index.cfm?controller=animals&action=addanimal">Add Animal</a>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!---If APPLICATION scope "Debug" is set to true, include it before JS--->
        <cfif StructKeyExists(APPLICATION, "Debug") AND APPLICATION.Debug EQ true>
            <!---Only include debug if not building a PDF--->
            <cfif REQUEST.ReqStr.BuildPDF EQ false>
                <cfinclude template="/views/includes/_Debug.cfm">
            </cfif>
        </cfif>
        <!---JS--->
        <script type="text/javascript" src="/js/jquery-3.3.1.min.js?d=20180720"></script>
        <script type="text/javascript" src="/js/popper.min.js?d=20180720"></script>
        <script type="text/javascript" src="/js/bootstrap.min.js?d=20180720"></script>
        <script type="text/javascript" src="/js/after-bootstrap.js?d=20180720"></script>
        <!---No longer doing !StructKeyExists(SESSION, "VisStr") check cause now SESSION.VisStr is always set in OnRequestStart, but if REQUEST.ReqStr.ReloadVisStr is true then is first request by visitor so use moment JS to update local browser time in SESSION--->
        <!---Thought might need an additiona timezone JS file cause the site examples are confusing, but only need one timezone file, refer to post - https://stackoverflow.com/questions/29877791/how-to-load-time-zone-data-into-moment-timezone-js--->
        <cfif REQUEST.ReqStr.ReloadVisStr EQ true>
            <script type="text/javascript" src="/js/moment.min.js?d=20180720"></script>
            <script type="text/javascript" src="/js/moment-timezone-with-data-2012-2022.min.js?d=20180720"></script>
            <!---By hardcoding anotehr ready function it only gets called when needed on the first page load where visitor's time zone isn't set--->
            <script type="text/javascript">
                $(document).ready(function ()
                {
                    "use strict";
                    AjaxBrowserTime();
                });
            </script>
        </cfif>
        <!---Specific page JS will be included here, the file must be named to match the page and placed in "/views/animals/includes/_JS-#URL.Action#.cfm"--->
        <cfif StructKeyExists(URL, "Action") AND FileExists("#ExpandPath('/')#views/animals/includes/_JS-#URL.Action#.cfm")>
            <cfinclude template="/views/animals/includes/_JS-#URL.Action#.cfm">
        </cfif>
    </cfoutput>
</body>
</html>