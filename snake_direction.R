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
travel_direction = 0
last_direction = 0

inherit_old_snake <- function(snake_vec, snake_len, shift){
  
  old_snake_vec = snake_vec
  snake_vec = seq(0, snake_len)
  
  if(shift == FALSE){
    for(i in 0:(snake_len - 1)) snake_vec[i] = old_snake_vec[i]
  }else{
    for(i in 0:(snake_len - 1)) snake_vec[i] = old_snake_vec[i + 1]
  }
  
  return(snake_vec)
  
}

move_snake <- function(xy_value, snake_vec, snake_len, snake_wid, 
                       travel_direction, max_value){
  
  snake_vec <- inherit_old_snake(snake_vec, snake_len, shift = TRUE)
  
  if(xy_value == 1 & travel_direction == 2 |
     xy_value == 2 & travel_direction == 3){
    new_value = snake_vec[snake_len - 1] + snake_wid 
    if(new_value > max_value) new_value = 0
      snake_vec[snake_len] = new_value
  }else if(xy_value == 1 & travel_direction == 4 |
           xy_value == 2 & travel_direction  == 1){
    new_value = snake_vec[snake_len - 1] - snake_wid 
    if(new_value < 0) new_value = max_value
    snake_vec[snake_len] = new_value
  }else{
    snake_vec[snake_len] = snake_vec[snake_len - 1]
  }
  
  return(snake_vec)
}

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
    travel_direction = 2
  }else if(keyCode == LEFT_ARROW && last_direction != 2){
    travel_direction = 4
  }else if(keyCode == DOWN_ARROW && last_direction != 1){
    travel_direction = 3
  }else if(keyCode == UP_ARROW && last_direction != 3){
    travel_direction = 1
  }else if(keyCode == ENTER){
    travel_direction = 0 # Game Pause
  }else{
    # Game Start
  }
  
  # Move the snake
  if(travel_direction != 0){
    
    snake_x = move_snake(xy_value = 1, 
                         snake_vec = snake_x, 
                         snake_len = snake_len, 
                         snake_wid = snake_wid, 
                         travel_direction = travel_direction, 
                         max_value = bkgrd_x)
    
    snake_y = move_snake(xy_value = 2, 
                         snake_vec = snake_y, 
                         snake_len = snake_len, 
                         snake_wid = snake_wid, 
                         travel_direction = travel_direction, 
                         max_value = bkgrd_y)
    
    last_direction = travel_direction
    
  }

}
# has issues with boolean strings - so  used numeric codes
# latest version of sketch doesn't have this problem

# be nice to synthesis code using a function for direction