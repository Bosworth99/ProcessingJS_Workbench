
//Seed[] _seeds = new Seed[0];
var _seeds=[];
int _keyFrameTimer=51;
int _backgroundTimer=301;

var _bg = #000000;

void setup(){
	console.log("sprak.ktyl.1.pde");

  	size(screen.width, screen.height);
  	background(0,50);
  	frameRate(60);
  	strokeWeight(10);

}

void draw(){  

	var colors = [#180962,#783A25,#5D5D5D,#BEC721,#630707,#CE8E7B,#54FF35,#00F9F9,#000000,#FF1C1C];
	if(_backgroundTimer>300){
		_backgroundTimer=0;
		_bg = colors[ (int) random(colors.length-1) ];
		console.log('_bg', _bg);
	}
	_backgroundTimer++;

	fill( _bg, 3);
	noStroke();
	rect(0, 0, screen.width, screen.height);
	stroke();

	if( _keyFrameTimer > frameRate/3 ){
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

		_config.circ = ( random(10) >5)?true:false;

		dead 	= false;
		count 	= 0;
		age 	= random(200, 300);
		girth	= random(100, 200);
		step 	= 1;
		len 	= random(50, 500);

		tx 		= random(250, screen.width - 250);
		ty 		= random(150, screen.height - 150);

		rot 	= random(360);

		stk 	= color(#ffffff);
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

		tx 		+= random(-5, 5);
		ty 		+= random(-5, 5);
		rot 	+= random(-5, 5);

		girth 	+= 2;
		step 	+= 1;

	}

	void draw(){
		
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(10);

		pushMatrix();
		stroke(stk, 255);			
		translate(tx,ty);

		for (int x=0; x<=len; x+=step) {
			y = noise(ynoise) * random(10);

			var gx,gy;

			if(_config.circ){
				gx = random(girth/2);
				gy = random(girth/2);
			} else {
				gx=gy=random(girth/2);
			}

			strokeWeight( random(10) );
			if (lastx > -999) {
				arc(x, y, gx, gy, lastx, lasty);
			}

			rotate(PI/180 * rot);	

			lastx = x;
			lasty = y;

			ynoise += .001;

		}

		popMatrix();

	}

}