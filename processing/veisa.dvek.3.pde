///////////////////////////////////////////////////////////////////////////////
//
// VEISA.dvek
//
///////////////////////////////////////////////////////////////////////////////

Overlay _over;

CLine[] _cLines= new CLine[0];
//var _cLines = [];

void setup() {
	console.log('VEISA.dvek.3',this);

	size(screen.width, screen.height, P2D);
  	frameRate(60);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){
	_over = new Overlay();

	// CLine instances
	for (int c = 0; c < 4; ++c) {

		//float x 	= 0;
		float x 	= (screen.width/2) * -1;
		float y 	= (screen.height/4) * c;
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
		stk 	= 255;
		linew 	= .2;
		seg 	= 25;
		rot 	= random(360);
		sLen 	= random(100,400);
		noiz 	= 10;
		points 	= new VPoint[0];
	}

	public void update(){

		float px = x;
		float py = y;
		float tx,ty;

		// define start and end points for each segment;
		for (int i = 0; i <= cLen/seg; i++) {
			px += seg;
			py = y;
			tx = px + sLen;
			ty = y;
			points[i] = new VPoint(px,py,tx,ty);
		}

		//rot += 1;
		//if(rot > 360){rot=0;}

	}

	boolean shift = true;
	public void render(){

		translate(0,100);

		for (int i = 0; i < points.length-1; i++) {

			float ro 	= radians(rot) + noise(noiz);
			VPoint ln 	= projectPoints(points[i].x, points[i].y, sLen, ro );

			pushMatrix();

			//translate(points[i].x, points[i].y);

			strokeWeight( linew );
			stroke(stk, 255);
			line(ln.x, ln.y, ln.tx, ln.ty);

			popMatrix();

			if(shift){
				noiz += .0001;
				if (noiz > 1) {shift=false;}
			} else {
				noiz -= .0001;
				if (noiz < -1) {shift=true;}
			}

			rot += .0001;
			if(rot > 360){rot=0;}
		}

	}

	VPoint projectPoints(float xpos, float ypos, float dst, float rot){
		float ax = xpos - (sin(rot)*dst);
		float ay = ypos - (cos(rot)*dst);
		float bx = xpos + (sin(rot)*dst);
		float by = ypos + (cos(rot)*dst);

		return new VPoint(ax, ay, bx, by);
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
				stroke( altColor, 6);
			} else {
				stroke( 255, 6);
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
