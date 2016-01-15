///////////////////////////////////////////////////////////////////////////////
//
// DEEHN.pask
//
///////////////////////////////////////////////////////////////////////////////

Overlay _over;

CLine[] _cLines= new CLine[0];
//var _cLines = [];

void setup() {
	console.log('DEEHN.pask.3',this);

	size(screen.width, screen.height, P2D);
  	frameRate(24);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){
	_over = new Overlay();

	// CLine instances
	for (int c = 0; c < 10; ++c) {
		string id 	= "Cline_"+c;
		_cLines.push( new CLine(id) );
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

	int seg;		// segment size
	float sLen; 	// length of individual line segments
	float growth;    // rate the sLen float changes

	float ang;		// angle of travel
	float angSpd; 	// speed of angle increase
	float speed; 	// speed of travel
	float travel;   // increment of travel

	float noiz;		// noise increment
	float nzGain;	// noise gain

	color stk;		// stroke color
	float linew;	// line weight;

	VPoint[] points;

	public CLine (String indent) {		

		id 		= indent;

		init(); 

		console.log('new Cline(%o)',this);
	}

	void init(){

		x 		= screen.width/2;
		y 		= screen.height/2;

		age 	= random(500,1000);

		stk 	= 255;
		linew 	= random(.5,1.2);

		speed 	= 1;
		travel 	= 1;
		seg 	= 10;

		ang 	= random(360);
		angSpd 	= random(.4,.6);
		sLen 	= 1;
		growth 	= random(.1,3);

		noiz	= 10;
		nzGain 	= random(1);

		points 	= new VPoint[0];

	}

	public void update(){

		float px;	
		float py;
		float tx,ty;
		Object pnt;

		// generate a path to travel
		for (int i = 0; i <= seg; i++) {

			pnt = pathStep( x, y, travel, ang);

			points[i] = new VPoint(x,y,pnt.x,pnt.y);

			x = pnt.x;
			y = pnt.y;

		}

		if(random(10)>9){
			if(random(10)>5){
				ang += angSpd; 
			} else {
				ang -= angSpd;
			}
		}
		
		if(ang > 360){ang=0;}
		if(ang < 0){ang=360;}

		count++;

		if(count>age){
			count=0;
			init();
		}

		if( x < -50 || x > screen.width+50 || y < -50 || y > screen.height+50 ){ 
			count=0;
			init(); 
		}	

	}

	boolean shift = true;
	public void render(){

		float ro 	= radians(ang);
		float ox,oy = -999;


		
		for (int i = 0; i < points.length-1; i++) {

			if(shift){
				sLen += (growth * ( noise(noiz) * nzGain ));
				if (sLen > 200){
					shift=false;
				}
			} else {
				sLen -= (growth * ( noise(noiz) * nzGain ));
				if (sLen < 10){
					shift=true;
				}
			}

			VPoint ln 	= projectPoints(points[i].x, points[i].y, sLen*noise(noiz), ro*noise(noiz) );

			strokeWeight( linew );
			stroke(stk, 255);

			if(ox>-999){
				line(ln.x, ln.y, ln.tx, ln.ty);
			}

			ox = ln.x;
			oy = ln.y;
			
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
		float tx = xpos + (sin(rot)*dst);
		float ty = ypos + (cos(rot)*dst);
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
		_colors 	= assignColors();
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

		fill( mainColor, 2);
		rect(0, 0, screen.width, screen.height);

		if(random(100)>80){

			strokeWeight( random(screen.height/2, screen.height) );

			if( random(10)>5 ){
				stroke( altColor, 3);
			} else {
				stroke( 255, 3);
			}
			
			line(0, random((screen.height/2)-300,(screen.height/2)+300), screen.width, random((screen.height/2)-300,(screen.height/2)+300));
		}
	}

	void assignColors(){
		var colAry = [#9F0F0F,#868302,#119393];
		if(false){
			for (int i = 0; i < 6; ++i) {
				colAry[i] = color(random(150), random(150), random(150));
			}
		}
		return colAry;
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
