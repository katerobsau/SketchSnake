#! load_script(src = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/p5.js")

# Background
bkgrd_x = 400
bkgrd_y  = 300

setup <- function() {
  createCanvas(bkgrd_x, bkgrd_y)
}

draw <- function() {
  
  #Draw the background colour
  background(0, 0, 33)    
  
  # Fruit details
  fruit_col = color('rgb(255,0,0')
  fruit_stay_length = 50
  fruit_radius = 20
  
  # Draw a piece of fruit
  timer = 2
  if(frameCount%%fruit_stay_length < timer){
     fruit_x = runif(1, min = 0, max = bkgrd_x/2)
     fruit_y = runif(1, min = 0, max = bkgrd_y/2)
  }
  circle(fruit_x,  fruit_y, fruit_radius)
  
}

# So equals didn't work in the boolean statement
# Neither did 1 the fruit didn't get drawn
# But 2 was fine ? Why
# I can also see two jumps using timer = 2
# So why wouldn't it work when timer == 0
