#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

bkgrd_x = 500
bkgrd_y  = 500
frame_rate = 5
setup <- function(){
  createCanvas(bkgrd_x, bkgrd_y)
  frameRate(frame_rate)
}

draw <- function(){
  
  #Draw the background colour
  background(0, 0, 33)    
  
  # Snake details
  snake_col = color('rgb(0,255,0)') 
  snake_wid =  20
  start_snake_len = 5
  
  # Fruit details
  fruit_col = color('rgb(255,0,0')
  fruit_stay_length = 50
  fruit_radius = snake_wid
  
  # Initialise game
  if(frameCount < 2){
    
    snake_len = start_snake_len
    snake_x = seq(0,start_snake_len)*snake_wid + bkgrd_x/2
    snake_y = seq(0,start_snake_len)*0 + bkgrd_y/2
    
    fruit_x = runif(1, min = 0, max = bkgrd_x)
    fruit_y = runif(1, min = 0, max = bkgrd_y)
    fruit_eaten = FALSE
    
  }
  
  # Draw the snake
  fill(snake_col)
  for(i in 0:snake_len){
    square(snake_x[i], snake_y[i], snake_wid)
  }
  
  # Draw the fruit
  fill(fruit_col)
  circle(fruit_x,  fruit_y, fruit_radius)
  
  # Move our snake East
  if(frameCount > 2){
    
    # Plain right shift
    if(keyCode == RIGHT_ARROW){
      snake_x = snake_x + snake_wid
      for(i in 0:snake_len){
        if(snake_x[i] > bkgrd_x){
          snake_x[i] = 0
        }
      }
    }
    
    # Plain left shift
    if(keyCode == LEFT_ARROW){
      snake_x = snake_x - snake_wid
      for(i in 0:snake_len){
        if(snake_x[i] < 0){
          snake_x[i] = bkgrd_x
        }
      }
    }
    
    # Downwards shift
    if(keyCode == DOWN_ARROW){
      snake_y = snake_y + snake_wid
      for(i in 0:snake_len){
        if(snake_y[i] > bkgrd_y){
          snake_y[i] = 0
        }
      }
    }
    
    # Upwards shift
    if(keyCode == UP_ARROW){
      snake_y = snake_y - snake_wid
      for(i in 0:snake_len){
        if(snake_y[i] < 0){
          snake_y[i] = bkgrd_y
        }
      }
    }
    
    if(abs(snake_x[1] - fruit_x) < snake_wid & 
       abs(snake_y[1] - fruit_y) < snake_wid){
      # fruit_eaten = TRUE
    # }
    # if(fruit_eaten){
      # snake_len = 1 # increase snake length
      fruit_x = runif(1, min = 0, max = bkgrd_x/2)
      fruit_y = runif(1, min = 0, max = bkgrd_y/2)
      circle(fruit_x, fruit_y, fruit_radius)
    }
    
  }
  
}