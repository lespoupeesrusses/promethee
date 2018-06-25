//= require angular-summernote/dist/angular-summernote
//= require angular-ui-sortable/dist/sortable
//= require ng-file-upload/dist/ng-file-upload
//= require angular-bootstrap-colorpicker/js/bootstrap-colorpicker-module
//= require fancybox/dist/js/jquery.fancybox
//= require promethee/fancybox

window.onbeforeunload = function(evt) {
  if (document.body.className.match(/\bpromethee-page-locked\b/)) {
    var messageText = 'You have modified this page. If you quit this page without saving it, all changes will be lost.';
    if (typeof evt == 'undefined') {
        evt = window.event;
    }
    if (evt) {
        evt.returnValue = messageText;
    }
    return messageText;
  }
};
