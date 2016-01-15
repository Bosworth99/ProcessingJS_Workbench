//////////////////////////////////////////////////////////////////////////////
//
// source  : waves.1.pde
// author  : josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////

void setup(){

  	size(screen.width, screen.height);
  	background(255,255);

  	fill(0,150);
  	stroke(0,255);
  	strokeWeight(2);

  	noLoop();

}

void draw(){  

	//simpleCircle();
	//noiseyCircle();
	simpleSpiral();
	//sineCurve();

	fill(255, 150);
	rect(0, 0, screen.width, screen.height);
}

void simpleCircle(){
	float radius 	= 300;
	int centX 		= width/2;
	int centY 		= height/2;

	float x, y;
	float lastx = -999;
	float lasty = -999;

	for (float ang = 0; ang <= 360; ang += 5) {
		float rad = radians(ang);
		x = centX + (radius * cos(rad));
		y = centY + (radius * sin(rad));
		//point(x,y);

		if(lastx > -999){
			line(x, y, lastx, lasty);	
		}

		lastx = x;
		lasty = y;
	}

}

float noiseVal = random(10);
void noiseyCircle(){
	float radius 	= 300;
	int centX 		= width/2;
	int centY 		= height/2;

	float x, y;
	float lastx = -999;
	float lasty = -999;
	float radVariance,thisRadius,rad;

	noiseVal += .01;

  	stroke(0,255);
  	strokeWeight(15);

	for (float ang = 0; ang <= 360; ang += 3) {

		noiseVal += 0.1;
		radVariance = 75*noise(noiseVal);

		thisRadius = radius + radVariance;
		rad = radians(ang);

		x = centX + (thisRadius * cos(rad));
		y = centY + (thisRadius * sin(rad));

		if(lastx > -999){
			line(x, y, lastx, lasty);
		}

		lastx = x;
		lasty = y;
	}

}


void simpleSpiral(float $radius){

	int centX 		= width/2;
	int centY 		= height/2;

	float x, y;
	float lastx 	= -999;
	float lasty 	= -999;
	
	float radius 	= ($radius)?$radius:10;
	float radiusNoise = random(10);

  	stroke(0,255);
  	strokeWeight(15);

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