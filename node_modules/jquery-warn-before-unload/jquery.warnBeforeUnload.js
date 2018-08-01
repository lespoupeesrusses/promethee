/*global window, $ */
window.warnBeforeUnload = {

    className: 'warn-before-unload',

    ignored: {
        classes: ['do-not-warn-before-unload', 'filter'],
        types: ['search']
    },

    message: 'You have entered new data on this page. If you navigate away from this page without first saving your data, the changes will be lost.',

    init: function () {
        'use strict';
        this.watchUnload();
        this.watchInputs();
        this.watchSubmits();
    },

    watchUnload: function () {
        'use strict';
        var that = this;
        window.addEventListener('beforeunload', function (event) {
            if ($('body').hasClass(that.className)) {
                event.returnValue = that.message;
                return that.message;
            }
        });
    },

    watchInputs: function () {
        'use strict';
        var that = this;
        $(':input, textarea').bind('change', function () {
            if (that.shouldLock(this)) {
                that.lock();
            }
        });
    },

    watchSubmits: function () {
        'use strict';
        var that = this;
        $('form').on('submit', function () {
            that.unlock();
        });
    },

    shouldLock: function (object) {
        'use strict';
        var that = this;
        var shouldLock = true;
        that.ignored.classes.forEach(function (item) {
            if ($(object).hasClass(item)) {
                shouldLock = false;
            }
        });
        that.ignored.types.forEach(function (item) {
            if ($(object).attr('type') === item) {
                shouldLock = false;
            }
        });
        return shouldLock;
    },

    lock: function () {
        'use strict';
        $('body').addClass(this.className);
    },

    unlock: function () {
        'use strict';
        $('body').removeClass(this.className);
    }

};

$(function () {
    'use strict';
    window.warnBeforeUnload.init();
});