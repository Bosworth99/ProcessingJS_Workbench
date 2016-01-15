
var _seeds = [];

void setup(){
	console.log("gr3ph.k0e.5.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(0);
  	frameRate(28);


}

void draw(){  

	fill(0,5);
	noStroke();
	rect(0, 0, screen.width, screen.height);

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
	int len;
	float step;

	float tx;
	float ty;
	//float xPos;
	float yPos;
	float rot;

	color stk;

	Seed () {
		update();
	}

	void update(){

		count 	= 0;
		age 	= random(200,800);
		step 	= 3;
		len 	= random(screen.width/1.5,screen.width);

		tx 		= random((screen.width/2)-150,(screen.width/2)+150);
		ty 		= random((screen.height/2)-150,(screen.height/2)+150);

		//xPos 	= 0;
		yPos 	= 0;
		rot 	= 180;

		stk 	= color(#ffffff);

	}

	void grow (){

		if (count > age){
			update();
		}

		count++;
		yPos 	+= 1;
		//xPos 	+= 0.1;
		rot 	+= 0.01;
		step 	+= .5;

		draw();
	}

	void draw(){
		
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(20,40);
		float lng 		= (screen.width-len)+random(50,350);

		pushMatrix();
		stroke(stk, 255);			
		translate(tx,ty);
	
		for (int x=0; x<= lng; x+=step) {
			y = yPos + noise(ynoise) * random(2);

			rot += .0001;
			rotate(rot);

			if (lastx > -999) {
				line(x, y, lastx, lasty);
			}

			lastx = x;
			lasty = y;

			ynoise += 0.01;

		}

		popMatrix();

	}

}