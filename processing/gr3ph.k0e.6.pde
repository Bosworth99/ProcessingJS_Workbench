
var _seeds = [];

void setup(){
	console.log("gr3ph.k0e.5.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(0,150);
  	frameRate(24);
  	strokeWeight(.5);
}

void draw(){  

	fill(35, 5);
	noStroke();
	rect(0, 0, screen.width, screen.height);

	stroke();

	if (_seeds.length < 7){
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
		age 	= random(500,2000);
		step 	= 50;
		len 	= random(screen.width/2,screen.width);

		tx 		= random((screen.width/2)-150,(screen.width/2)+50);
		ty 		= random((screen.height/2)-150,(screen.height/2)+50);

		//xPos 	= 0;
		yPos 	= 0;
		rot 	= 180;

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
		yPos 	+= 1;
		//xPos 	+= 0.1;
		rot 	+= 0.001;
		step 	+= 0.005;

		draw();
	}

	void draw(){
		
		float lastx 	= -999;
		float lasty 	= -999;
		float ynoise 	= random(5,10);
		float lng 		= (screen.width-len)+random(250,350);

		pushMatrix();
		stroke(stk, 255);			
		translate(tx,ty);
	
		for (int x=0; x<= lng; x+=step) {
			y = yPos + noise(ynoise) * random(5);

			rot += .005;
			rotate(PI/rot*180);

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