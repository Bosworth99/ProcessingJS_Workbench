
// generative art stuff - chapter 3
import processing.opengl.*;

var _sketch = [];

interface Sketch{ void update(); }

void setup(){
	console.log("3D.1.pde - js/processing mix");

  	size(600,600,OPENGL);

  	//strokeWeight(2);
  	smooth();

  	fill(180, 25);
  	stroke(50,70);

  	//noStroke();
  	//noFill();
  	//noLoop();

  	frameRate(12);

	line(0, height/2, width, height/2);
	ellipse(height/2,height/2,height/1.2,height/1.2);


	for (int i = 0; i < 1; ++i) {
		var s = new SimpleSphere();
		_sketch.push(s);
	};

	draw();
}
 
void draw() {
	for (int i = 0; i < _sketch.length; ++i) {
		_sketch[i].update();
	};
}

public class SimpleSphere implements Sketch {

	var rad = 0;
	boolean flip;

	public SimpleSphere () {
		console.log("SimpleSphere");
		flip = true;
	}

	void update(){
		background(0);

		directionalLight(126, 126, 126, 0, 0, -1);
		ambientLight(102, 102, 102);

		if (flip){
			if(rad>120){
				flip = false;
			}
			rad++;
		} else {
			if(rad<40){
				flip = true;
			}
			rad--;
		}

		rotate(PI/rad);
		sphere(150);
		translate(width/2, height/2, 50);
		
		
	}

}


public class NoiseCube implements Sketch {

	float xstart, ystart, zstart;
	float xnoise, ynoise, znoise;
	int sideLength = 200;
	int spacing = 5;

	public NoiseCube () {
		console.log("NoisePlane");
		
		background(0);
		noStroke();

		xstart = random(10);
		ystart = random(10);
		zstart = random(10);
	}

	void update(){

		background(0);
		xstart += 0.01;
		ystart += 0.01;
		zstart += 0.01;

		xnoise = xstart;
		ynoise = ystart;
		znoise = zstart;
		translate(150, 20, -150);
		rotateZ(frameCount * 0.1);
		rotateY(frameCount * 0.1);

		for (int z = 0; z <= sideLength; z+=spacing) {
			znoise += 0.1;
			ynoise = ystart;
			for (int y = 0; y <= sideLength; y+=spacing) {
				ynoise += 0.1;
				xnoise = xstart;
				for (int x = 0; x <= sideLength; x+=spacing) {
					xnoise += 0.1;
					drawPoint(x, y, z, noise(xnoise, ynoise, znoise));
				}
			}
		}
	}

	void drawPoint(float x, float y, float z, float noiseFactor) {

		pushMatrix();
		translate(x, y, z);

		float grey = noiseFactor * 255;
		fill(grey, 10);

		box(spacing, spacing, spacing);
		popMatrix();
	}

}

public class NoisePlane implements Sketch  {

	float xstart, xnoise, ystart, ynoise;

	public NoisePlane () {
		console.log("NoisePlane");

		sphereDetail(8);	

		xstart = random(20);
		ystart = random(20);
	}

	void update(){

		background(#000000);

		xstart += 0.01;
		ystart += 0.01;

		xnoise = xstart;
		ynoise = ystart;

		for (int y = 0; y <= height; y+=10) {
			ynoise += 0.1;
			xnoise = xstart;

			for (int x = 0; x <= width; x+=10) {
				xnoise += 0.1;
				drawPoint(x, y, noise(xnoise, ynoise));
			}
		}
	}

	void drawPoint(float x, float y, float noiseFactor) {

		pushMatrix();
		translate(x, 400 - y, -y);

		float sphereSize = noiseFactor * 60;
		float grey = 150 + (noiseFactor * 120);
		float alph = 150 + (noiseFactor * 120);
		fill(grey, alph);
		sphere(sphereSize);
		popMatrix();

	}

}