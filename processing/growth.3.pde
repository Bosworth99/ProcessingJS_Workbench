
var _seeds = [];
//Growth[] growth = new Growth[10];

void setup(){
	console.log("Growth.3.pde - js/processing mix");

  	size(screen.width, screen.height);
  	background(#A8CFFF);
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

	float yRad;
	float xRad;
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

		age 	= random(300,500);
		yRad 	= random(100, 400);
		xRad 	= random(yRad - 40, yRad + 40);;

		xPos 	= random(50, screen.width-50);
		yPos 	= random(50, screen.height-400);
		speed 	= random(0.1, 0.8);
		growth 	= random(0.1, 0.4);
		rot 	= random(PI/360);

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
		yRad 	+= (yRad*growth)/100;
		xRad 	+= (xRad*growth)/100;
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
		//ellipse(xPos, yPos, yRad, xRad );

		beginShape();
		curveVertex(xPos,  yPos);
		curveVertex(xPos + xRad,  yPos + yRad);
		curveVertex(xPos - xRad,  yPos + yRad);
		curveVertex(xPos - xRad,  yPos - yRad);
		curveVertex(xPos + xRad,  yPos - yRad);
		curveVertex(xPos + xRad,  yPos + yRad);
		curveVertex(xPos,  yPos);
		endShape();


	}

}