#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 500
bkgrd_y  = 500
bkgrd_col = 33

frame_rate = 10
last_direction = 0
travel_direction = 2

snake_stop = FALSE
snake_wid =  10
start_snake_len = 5
snake_green = 255

fruit_radius = snake_wid
fruit_red = 255
# fruit_stay_length = 50

snake_len = start_snake_len
snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2

fruit_x = runif(1, min = 0, max = bkgrd_x)%%snake_wid * snake_wid
fruit_y = runif(1, min = 0, max = bkgrd_y)%%snake_wid * snake_wid

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

grow_snake <- function(xy_value, snake_vec, snake_len, snake_wid, travel_direction){
  
  snake_vec <- inherit_old_snake(snake_vec, snake_len, shift = FALSE)
  
  if(xy_value == 1 & travel_direction == 2 |
     xy_value == 2 & travel_direction == 3){
    snake_vec[snake_len] = snake_vec[snake_len - 1] + snake_wid 
  }else if(xy_value == 1 & travel_direction == 4 |
           xy_value == 2 & travel_direction  == 1){
    snake_vec[snake_len] = snake_vec[snake_len - 1] - snake_wid
  }else{
    snake_vec[snake_len] = snake_vec[snake_len - 1]
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

# check_collision <- function(snake_x_coord, snake_y_coord, 
#                             collsion_x, collision_y,
#                             snake_wid){
#   dx = abs(snake_x_coord - collision_x)
#   dy = abs(snake_y_coord - collision_y)
#   collision_event = FALSE
#   if(dx < snake_wid & dy < snake_wid) collision_event =  TRUE
#   return(collision_event)
# }

setup <- function(){
  createCanvas(bkgrd_x, bkgrd_y)
  frameRate(frame_rate)
}

draw <- function(){
  
  # Draw the background
  background(0, 0, bkgrd_col)    
  
  # Draw the snake
  fill(0, snake_green, 0)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], snake_wid)
  }
  
  # Draw the fruit
  fill(fruit_red, 0, 0)
  circle(fruit_x,  fruit_y, fruit_radius)
  
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
  if(travel_direction != 0 & snake_stop == FALSE){
    
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
    
    # Collision Code
    for(i in 0:(snake_len - 1)){
      snake_head_dx = abs(snake_x[i] - snake_x[snake_len])
      snake_head_dy = abs(snake_y[i] - snake_y[snake_len])
      if(snake_head_dx < snake_wid & snake_head_dy < snake_wid)
        snake_stop = TRUE
    }
    
    
    # fruit_collision = check_collision( snake_x_coord = snake_x[snake_len], 
    #                                    snake_y_coord = snake_y[snake_len],  
    #                                    collsion_x = fruit_x, 
    #                                    collision_y = fruit_y,
    #                                    snake_wid = snake_wid)
    # Check if fruit was eaten
    fruit_dx = abs(snake_x[snake_len] - fruit_x)
    fruit_dy = abs(snake_y[snake_len] - fruit_y)
    if(fruit_dx < snake_wid & fruit_dy < snake_wid){
    # if(fruit_collision == TRUE){
      fruit_x = runif(1, min = 0, max = bkgrd_x/2)
      fruit_y = runif(1, min = 0, max = bkgrd_y/2)
      snake_len = snake_len + 1
      snake_x = grow_snake(1, snake_x, snake_len, snake_wid, travel_direction)
      snake_y = grow_snake(2, snake_y, snake_len, snake_wid, travel_direction)
    }
  
}

# Still having issues with growing

# Some direction bugs (eg. up to down, left to right)
# Clash with collision code!

# Fruit offset is incorrect