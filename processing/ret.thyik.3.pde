
//Seed[] _seeds = new Seed[0];

var _seeds		= [];
var _bg 		= [#720509,#1CF0F0,#E88704];
int _bgTimer	= 999;
int _keyTimer	= 999;

int _col 		= 24;
int _row 		= 20;

Object _target 	= new Object();
String _dir 	= "RIGHT";
String _oDir  	= "UP";

void setup(){
	console.log("ret.thyik.3.pde");

  	size(screen.width, screen.height);
  	frameRate(60);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){

	float oh 	= screen.height/_row;
	float ow	= screen.width/_col;

	for (int r = 0; r < _row; ++r) {

		for (int c = 0; c < _col; ++c) {
			
			Object data 	= {};
			data.row 		= r;
			data.col 		= c;
			data.h 			= oh;
			data.w 			= ow;

			_seeds.push( new Seed(data) )
		}
	}

	_target.x = screen.width/2;
	_target.y = screen.height/2;

}

void draw(){  

	updateTarget();
	overlay();

	for (var i = _seeds.length - 1; i >= 0; i--) {
		(Seed) _seeds[i].grow(_target);
	};
	
}

void updateTarget(){

	if(_keyTimer > 60){
		_keyTimer = 0;

		_dir = getPath();
		
		float distX = screen.width/_col;
		float distY = screen.height/_row;
		int steps 	= random(4);

		switch ( _dir ) {
			
			case "UP" :
				_target.ty = _target.y-(distY*steps);
			break;	

			case "DOWN" :
				_target.ty = _target.y+(distY*steps);
			break;	

			case "LEFT" :
				_target.tx = _target.x-(distX*steps);	
			break;	

			case "RIGHT" :
				_target.tx = _target.x+(distX*steps);		
			break;	

			case "RAND" :
				int c = random(_col);
				int r = random(_row);
				_target.tx = c * distX;
				_target.ty = r * distY;
			break;
		}

		_oDir = _dir;

		console.log('path:%s, x:%s, y:%s',_dir,_target.x,_target.y);
	}

	if(_dir == "UP" || _target.ty > _target.y){
		_target.y += (_target.ty - _target.y)/5;
	}

	if(_dir == "DOWN" || _target.y > _target.ty){
		_target.y -= (_target.y - _target.ty)/5;
	}

	if(_dir == "LEFT" || _target.x > _target.tx){
		_target.x -= (_target.x - _target.tx)/5;
	}

	if(_dir == "RIGHT" || _target.tx > _target.x){
		_target.x += (_target.tx - _target.x)/5;
	}

	_keyTimer++;

}

void getPath(){

	// if we're offscreen, reverse course
	if( _target.x < 50 || _target.x > screen.width-50 || _target.y < 50 || _target.y > screen.height-50){ return "RAND"; }

	// good chance to return last value. unless its a RAND jump
	if(random(10) > 5){
		if(_oDir != "RAND"){
			return _oDir;
		}
	}

	// nope, pick a new direction
	int ran = random(1099);

	if ( ran < 250 ) {
		return "UP";
	} else if ( ran > 250 && ran < 500 ){
		return "DOWN";
	} else if ( ran > 500 && ran < 750 ){
		return "LEFT";
	} else if ( ran > 750 && ran < 1050 ){
		return "RIGHT";
	} else if ( ran > 1050 ){
		return "RAND";
	}
}

void overlay(){

	if(_bgTimer>998){
		_bgTimer=0;
		_fil = (color) _bg[ (int) random(_bg.length) ];
	}
	_bgTimer++;

	fill( _fil, 3);
	noStroke();
	rect(0, 0, screen.width, screen.height);
	stroke();
}

interface Growth {void grow();}

class Seed implements Growth{

	String 	id;
	int 	count;
	float 	dia;
	float 	x;
	float 	y;
	float 	gain;
	float 	nz;
	int 	nzAge;
	boolean out;

	Seed (d) {
		init(d);
	}

	void init(d){
		id 		= "Seed_"+ (int) random(9999);
		count 	= 0;
		x		= d.col * d.w;
		y		= d.row * d.h;
		dia		= ((d.w < d.h)?d.w:d.h);
		gain 	= random(-1, 8);
		nz 		= random(10,30);
		nzAge 	= random(20,120);
		out 	= true;
	}

	void grow (t){
		
		render(t);

		count++;

		if (out){
			nz += .1;
			if(nz>nzAge){
				out = false;
			}
		} else {
			nz -= .1;
			if(nz<0){
				out = true;
			}
		}
	}	

	void render(t){

		float dis = dist( t.x, t.y, x, y);
		//float dis = dist(x, y, mouseX, mouseY);

		float w = dia*(dia/dis);
		float h = dia*(dia/dis);

		if(w<1){w=1;}
		if(w>dia){w=dia;}
		if(h<1){h=1};
		if(h>dia){h=dia};

		fill(255,5);
		strokeWeight( random(1.5) );
		ellipse(x + dia/2, y + dia/2, (w*noise(nz))*gain, (h*noise(nz))*gain );

	}

}