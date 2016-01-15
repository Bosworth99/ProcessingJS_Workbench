
//Seed[] _seeds = new Seed[0];
var _seeds = [];
int _keyFrameTimer = 51;

void setup(){
	console.log("gr3ph.k0e.7.pde");

  	size(screen.width, screen.height);
  	background(0,50);
  	frameRate(60);
  	strokeWeight(15);

}

void draw(){  

	fill(0, 5);
	noStroke();
	rect(0, 0, screen.width, screen.height);

	stroke();

	if( _keyFrameTimer > frameRate ){
		_keyFrameTimer = 0;

		_seeds.push( new Seed() );

		console.log('_seeds %o', _seeds);
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


	//_seeds = _seeds.map( function(e,i){
	//	if (!e.dead){
	//		return e;
	//	}
	//});	

}

interface Growth {void grow();}

class Seed implements Growth{

	var dead;
	int count;
	int age;
	int len;
	float step;

	float tx;
	float ty;
	float xPos;
	float yPos;
	float rot;

	color stk;

	Seed () {
		
		init(); 
	}

	void init(){

		dead 	= false;
		count 	= 0;
		age 	= 500;
		step 	= 5;
		len 	= random(50, 500);

		tx 		= random(150, screen.width - 150);
		ty 		= random(100, screen.height - 100);

		xPos 	= 0;
		yPos 	= 0;
		rot 	= 180;

		stk 	= color(#ffffff);
	}

	void grow (){

		if (count > age){
			dead = true;
		}

		count++;
		yPos 	+= 0.5;
		xPos 	+= 0.5;
		rot 	+= 0.1;
		step 	+= .5;

		draw();
	}

	void draw(){
		
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(20);
		float lng 		= len;

		pushMatrix();
		stroke(stk, 255);			
		translate(tx,ty);
	
		rot += .1;
		rotate(PI/rot*180);	

		for (int x=0; x<= lng; x+=step) {
			y = yPos + noise(ynoise) * random(10,25);

			if (lastx > -999) {
				line(x, y, lastx, lasty);
			}

			rotate(PI/rot*180);	

			lastx = x;
			lasty = y;

			ynoise += 0.01;

		}

		popMatrix();

	}

}