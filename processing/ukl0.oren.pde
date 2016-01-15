//////////////////////////////////////////////////////////////////////////////
//
// source  : ukl0.oren.pde
// author  : josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////


var _seeds		= [];


void setup(){
	console.log("ukl0.oren.pde");

  	size(screen.width, screen.height);
  	frameRate(60);
  	smooth();

  	assembleDisplay();
}

void assembleDisplay(){

	for (int c = 0; c < 10; ++c) {
		Object o = {};
		o.seeds = _seeds;
		o.id = 'Seed_'+c;		
		_seeds.push( new Seed(o) );
	}

}

void draw(){  

	for (var i = _seeds.length - 1; i >= 0; i--) {
		(Seed) _seeds[i].grow();
	};
	
}

interface Growth {void grow();}

class Seed implements Growth{

	public string id;
	public float x = random(100, screen.width-100);
	public float y = random(100, screen.height-100);
	public float rad = random(150,300);

	float xSpd = ((100-rad)*.05);
	float ySpd = ((100-rad)*.05);
	float opc = random(50,200);
	float col = random(40,160);
	boolean collision = false;
	var seeds = [];

	Seed (args) {
		console.log('new Seed',args);
		id = args.id;
		seeds = args.seeds;
	}

	void grow (){

		update();
		render();
	}	

	void update(){

		x += random(-xSpd,xSpd);
		y += random(-ySpd,ySpd);

		if(x<100){x=100}
		if(x>screen.width-100){x=screen.width-100}
		if(y<100){y=100}
		if(y>screen.height-100){y=screen.height-100}

		collision = false;

		for (int k = 0; k < seeds.length; ++k) {
			Seed t = seeds[k];

			if(t.id!=id){
				float dis = dist(x, y, t.x, t.y);

				float overlap = dis-rad-t.rad;
				if(overlap<0){
					collision = true;

					float midx,midy;
					midx = (t.x+x)/2;
					midy = (t.y+y)/2;
					stroke(0,255);
					noFill();
					overlap *= -1;
					ellipse(midx, midy, overlap, overlap);

					break;
				}
			}
		}

		if(collision){
			if(opc>0){opc -= .01;}
		}else{
			if(opc<255){opc += 1;}
		}

	}

	void render(){

		pushMatrix();

		translate(x, y);

		noStroke();

		fill(255,col,0,opc);

		ellipse( 0, 0, rad, rad );

		popMatrix();

	}

}