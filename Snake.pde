class Snake {
  PVector[] position;
  int len;
  boolean enableDir;
  PVector direction;
  ArrayList<PVector> foodEaten;
  /* directions are:
   up:     0, -1
   down:   0,  1
   right:  1,  0
   left:  -1,  0
   */

  Snake() {
    this.len = 2;
    // maybe set max value - > like win condition :P
    this.position = new PVector[this.len];
    this.position[0] = new PVector( 10, 10 );
    this.position[1] = new PVector( 10, 0 );
    this.direction = new PVector( 0, 1 ); // it goes down
    this.foodEaten = new ArrayList<PVector>();
  }

  public void show() {
    fill(255);
    for ( PVector p : position ) {
      rect(p.x, p.y, 10, 10, 3);
    }
  }

  public void move() {

    // if something was eaten
    if ( foodEaten.size() > 0 ) {
      // we check if current endTailPosition is same as first eaten food
      PVector temp = foodEaten.get(0);
      int end = this.len-1;
      if ( this.position[end].x == temp.x && this.position[end].y == temp.y ) {
        // now we create new Bigger position array and give extra food
        PVector[] newPosition = new PVector[this.len+1];
        //println("GROWING: " + temp.x + ", " + temp.y );
        for ( int i = 0; i < this.len; i++ ) {
          newPosition[i] = new PVector(this.position[i].x, this.position[i].y);
        }
        // set empty last element cos it really just doesnt matter
        newPosition[this.len] = new PVector(0, 0);
        // set size one bigger
        this.len++;
        // get rid of metabolished food
        foodEaten.remove(0);
        // set newPosition array as this position
        this.position = newPosition;
      }
    }

    // move tail
    for ( int i = this.len-1; i > 0; i-- ) {
      this.position[i].x = this.position[i-1].x;
      this.position[i].y = this.position[i-1].y;
    }
    // move head
    this.position[0].x += 10*direction.x;
    this.position[0].y += 10*direction.y;
  }

  public void setDirection( PVector newDir ) {
    if ( !this.enableDir ) return;
    if ( this.direction.x*newDir.x != -1 && this.direction.y*newDir.y != -1 ) {
      this.direction.x = newDir.x;
      this.direction.y = newDir.y;
    }
  }

  public PVector getHead() {
    return this.position[0];
  }

  public void grow() {
    // adda current head position to arrayList (queue)
    float x = this.position[0].x;
    float y = this.position[0].y;
    foodEaten.add( new PVector( x, y) );
  }

  public void checkCollisions() {
    if ( this.position[0].x > width-1 || this.position[0].x < 0 ||
      this.position[0].y > height-1 || this.position[0].y < 0 ) {
      print("GAME OVER!!! SCORE: " + this.len );
      noLoop();
    }

    for ( int i = 3; i < this.len; i++ ) {
      if ( this.position[0].x == this.position[i].x && this.position[0].y == this.position[i].y ) {
        print("GAME OVER!!! SCORE: " + this.len );
        noLoop();
      }
    }
  }

  public boolean isThereSnake( PVector pos ) {
    for ( PVector p : this.position ) {
      if ( p.x == pos.x && p.y == pos.y ) return true;
    }
    return false;
  }
} // end of class Snake
