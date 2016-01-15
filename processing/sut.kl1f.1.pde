//////////////////////////////////////////////////////////////////////////////
//
// source  	: sut.kl1f.1.pde
// comment 	: sutcliffe pentagons
// dev  	: josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////

FractalRoot _pentagon;
int _maxLevels = 2;
int _numSides = 6;

float _strutFactor = .5;
float _strutNoise;

float _overlay;
float _outerDim;

boolean _grow;

void setup(){
	console.log("sut.kl1f.1.pde - Sutcliffe Pentagons");

  	size(screen.width, screen.height);
  	frameRate(60);
  	smooth();
  	background(255);

  	_overlay 		= new Overlay();
  	_strutNoise 	= random(3);
  	_outerDim		= 100;
  	_grow			= true;
}

void draw(){  
	_overlay.render();

	_strutNoise += 0.01;
	_strutFactor = (noise(_strutNoise)*4)-1;

	if(_grow){
		_outerDim += 1;
	} else {
		_outerDim -= 1;
	}

	if (_outerDim < 100) { _grow = true; }
	if (_outerDim > screen.height/2 ) { _grow = false; }

	_pentagon = new FractalRoot( noise(frameCount) );
	_pentagon.render();
}

///////////////////////////////////////////////////////////////////////////////
public class PointObj {

	public float x,y;

	public PointObj (int ex, int wy) {
		x = ex;
		y = wy;
	}
}

///////////////////////////////////////////////////////////////////////////////
public class FractalRoot {

	Branch rootBranch;
	PointObj[] pointAry = {};

	public FractalRoot (float startAngle) {
		
		float centX = screen.width/2;
		float centY = screen.height/2;
		float angleStep = 360/_numSides;
		int count = 0;

		for (int i = 0; i < 360; i+=angleStep;) {
			float x = centX + (_outerDim * cos(radians(startAngle+i)));
			float y = centY + (_outerDim * sin(radians(startAngle+i)));
			pointAry[count] = new PointObj(x,y);
			count++;
		}

		rootBranch = new Branch(0,0,pointAry);

	}

	public void update(){}
	public void render(){
		rootBranch.render();
	}

}

///////////////////////////////////////////////////////////////////////////////
public class Branch {

	int level, num;
	PointObj[] outerPoints;
	PointObj[] midPoints;
	PointObj[] projPoints;
	Branch[] branches;
	color[] colors 	= [#FFFFFF];

	public Branch (int lev, int n, PointObj[] points) {
		level = lev;
		num = n;
		outerPoints = points;
		midPoints = calcMidPoints();
		projPoints = calcStrutPoints();
		branches = [];

		if ((level+1) < _maxLevels) {
			Branch childBranch = new Branch(level+1,0,projPoints);
			branches.push(childBranch); 

			for (int k = 0; k < outerPoints.length; ++k;) {
				int nextk = k - 1;
				if (nextk < 0) {
					nextk += outerPoints.length;
				}
				PointObj[] newPoints = { projPoints[k], midPoints[k], outerPoints[k], midPoints[nextk], projPoints[nextk]};
				childBranch = new Branch(level+1,k+1,newPoints);
				branches.push(childBranch);
			}
		}
	}

	public void render(){

		color col = (color) colors[(int) random(colors.length)]; 

		// outer lines
		for (int i = 0; i < outerPoints.length; ++i;) {

			int nexti = i+1;
			if( nexti == outerPoints.length ){
				nexti = 0;
			}

			// outer lines

			stroke(255,50);
			strokeWeight(2);

			line(outerPoints[i].x, outerPoints[i].y, outerPoints[nexti].x, outerPoints[nexti].y);
		}

		// draw mid points, struts, projected points
		for (int j = 0; j < midPoints.length; ++j;) {

			// mid point

			//noStroke();
			//fill(col,50);
			//ellipse(midPoints[j].x, midPoints[j].y, (100/level)*noise(_strutNoise), (100/level)*noise(_strutNoise));

			// strut

			stroke(255,50);
			strokeWeight(1);
			line(midPoints[j].x, midPoints[j].y, projPoints[j].x, projPoints[j].y);

			// projected point

			noStroke();
			fill(col,50);
			ellipse(projPoints[j].x, projPoints[j].y, (10/level)*noise(_strutNoise), (10/level)*noise(_strutNoise));
		}

		// inner branch
		for (int k = 0; k < branches.length; ++k) {
			branches[k].render();
		}

	}

	PointObj[] calcMidPoints(){

		PointObj[] mpArray = new PointObj[outerPoints.length];

		for (int i = 0; i < outerPoints.length; ++i) {
			int nexti = i+1;
			if(nexti == outerPoints.length) { nexti = 0;}
			PointObj thisMP = calcMidPoint(outerPoints[i], outerPoints[nexti]);
			mpArray[i] = thisMP;
		}

		return mpArray;
	}

	PointObj calcMidPoint(PointObj end1, PointObj end2){

		float mx, my;

		if(end1.x > end2.x){
			mx = end2.x + ((end1.x - end2.x)/2);
		} else{
			mx = end1.x + ((end2.x - end1.x)/2);
		} 

		if(end1.y > end2.y){
			my = end2.y + ((end1.y - end2.y)/2);
		} else{
			my = end1.y + ((end2.y - end1.y)/2);
		} 

		return new PointObj(mx,my);
	}

	PointObj calcStrutPoints(){
		PointObj[] strutAry = new PointObj[midPoints.length];

		for (int i = 0; i < midPoints.length; ++i) {
			int nexti = i+3;

			if (nexti >= midPoints.length) { 
				nexti -= midPoints.length; 
			}

			PointObj thisSP = calcProjPoint(midPoints[i], outerPoints[nexti]);
			strutAry[i] = thisSP;
		}

		return strutAry;
	}

	PointObj calcProjPoint(PointObj mp, PointObj op){

		float px,py;
		float adj, opp;

		if (op.x > mp.x) {
			opp = op.x - mp.x;
		} else {
			opp = mp.x - op.x;
		}

		if (op.y > mp.y) {
			adj = op.y - mp.y;
		} else {
			adj = mp.y - op.y;
		}

		if (op.x > mp.x) {
			px = mp.x + (opp * _strutFactor);
		} else {
			px = mp.x - (opp * _strutFactor);
		}

		if (op.y > mp.y) {
			py = mp.y + (adj * _strutFactor);
		} else {
			py = mp.y - (adj * _strutFactor);
		}

		return new PointObj(px, py);
	}

}

///////////////////////////////////////////////////////////////////////////////
class Overlay{

	var colors;
	int bgTimer;
	public color mainColor;
	public color altColor;

	public Overlay () {
		init();
	}

	void init(){
		colors 	= [#444444,#0404BB,#548FFE,#527C03,#D6E701,#534526,#AE1A15,#58A05A];
		bgTimer	= 999;
		mainColor 	= #ffffff;
		altColor 	= #000000;

		console.log('new Overlay()', colors);
	}

	public void grow(){
		render();
	}

	public void render(){

		// update mainColor every n seconds
		if(bgTimer>frameRate*10){
			bgTimer=0;
			mainColor 	= (color) colors[ (int) random(colors.length) ];
			altColor 	= (color) colors[ (int) random(colors.length) ];
		}
		bgTimer++;

		noStroke();

		fill( mainColor, 3);
		rect(0, 0, screen.width, screen.height);

	}

}