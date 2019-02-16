class Food {
  PVector position;
  boolean bAlive;

  Food( Snake snake ) {
    this.reload( snake );
  }

  public void show() {
    fill(204, 102, 0);
    rect( this.position.x, this.position.y, 10, 10, 7 );
  }

  public void checkIfEaten( Snake snake ) {
    PVector snakeHead = snake.getHead();
    if ( snakeHead.x == this.position.x && snakeHead.y == this.position.y ) {
      snake.grow();
      //println("EATEN: " + this.position.x + ", " + this.position.y);
      this.reload( snake );
    } else if ( bAlive &&  time % escapeTimeStep == 0  ) {
      this.runAway();
    }
  }

  private void reload( Snake snake ) {
    PVector p = snake.getHead();
    while ( snake.isThereSnake( p ) ) {
      p = new PVector( 10*int(random(50)), 10*int(random(50)) );
    }
    this.position = p;
    bAlive = ( random(10) < snake.len ) ? true : false; // 3:) 
  }

  private void runAway() {
    // here might be added checkin' if new position is going to be snake
    float newx = this.position.x + ( int( random( 3 ) ) - 1 ) * 10;
    float newy = this.position.y + ( int( random( 3 ) ) - 1 ) * 10;

    if ( snake.isThereSnake( new PVector( newx, newy ) ) ) {
      // most optimal way is to find where it may go, but now just repeat
      // generating newx and newy
    }

    // this is just random
       this.position.x += ( int(random(3)) - 1 ) * 10;
       this.position.y += ( int(random(3)) - 1 ) * 10;
    // boundaries for x
    if ( this.position.x >= width ) this.position.x -= 10;
    else if ( this.position.x <= 0 ) this.position.x += 10;
    // boundaries for y
    if ( this.position.y >= height ) this.position.y -= 10;
    else if ( this.position.y <= 0 ) this.position.y += 10;
  }
}
