
//Seed[] _seeds = new Seed[0];
var _seeds=[];
int _plantTimer=151;
int _bgTimer=501;
var _bg 	= [#720509,#1FCC00,#E88704];

void setup(){
	console.log("ret.thyik.1.pde");

  	size(screen.width, screen.height);
  	frameRate(12);
}

void draw(){  

	overlay();

	if( _plantTimer > 150 ){
		_plantTimer=0;
		_seeds.push( new Seed() );
		console.log('planted ',_seeds);
	}
	_plantTimer++;

 	var tmp = [];

	for (var i = _seeds.length - 1; i >= 0; i--) {
		(Seed) _seeds[i].grow();

		if ( !_seeds[i].dead){
			tmp.push(_seeds[i]);
		}
	};

	_seeds = tmp;
}

void overlay(){
	if(_bgTimer>300){
		_bgTimer=0;
		_fil = (color) _bg[ (int) random(_bg.length) ];
	}
	_bgTimer++;

	fill( _fil, 10);
	noStroke();
	rect(0, 0, screen.width, screen.height);
	stroke();
}


interface Growth {void grow();}

class Seed implements Growth{

	String id;
	boolean dead;
	int count;
	int age;

	float gravity;
	float wind;

	Seed () {
		init();
	}

	void init(){

		id 		= "Seed_"+ (int) random(9999);
		dead 	= false;
		count 	= 0;
		age 	= 150;

		gravity	= random(-3,3);
		wind	= random(-3,3);

		console.log('id=%s dead=%s, age=%s',id,dead,age);
	}

	void grow (){

		if (count > age){
			dead = true;
		}
		count++;

		//line_cluster();
		box_grid();
	}	

	void line_cluster(){
		
		float px 	= 0;
		float py	= random(screen.height);
		float ox 	= -999;
		float oy	= -999;
		float yn	= 1;
		int step	= random(1,10);
		color stk 	= #000000;

		pushMatrix();
		stroke(stk, 255);			
		//translate(px,py);
	
		for (int x=0; x<=screen.width; x+=step) {

			int y = py / noise(yn);

			if (ox > -999) {
				line(x, y, ox, oy);
			}

			ox	= x;
			oy	= y;
			yn	+= .01;

		}

		popMatrix();
	}

	void box_grid(){

		int row		= 14;
		int col 	= 20;
		float oh 	= screen.height/row;
		float ow	= screen.width/col;
		color stk 	= #000000;
		int fil 	= random(5);

		translate(0, 0);
		translate(ow/2, oh/2);

		boolean dofil = true;

		for (int r = 0; r < row; ++r) {

			for (int c = 0; c < col; ++c) {
				
				if( random(999) > 950){

					float x = (c*ow);
					float y = (r*oh);

					fill(fil);
					//strokeWeight(1);
					//stroke(stk);
					noStroke();
					ellipse(x, y, ow, oh);
					stroke();
					noFill();

				}

				if(dofil){
					fil+=10;
					if(fil > 255){
						fil = 255;
						dofil = false;
					}
				} else{
					fil-=10;
					if(fil < 0){
						fil = 0;
						dofil = true;
					}
				}
			}
		}
	}
}