class IncludeTemplate < HTMLIframeElement {
  constructor() {
    super();
  }

  get target() {
    return this._target;
  }

  set target(v) {
    v = v ? '' + v : null;

    if(v !== this.target) {
      this.setAttribute('target', v ? v : '');
      this._target = v;
    }
  }

  get content() {
    return this.contentWindow;
  }

  get template() {
    try {
      return document.querySelector('define-template#' + this.target);
    }
    catch(e) {
      return null;
    }
  }

  load() {
    var template = this.template;
    if(template) this.content.document.body.appendChild(template.instance);
  }

  attributeChangedCallback(attribute, oldValue, newValue) {
    this[attribute] = newValue;
  }

  static get observedAttributes() {
    return ['target'];
  }
}

class DefineTemplate < HTMLTemplateElement {
  constructor() {
    super();
  }

  get instance() {
    return document.importNode(this.content, true);
  }
}

// Promethee.Frame = function(element) {
//   this.element = element;
// };

// Promethee.Frame.prototype = {
//   get available() {
//     return this.element instanceof HTMLIframeElement;
//   },

//   get window() {
//     return this.available ? this.element.contentWindow : null;
//   },

//   get document() {
//     return this.available ? this.window.document : null;
//   },

//   get template() {
//     return this.available ? this.element.getAttribute('data-template') : null;
//   },

//   set template(v) {
//     if(this.available) {
//       this.element.setAttribute('data-template', v);
//       this.load();
//     }
//   },

//   get source() {
//     try {
//       return document.querySelector('template#' + this.template);
//     }
//     catch(e) {
//       return null;
//     }
//   },

//   get content() {
//     var source = this.source;
//     return source ? document.importNode(source.content, true) : null;
//   },

//   create: function() {
//     this.element = document.createElement('iframe');

//     return this;
//   },

//   load: function() {
//     if(this.available) {
//       var content = this.content;
//       if(content) this.document.body.appendChild(content);
//     }

//     return this;
//   }
// };
