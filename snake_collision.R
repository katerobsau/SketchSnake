#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 400
bkgrd_y  = 300
setup <- function() {
  frameRate(10)
  createCanvas(bkgrd_x, bkgrd_y)
}

draw <- function(){
  
  #Draw the background colour
  background(0, 0, 33)    
  
  # Snake details
  snake_col = color('rgb(0,255,0)') 
  snake_wid =  10
  start_snake_len = 15
    
  # Initialise snake
  if(frameCount < 2){
    snake_stop = FALSE
    snake_len = start_snake_len
    snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
    snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2
  }
  
  # Draw the snake
  fill(snake_col)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], 10)
  }
  
  # Move our snake East
  if(frameCount > 2 & snake_stop == FALSE){
    
    # Plain right shift
    if(keyCode == RIGHT_ARROW){
      direction = "right"
      old_snake_x = snake_x
      old_snake_y = snake_y
      for(i in 0:(snake_len - 1)){
        snake_x[i] = old_snake_x[i+1]
        snake_y[i] = old_snake_y[i+1]
      }
      new_x = old_snake_x[snake_len] + snake_wid
      snake_x[snake_len] = new_x
      if(new_x > bkgrd_x) snake_x[snake_len] = 0
    }
    
    # Plain left shift
    if(keyCode == LEFT_ARROW){
      
      old_snake_x = snake_x
      old_snake_y = snake_y
      
      # # if(direction == "right"){
      #   for(i in 1:snake_len){
      #     snake_x[i] = old_snake_x[i-1]
      #     snake_y[i] = old_snake_y[i-1]
      #   }
      #   new_x = old_snake_x[0] - snake_wid
      #   snake_x[0] = new_x
      #   if(new_x < 0) snake_x[0] = bkgrd_x
      # # }
      
      # if(direction != "right"){
        for(i in 0:(snake_len - 1)){
          snake_x[i] = old_snake_x[i+1]
          snake_y[i] = old_snake_y[i+1]
        }
        new_x = old_snake_x[snake_len] - snake_wid
        snake_x[snake_len] = new_x
        if(new_x < 0) snake_x[snake_len] = bkgrd_x
      # }
      
      direction = "left"
    }
    
    # Downwards shift
    if(keyCode == DOWN_ARROW){
      direction = "down"
      old_snake_x = snake_x
      old_snake_y = snake_y
      for(i in 0:(snake_len - 1)){
        snake_x[i] = old_snake_x[i+1]
        snake_y[i] = old_snake_y[i+1]
      }
      new_y = old_snake_y[snake_len] + snake_wid
      snake_y[snake_len] = new_y
      if(new_y > bkgrd_y) snake_y[snake_len] = 0
    }
    
    # Upwards shift
    if(keyCode == UP_ARROW){
      direction = "up"
      old_snake_x = snake_x
      old_snake_y = snake_y
      for(i in 0:(snake_len - 1)){
        snake_x[i] = old_snake_x[i+1]
        snake_y[i] = old_snake_y[i+1]
      }
      new_y = old_snake_y[snake_len] - snake_wid
      snake_y[snake_len] = new_y
      if(new_y < 0) snake_y[snake_len] = bkgrd_y
    }
    
    for(i in 0:(snake_len - 1)){
      dx = abs(snake_x[i] - snake_x[snake_len])
      dy = abs(snake_y[i] - snake_y[snake_len])
      if(dx < snake_wid & dy < snake_wid)
        snake_stop = TRUE
    }
    
  }

}
