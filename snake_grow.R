#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 400
bkgrd_y  = 300
bkgrd_black = 33

frame_rate = 10
travel_direction = 2

snake_wid =  10
start_snake_len = 5
snake_green = 255

fruit_radius = 10
fruit_red = 255

snake_len = start_snake_len
snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2

fruit_x = bkgrd_x/2 + 150
fruit_y = bkgrd_y/2 + snake_wid/2

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

grow_snake <- function(xy_value, snake_vec, snake_len, snake_wid, 
                       travel_direction){
  
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

setup <- function() {
  createCanvas(bkgrd_x, bkgrd_y)
  frameRate(frame_rate)
}

draw <- function(){
  
  background(0, 0, bkgrd_black)    

  # Draw the fruit
  fill(fruit_red, 0, 0)
  circle(fruit_x,  fruit_y, fruit_radius)

  # Draw the snake
  fill(0, snake_green, 0)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], 10)
  }
  
  # Move our snake East
  if(frameCount > 2){
    
    # Plain left shift
    snake_x = snake_x + snake_wid
    for(i in 0:snake_len){
      if(snake_x[i] > bkgrd_x) snake_x[i] = 0
    }
    
  }
  
  # Check if fruit was eaten
  fruit_dx = abs(snake_x[snake_len] - fruit_x)
  fruit_dy = abs(snake_y[snake_len] - fruit_y)
  if(fruit_dx < snake_wid & fruit_dy < snake_wid){
    
    fruit_x = runif(1, min = 0, max = bkgrd_x/2)
    snake_len = snake_len + 1
    snake_x = grow_snake(1, snake_x, snake_len, snake_wid, travel_direction)
    snake_y = grow_snake(2, snake_y, snake_len, snake_wid, travel_direction)
    
  }
  
}

# Check vector referencing (maybe I can speed up my for loop)
# Layering of the snake and the fruit - disappear fruit
# Warning: Code assumes fruit is on the board


# ###  OLD
# grow_snake_x <- function(snake_x, snake_len, snake_wid, travel_direction){
#   
#   snake_x <- inherit_old_snake(snake_x, snake_len, shift = FALSE)
#   
#   if(travel_direction  == 2){
#     snake_x[snake_len] = snake_x[snake_len - 1]  + snake_wid 
#   }else if(travel_direction == 4){
#     snake_x[snake_len] = snake_x[snake_len - 1] - snake_wid
#   }else{
#     snake_x[snake_len] = snake_x[snake_len - 1]
#   }
#   
#   return(snake_x)
# }
# 
# grow_snake_y <- function(snake_y, snake_len, snake_wid, travel_direction){
#   
#   snake_y <- inherit_old_snake(snake_y, snake_len, shift = FALSE)
#   
#   if(travel_direction  == 1){
#     snake_y[snake_len] = snake_y[snake_len - 1]  - snake_wid 
#   }else if(travel_direction == 3){
#     snake_y[snake_len] = snake_y[snake_len - 1] + snake_wid
#   }else{
#     snake_y[snake_len] = snake_y[snake_len - 1]
#   }
#   
#   return(snake_y)
# }