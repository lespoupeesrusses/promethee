//= require tinymce
//= require angular
//= require angular-ui-tinymce-rails
//= require_self
//= require_tree './promethee'

Promethee = function(name, data) {
  this.name = name;
  this.data = data;
};

Promethee.prototype = {
  constructor: Promethee,
  dependencies: ['ui.tinymce'],

  get app() {
    if(!this.initialized) this.initialize();
    return this._app;
  },

  get initialized() {
    return !!this._app;
  },

  initialize: function() {
    this._app = angular
      .module(this.name, this.dependencies)
      .constant('promethee', this);

    this.app.filter('htmlSafe', ['$sce', function($sce){
      return function(val) {
        return $sce.trustAsHtml(val);
      };
    }]);

    this.constructor.Controller.initialize(this);
  }
};
