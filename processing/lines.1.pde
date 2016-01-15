
// generative art stuff - chapter 3


void setup(){
  	size(600,600);
  	background(0);
  	noLoop();

  	strokeWeight(2);
  	smooth();
  	//noFill();

  	stroke(60);
	line(0, height/2, width, height/2);
	ellipse(height/2,height/2,height/1.2,height/1.2);

	//stroke(20,50,70);
	//strokeWeight(5);

	stroke(#ffffff);
	strokeWeight(2);

	//sineCurve();
	//sineCurveCubed();
	noiseyCircle();
	//perlinLine();
	//simpleCircle();
	//simpleSpiral();
	//manySpirals()

}

void draw(){  


}


float customRandom(){
	float val = 1 - pow(random(1),0.3);
	return val;
}

float customNoise(float value){
	int count = int((value % 12));
	float val = pow(sin(value),count);
	return val;
}


void simpleCircle(){
	float radius 	= 200;
	int centX 		= width/2;
	int centY 		= height/2;

	float x, y;
	float lastx = -999;
	float lasty = -999;
	for (float ang = 0; ang <= 360; ang += 5) {
		float rad = radians(ang);
		x = centX + (radius * cos(rad));
		y = centY + (radius * sin(rad));
		point(x,y);
	}

}

void noiseyCircle(){
	float radius 	= 100;
	int centX 		= width/2;
	int centY 		= height/2;

	float x, y;
	float noiseVal = random(10);
	float radVariance,thisRadius,rad;

	fill(random(255), random(255));

	beginShape();

	for (float ang = 0; ang <= 360; ang += 1) {

		noiseVal += 0.1;
		radVariance = 30*customNoise(noiseVal);

		thisRadius = radius + radVariance;
		rad = radians(ang);

		x = centX + (thisRadius * cos(rad));
		y = centY + (thisRadius * sin(rad));

		curveVertex(x,y);
	}

	endShape();

}


void simpleSpiral(float $radius){

	int centX 		= width/2;
	int centY 		= height/2;

	float x, y;
	float lastx 	= -999;
	float lasty 	= -999;
	
	float radius 	= ($radius)?$radius:10;
	float radiusNoise = random(10);

	for (float ang = 0; ang <= 1440; ang += 5) {
		radiusNoise+=0.05;
		radius+=0.5;
		float thisRadius = radius+(noise(radiusNoise)*200)-100;
		float rad = radians(ang);
		x = centX + (thisRadius * cos(rad));
		y = centY + (thisRadius * sin(rad));
		
		if (lastx > -999) {
			line(x,y,lastx,lasty);
		}

		lastx = x;
		lasty = y;

	}

}

void manySpirals(){

	fill();
	for (int i = 0; i < 100; ++i) {
		strokeWeight( random(2) );
		stroke(color(00, 00, random(255)),random(255))
		fill(color(00,random(140,225),00), random(150,255));

		simpleSpiral(random(50, height));
	}
}


void sineCurve(){

	float xstep = 1;
	float lastx = -999;
	float lasty = -999;
	float angle = 0;
	float y 	= 50;

	for (int x=20; x<=screen.width-20; x+=xstep) {

		float rad = radians(angle);
		//y = height/2 + (pow(sin(rad), 3) * noise(rad*2) * 30);
		y = height/2 + (customRandom() * 60);

		if (lastx > -999) {
			line(x, y, lastx, lasty);
		}

		lastx = x;
		lasty = y;
		angle++;
	}
}

void sineCurveCubed(){

	float xstep = 1;
	float lastx = -999;
	float lasty = -999;
	float angle = 0;
	float y 	= 50;

	for (int x=20; x<=screen.width-20; x+=xstep) {

		float rad = radians(angle);
		y = height/2 + (pow(sin(rad),3) * 30);

		if (lastx > -999) {
			line(x, y, lastx, lasty);
		}

		lastx = x;
		lasty = y;
		angle++;
	}
}


void perlinLine(){

  	stroke(20, 50, 70);

	int step 		= 1;
	float lastx 	= -999;
	float lasty 	= -999;
	float ynoise 	= random(10);
	float y;

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