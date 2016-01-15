//////////////////////////////////////////////////////////////////////////////
//
// source  	: genart.8.3.pde
// comment 	: sutcliffe pentagons
// dev  	: josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////

FractalRoot pentagon;
int _maxLevels = 4;
float _strutFactor = 0.2;
float _strutNoise;

void setup(){
	console.log("genart.8.3.pde - Sutcliffe Pentagons");

  	size(screen.width, screen.height);
  	frameRate(24);
  	smooth();
  	background(255);

  	_strutNoise = random(10);

}

void draw(){  

	background(255);
	_strutNoise += 0.01;
	_strutFactor = (noise(_strutNoise)*3)-1;

	pentagon = new FractalRoot(frameCount);
	pentagon.render();

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

	PointObj[] pointAry = new PointObj[5];
	Branch rootBranch;

	public FractalRoot (float startAngle) {
		
		float centX = screen.width/2;
		float centY = screen.height/2;
		int count = 0;

		for (int i = 0; i < 360; i+=72;) {
			float x = centX + (500 * cos(radians(startAngle+i)));
			float y = centY + (500 * sin(radians(startAngle+i)));
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

		// outer lines
		for (int i = 0; i < outerPoints.length; ++i;) {
			int nexti = i+1;
			if(nexti == outerPoints.length){nexti = 0;}
			line(outerPoints[i].x, outerPoints[i].y, outerPoints[nexti].x, outerPoints[nexti].y);
		}

		// mid points and projected points
		strokeWeight(.5);
		fill(#E80005,5);

		for (int j = 0; j < midPoints.length; ++j;) {
			//ellipse(midPoints[j].x, midPoints[j].y, 20/level, 20/level);
			line(midPoints[j].x, midPoints[j].y, projPoints[j].x, projPoints[j].y);
			//ellipse(projPoints[j].x, projPoints[j].y, 5/level, 5/level);	
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