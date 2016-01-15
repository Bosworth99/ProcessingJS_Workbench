
//Seed[] _seeds = new Seed[0];
var _seeds=[];
int _keyFrameTimer=51;
int _backgroundTimer=301;

var _colors = [#000000,#FFFF00,#FFFFFF];
var _bg 	= [#65B1F8,#FEE13D,#15AAAA];
var _fil;

void setup(){
	console.log("sprak.ktyl.2.pde");

  	size(screen.width, screen.height);
  	frameRate(60);
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

	if( _keyFrameTimer > frameRate / 2 ){
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

		dead 	= false;
		count 	= 0;
		age 	= random(150,500);
		girth	= random(50,100);
		step 	= 1;
		len 	= random(50, 250);

		if(_config.ascend){
			tx 	= random(250, screen.width - 250);
			ty 	= screen.height/2;
		} else {
			tx 	= random(250, screen.width - 250);
			ty 	= screen.height/2;
		}

		rot 	= random(360);
		stk 	= (color) _colors[ (int) random(_colors.length) ];
	}

	void grow (){

		if (count > age){
			dead = true;
		}
		count++;

		increment();
		draw();
	}

	void increment(){

		rot 	+= random(-3, 1);

		if(_config.ascend){
			tx		+= random(-2, 2);
			ty 		+= .5;
		} else {
			tx 		+= random(-2, 2);
			ty 		-= .5;
		}

		girth 	+= .8;
		step 	+= .01;

	}

	void draw(){
		
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(30);

		pushMatrix();
		stroke(stk, 150);			
		translate(tx,ty);

		for (int x=0; x<=len; x+=step) {
			y = noise(ynoise) * random(10);

			var gx,gy;

			gx += girth;
			gy += girth;

			strokeWeight( random(10) );
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

}