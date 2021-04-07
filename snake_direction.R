#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 400
bkgrd_y  = 300
frame_rate = 10

# can move to set up (global)
snake_wid =  10
start_snake_len = 5
snake_len = start_snake_len
snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2
last_direction = 2

setup <- function() {
  frameRate(frame_rate)
  createCanvas(bkgrd_x, bkgrd_y)
  
}

draw <- function(){
  
  #Draw the background colour
  background(0, 0, 33)    
  
  # Snake details
  snake_col = color('rgb(0,255,0)') 
  
  # Draw the snake
  fill(snake_col)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], 10)
  }

  # Determine movement direction
  if(keyCode == RIGHT_ARROW && last_direction != 4){
    travel_direction = 2 #"right"
  }else if(keyCode == LEFT_ARROW && last_direction != 2){
    travel_direction = 4
  }else if(keyCode == DOWN_ARROW && last_direction != 1){
    travel_direction = 3
  }else if(keyCode == UP_ARROW && last_direction != 3){
    travel_direction = 1
  # }else if(travel_direction %in% 1:4){
  #   travel_direction = last_direction
  }else{
    travel_direction = last_direction
  }
  
  # Move snake right
  if(travel_direction == 2){
    last_direction = 2
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
  
  # Move snake left
  if(travel_direction == 4){
    last_direction = 4
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
  
  # Move snake down
  if(travel_direction == 3){
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
  
  # Move snake up
  if(travel_direction == 1){
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
# has issues with boolean strings - so  used numeric codes
# latest version of sketch doesn't have this problem