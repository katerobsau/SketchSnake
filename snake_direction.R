#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 400
bkgrd_y  = 300

# can move to set up (global)
snake_wid =  10
start_snake_len = 5
snake_len = start_snake_len
snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2
last_direction = 4

setup <- function() {
  frameRate(10)
  createCanvas(bkgrd_x, bkgrd_y)
  
}

draw <- function(){
  
  #Draw the background colour
  background(0, 0, 33)    
  
  # Snake details
  snake_col = color('rgb(0,255,0)') 
  # snake_wid =  10
  # start_snake_len = 5
    
  # # Initialise snake
  # if(frameCount == 1){
    
    # # can move to set up (global)
    # snake_len = start_snake_len
    # snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
    # snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2
    # last_direction = 4
    # 
  # }
  
  # Draw the snake
  fill(snake_col)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], 10)
  }
    
    # Plain right shift
    if(keyCode == RIGHT_ARROW && last_direction != 2){
    # if(last_direction != 2){
      last_direction = 4
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
    if(keyCode == LEFT_ARROW && last_direction != 4){
      
      last_direction = 2
      old_snake_x = snake_x
      old_snake_y = snake_y
      
      for(i in 0:(snake_len - 1)){
        snake_x[i] = old_snake_x[i+1]
        snake_y[i] = old_snake_y[i+1]
      }
      new_x = old_snake_x[snake_len] - snake_wid
      snake_x[snake_len] = new_x
      if(new_x < 0) snake_x[snake_len] = bkgrd_x
    }
    
    # Downwards shift
    if(keyCode == DOWN_ARROW && last_direction != 1){
      last_direction = 3
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
    if(keyCode == UP_ARROW && last_direction != 3){
      last_direction = 1
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

}

# bug with up then down / bug with left then right
# ?? Not with this code but in snake_all ?? why

# important to track the direction of the snake head
# when the snake goes left this creates two options 
# for how to append the new square / create movement
# having some trouble with a boolean if statement to do both