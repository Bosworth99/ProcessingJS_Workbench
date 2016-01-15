///////////////////////////////////////////////////////////////////////////////
//
// VEISA.sem
//
///////////////////////////////////////////////////////////////////////////////

Overlay _over;

CLine[] _cLines= new CLine[0];
//var _cLines = [];

void setup() {
	console.log('VEISA.sem.1',this);

	size(screen.width, screen.height, P2D);
  	frameRate(60);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){
	_over = new Overlay();

	// CLine instances
	for (int c = 0; c < 1; ++c) {

		float x 	= (screen.width/2) * -1;
		//float x 	= 0;
		float y 	= screen.height/2;
		string id 	= "Cline_"+c;
		int cLen 	= screen.width*2;
		float rot 	= 0;

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

	String id;
	float x,y;

	int cLen; 		// overall length of Cline
	float sLen; 	// length of individual line segments

	int seg;		// seg increase  

	float rot;  	// rotation increment
	float noiz;		// noise increment

	color stk;		// stroke color
	float linew;	// line weight;

	VPoint[] points;

	public CLine (String indent, float xpos, float ypos, int cLineLength, float rotation) {		

		id 		= indent;
		x 		= xpos;
		y 		= ypos;
		rot 	= rotation;
		cLen 	= cLineLength;

		init();

		console.log('new Cline(%o)',this);
	}

	void init(){
		stk 	= #000000;
		linew 	= 1;
		seg 	= 15;
		rot 	= 1;
		sLen 	= 10;
		noiz 	= 1;
		points 	= new VPoint[0];
	}

	boolean shift = true;
	int MAX = screen.height;
	float len = sLen;
	public void update(){

		float px = x;
		float py = y;
		float tx,ty;
				
		rot   = 0;

		// define start and end points for each segment;
		for (int i = 0; i < cLen; i+=seg) {
	
			px += seg;
			py = y + cos(rot)*len;
			tx = px - sin(rot)*len;
			ty = y - cos(rot)*len;

			points[i] = new VPoint(px,py,tx,ty);

			noiz += .05;
			if (noiz > 50){noiz=0;}

			rot += 360;
			if (rot > 360){rot=0;}

			if(shift){
				len += .01;
				if(len>MAX){shift=false;}
			} else {
				len -= .01;
				if(len<(MAX*-1)){shift=true;}
			}

		}
	
	}

	public void render(){
 
		strokeWeight(linew);
		stroke(stk, 255);

		//translate(x,y);

		
		for (int i = 0; i < points.length; i+=seg) {

			float ax = points[i].x;
			float ay = points[i].y;
			float bx = points[i].tx;
			float by = points[i].ty;

			pushMatrix();

			line(ax, ay, bx, by);

			stroke(stk, 255);
			fill(stk,255);
			ellipse(bx, by, 10, 10);
			ellipse(ax, ay, 10, 10);

			popMatrix();

			//console.log('ax:%s ay:%s bx:%s by:%s',ax, ay, bx, by);
		}

	}


}
///////////////////////////////////////////////////////////////////////////////
// background colors and texture
//
///////////////////////////////////////////////////////////////////////////////
class Overlay implements Agent {

	var _colors;
	int _bgTimer;
	int _opc;
	public color mainColor;
	public color altColor;

	public Overlay () {
		init();
		console.log('new Overlay()', _colors);		
	}


	void init(){
		_colors 	= [#444444,#0404BB,#548FFE,#527C03,#534526,#AE1A15,#58A05A];
		_bgTimer	= 999;
		_opc		= 5;
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

		fill( mainColor, _opc);
		rect(0, 0, screen.width, screen.height);

		if(random(100)>80){

			strokeWeight( random(screen.height/2, screen.height) );

			if( random(10)>5 ){
				stroke( altColor, 2);
			} else {
				stroke( 255, 2);
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
