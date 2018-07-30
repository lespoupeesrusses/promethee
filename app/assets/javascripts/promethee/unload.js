/*global window */
window.addEventListener("beforeunload", function (event) {
    "use strict";
    var message,
        shouldLock = document.body.className.match(/\bpromethee-page-locked\b/);
    if (shouldLock) {
        message = "You have modified this page. If you quit without saving, your changes will be lost.";
        event.returnValue = message;
        return message;
    }
});
