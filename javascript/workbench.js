//////////////////////////////////////////////
//
//  Workbench
//
//////////////////////////////////////////////

// namespace
var B99 = window.B99||{};

// initializer class
B99.Main = function(){

    var self = this;
    var control;

    self.init = function(){
        console.log('B99.Main::init');

        control = new B99.Control();
        control.init();

        self.start();
    }

    self.start = function(){
        console.log('B99.Main::start');
        control.start();
        
    }

    self.init();

    return true;
};


B99.Control = function(){

    var self = this;
    var $ = window.$;

    var _control, _gear, _full, _title;

    self.init = function(){
        console.log('B99.Control::init');

        _control    = $('#control');
        _control.addClass('control-over control-in');
        _control.data('state','in');

        _full = $('#fullscreen');

        _title      = $('h1.header');

        self.assembleElements();
        self.addEventHandlers();
        self.start();
    }

    self.start = function(){
        console.log('B99.Control::start');
    }

    self.assembleElements = function(){
        _gear       = $(self.makeGear());
        _control.prepend(_gear);
    }

    self.addEventHandlers = function(){

        _control.on({
            'mouseenter' : function(e,args){
                _control.addClass('control-over').removeClass('control-up');
                _gear.addClass('gear-over').removeClass('gear-up');
            },
            'mouseleave' : function(e,args){
                _control.addClass('control-up').removeClass('control-over');
                _gear.addClass('gear-up').removeClass('gear-over');
            },
            'click'         : function(e,args){
                if(_control.data('state') == 'in'){
                    _control.addClass('control-out').removeClass('control-in');
                    _gear.addClass('gear-out').removeClass('gear-in');
                    _control.data('state', 'out');
                    _title.addClass('out').removeClass('in');

                } else {
                    _control.addClass('control-in').removeClass('control-out');
                    _gear.addClass('gear-in').removeClass('gear-out');
                    _control.data('state','in');
                    _title.addClass('in').removeClass('out');                   
                }
            }
        });

        _full.on({
            'click' : function (e,args){
                e.preventDefault();
                self.goFullScreen();
            }

        });

    }

    self.goFullScreen = function(){
        var canvas = document.getElementById("cvs");
        if(canvas.requestFullScreen)
            canvas.requestFullScreen();
        else if(canvas.webkitRequestFullScreen)
            canvas.webkitRequestFullScreen();
        else if(canvas.mozRequestFullScreen)
            canvas.mozRequestFullScreen();
    }

    self.makeGear = function(){
        var str = '';
        str     += '<span id="gear" class="gear gear-up gear-in" data-state="in"><span>___</span></span>';
        return str;
    }

    return{
        init:self.init,
        start:self.start
    };
};