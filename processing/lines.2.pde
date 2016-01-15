
// generative art stuff - chapter 3

var _sketch = [];
interface Sketch{ void update(); }

void setup(){
	console.log("Lines.2.pde - js/processing mix");

  	size(600,600);
  	background(#000000);

  	strokeWeight(2);
  	smooth();
  	//noFill();
  	//noLoop();
  	frameRate(24);

	line(0, height/2, width, height/2);
	ellipse(height/2,height/2,height/1.2,height/1.2);

	strokeWeight(1);

	for (int i = 0; i < 1; ++i) {
		var s = new NoiseyNoiseGrid();
		_sketch.push(s);
	};

}
 
void draw() {

	for (int i = 0; i < _sketch.length; ++i) {
		_sketch[i].update();
	};

}

public class NoiseyNoiseGrid implements Sketch {

	float xstart, xnoise, ystart, ynoise;
	float xstartNoise, ystartNoise;

	public NoiseyNoiseGrid () {
		console.log('NoiseyNoiseGrid',this);

		xstartNoise = random(20);
		ystartNoise = random(20);

		xstart = random(10);
		ystart = random(10);
	}

	void update(){
		background(0);

		xstartNoise += 0.01;
		ystartNoise += 0.01;

		xstart += (noise(xstartNoise) * 0.5) - 0.25;
		ystart += (noise(ystartNoise) * 0.5) - 0.25;

		xnoise = xstart;
		ynoise = ystart;

		for (int y = 0; y <= height; y+=18) {

			ynoise += 0.1;
			xnoise = xstart;

			for (int x = 0; x <= width; x+=18) {
				xnoise += 0.1;
				drawPoint(x, y, noise(xnoise, ynoise));
			}
		}
	}

	void drawPoint(float x, float y, float noiseFactor) {
		pushMatrix();
		translate(x,y);
		rotate(noiseFactor * radians(360));
		stroke(255,175);
		line(0,0,35,0);
		popMatrix();
	}

}

public class NoiseGrid implements Sketch {

	float xstart, xnoise, ynoise;

	public NoiseGrid () {
		console.log('NoiseGrid',this);

		xstart = random(4);
		xnoise = xstart;
		ynoise = random(4);
	}

	void update(){
		background(#000000,10);

		for (int y = 0; y <= height; y+=4) {
			ynoise += 0.05;
			xnoise = xstart;
			stroke(#ffffff);

			for (int x = 0; x <= width; x+=4) {
				xnoise += 0.05;
				drawPoint(x, y, noise(xnoise, ynoise));
			}
		}

	}

	void drawPoint(float x, float y, float noiseFactor) {
		pushMatrix();
		translate(x,y);
		rotate(noiseFactor * radians(540));

		float edgeSize = noiseFactor * 120;
		float grey = 50 + (noiseFactor * 150);
		float alph = 50 + (noiseFactor * 60);

		noStroke();
		fill(grey, alph);
		ellipse(0,0, edgeSize, edgeSize/2);

		popMatrix();
	}

}


public class ShapeGrid implements Sketch {

	float _xstart = random(10);
	float _xnoise = _xstart;
	float _ynoise = random(10);

	public ShapeGrid () {
		console.log('ShapeGrid',this);

	}

	void drawPoint(float x, float y, float noiseFactor){
		float len=random(200,600)*noiseFactor;
		float edgesize=noiseFactor*350;
		float grey=150+(noiseFactor*120);
		float alph=150+(noiseFactor*120);

		stroke( ((random(10)-3)>3)?#000000:#ffffff, alph);
		rect(x,y,10,10);

		pushMatrix();
		translate(x,y);
		rotate(noiseFactor * radians(540));

		
		//line(0,0,len,0);
		ellipse(0,0, edgesize, edgesize/2);

		popMatrix();
	}

	void update(){

		for (int y = 0; y <= height; y+=(screen.height/12)){
			_ynoise += 0.1;
			_xnoise = _xstart;

			for (int x = 0; x <= width; x+=(screen.width/12)) {
				_xnoise += 0.1;
				int alph = int(noise(_xnoise, _ynoise) * 255);

				//line(x,y, x+1, y+1);
				drawPoint(x,y,noise(_xnoise,_ynoise));
			}
		}

	}
}

public class WaveClock implements Sketch {

	float _angnoise, _radiusnoise;
	float _xnoise, _ynoise;
	float _angle = -PI/2;
	float _radius;
	float _strokeCol = 254;
	int _strokeChange = -1;

	public WaveClock () {
		console.log('WaveClock',this);
		
		_angnoise = random(10);
		_radiusnoise = random(10);
		_xnoise = random(10);
		_ynoise = random(10);		

	}

	void update(){

		_radiusnoise += 0.005;
		_radius = (noise(_radiusnoise) * 550) +1;

		_angnoise += 0.005;
		_angle += (noise(_angnoise) * 6) - 3;

		if (_angle > 360) { _angle -= 360; }
		if (_angle < 0) { _angle += 360; }

		_xnoise += 0.01;
		_ynoise += 0.01;

		float centerX = width/2 + (noise(_xnoise) * 100) - 50;
		float centerY = height/2 + (noise(_ynoise) * 100) - 50;
		float rad = radians(_angle);
		float x1 = centerX + (_radius * cos(rad));
		float y1 = centerY + (_radius * sin(rad));
		float opprad = rad + PI;
		float x2 = centerX + (_radius * cos(opprad));
		float y2 = centerY + (_radius * sin(opprad));
		_strokeCol += _strokeChange;

		if (_strokeCol > 254) { _strokeChange = -1; }
		if (_strokeCol < 0) { _strokeChange = 1; }

		stroke(_strokeCol, 60);
		strokeWeight(1);
		line(x1, y1, x2, y2);

	}


}