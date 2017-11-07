Promethee.Controller = function(promethee) {
  this.promethee = promethee;
};

Promethee.Controller.prototype = {
  constructor: Promethee.Controller,
  abstract: true,
  name: 'Controller',
  dependencies: [],

  initializer: function() {

  },

  initialize: function() {
    console.log('Initialized '+ this.name + ' controller');

    if(!this.abstract) {
      var self = this;

      this.promethee.app.controller(this.name, this.dependencies.concat([function() {
        this.promethee = self.promethee;
        self.initializer.apply(this, arguments);
      }]));
    }

    var controller;

    for(var i = 0; i < this.constructor.controllers.length; i++) {
      controller = new this.constructor.controllers[i](this.promethee);
      controller.initialize();
    }
  }
};

Promethee.Controller.for = function(name, initializer, abstract) {
  var self = this;

  var controller = function() {
    self.apply(this, arguments);
  };

  if(!Array.isArray(initializer)) initializer = [initializer];
  if(typeof initializer[initializer.length - 1] !== 'function') initializer.push(function() {});

  controller.prototype = Object.create(self.prototype, {
    constructor: {
      value: controller
    },

    abstract: {
      value: !!abstract
    },

    name: {
      value: name
    },

    dependencies: {
      value: initializer.slice(0, -1)
    },

    initializer: {
      value: function() {
        self.prototype.initializer.apply(this, arguments);
        initializer[initializer.length - 1].apply(this, arguments);
      }
    }
  });

  controller.for = this.for;
  controller.controllers = [];

  this.controllers.push(controller);
  this[name] = controller;
};

Promethee.Controller.abstract = function(name, initializer) {
  this.for(name, initializer, true);
};

Promethee.Controller.controllers = [];
