<cfoutput>
    <!---Cancel modal--->
    <div class="modal fade" id="sys-confirm-cancel" tabindex="-1" role="dialog" aria-labelledby="sys-confirm-cancel-label" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header small">
                    <p class="modal-title" id="sys-confirm-cancel-label">Are you sure?</p>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-right">
                    <button class="btn btn-sm btn-danger py-0" name="ButtonModalCancel" type="submit">Yes, Cancel</button>
                </div>
            </div>
        </div>
    </div>
</cfoutput>