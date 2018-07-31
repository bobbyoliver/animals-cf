<cfoutput>
    <!---Submit modal--->
    <div class="modal fade" id="sys-confirm-submit" tabindex="-1" role="dialog" aria-labelledby="sys-confirm-submit-label" aria-hidden="true">
        <!---modal-sm gives modal less width--->
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header small">
                    <p class="modal-title" id="sys-confirm-submit-label">Are you sure?</p>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-right">
                    <button class="btn btn-sm btn-danger py-0" type="button" data-dismiss="modal">Cancel</button>
                    <button class="btn btn-sm btn-success py-0" name="ButtonModalSubmit" type="submit">Yes, Submit</button>
                </div>
                <!---<div class="modal-footer"></div>--->
            </div>
        </div>
    </div>
</cfoutput>