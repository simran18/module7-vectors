# Exercise 4: Creating and operating on vectors

# Create a vector `names` that contains your name and the names of 2 people next to you.
names <- c('Simran', 'Nick', 'Coco')

# Use the colon operator : to create a vector `n` of numbers from 10:49
n <- 10:49

# Use `length()` to get the number of elements in `n`
length(n)

# Create a vector `m` that contains the numbers 10 to 1. Hint: use the `seq()` function
m <- seq(10:1)

# Subtract `m` FROM `n`. Note the recycling!
n.subtract.m <- n - m

# Use the `seq()` function to produce a range of numbers from -5 to 10 in `.1` increments.
# Store it in a variable `x`
x <- seq(-5,10,.1)

# Create a vector `sin.wave` by calling the `sin()` function on each element in `x`.
sin.wave <- sin(x)

# Create a vector `cos.wave` by calling the `cos()` function on each element in `x`.
cos.wave <-cos(x)

# Create a vector `wave` by multiplying `sin.wave` and `cos.wave` together, then adding `sin.wave`
wave <- sin(x) + cos(x)

# Use the `plot()` function to plot your `wave`!
plot(wave)