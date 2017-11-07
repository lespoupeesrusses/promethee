Promethee.Controller = function(promethee) {
  this.promethee = promethee;
};

Promethee.Controller.prototype = {
  constructor: Promethee.Controller,
  abstract: true,

  get name() {
    return this.constructor.name;
  },

  initializer: function() {

  },

  initialize: function() {
    var self = this;

    this.promethee.app.controller(this.name, function() {
      self.initializer.apply(this, arguments);
    });
  }
};

Promethee.Controller.for = function(name, initializer, abstract) {
  var self = this;

  var controller = function() {
    self.apply(this, arguments);
  };

  if(typeof initializer !== 'function') initializer = function() {};
  controller.name = name;

  controller.prototype = Object.create(self.prototype, {
    constructor: {
      value: controller
    },

    abstract: {
      value: !!abstract
    },

    initializer: {
      value: function() {
        self.prototype.initializer.apply(this, arguments);
        initializer.apply(this, arguments);
      }
    }
  };

  controller.for = this.for;

  this[name] = controller;
};

Promethee.Controller.for.abstract = function(name, initializer) {
  this.for(name, initializer, true);
};
