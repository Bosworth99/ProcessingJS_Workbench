
var _seeds = [];
//Growth[] growth = new Growth[10];

void setup(){
	console.log("gr3ph.k0e.0.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(#141414);
  	frameRate(18);
}

void draw(){  

	if (_seeds.length < 5){
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
	boolean out;

	float xPos;
	float yPos;
	float speed;
	float growth;
	float rot;

	color fil;
	int filA = 10;

	color stk;
	int stkA = 255;

	Seed () {
		update();
	}

	void update(){

		count 	= 0;
		out 	= (random(10)>5)?true:false;

		age 	= (random(1) * (300+1000)) - 300;

		xPos 	= random(50, screen.width-50);
		yPos 	= random(50, screen.height-400);
		speed 	= random(0.05, 0.3);
		growth 	= random(0.05, 0.3);
		rot 	= random(PI/180);

		if(random(10)>5){
			fil 	= color(random(255),00, 00);
			stk 	= color(#ffffff);
		} else {
			fil 	= color(00,00, random(255));
			stk 	= color(000);
		}

	}

	void grow (){

		if (count > age){
			update();
		}

		count++;
		yPos 	+= (yPos*speed)/1000;
		xPos 	+= (xPos*speed)/1000;
		rot 	+= (rot*growth)/20;


		fill(fil, filA);
		stroke(stk, stkA);			

		// alpha in
		if( count < filA){
			fill(fil, count);
		} 
		if( count < stkA ){
			stroke(stk, count);
		} 

		// alpha out
		if( (count - 255) > age ){
			fill(fil, (age-count));
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