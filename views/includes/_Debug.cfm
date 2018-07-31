<!---
-If using this debug with another project include the below CSS
/*debug style*/
#debug {background:#FDCFCE;}
#debug .table-striped tbody tr:nth-child(even) td {background-color:#D0D0D0;}
--->
<cfoutput>
    <div id="debug" class="container-fluid pt-2">
        <div class="row small">
            <div class="col-12">
                <h4>Debug Info</h4>
            </div>
            <div class="col-12">
                <!---Doesn't float right in xs--->
                <span class="float-sm-right">
                    <a href="/index.cfm?reloadapp=#APPLICATION.ReloadKey#">Reload App</a>
                    <br />
                    <a href="/index.cfm?reloadappanddb=#APPLICATION.ReloadKey#">Reload App & DB</a>
                </span>
            </div>
            <div class="col-12">
                <hr />
            </div>
            <!---APPLICATION Scope Variables--->
            <div class="col-12">
                <h5>APPLICATION Scope Variables</h5>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-sm">
                        <tbody>
                            <cfloop collection="#APPLICATION#" item="i">
                                <!---Not displaying APPLICATION scope components such as "APPLICATION.Inst" etc., displaying variables only--->
                                <cfif !IsValid("Component", APPLICATION[i])>
                                    <tr>
                                        <td>##APPLICATION.#i###</td>
                                        <!---Calling "ReplaceNoCase" for variables that contain "<" and ">"--->
                                        <td>"#ReplaceNoCase(ReplaceNoCase(APPLICATION[i], '<', '&lt;'), '>', '&gt;')#"</td>
                                    </tr>
                                </cfif>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
            <!---CGI Scope Variables--->
            <div class="col-12">
                <h5>CGI Scope Variables</h5>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-sm">
                        <tbody>
                            <tr>
                                <td>##CGI.SCRIPT_NAME##</td>
                                <td>"#CGI.SCRIPT_NAME#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.QUERY_STRING##</td>
                                <td>"#CGI.QUERY_STRING#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.SERVER_NAME##</td>
                                <td>"#CGI.SERVER_NAME#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.HTTP_USER_AGENT##</td>
                                <td>"#CGI.HTTP_USER_AGENT#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.HTTP_ACCEPT_LANGUAGE##</td>
                                <td>"#CGI.HTTP_ACCEPT_LANGUAGE#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.HTTPS## (on, off)</td>
                                <td>"#CGI.HTTPS#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.CF_TEMPLATE_PATH##</td>
                                <td>"#CGI.CF_TEMPLATE_PATH#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.HTTP_REFERER##</td>
                                <td>"#CGI.HTTP_REFERER#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.LOCAL_ADDR##</td>
                                <td>"#CGI.LOCAL_ADDR#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.REMOTE_ADDR##</td>
                                <td>"#CGI.REMOTE_ADDR#"</td>
                            </tr>
                            <tr>
                                <td>##CGI.REQUEST_URL##</td>
                                <td>"#CGI.REQUEST_URL#"</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!---getPageContext Calls--->
            <div class="col-12">
                <h5>getPageContext Calls</h5>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-sm">
                        <tbody>
                            <!---No "getPageContext()" equivalent to CGI.CF_TEMPLATE_PATH--->
                            <tr>
                                <td>##getPageContext().getRequest().getServletPath()##</td>
                                <td>"#getPageContext().getRequest().getServletPath()#"</td>
                            </tr>
                            <tr>
                                <td>##getPageContext().getRequest().getQueryString()##</td>
                                <td>"#getPageContext().getRequest().getQueryString()#"</td>
                            </tr>
                            <tr>
                                <td>##getPageContext().getRequest().getServerName()##</td>
                                <td>"#getPageContext().getRequest().getServerName()#"</td>
                            </tr>
                            <tr>
                                <td>##getPageContext().getRequest().getHeader("User-Agent")##</td>
                                <td>"#getPageContext().getRequest().getHeader("User-Agent")#"</td>
                            </tr>
                            <tr>
                                <td>##getPageContext().getRequest().getHeader("Accept-Language")##</td>
                                <td>"#getPageContext().getRequest().getHeader("Accept-Language")#"</td>
                            </tr>
                            <tr>
                                <td>##getPageContext().getRequest().getScheme()## (http, https, ftp)</td>
                                <td>"#getPageContext().getRequest().getScheme()#"</td>
                            </tr>
                            <tr>
                                <td>##getPageContext().getRequest().getHeader("Referer")##</td>
                                <td>"#getPageContext().getRequest().getHeader("Referer")#"</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!---COOKIE Scope Variables--->
            <div class="col-12">
                <h5>COOKIE Scope Variables</h5>
                <cfif StructCount(COOKIE)>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-sm">
                            <tbody>
                                <cfloop collection="#COOKIE#" item="i">
                                    <tr>
                                        <td>##COOKIE.#i###</td>
                                        <td>"#COOKIE[i]#"</td>
                                    </tr>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                <cfelse>
                    <p class="ml-3">No COOKIE scope variables.</p>
                </cfif>
            </div>
            <!---URL Scope Variables--->
            <div class="col-12">
                <h5>URL Scope Variables</h5>
                <cfif StructCount(URL)>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-sm">
                            <tbody>
                                <cfloop collection="#URL#" item="i">
                                    <tr>
                                        <td>##URL.#i###</td>
                                        <td>"#URL[i]#"</td>
                                    </tr>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                <cfelse>
                    <p class="ml-3">No URL scope variables.</p>
                </cfif>
            </div>
            <!---FORM Scope Variables--->
            <div class="col-12">
                <h5>FORM Scope Variables</h5>
                <cfif StructCount(FORM)>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-sm">
                            <tbody>
                                <cfloop collection="#FORM#" item="i">
                                    <tr>
                                        <td>##FORM.#i###</td>
                                        <td>
                                            <!---Added if statement to put a space between the field names for "FORM.FieldNames"--->
                                            <cfif i EQ "FieldNames">
                                                <cfloop list="#FORM.FieldNames#" index="j">
                                                    <cfoutput>#j#,&nbsp;</cfoutput>
                                                </cfloop>
                                            <cfelse>
                                                "#FORM[i]#"
                                            </cfif>
                                        </td>
                                    </tr>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                <cfelse>
                    <p class="ml-3">No FORM scope variables.</p>
                </cfif>
            </div>
            <!---REQUEST Scope Variables--->
            <div class="col-12">
                <h5>REQUEST Scope Variables</h5>
                <cfif StructCount(REQUEST)>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-sm">
                            <tbody>
                                <cfloop collection="#REQUEST#" item="i">
                                    <!---If it's a REQUEST scope query or array then skip it--->
                                    <cfif !IsQuery(Evaluate("REQUEST." & i)) AND !IsArray(Evaluate("REQUEST." & i))>
                                        <!---Is a REQUEST scope string (REQUEST.SomeString)--->
                                        <cfif !IsStruct(Evaluate("REQUEST." & i))>
                                            <tr>
                                                <td>##REQUEST.#i###</td>
                                                <td>"#REQUEST[i]#"</td>
                                            </tr>
                                        <!---REQUEST scope might include structs, if it's a REQUEST scope struct, could contain queries and models that can't be displayed as strings--->
                                        <cfelseif IsStruct(Evaluate("REQUEST." & i))>
                                            <!---Looping REQUEST scope struct--->
                                            <cfloop collection="#Evaluate("REQUEST." & i)#" item="j">
                                                <!---Is a REQUEST scope string in struct (REQUEST.SomeStruct.SomeString)--->
                                                <!---Check to make sure it's not a struct, query, or array--->
                                                <cfif !IsStruct(Evaluate("REQUEST." & i & "." & j)) AND !IsQuery(Evaluate("REQUEST." & i & "." & j)) AND !IsArray(Evaluate("REQUEST." & i & "." & j))>
                                                    <tr>
                                                        <td>##REQUEST.#i#.#j###</td>
                                                        <td>"#Evaluate("REQUEST." & i & "." & j)#"</td>
                                                    </tr>
                                                <!---Is a REQUEST scope model or query in struct which cannot be output as a string--->
                                                <cfelse>
                                                    <tr>
                                                        <td>##REQUEST.#i#.#j###</td>
                                                        <td>Cannont cast model or query as string, but does exist.</td>
                                                    </tr>
                                                </cfif>
                                            </cfloop>
                                        </cfif>
                                    </cfif>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                <cfelse>
                    <p class="ml-3">No REQUEST scope variables.</p>
                </cfif>
            </div>
            <!---SESSION Scope Variables--->
            <div class="col-12">
                <h5>SESSION Scope Variables</h5>
                <cfif StructCount(SESSION)>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-sm">
                            <tbody>
                                <!---SESSION scope might include structs (SESSION.SomeStruct etc.)--->
                                <cfloop collection="#SESSION#" item="i">
                                    <!---Is a SESSION scope string (SESSION.SomeString)--->
                                    <cfif !IsStruct(Evaluate("SESSION." & i))>
                                        <tr>
                                            <td>##SESSION.#i###</td>
                                            <td>"#SESSION[i]#"</td>
                                        </tr>
                                    <!---Is a SESSION scope struct, could contain queries and models that can't be displayed as strings --->
                                    <cfelseif IsStruct(Evaluate("SESSION." & i))>
                                        <!---Looping SESSION scope struct--->
                                        <cfloop collection="#Evaluate("SESSION." & i)#" item="j">
                                            <!---Is a SESSION scope string in struct (SESSION.SomeStruct.SomeString)--->
                                            <!---Check to make sure it's not a struct, query, or array--->
                                            <cfif !IsStruct(Evaluate("SESSION." & i & "." & j)) AND !IsQuery(Evaluate("SESSION." & i & "." & j)) AND !IsArray(Evaluate("SESSION." & i & "." & j))>
                                                <tr>
                                                    <td>##SESSION.#i#.#j###</td>
                                                    <td>"#Evaluate("SESSION." & i & "." & j)#"</td>
                                                </tr>
                                            <!---Is a SESSION scope model or query in struct which cannot be output as a string--->
                                            <cfelse>
                                                <tr>
                                                    <td>##SESSION.#i#.#j###</td>
                                                    <td>Cannont cast model or query as string, but does exist.</td>
                                                </tr>
                                            </cfif>
                                        </cfloop>
                                    </cfif>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                <cfelse>
                    <p class="ml-3">No SESSION scope variables.</p>
                </cfif>
            </div>
            <!---Expand Path Calls--->
            <div class="col-12">
                <h5>Expand Path Calls</h5>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-sm">
                        <tbody>
                            <tr>
                                <td>Site Root: ##ExpandPath("/")##</td>
                                <td>"#ExpandPath("/")#"</td>
                            </tr>
                            <tr>
                                <td>Current Directory: ##ExpandPath("./"##)</td>
                                <td>"#ExpandPath("./")#"</td>
                            </tr>
                            <tr>
                                <td>Back a Directory: ##ExpandPath(".././")##</td>
                                <td>"#ExpandPath(".././")#"</td>
                            </tr>
                            <tr>
                                <td>Path to this Specific Include File: ##GetCurrentTemplatePath()##</td>
                                <td>"#GetCurrentTemplatePath()#"</td>
                            </tr>
                            <tr>
                                <td>Directory of this Specific Include File: ##GetDirectoryFromPath(GetCurrentTemplatePath())##</td>
                                <td>"#GetDirectoryFromPath(GetCurrentTemplatePath())#"</td>
                            </tr>
                            <tr>
                                <td>Current Executing Page: ##GetBaseTemplatePath()##</td>
                                <td>"#GetBaseTemplatePath()#"</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</cfoutput>