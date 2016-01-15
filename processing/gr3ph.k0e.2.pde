
var _seeds = [];

void setup(){
	console.log("gr3ph.k0e.2.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(#000000);
  	frameRate(60);

  	for (int i = 0; i < 100; i++) {
		var n = new Seed(i);
		_seeds.push(n);	  		
  	}

  	console.log('seeds:: ', _seeds);
}

void draw(){  

	for (int i = 0; i < _seeds.length; ++i) {
		_seeds[i].grow();
	}

	fill(#000000, 10);
	noStroke();
	rect(0, 0, screen.width, screen.height);

	stroke();
}

interface Growth {
	void grow();
}

class Seed implements Growth{

	int count;
	int age;
	int id;

	float ySpeed;
	float xSpeed;
	float xPos;
	float yPos;
	float rot;

	color stk;

	Seed (n) {
		console.log('Seed%s', n);
		id = n;
		update();
	}

	void update(){

		count 	= 0;
		age 	= random(125,500);

		xPos 	= random(0, screen.width-500);
		yPos 	= random(0, screen.height-200);

		xSpeed 	= random(-0.1,0.1);
		ySpeed 	= random(-0.1,0.1);

		rot 	= random(-10,10);

		stk 	= color(#ffffff);

		/*
		if(random(10)>6){
			stk 	= color(#3C4148);
		} else {
			stk 	= color(#ffffff);
		}
		*/

		console.log('Seed%s::Update ',id, xPos, yPos);
	}

	void grow (){

		int step 		= 3;
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(50,120);
		float y 		= yPos;

		if (count > age){
			update();
		}

		ySpeed  += 0.005;
		xSpeed  += 0.005;
		rot 	+= 0.001;
		yPos 	+= ySpeed;
		xPos 	+= xSpeed;
		count++;

		pushMatrix();
		stroke(stk);
		translate(xPos, yPos);
		rotate(rot);

		for (int x=random(0, 50); x<= random(900, 1200); x+=step) {
			y = (yPos + noise(ynoise))*3;

			if (lastx > -999) {
				line(x, y, lastx, lasty);
			}

			lastx = x;
			lasty = y;

			ynoise += 0.1;

		}

		popMatrix();

	}

}