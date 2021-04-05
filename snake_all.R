#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 500
bkgrd_y  = 500
bkgrd_col = 33

frame_rate = 10

snake_wid =  10
start_snake_len = 5
snake_green = 255

fruit_stay_length = 50
fruit_radius = snake_wid
fruit_red = 255

setup <- function(){
  createCanvas(bkgrd_x, bkgrd_y)
  frameRate(frame_rate)
}

draw <- function(){
  
  #Draw the background colour
  background(0, 0, bkgrd_col)    
  
  # Initialise game
  if(frameCount < 2){
    
    # Initialise snake
    snake_stop = FALSE
    snake_len = start_snake_len
    snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
    snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2
    
    # Initialise fruit
    fruit_x = runif(1, min = 0, max = bkgrd_x)%%snake_wid * snake_wid
    fruit_y = runif(1, min = 0, max = bkgrd_y)%%snake_wid * snake_wid
  }
  
  # Draw the snake
  fill(0, snake_green, 0)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], snake_wid)
  }
  
  # Draw the fruit
  fill(fruit_red, 0, 0)
  circle(fruit_x,  fruit_y, fruit_radius)
  
  # Game Play
  if(frameCount > 2  & snake_stop == FALSE){
    
    # Right Move
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
    
    # Left Move
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
    
    # Downwards Move
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
    
    # Upwards Move
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
    
    # Collision Code
    for(i in 0:(snake_len - 1)){
      snake_head_dx = abs(snake_x[i] - snake_x[snake_len])
      snake_head_dy = abs(snake_y[i] - snake_y[snake_len])
      if(snake_head_dx < snake_wid & snake_head_dy < snake_wid)
        snake_stop = TRUE
    }
    
    # Eat Fruit
    fruit_dx = abs(fruit_x - snake_x[snake_len])
    fruit_dy = abs(fruit_y - snake_y[snake_len])
    if(fruit_dx < snake_wid & fruit_dy < snake_wid){
      fruit_x = runif(1, min = 0, max = bkgrd_x/2)%%snake_wid * snake_wid 
      fruit_y = runif(1, min = 0, max = bkgrd_y/2)%%snake_wid * snake_wid 
    }
    
  }
  
}

# Still having issues with growing

# Some direction bugs (eg. up to down, left to right)
# Clash with collision code!

# Fruit offset is incorrect