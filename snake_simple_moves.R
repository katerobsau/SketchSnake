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
  
  # Initialise snake
  if(frameCount < 2){
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
  if(frameCount > 2){
    
    # Plain left shift
    snake_x = snake_x + snake_wid
    for(i in 0:snake_len){
      if(snake_x[i] > bkgrd_x){
        snake_x[i] = 0
      }
    }
    
    # # Plain right shift
    # snake_x = snake_x - snake_wid 
    # for(i in 0:snake_len){
    #   if(snake_x[i] < 0){
    #     snake_x[i] = bkgrd_x
    #   }
    # }
    
    # # Downwards shift
    # snake_y = snake_y + snake_wid 
    # for(i in 0:snake_len){
    #   if(snake_y[i] > bkgrd_y){
    #     snake_y[i] = 0
    #   }
    # }
    
    # # Upwards shift
    # snake_y = snake_y - snake_wid 
    # for(i in 0:snake_len){
    #   if(snake_y[i] < 0){
    #     snake_y[i] = bkgrd_y
    #   }
    # }
    
  }

}

# Two hurdles: 
# - pop on/ pop off
# - add to snake using frameCount