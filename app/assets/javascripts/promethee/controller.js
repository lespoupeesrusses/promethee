Promethee.Controller = function(name, initializer) {
  this.name = name;
  this.initializer = initializer;
};

Promethee.Controller.prototype = {
  constructor: Promethee.Controller,

  initialize: function(promethee) {
    promethee.app.controller(this.name, this.initializer);
  }
};

Promethee.Controller.controllers = {};

Promethee.Controller.for = function(name, initializer) {
  this.controllers[name] = new this(name, initializer);
};

Promethee.Controller.initialize = function(promethee) {
  for(var name in this.controllers) this.controllers[name].initialize(promethee);
};
