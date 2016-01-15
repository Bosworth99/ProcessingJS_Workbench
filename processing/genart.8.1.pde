//////////////////////////////////////////////////////////////////////////////
//
// source  : genart.8.1.pde
// author  : josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////

int _maxLevels = 5;
int _numChildren = 3;

Branch _trunk;

void setup(){
	console.log("genart.8.1.pde - Fractals");

  	size(screen.width, screen.height);
  	frameRate(60);
  	noFill();
  	smooth();
  	background(255);

  	plantTree();
}

void plantTree(){
	_trunk = new Branch(1,0, screen.width/2, screen.height/2);
	_trunk.render();

}

void draw(){  
	background(255, 150);
	_trunk.update(screen.width/2, screen.height/2);
	_trunk.render();
}

class Branch{

	Branch[] children = new Branch[0];

	float level, index;
	float x,y;
	float endx, endy;
	float strokeW, alph;
	float len, lenChange;
	float rot, rotChange;

	Branch (float lev, float ind, float ex, float why) {
		level = lev;
		index = ind;

		strokeW = (1/level)*100;
		alph 	= 255/level;
		len 	= (1/level) * random(100,300);
		rot 	= random(360);
		lenChange = random(10) - 5;
		rotChange = random(5) - 2.5;

		update(ex, why);

		if (level < _maxLevels) {
			
			children = new Branch[_numChildren];

			for (int x = 0; x < _numChildren; ++x) {
				children[x] = new Branch(level+1,x, endx, endy);
			}

		}
	}

	public void update(float ex, float why){
		x = ex;
		y = why;
		endx = x + (level * random(100)-50);
		endy = y + 50 + (level * random(50));

		rot += rotChange;
		if (rot > 360) { rot = 0; }
		if (rot < 0) { rot = 360; }

		len -= lenChange;
		if (len < 0 || len > 200) { lenChange *= -1; }

		float radian = radians(rot);

		endx = x + (len * cos(radian));
		endy = y + (len * sin(radian));

		for (int i = 0; i < children.length; ++i) {
			children[i].update(endx,endy);
		}

	}

	public void render(){

		strokeWeight(strokeW);
		stroke(0,alph);
		fill(255,alph);

		if(level>1){
			line(x,y,endx,endy);
		}
		ellipse(endx, endy, len/12, len/12);

		for (int i = 0; i < children.length; ++i) {
			children[i].render();
		}

	}

}