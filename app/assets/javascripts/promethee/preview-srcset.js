/*global $, document */
$(function () {
    'use strict';
    // NOTE: srcset is supposed to be clean, but when we resize the iframe the images inside aren't recalculate to switch to the proper src.
    // It takes the desktop image and reduce it.
    // To avoid this unwanted effect we just remove the srcset on preview, so we always use the base src image
    $('.promethee-previewmode').click(function () {
        $('.promethee-edit__preview-frame').contents().find('img').each(function () {
            $(this).removeAttr('srcset');
        });
    });
});