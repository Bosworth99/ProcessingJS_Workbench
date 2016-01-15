
//Seed[] _seeds = new Seed[0];
var _seeds=[];
int _keyFrameTimer=151;
int _backgroundTimer=501;

var _colors = [#000000,#FFFF00,#06FF00,#3338FF,#FFFFFF];
var _bg 	= [#910000,#C5BE76,#46FFF5];
var _fil;

void setup(){
	console.log("sprak.ktyl.3.pde");

  	size(screen.width, screen.height);
  	frameRate(24);
}

void draw(){  

	if(_backgroundTimer>300){
		_backgroundTimer=0;
		_fil = (color) _bg[ (int) random(_bg.length) ];
	}
	_backgroundTimer++;

	fill( _fil, 5);
	noStroke();
	rect(0, 0, screen.width, screen.height);
	stroke();

	if( _keyFrameTimer > 150 ){
		_keyFrameTimer=0;

		_seeds.push( new Seed() );
	}
	_keyFrameTimer++;

 	var tmp = [];

	for (var i = _seeds.length - 1; i >= 0; i--) {
		(Seed) _seeds[i].grow();

		if ( !_seeds[i].dead){
			tmp.push(_seeds[i]);
		}
	};

	_seeds = tmp;
}

interface Growth {void grow();}

class Seed implements Growth{

	var dead;
	int count;
	int age;
	int len;
	float girth;
	float step;

	float tx;
	float ty;
	float rot;

	color stk;

	var _config = {};

	Seed () {
		init(); 
	}

	void init(){

		_config.ascend = ( random(10)>5)?true:false;
		_config.grow = true;

		dead 	= false;
		count 	= 0;
		age 	= random(450,550);
		girth	= random(10,20);
		step 	= 1;
		len 	= random(50, 250);

		if(_config.ascend){
			tx 	= random(250, screen.width - 250);
			ty 	= screen.height/2;
		} else {
			tx 	= random(250, screen.width - 250);
			ty 	= screen.height/2;
		}

		rot 	= 0;
		stk 	= (color) _colors[ (int) random(_colors.length) ];
	}

	void grow (){

		if (count > age){
			dead = true;
		}
		count++;

		increment();
		stroke_fill();
		spot_point();
	}

	void increment(){


		if(_config.ascend){
			tx		+= random(-10, 10);
			ty 		+= .5;
		} else {
			tx 		+= random(-10, 10);
			ty 		-= .5;
		}

		if (girth>400){
			_config.grow = false;
		} else if (girth < 25 ){
			_config.grow = true;
		}

		girth 	+= (_config.grow)?2:-1;
		step 	+= .01;
		rot 	+= .1;

	}

	void stroke_fill(){
		
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(30);

		pushMatrix();		
		translate(tx,ty);

		for (int x=0; x<=len; x+=step) {
			y = noise(ynoise) * random(50);

			var gx = random(girth-50,girth+100);
			var gy = random(girth-50,girth+100);

			strokeWeight( random(10+random(20)) );
			stroke(stk,155);
			fill( _fil, 5);

			if (lastx > -999) {
				arc(x, y, gx, gy, lastx, lasty);
			}
			rotate(PI/180 * rot);	

			lastx = x;
			lasty = y;

			ynoise += .1;

		}

		popMatrix();

	}

	void spot_point(){

		float px 	= random(tx-random(girth),tx+random(girth));
		float py	= random(ty-girth,ty+girth);
		int dia	= random(1,20);

		if(random(10)>7){
			noStroke();
			fill(stk,255);
			ellipse(px, py, dia, dia);
		} 
	}

}