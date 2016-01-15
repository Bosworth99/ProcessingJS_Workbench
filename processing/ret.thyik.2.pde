
//Seed[] _seeds = new Seed[0];

var _seeds		= [];
var _bg 		= [#720509,#1FCC00,#E88704];
int _bgTimer	= 501;

Object _target 	= new Object();
boolean _tDir	= true;

void setup(){
	console.log("ret.thyik.2.pde");

  	size(screen.width, screen.height);
  	frameRate(24);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){

	int row		= 14;
	int col 	= 18;
	float oh 	= screen.height/row;
	float ow	= screen.width/col;

	for (int r = 0; r < row; ++r) {

		for (int c = 0; c < col; ++c) {
			
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

	_target.y += random(-10,10);

	if(_tDir){

		_target.x += 10;

		if ( _target.x > screen.width )	{
			_tDir = false;

		}

	} else {

		_target.x -= 10;

		if ( _target.x < 0 )	{
			_tDir = true;

		}
	}
}

void overlay(){

	if(_bgTimer>300){
		_bgTimer=0;
		_fil = (color) _bg[ (int) random(_bg.length) ];
	}
	_bgTimer++;

	fill( _fil, 10);
	noStroke();
	rect(0, 0, screen.width, screen.height);
	stroke();
}

interface Growth {void grow();}

class Seed implements Growth{

	String 	id;
	int 	count;

	int 	row;
	int 	col;
	float 	x;
	float 	y;
	float 	h;
	float 	w;

	float   nz = random(10);

	Seed (d) {
		init(d);
	}

	void init(d){
		id 		= "Seed_"+ (int) random(9999);
		count 	= 0;

		row		= d.row;
		col		= d.col;
		w		= d.w;
		h		= d.h;
		x		= col * w;
		y		= row * h;
	}

	void grow (t){

		render(t);
	}	

	void render(t){

		float size = dist(x, y, t.x, t.y);
		//float size = dist(x, y, mouseX, mouseY);

		fill(255,5);
		ellipse(x + w/2, y + h/2, w-(size/nz), h-(size/nz ) );

	}
}