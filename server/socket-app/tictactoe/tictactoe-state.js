var _ = require('lodash');

module.exports = function (injected) {

    return function (history) {

        var isFull = false;
        var movesMaded = 0;
        var board = new Array(9);

        function gameFull(){
          return isFull;
        }

        function processEvent(event){
        console.log(event);
            if(event.type === "GameJoined"){
              isFull = true;
            }
            //if(event.type == "FullGameJoinAttempted")
        }

        function processEvent(event){

        }

        function processEvent(event){

        }

        function processEvents(history) {
            _.each(history, processEvent);
        }

        processEvents(history);

        return {
            processEvents: processEvents,
            gameFull: gameFull

        }
    };
};
