int xPos = 0;
int yPos = 500;
float rad = 10;
int mx 	= 1000;
int speed = 1;
int count = 40;

void setup(){
  	size(600,600);
  	frameRate(60);
  	background(0);

  	smooth();  	
  	stroke(0)
  	strokeWeight(1);
}

void draw(){  
	
	rad = rad *1.01;
	if(rad > mx){
		mx 		= random(1000);
		rad 	= 1;
		xPos	= random(100, (width-100)); 
		yPos	= random(500-10, 500+10);

		if (random(0,5) > 4){
			fill(5, 5, 5, 25);
		} else{
			fill(255, 255, 255, 25);
		}
	}

	drawCircle(xPos, yPos, rad);

}


void drawCircle(int x, int y, float radius){

	ellipse(x, y, radius, radius); 
}