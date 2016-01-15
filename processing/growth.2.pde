int xPos = 0;
int yPos = 500;
float outer = 1000;
float inner = 350;
int speed = 1.02;
int dir = 1;
int count = 40;


void setup(){
  	size(screen.width, screen.height);

  	frameRate(60);
  	background(0);

  	smooth();  	

	stroke(#FFFFFF, 30);
	fill(#517D53, 25);
  	strokeWeight(1);
}

void draw(){  

	outer = outer / speed;
	if(outer < inner){
		outer 	= random(750,1600);
		inner 	= random(250);
		xPos	= random(100, (width-100)); 
		
		if (random(0,10) > 5){
  			stroke(#FB0000, 20);
			fill(#940C0C, 5);
		} else{
			stroke(#FFFFFF, 20);
			fill(#517D53, 5);
		}

		if (random(0,10) > 5){
  			dir = speed*2;
		} else{
			dir = speed*-2;
		}
	}

	yPos += dir;

	drawCircle(xPos, yPos, outer);
}


void drawCircle(int x, int y, float radius){

	ellipse(x, y, radius, radius); 
}