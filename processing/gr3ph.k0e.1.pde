
var _seeds = [];

void setup(){
	console.log("gr3ph.k0e.1.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(#303025);
  	frameRate(606);
}

void draw(){  

	if (_seeds.length < 3){
		var n = new Seed();
		_seeds.push(n);
	};

	for (var i = _seeds.length - 1; i >= 0; i--) {
		_seeds[i].grow();
	};

}

interface Growth {void grow();}

class Seed implements Growth{

	int count;
	int age;

	float xPos;
	float yPos;
	float rot;

	color stk;
	int stkA = 255;

	Seed () {
		update();
	}

	void update(){

		count 	= 0;
		age 	= (random(1) * (300+500)) - 300;

		xPos 	= random(50, screen.width-50);
		yPos 	= random(50, screen.height-50);
		rot 	= random(PI/360, PI/180);

		if(random(10)>5){
			stk 	= color(#ffffff);
		} else {
			stk 	= color(000);
		}

	}

	void grow (){

		if (count > age){
			update();
		}

		count++;
		yPos 	+= 1;
		xPos 	+= 1;
		rot 	+= 0.01;

		stroke(stk, stkA);			

		if( count < stkA ){
			stroke(stk, count);
		} 

		if( (count - 255) < stkA ){
			stroke(stk, (age-count));
		}

		rotate(rot);
		draw();

	}

	void draw(){
		
		int step 		= 1;
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(10);
		float y 		= yPos;
		float x 		= xPos;

		for (int x=20; x<=width-20; x+=step) {
			y = (height/2)-50 + noise(ynoise) * 80;

			if (lastx > -999) {
				line(x, y, lastx, lasty);
			}

			lastx = x;
			lasty = y;

			ynoise += 0.03;

		}

	}

}