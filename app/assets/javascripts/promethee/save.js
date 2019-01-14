/*global $, document */
$(function () {
    'use strict';

    if ($('div[ng-app=Promethee]').length === 0) {
        return;
    }

    // CTRL + S on promethee does save the page
    $(document).bind('keydown', function (e) {
        if ((e.ctrlKey || e.metaKey) && (e.which === 83)) {
            e.preventDefault();
            $('form').submit();
            return false;
        }
    });
});