const IncomingSocketMessageDispatcher = require('./incoming-socket-message-dispatcher')(inject({}));

describe('socket message dispatcher', function(){
    var socket;
    var messageDispatcher;
    var router;
    var session;

    beforeEach(function(){

        socket = {
            _subscriptions: {},
            on: function (verb, callback) {
                console.debug("Subscribe ", verb);
                socket._subscriptions[verb] = callback;
            },
            removeListener:function(verb, callback){
                delete socket._subscriptions[verb];
            }
        };

        router = {
            _dispatched:[],
            routeMessage:function(message){
                router._dispatched.push(message);
            }
        };

        session = {sessionId: 99};
        messageDispatcher = new IncomingSocketMessageDispatcher('issueCommand', socket, router, session);
    });

    it('should subscribe to commandIssued messages',function(){
        expect(socket._subscriptions['issueCommand']).toBeTruthy();
    });

    it('should route command object on commandIssued',function(){
        socket._subscriptions['issueCommand']({message:'dummy'});
        expect(router._dispatched.length).toBe(1);
        expect(router._dispatched[0].message).toBe("dummy");
    });

    it('should attach session object to message',function(){
        socket._subscriptions['issueCommand']({message:'dummy'});
        expect(router._dispatched.length).toBe(1);
        expect(router._dispatched[0].message).toBe("dummy");
        expect(router._dispatched[0]._session.sessionId).toBe(99);
    });

    it('should remove socket listener when stop dispatching called.',function(){
        messageDispatcher.stopDispatching();
        expect(socket._subscriptions['issueCommand']).toBeFalsy();

    });
});
