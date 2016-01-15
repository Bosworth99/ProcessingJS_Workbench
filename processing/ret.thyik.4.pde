//////////////////////////////////////////////////////////////////////////////
//
// source  : ret.thyik.4.pde
// author  : josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////


var _seeds		= [];

int _col 		= 24;
int _row 		= 20;

Overlay _overlay;
Target _target;

void setup(){
	console.log("ret.thyik.4.pde");

  	size(screen.width, screen.height, P2D);
  	frameRate(60);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){

	_target 	= new Target(_col,_row);
	_overlay 	= new Overlay();

	for (int r = 0; r < _row; ++r) {

		for (int c = 0; c < _col; ++c) {
			
			Object data 	= {};
			data.overlay 	= _overlay;
			data.target 	= _target;
			data.row 		= r;
			data.col 		= c;
			data.h 			= screen.height/_row;
			data.w 			= screen.width/_col;

			_seeds.push( new Seed(data) );
		}
	}

	console.log(_target, _overlay, _seeds);

}

void draw(){  

	_target.grow();
	_overlay.grow();

	for (var i = _seeds.length - 1; i >= 0; i--) {
		(Seed) _seeds[i].grow();
	};
	
}

interface Growth {void grow();}

class Overlay implements Growth {

	var _colors;
	int _bgTimer;
	public color mainColor;
	public color altColor;

	public Overlay () {
		init();
	}

	void init(){
		_colors 	= [#444444,#0404BB,#548FFE,#527C03,#D6E701,#534526,#AE1A15,#58A05A];
		_bgTimer	= 999;
		mainColor 	= #ffffff;
		altColor 	= #000000;

		console.log('new Overlay()', _colors);
	}

	public void grow(){
		render();
	}

	void render(){

		// update mainColor every n seconds
		if(_bgTimer>frameRate*10){
			_bgTimer=0;
			mainColor 	= (color) _colors[ (int) random(_colors.length) ];
			altColor 	= (color) _colors[ (int) random(_colors.length) ];
		}
		_bgTimer++;

		noStroke();

		fill( mainColor, 3);
		rect(0, 0, screen.width, screen.height);

		if(random(100)>80){

			strokeWeight( random(400, 600) );

			if( random(10)>5 ){
				stroke( altColor, 1);
			} else {
				stroke( 255, 1);
			}
			
			line(0, random((screen.height/2)-300,(screen.height/2)+300), screen.width, random((screen.height/2)-300,(screen.height/2)+300));
		}
	}

}

class Target implements Growth{

	public float x;
	public float y;
	float 		_tx;
	float 		_ty;


	int 		_col;
	int 		_row;

	int 		_keyTimer;
	String 		_dir;
	String 		_oDir;

	float 		_distX;
	float 		_distY;

	float 		_oMouseX;
	float 		_oMouseY;
	float 		_ease;

	int 		_mouseTimer;
	boolean 	_doMouse;

	public Target (int col, int row) {

		_col = col;
		_row = row;

		init();
	}

	void init(){
		console.log('new Target()');

		x 			= screen.width/2;
		y 			= screen.height/2;

		_distX		= screen.width/_col;
		_distY		= screen.height/_row;	

		_oMouseX 	= screen.width/2;
		_oMouseY 	= screen.height/2;

		_ease 		= 6;

		_mouseTimer = 999;
		_keyTimer	= 999;

		_dir 		= "RIGHT";
		_oDir  		= "RIGHT";
		_doMouse 	= false;
	}

	void grow(){

		mouseCheck();

		if( !_doMouse ){
			updateTarget();
			//console.log('AUTO path:%s, x:%s, y:%s',_dir,_target.x,_target.y);

		} else {		
			x = mouseX;
			y = mouseY;
			//console.log('MOUSE mouseX:%s mouseY:%s',mouseX, mouseY);
		}
	}

	void updateTarget(){

		//console.log('updateTarget _dir:%s _oDir:%s _distX:%s _distY:%s x:%s y:%s _ease:%s',_dir,_oDir,_distX,_distY,x,y,_ease);

		// ease _target.x/y to the target x/y coords
		if(_dir == "UP" || _ty > y){
			y += (_ty - y)/_ease;
		}
		if(_dir == "DOWN" || y > _ty){
			y -= (y - _ty)/_ease;
		}
		if(_dir == "LEFT" || x > _tx){
			x -= (x - _tx)/_ease;
		}
		if(_dir == "RIGHT" || _tx > x){
			x += (_tx - x)/_ease;
		}

		// once a second, update the target.tx/ty values. 
		// use these targets to ease to each frame
		if(_keyTimer > frameRate){

			_keyTimer 	= 0;
			_dir 		= getPath();
			int steps 	= random(4);

			switch ( _dir ) {
				case "UP" :
					_ty = y - (_distY*steps);
					break;	
				case "DOWN" :
					_ty = y + (_distY*steps);
					break;	
				case "LEFT" :
					_tx = x - (_distX*steps);	
					break;	
				case "RIGHT" :
					_tx = x + (_distX*steps);		
					break;	
				case "RAND" :

					// point the target towards the inside
					int c = random(3,_col-3);
					int r = random(3,_row-3);
					_tx = c * _distX;
					_ty = r * _distY;
					break;
			}

			//ellipse(_target.tx, _target.ty, random(9,10), random(9,10));
			_oDir = _dir;
		}

		_keyTimer++;

	}


	// return a string to assign to the increment algorithm
	String getPath(){

		// if we're offscreen, reverse course
		if( x < 150 || x > screen.width-150 || y < 150 || y > screen.height-150){ return "RAND"; }

		// good chance to return last value. unless its a RAND jump
		if(random(10) > 5){
			if(_oDir != "RAND"){
				return _oDir;
			}
		}

		// nope, pick a new direction
		int ran = random(999);

		if ( ran < 250 ) {
			return "UP";
		} else if ( ran > 250 && ran < 500 ){
			return "DOWN";
		} else if ( ran > 500 && ran < 750 ){
			return "LEFT";
		} else if ( ran > 750  ){
			return "RIGHT";
		}

		// else if ( ran > 1050 ){
		//	return "RAND";
		//}
	}


	// once a second, check current mousex against _oMouseX 
	// if they match, we assume the mouse isn't moving, and fire up auto pilot again
	// if they dont match, switch control back to mouseX/Y
	void mouseCheck(){

		if (_mouseTimer > frameRate){
			_mouseTimer = 0;

			_doMouse = true;

			if ( mouseX == _oMouseX || mouseY == _oMouseY ){
				_doMouse = false;
			}

			_oMouseX = mouseX;
			_oMouseY = mouseY;
		}
		_mouseTimer++;

	}

}

class Seed implements Growth{

	Target 	_target;
	Oerlay  _overlay;

	String 	_id;
	int 	_count;

	float 	_dia;
	float 	_x;
	float 	_y;

	float 	_gain;
	float 	_nz;
	int 	_nzAge;

	boolean _out;

	Seed (d) {
		init(d);
	}

	void init(d){

		_overlay 	= d.overlay;
		_target 	= d.target;

		_id 		= "Seed_"+ (int) random(9999);
		_count 		= 0;

		_x			= d.col * d.w;
		_y			= d.row * d.h;
		_dia		= (d.w < d.h)?d.w:d.h;

		_gain 		= random(-1,9);
		_nz 		= random(10,30);
		_nzAge 		= random(20,100);

		_out 		= true;
	}

	void grow (){
		
		render();

		_count++;

		if (_out){
			_nz += .1;
			if(_nz>_nzAge){
				_out = false;
			}
		} else {
			_nz -= .1;
			if(_nz<0){
				_out = true;
			}
		}
	}	

	void render(){

		float dis 	= dist( _target.x, _target.y, _x, _y);
		float w 	= _dia * (_dia/dis);
		float h 	= _dia * (_dia/dis);

		// contain overall ellipse size
		if( w < 1 ){ w=1; }
		if( w > _dia ){ w = _dia; }
		if( h < 1 ){ h=1; }
		if( h > _dia ){ h = _dia; }

		w = (w*noise(_nz))*(_gain*random(.99,1.1));
		h = (h*noise(_nz))*(_gain*random(.99,1.1));

		//randomize the fill
		if(random(10)>9){
			if(random(100)>90){
				fill( _overlay.altColor, 50);
			} else {
				fill(255,255);
			}
		} else {
			fill(255,15);
		}
		
		if(random(100)>90){
			stroke( _overlay.altColor, 99);
		} else {
			stroke(255,99);
		}

		strokeWeight( random(.1, 1.9) );

		// draw dem circles
		pushMatrix();

		translate(_x,_y);

		rotate((PI*_nz/180)/2);

		ellipse( _dia/2, _dia/2, w, h );

		popMatrix();

	}

}