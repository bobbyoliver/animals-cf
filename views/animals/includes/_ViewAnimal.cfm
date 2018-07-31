<!---BODY ========================================================--->
<cfoutput>
    <!---"SeparatorLine" is now the same whether building a PDF or displaying a view--->
    <cfset SeparatorLine = "<div class=""row""><div class=""col float-left""><hr class=""my-1"" /></div></div>">
    <!---Time stamp for when building a PDF--->
    <cfif REQUEST.ReqStr.BuildPDF EQ true>
        <!---Without "clearfix" class this div will be hidden in pdf--->
        <div class="row small clearfix">
            <div class="col-12 float-left">
                <p class="float-right text-muted mt-0 mb-2 pt-0">Created: #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=REQUEST.ReqStr.UTCNow, Format='DateTimeForDisplay')#</p>
            </div>
        </div>
    </cfif>

    <!---EDIT--->
    <cfif REQUEST.action EQ "animal">
        <!---Non editable fields--->
        <div class="card bg-light mb-3 mt-2 clearfix">
            <div class="card-body py-1">
                <!---Created--->
                <div class="row small">
                    <div class="col-4 float-left">
                        Created:
                    </div>
                    <div class="col-8 float-left">
                        #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getCreatedAt(), Format="DateTimeForDisplay")#<!---DateTimeLinkBreakForDisplay--->
                    </div>
                </div>
                #SeparatorLine#

                <!---Updated--->
                <div class="row small">
                    <div class="col-4 float-left">
                        Updated:
                    </div>
                    <div class="col-8 float-left">
                        #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getUpdatedAt(), Format="DateTimeForDisplay")#<!---DateTimeLinkBreakForDisplay--->
                    </div>
                </div>
                <!---#SeparatorLine#--->
            </div>
        </div>
    </cfif>

    <!---Editable fields--->
    <div class="card bg-light mb-3 clearfix">
        <div class="card-body py-1">
            <!---Animal--->
            <div class="row small">
                <div class="col-4 float-left">
                    Animal Name: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        #Model.getName()#
                    <cfelseif REQUEST.action EQ "addanimal">
                        #SESSION.AnimalStepsStr.EncName#
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Keeper--->
            <div class="row small">
                <div class="col-4 float-left">
                    Keeper: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif !IsNull(Model.getKeeper())>
                            #Model.getKeeper().getFirstName()# #Model.getKeeper().getLastName()#
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Area--->
            <div class="row small">
                <div class="col-4 float-left">
                    Area:
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <!---Associated Area model isn't required--->
                        <cfif !IsNull(Model.getArea())>
                            #Model.getArea().getArea()#
                        <cfelse>
                            Not entered
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Species--->
            <div class="row small">
                <div class="col-4 float-left">
                    Species: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getSpecies() NEQ "">
                            #Model.getSpecies()#
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---DOB--->
            <div class="row small">
                <div class="col-4 float-left">
                    DOB: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getDOB() NEQ "">
                            <!---No UTC considerations with calculating age--->
                            #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getDOB(), Format="DateForDisplay")# (<cfif DateDiff("yyyy", Model.getDOB(), Now()) EQ 0>Less than 1 year of age<cfelseif DateDiff("yyyy", Model.getDOB(), Now()) EQ 1>1 year of age<cfelse>#DateDiff("yyyy", Model.getDOB(), Now())# years of age</cfif>)
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Gender--->
            <div class="row small">
                <div class="col-4 float-left">
                    Gender: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getGender() NEQ "">
                            <cfif Model.getGender() EQ "m">Male<cfelseif Model.getGender() EQ "f">Female</cfif>
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Type--->
            <div class="row small">
                <div class="col-4 float-left">
                    Type: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif !IsNull(Model.getType())>
                            #Model.getType().getType()#
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Notes--->
            <div class="row small">
                <div class="col-4 float-left">
                    Notes:
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getNotes() NEQ "">
                            #Model.getNotes()#
                        <cfelse>
                            Not entered
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---SpecialDietBit--->
            <div class="row small">
                <div class="col-4 float-left">
                    Special Diet: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getSpecialDietBit() NEQ "">
                            <cfif Model.getSpecialDietBit() EQ true>
                                Yes
                            <cfelseif Model.getSpecialDietBit() EQ false>
                                No
                            </cfif>
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---SpecialDiet--->
            <!---Can be hidden on form, so can be hidden in view too--->
            <cfif REQUEST.action EQ "animal">
                <cfif Model.getSpecialDietBit() EQ true>
                    <div class="row small">
                        <div class="col-4 float-left">
                            Special Diet Instructions: <span class="text-danger">*</span>
                        </div>
                        <div class="col-8 float-left">
                            <cfif Model.getSpecialDiet() NEQ "">
                                #Model.getSpecialDiet()#
                            <cfelse>
                                Not entered yet
                            </cfif>
                        </div>
                    </div>
                    #SeparatorLine#
                </cfif>
            </cfif>

            <!---FavoriteColor--->
            <div class="row small">
                <div class="col-4 float-left">
                    Favorite Color:
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getFavoriteColor() NEQ "">
                            #Model.getFavoriteColor()#
                        <cfelse>
                            Not entered
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---FavoriteColorExplain--->
            <!---Can be hidden on form, so can be hidden in view too--->
            <cfif REQUEST.action EQ "animal">
                <cfif Model.getFavoriteColor() NEQ "">
                    <div class="row small">
                        <div class="col-4 float-left">
                            Color Choice Explanation: <span class="text-danger">*</span>
                        </div>
                        <div class="col-8 float-left">
                            <cfif Model.getFavoriteColorExplain() NEQ "">
                                #Model.getFavoriteColorExplain()#
                            <cfelse>
                                Not entered yet
                            </cfif>
                        </div>
                    </div>
                    #SeparatorLine#
                </cfif>
            </cfif>

            <!---ArrivedAt--->
            <div class="row small">
                <div class="col-4 float-left">
                    Arrival: <span class="text-danger">*</span>
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getArrivedAt() NEQ "">
                            #APPLICATION.Inst.DateTimeUTCToTimeZone(DateTime=Model.getArrivedAt(), Format="DateTimeForDisplay")#<!---DateTimeLinkBreakForDisplay--->
                        <cfelse>
                            Not entered yet
                        </cfif>
                    </cfif>
                </div>
            </div>
            #SeparatorLine#

            <!---Avatar--->
            <div class="row small">
                <div class="col-4 float-left">
                    Avatar:
                </div>
                <div class="col-8 float-left">
                    <cfif REQUEST.action EQ "animal">
                        <cfif Model.getFileUUIDAvatar() NEQ "">
                            <a class="btn btn-sm btn-outline-dark pb-0" data-toggle="tooltip" data-placement="top" title="Download" href="/index.cfm?controller=#REQUEST.controller#&action=getfile&filename=#Model.getFileUUIDAvatar()#"><i class="fas fa-download"></i></a>
                        <cfelse>
                            Not entered
                        </cfif>
                    </cfif>
                </div>
            </div>
            <!---#SeparatorLine#--->
        </div>
    </div>
    <!---Delete record modal--->
    <form id="sys-form" name="sys-form" role="form" action="/index.cfm?controller=#REQUEST.controller#&action=#REQUEST.action#&id=#Model.getID()#&pageaction=delete&start=#URL.Start#" method="post" enctype="multipart/form-data">
        <cfinclude template="/views/animals/includes/_ModalSubmit.cfm">
    </form>
</cfoutput>