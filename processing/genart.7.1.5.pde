//////////////////////////////////////////////////////////////////////////////
//
// source  : genart.7.1.5.pde
// author  : josh@joshbosworth.com
//
//////////////////////////////////////////////////////////////////////////////

Cell[][] _cellArray;
int _cellSize = 20;
int _numX,_numY;


void setup(){
	console.log("genart.7.1.5.pde - Autonomy");

  	size(screen.width, screen.height);
  	frameRate(24);
  	noStroke();

  	_numX = floor(screen.width / _cellSize);
  	_numY = floor(screen.height / _cellSize);

  	restart();
}

void restart(){

	_cellArray = new Cell[_numX][_numY];

	for (int c = 0; c < _numX; c++;) {
		for (int r = 0; r < _numY; r++;) {
			Cell nCell = new Cell(c,r,_cellSize);
			_cellArray[c][r] = nCell;
		}
	}

	for (int c = 0; c < _numX; c++;) {
		for (int r = 0; r < _numY; r++;) {
			
			int above = r-1;
			int below = r+1;
			int left  = c-1;
			int right = c+1;

			if (above<0){above = _numY-1;}
			if (below==_numY){below = 0;}
			if (left<0){left = _numX-1;}
			if (right==_numX){right = 0;}

			_cellArray[c][r].addNeighbor(_cellArray[left][above]);
			_cellArray[c][r].addNeighbor(_cellArray[left][r]);
			_cellArray[c][r].addNeighbor(_cellArray[left][below]);
			_cellArray[c][r].addNeighbor(_cellArray[c][below]);
			_cellArray[c][r].addNeighbor(_cellArray[right][below]);
			_cellArray[c][r].addNeighbor(_cellArray[right][r]);
			_cellArray[c][r].addNeighbor(_cellArray[right][above]);
			_cellArray[c][r].addNeighbor(_cellArray[c][above]);
		}		
	}

}

void draw(){  

	for (int c = 0; c < _numX; c++;) {
		for (int r = 0; r < _numY; r++;) {
			(Cell) _cellArray[c][r].update();
		}
	}

	translate(_cellSize/2, _cellSize/2);

	for (int c = 0; c < _numX; c++;) {
		for (int r = 0; r < _numY; r++;) {
			(Cell) _cellArray[c][r].render();
		}
	}

}

void mousePressed() {
	restart();
}


class Cell{

	public float state;
	public float nextState;
	public float lastState;

	int x,y,siz;

	Cell[] neighbors;

	Cell (col,row,sz) {
		siz = sz;
		x = col*siz;
		y = row*siz;
		nextState = ((x/500)+(y/300))*14;
		state = nextState;
		lastState = 0;
		neighbors = new Cell[0];

		console.log('new Cell(%s,%s);',x,y);
	}

	public void update(){

		float total = 0;
		
		for (int i = 0; i < neighbors.length; ++i) {
			total += neighbors[i].state;
		}

		float average = int(total/8);

		if (average==255){
			nextState = 0;
		} else if ( average == 0){
			nextState = 255;
		} else {
			nextState = state + average;
			if ( lastState > 0 ){
				nextState -= lastState;
			}
			if ( nextState > 255 ){
				nextState = 255;
			} else if ( nextState < 0 ){
				nextState = 0;
			}

		}

		lastState = state;
	}

	public void render(){
		state = nextState;

		fill(state);

		ellipse(x, y, siz, siz);
	}

	public void addNeighbor(Cell cell){
		neighbors.push(cell);
	}

}