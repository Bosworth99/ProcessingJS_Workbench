///////////////////////////////////////////////////////////////////////////////
//
// DEEHN.pask
//
///////////////////////////////////////////////////////////////////////////////

Overlay _over;

CLine[] _cLines= new CLine[0];
//var _cLines = [];

void setup() {
	console.log('DEEHN.pask.1',this);

	size(screen.width, screen.height, P2D);
  	frameRate(12);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){
	_over = new Overlay();

	// CLine instances
	for (int c = 0; c < 6; ++c) {

		float x 	= screen.width/2;
		float y 	= screen.height/2;
		string id 	= "Cline_"+c;
		int cLen 	= screen.width*2;
		float rot 	= c*PI/180;

		_cLines.push( new CLine(id,x,y,cLen,rot) );
	}
}

void draw() {
	
	_over.render();

	// update all Clines
	for (int c = 0; c < _cLines.length; ++c) {
		_cLines[c].update();
	}

	// then render them
	for (int k = 0; k < _cLines.length; ++k) {
		_cLines[k].render();
	}

}

///////////////////////////////////////////////////////////////////////////////

interface Agent {void update();}
interface Agent {void render();}

///////////////////////////////////////////////////////////////////////////////
// complex line structure 
//
///////////////////////////////////////////////////////////////////////////////
class CLine implements Agent {

	int age,count;

	String id;
	float x,y;

	int cLen; 		// overall length of Cline
	float sLen; 	// length of individual line segments

	int seg;		// segment size  

	float dir;		// angle of travel
	float speed; 	// speed of travel
	float travel;   // increment of travel

	float rot;  	// rotation increment
	float rotSpd; 	// rotation speed

	float noiz;		// noise increment
	float nzGain;	// noise gain

	color stk;		// stroke color
	float linew;	// line weight;

	VPoint[] points;

	public CLine (String indent, float xpos, float ypos, int cLineLength, float rotation) {		

		id 		= indent;
		x 		= xpos;
		y 		= ypos;
		dir 	= rotation;
		cLen 	= cLineLength;

		init();

		console.log('new Cline(%o)',this);
	}

	void init(){

		age 	= 500;
		stk 	= 255;
		linew 	= random(1, 2);

		spd 	= 2;
		travel 	= 10;

		seg 	= 30;

		rot 	= 90;
		rotSpd 	= 1;
		sLen 	= random(150,300);

		noiz	= 0;
		nzGain 	= random(-1, 1)/100;

		points 	= new VPoint[0];

	}

	public void update(){

		float px;	
		float py;
		float tx,ty;
		Object pnt;


		for (int i = 0; i <= travel; i++) {

			pnt = pathStep( x, y, spd, dir);

			x = pnt.x;
			y = pnt.y;
			tx = x + sLen;
			ty = pnt.y + sLen;

			points[i] = new VPoint(x,y,tx,ty);
		}

		dir += (spd * noise(noiz)) * ((random(5)>2)?1:-1);
		if(dir > 360){dir=0;}
		if(dir < 0){dir=360;}

		if(x<100||x>screen.width-100){x=screen.width/2;}
		if(y<100||y>screen.height-100){y=screen.height/2;}

		count++;

		console.log(x,y,travel,spd,dir, pnt.x, pnt.y);
	}

	public void render(){


		for (int i = 0; i < points.length-1; i++) {

			float ro 	= radians(rot) + noise(noiz);
			VPoint ln 	= projectPoints(points[i].x, points[i].y, sLen, ro );

			strokeWeight( linew );
			stroke(stk, 255);

			line(ln.x, ln.y, ln.tx, ln.ty);
		}

	}

	VPoint projectPoints(float xpos, float ypos, float dst, float rot){
		float ax = xpos - (sin(rot)*dst);
		float ay = ypos - (cos(rot)*dst);
		float bx = xpos + (sin(rot)*dst);
		float by = ypos + (cos(rot)*dst);

		return new VPoint(ax, ay, bx, by);
	}

	Object pathStep(float xpos, float ypos, float dst, float rot ){
		float tx = xpos - (sin(rot)*dst);
		float ty = ypos - (cos(rot)*dst);
		Object o = new Object();
		o.x = tx;
		o.y = ty;

		return o;
	}


}
///////////////////////////////////////////////////////////////////////////////
// background colors and texture
//
///////////////////////////////////////////////////////////////////////////////
class Overlay implements Agent {

	var _colors;
	int _bgTimer;
	public color mainColor;
	public color altColor;

	public Overlay () {
		init();
		console.log('new Overlay()', _colors);		
	}

	void init(){
		_colors 	= [#9F0F0F,#868302,#0B9299];
		_bgTimer	= 999;
		mainColor 	= #ffffff;
		altColor 	= #000000;
	}

	public void update(){

	}

	public void render(){

		// update mainColor every n seconds
		if(_bgTimer>frameRate*10){
			_bgTimer=0;
			mainColor 	= (color) _colors[ (int) random(_colors.length) ];
			altColor 	= (color) _colors[ (int) random(_colors.length) ];
		}
		_bgTimer++;

		noStroke();

		fill( mainColor, 5);
		rect(0, 0, screen.width, screen.height);

		if(random(100)>80){

			strokeWeight( random(screen.height/2, screen.height) );

			if( random(10)>5 ){
				stroke( altColor, 5);
			} else {
				stroke( 255, 5);
			}
			
			line(0, random((screen.height/2)-300,(screen.height/2)+300), screen.width, random((screen.height/2)-300,(screen.height/2)+300));
		}
	}

}
///////////////////////////////////////////////////////////////////////////////
// Veisa Point - generic point container 
///////////////////////////////////////////////////////////////////////////////
class VPoint {
	public float x,y,tx,ty;
	public VPoint (float xpos, float ypos, float txpos, float typos) {
		x = xpos;
		y = ypos;
		tx = txpos;
		ty = typos;
	}
}
