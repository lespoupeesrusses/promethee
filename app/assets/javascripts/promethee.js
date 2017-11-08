//= require tinymce
//= require angular
//= require angular-ui-tinymce-rails
//= require angular-drag-and-drop-lists
//= require_self
//= require_tree './promethee'

Promethee = function(id, data) {
  this.id = id;
  this.data = data;
};

Promethee.prototype = {
  constructor: Promethee,
  dependencies: ['ui.tinymce', 'dndLists'],

  get app() {
    if(!this.initialized) this.initialize();
    return this._app;
  },

  get initialized() {
    return !!this._app;
  },

  initialize: function() {
    this._app = angular
      .module(this.id, this.dependencies)
      .constant('promethee', this)
      .value('state', {
        editing: false
      })

    this.app.filter('htmlSafe', ['$sce', function($sce){
      return function(val) {
        return $sce.trustAsHtml(val);
      };
    }]);

    this.constructor.Controller.initialize(this);
  }
};
