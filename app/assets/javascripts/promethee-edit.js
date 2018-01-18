var promethee = angular
  .module('Promethee', ['summernote', 'ngAnimate'])
  .value('definitions', [])
  // What does the next 3 lines do? Why?
  .config(function($rootScopeProvider) {
    $rootScopeProvider.digestTtl(20);
  })
  .filter('htmlSafe', ['$sce', function($sce) {
    return function(val) {
      return $sce.trustAsHtml(val);
    };
  }])
  .filter('urlSafe', ['$sce', function($sce) {
    return function(val) {
      return $sce.trustAsResourceUrl(val);
    };
  }])
  .filter('humanize', function() {
    return function(val) {
      val = (val + '').replace(/_/g, ' ').replace(/([A-Z])/g, ' $1').replace(/\s\s+/, ' ').trim();
      return val[0].toUpperCase() + val.substring(1).toLowerCase();
    };
  })
  .filter('textContentFromHTML', function() {
    return function(val, distinctParagraphs) {
      var element = document.createElement('div');
      element.innerHTML = val;

      if(distinctParagraphs === 'distinctParagraphs') {
        var paragraphs = element.querySelectorAll('p');
        for(var i = 0; i < paragraphs.length; i++) paragraphs[i].textContent += ' ';
      }

      return element.textContent;
    }
  })
  .filter('numberOfCharacters', function() {
    return function(val) {
      return val.length;
    };
  })
  .filter('numberOfWords', function() {
    return function(val) {
      var words = val
        .replace(/\bhttps?:\/\/[a-z0-9\-\._]+(?:\/[^\s\n\r]+)?/gi, 'a') // A URL is one word
        .replace(/\b[a-z0-9\-\._]+@[a-z0-9\-\._]+\.[a-z0-9\-\._]+\b/gi, 'a') // An email is one word
        .replace(/[^a-z0-9\s\n\r]/gi, ' ')
        .replace(/[\s\n\r]+/g, ' ')
        .trim()
        .split(' ');

      return words[0] === '' ? 0 : words.length;
    };
  });

promethee.controller('PrometheeController', ['$scope', 'definitions', '$http', function($scope, definitions, $http) {

  // Data (TODO use Adder and probably page definition to init)
  if($scope.data === null || $scope.data === '') {
    $scope.data = {
      id: '',
      type: 'page',
      version: 1,
      children: []
    };
  }
  
  $scope.promethee = { 
    data: $scope.data,
    inspected: null,
    mode: 'write',
    //mode: 'move',
    preview: 'desktop',
    fullscreen: false
  };

  $scope.inspect = function(component, event) {
    $scope.promethee.inspected = component;
    event.stopPropagation();
  }

  $scope.enablePreview = function() {
    if (this.promethee.mode === 'preview') return;
    this.promethee.mode = 'preview';

    var form = document.createElement('form');
    document.body.appendChild(form);
    form.method = 'POST';
    form.action = '/promethee/preview';
    form.target = 'preview';
    
    var input = document.createElement('input');
    input.type = 'text';
    input.value = JSON.stringify($scope.promethee.data);
    input.name = 'data';
    form.appendChild(input);
    form.submit();
    document.body.removeChild(form);
  }

  $scope.remove = function(component, components) {
    var index = components.indexOf(component);
    components.splice(index, 1);
  }

}]);


promethee.controller('AdderController', ['$scope', '$rootScope', 'definitions', function($scope, $rootScope, definitions) {

  $scope.adding = false;
  $scope.childrenToAddTo = null;
  $scope.definitions = definitions;

  $scope.close = function() {
    $scope.adding = false;
    $scope.addingToChildren = null;
  };

  $scope.pushComponent = function(definition) {
    var definition = angular.copy(definition.data);
    definition.id = $scope.createIdentifier();
    $scope.childrenToAddTo.push(definition);
    $scope.close();
  };

  $rootScope.addComponentTo = function(components) {
    $scope.adding = true;
    $scope.childrenToAddTo = components;
  };

  // https://gist.github.com/gordonbrander/2230317
  $scope.createIdentifier = function () {
    // Math.random should be unique because of its seeding algorithm.
    // Convert it to base 36 (numbers + letters), and grab the first 9 characters
    // after the decimal.
    return '' + Math.random().toString(36).substr(2, 9);
  };

}])



promethee
  .directive('draggable', function() {
    return {
      restrict:'A',
      link: function(scope, element, attrs) {
        element.draggable({
          revert: true,
          revertDuration: 0,
          scroll: true,
          refreshPositions: true,
          cursor: 'move', 
          start: function() {
            var $elementDragged = $(element[0]);
            var type = $elementDragged.data('type');
            $('.promethee-edit__move').addClass('promethee-edit__move--dragging promethee-edit__move--dragging--' + type);

            // The droppable zone immediately before has no use, it would put the object at the same position
            // FIXME the selector is not correct
            /*
            var $droppableBefore = $elementDragged.prev('.promethee-edit__move__draggable').find('.promethee-edit__move__droppable').last();
            if ($droppableBefore.length === 0) {
              // For the first child, we look for the previous droppable zone
              $droppableBefore = $elementDragged.prev('.promethee-edit__move__droppable');
            }
            $droppableBefore.addClass('promethee-edit__move__droppable--hidden');
            */
          },
          stop: function() {
            var $elementDragged = $(element[0]);
            var type = $elementDragged.data('type');
            $('.promethee-edit__move').removeClass('promethee-edit__move--dragging promethee-edit__move--dragging--' + type);
            // $('.promethee-edit__move__droppable').removeClass('promethee-edit__move__droppable--hidden');
          }
        });
      }
    }
  })
  .directive('droppable', function($compile) {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        element.droppable({
          tolerance: 'pointer',
          drop: function(event, ui) {
            var draggedFromList = angular.element(ui.draggable).parent().scope().components;
            var draggedFromIndex = parseInt(ui.draggable[0].getAttribute('data-index'));
            // console.log('dragged', draggedFromList, draggedFromIndex);
            draggedFromList.splice(draggedFromIndex, 1);

            var component = angular.element(ui.draggable).scope().component;
            var droppedToList = angular.element(this).scope().components;
            var droppedToIndex = parseInt(this.getAttribute('data-index'));
            if (draggedFromList == droppedToList) {
              // The object we dragged was removed from the list
              if (draggedFromIndex < droppedToIndex) {
                // It was before the dropped index, so removing it changed the index
                droppedToIndex -= 1;
              }
            }
            // console.log('dropped', component, droppedToList, droppedToIndex);
            droppedToList.splice(droppedToIndex, 0, component);

            scope.$apply();
          }
        });
      }
    }
  });