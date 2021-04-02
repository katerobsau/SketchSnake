#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 400
bkgrd_y  = 300
setup <- function() {
  createCanvas(bkgrd_x, bkgrd_y)
}

draw <- function(){
  
  #Draw the background colour
  background(0, 0, 33)    
  
  # Snake details
  snake_col = color('rgb(0,255,0)') 
  snake_wid =  10
  start_snake_len = 5
  snake_speed = 200
  
  # Fruit details
  fruit_col = color('rgb(255,0,0')
  fruit_stay_length = 50
  fruit_radius = 20
  
  # Initialise snake and the fruit
  if(frameCount < 2){
    
    snake_len = start_snake_len
    snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
    snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2

    fruit_x = bkgrd_x/2 + 150
    fruit_y = bkgrd_y/2 
    fruit_eaten = FALSE
    
  }
  
  # Draw the fruit
  fill(fruit_col)
  circle(fruit_x,  fruit_y, fruit_radius)
  
  # Draw the snake
  fill(snake_col)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], 10)
  }
  
  # Move our snake East
  if(frameCount > 2){

    # Plain left shift
    fill(snake_col)
    snake_x = snake_x + snake_wid
    for(i in 0:snake_len){
      if(snake_x[i] > bkgrd_x){
        snake_x[i] = 0
      }
    }

  }

  if(snake_x[1] == fruit_x & snake_y[1] == fruit_y){
    fruit_eaten = TRUE
    snake_len = 1 #snake_len 
  }  

  if(fruit_eaten){
    fruit_x = runif(1, min = 0, max = bkgrd_x/2)
    fruit_y = runif(1, min = 0, max = bkgrd_y/2)
    circle(fruit_x,  fruit_y, fruit_radius)
    fruit_eaten = FALSE
  }
  
}

# Layering of the snake and the fruit - disappear fruit
# Timing not instantaneous (ie snake_len + 10 fails, but snake_len = 2 ok)
# ? Push back and pop back issue related to timing
