
var _seeds = [];

void setup(){
	console.log("gr3ph.k0e.3.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(#36252C);
  	frameRate(60);
}

void draw(){  

	if (_seeds.length < 15){
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
	int len;

	float xPos;
	float yPos;
	float rot;

	color stk;

	Seed () {
		update();
	}

	void update(){

		count 	= 0;
		age 	= (random(1) * (100+600)) - 100;
		len 	= random(screen.width);

		xPos 	= random(screen.width / 1.5);
		yPos 	= random(screen.height / 1.7);
		rot 	= random(180);

		if(random(10)>5){
			stk 	= color(#ffffff);
		} else {
			stk 	= color(#000000);
		}

	}

	void grow (){

		if (count > age){
			update();
		}

		count++;
		yPos 	+= 0.01;
		xPos 	+= 0.01;
		rot 	+= 0.01;

		stroke(stk, random(255));			

		rotate(rot);
		draw();

	}

	void draw(){
		
		int step 		= 1;
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(20);
		float lng 		= (screen.width-len)+random(50,350);

		for (int x=xPos; x<= lng; x+=step) {
			y = yPos + noise(ynoise) * random(2);

			if (lastx > -999) {
				line(x, y, lastx, lasty);
			}

			lastx = x;
			lasty = y;

			ynoise += 0.01;

		}

	}

}