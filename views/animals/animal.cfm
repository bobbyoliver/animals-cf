<!---BODY ========================================================--->
<cfoutput>
    <div class="container">
        <cfif URL.PageAction EQ "view" OR URL.PageAction EQ "buildpdf">
            <div class="row">
                <div class="col-12 my-0 small">
                    <ul class="nav float-left">
                        <li class="nav-item">
                            <a class="nav-link sys-href-primary" href="/index.cfm?controller=animals&action=animals&start=#URL.Start#"><i class="fas fa-arrow-circle-left mr-1"></i> Return to Animals</a>
                        </li>
                    </ul>
                    <!---Break in xs to stack two uls--->
                    <div class="clearfix d-block d-sm-none"></div>
                    <!---Float right sm and above--->
                    <ul class="nav float-sm-right">
                        <li class="nav-item">
                            <a class="nav-link sys-href-primary" href="/index.cfm?controller=animals&action=animal&id=#Model.getID()#&pageaction=edit&start=#URL.Start#"><i class="fas fa-edit mr-1"></i> Edit</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link sys-href-primary" href="/index.cfm?controller=animals&action=animal&id=#Model.getID()#&pageaction=buildpdf&start=#URL.Start#"><i class="fas fa-download mr-1"></i> PDF</a>
                        </li>
                        <!---Hardcoded Delete into record nav--->
                        <li class="nav-item">
                            <button style="text-decoration:none;" class="btn btn-link py-1" type="button" name="ButtonSubmit" data-toggle="modal" data-target="##sys-confirm-submit"><span class="small"><i class='fas fa-trash mr-1'></i> Delete</span></button>
                        </li>
                    </ul>
                </div>
            </div>
        </cfif>
        <cfif StructKeyExists(SESSION, "AlertPageTop")><cfinclude template="/views/includes/_AlertPageTop.cfm"></cfif>
        <cfif StructKeyExists(SESSION, "AlertForm")><cfinclude template="/views/includes/_AlertForm.cfm"></cfif>
        <!---DOWNLOAD FILE--->
        <cfif URL.PageAction EQ "buildpdf">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="alert alert-primary alert-dismissable fade show" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <small class="pr-3">
                            Animal Profile
                            <a class="alert-link" href="/index.cfm?controller=animals&action=getfile&filename=#FileUUIDProfile#.pdf">Ready for Download</a>
                            (#APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=REQUEST.ReqStr.UTCNow, Format='DateTimeForDisplay')#)
                            <a class="alert-link ml-2" href="/index.cfm?controller=animals&action=getfile&filename=#FileUUIDProfile#.pdf"><i class="fas fa-download"></i></a>
                        </small>
                    </div>
                </div>
            </div>
        </cfif>
        <cfif URL.PageAction EQ "view" OR URL.PageAction EQ "buildpdf">
            <!---Model view include, has it's own rows--->
            <cfinclude template="/views/animals/includes/_ViewAnimal.cfm">
        <cfelseif URL.PageAction EQ "edit">
            <!---Model view include, has it's own rows--->
            <cfinclude template="/views/animals/includes/_FormCreateUpdateAnimal.cfm">
        </cfif>
    </div>
</cfoutput>