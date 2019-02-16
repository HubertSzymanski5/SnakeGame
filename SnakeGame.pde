Snake snake = new Snake(); //<>//
Food food = new Food( snake );
long time;
int escapeTimeStep;

void setup() {
  size(500, 500);
  time = 0;
  escapeTimeStep = 5;
}

void keyPressed() {
  PVector newDir = new PVector();
  if ( keyCode == UP ) newDir = new PVector( 0, -1);
  else if ( keyCode == DOWN ) newDir = new PVector( 0, 1);
  else if ( keyCode == RIGHT ) newDir = new PVector( 1, 0);
  else if ( keyCode == LEFT ) newDir = new PVector( -1, 0);
  else return;
  snake.setDirection( newDir );
  snake.enableDir = false;
}

void draw() {
  snake.enableDir = true;
  noStroke();
  frameRate(10);
  background(25);
  // co mozemy to ruszamy
  snake.move();
  // sprawdzamy kolizje
  food.checkIfEaten( snake );
  snake.checkCollisions();
  // pokazujemy wszystkie elementy
  snake.show();
  food.show();
  //increase time
  time++;
}
