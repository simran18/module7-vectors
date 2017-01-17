# Module 7: Introduction to Vectors

In this module, we'll cover the foundational concepts for working with vectors in R. Vectors are _the_ fundamental data type in R: in order to use R, you need to become comfortable with vectors. This module will discuss how R stores information in vectors, the way in which operations are executed in _vectorized_ form, and how to extract subsets of vectors. These concepts are key to effectively programming in R.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Resources](#resources)
- [What is a Vector?](#what-is-a-vector)
  - [Creating Vectors](#creating-vectors)
- [Vectorized Operations](#vectorized-operations)
  - [Recycling](#recycling)
  - [Everything is a Vector!](#everything-is-a-vector)
  - [Vectorized Functions](#vectorized-functions)
- [Vector Indices](#vector-indices)
  - [Multiple Indicies](#multiple-indicies)
- [Vector Filtering](#vector-filtering)
- [Modifying Vectors](#modifying-vectors)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Resources
- [R Tutorial: Vectors](http://www.r-tutor.com/r-introduction/vector)

## What is a Vector?
**Vectors** are _one-dimensional collections of values_ that are all stored in a single variable. For example, you can make a vector `names` that contains the character strings "Sarah", "Amit", and "Zhang", or a vector `one.to.hundred` that stores the numbers from 1 to 100. Each value in a vector is refered to as an **element** of that vector; thus our `names` vector would have 3 elements: `"Sarah"`, `"Amit"`, and `"Zhang"`.

- Importantly, all the elements in a vector need to have the same _type_ (numeric, character, logical, etc.). You can't have a vector whose elements are both numbers and character strings.


### Creating Vectors
The easiest and most common syntax for creating vectors is to use the built in `c()` function, which is used to ***c***_ombine_ values into a vector. The `c()` function takes in any number of **arguments** of the same type (separated by commas as usual), and **returns** a vector of that contains those elements:

```r
# Use the combine (`c`) function to create a vector.
names <- c("Sarah", "Amit", "Zhang")
print(names)  # [1] "Sarah" "Amit"  "Zhang"

numbers <- c(1,2,3,4,5)
print(numbers)  # [1] 1 2 3 4 5
```

We can use the `length()` function to determine how many **elements** are in a vector:

```r
names <- c("Sarah", "Amit", "Zhang")
names.length <- length(names)
print(names.length)  # [1] 3

numbers <- c(1,2,3,4,5)
print( length(numbers) )  # [1] 5
```

Other functions can also help with creating vectors. For example, the `seq()` function mentioned in module 6 takes 2 arguments and produces a vector of the integers between them. An _optional_ third argument specifies how many numbers to skip:

```r
# Make vector of numbers 1 to 100
one.to.hundred <- seq(1,100)
print(one.to.hundred)

# Make vector of numbers 1 to 10, counting by 2
odds <- seq(1, 10, 2)
print(odds)  # [1] 1 3 5 7 9
```

- When you print out `one.to.hundred`, you'll notice that in addition to the leading `[1]` that we've seen in all printed results, there are additional bracketed numbers at the start of each line. These bracketed numbers tells you from which element number (**index**, see below) that line is showing the elements of. Thus the `[1]` means that the printed line shows elements started at element number `1`, a `[20]` means that the printed line shows elements starting at element number `20`, and so on. This is to help make the output more readable, so you know where in the vector you are when looking at a printed line of elements!

As a shorthand, you can produce a sequence with the _colon operator_ (**`a:b`**), which returns a vector `a` to `b` incrementing by `1`:

```r
one.to.hundred <- 1:100
```

Once created, you are unable to change the number of elements in a vector. However, you can create a _new vector_ by **c**ombining a new element with an existing vector:

```r
# Use the combine (`c`) function to create a vector.
names <- c("Sarah", "Amit", "Zhang")

# Use the combine (`c`) function to combine the `people` vector and the name 'Josh'.
more.names <- c(names, 'Josh')
print(more.names)  # [1] "Sarah" "Amit"  "Zhang" "Josh"
```

## Vectorized Operations
When performing operations (such as math operations `+`, `-`, etc.) on vectors, the operation is applied to vector elements **member-wise**. This means that each element from the first vector operand is modified by the element in the **same corresponding position** in the second vector operand in order to determine the value of at _the corresponding position_ of the resulting vector. E.g., if you want to add (`+`) two vectors, then the value of the first element in the result will be the sum (`+`) of the first elements in each vector, the second element in the result will be the sum of the second elements in each vector, and so on.

```r
# Create two vectors to combine
v1 <- c(1, 1, 1, 1, 1)
v2 <- c(1, 2, 3, 4, 5)

# Create arithmetic combinations of the vectors
v1 + v2  # returns 2, 3, 4, 5, 6
v1 - v2  # returns 0, -1, -2, -3, -4
v1 * v2  # returns 1, 2, 3, 4, 5
v1 / v2  # returns 1, .5, .33, .25, .2

# Add a vector to itself (why not?)
v3 <- v2 + v2  # returns 2, 4, 6, 8, 10

# Perform more advanced arithmetic!
v4 <- (v1 + v2) / (v1 + v1)  # returns 1, 1.5, 2, 2.5, 3
```

While we can't apply mathematical operators (namely, `+`) to combine vectors of character strings, we can use functions like `paste()` to concatenate the elements of two vectors.

```r
colors <- c('Green', 'Blue')
spaces <- c('sky', 'grass')

# Note: look up the `paste0()` function if it's not familiar!
bands <- paste0(colors, spaces)  # returns "Greensky", "Bluegrass"
# http://greenskybluegrass.com/
```

Notice the same _member-wise_ combination is occuring: the `paste0()` function is applied to the first elements, then to the second elements, and so on.


### Recycling
**Recycling** refers to what R does in cases when there are an unequal number of elements in two operand vectors. If R is tasked with performing a vectorized operation with two vectors of unequal length, it will reuse (_recycle_) elements from the shorter vector. For example:

```r
# Create vectors to combine
v1 <- c(1, 3, 5)
v2 <- c(1, 2)

# Add vectors
v3 <- v1 + v2  # returns (2, 5, 6)
```

In the example above, R first combined the elements in the first position of each vector (`1+1=2`). Then, it combined elements from the second position (`3+2=5`). When it got to the third element (which only was present in `v1`), it went back to the **beginning** of `v1` to select a value, yielding `5+1=6`.

- Recycling will occur no matter if the longer vector is the first or second operand.

- Note, R may provide a warning message, notifying you that the vectors are of different length. This warning doesn't necessarily mean you did something wrong, but you should pay attention to it because it may be indicative of an error (i.e., you thought the vectors were of the same length, but overlooked it).


### Everything is a Vector!
What happens if we try to add a vector and a "regular" single value (a **scalar**)?

```r
# create vector of numbers 1 to 5
v1 <- 1:5
result <- v1 + 4  #add scalar to vector
print(result)  # [1] 5 6 7 8 9
```

As you can see (and probably expected), the operation added `4` to every element in the vector.

The reason this sensible behavior occurs is because, in truth, **everything in R is a vector**. Even when you thought you were creating a single value (a scalar), you were actually just creating a vector with a single element (length 1). Even when you create a variable storing the number `7` (with `x <- 7`), R creates a vector of length 1 with the number `7` as that single element.

- This is why R kept printing the `[1]` in front of all results: it's telling you that it's showing a vector (which happens to have 1 element) starting at element number 1.

- This is also why you can't use the `length()` function to get the length of a character string; it just returns the length of the array containing that string (`1`). Instead, use the `nchar()` function to get the number of characters in the character string.

```r
# Create a vector of length 1 in a variable x
x <- 7  # equivalent to `x <- c(7)`

# Print out x: R states the vector index (1) in the console
print(x)  # [1] 7
```

Thus when you add a "scalar" such as `4` to a vector, what you're really doing is adding a vector with a single element `4`. Thus the same _recycling_ principle applies, and that single element is "recycled" and applied to each element of the first operand.


### Vectorized Functions

> _Vectors In, Vector Out_

Because _everything is a vector_, it means that pretty much every function we've used so far has actually applied to vectors, not just to single values. These are referred to as **vectorized functions**, and will run significantly faster than non-vector approaches. You'll find that functions work the same way for vectors as they do for single values, because single values are just a special case of vectors!

- _Fun fact:_ The mathematical operators (e.g., `+`) are actually functions in R that take 2 arguments (the operands). The mathematical notation we're used to using is just a shortcut

  ```r
  # these two lines of code are the same:
  x <- 2 + 3  # add 2 and 3
  x <- '+'(2, 3)  # add 2 and 3
  ```

This means that we an use any function on a vector, and it will act in the same _member-wise_ manner: the function will result in a new vector where the function's transformation has been applied to each individual element in order.

For example consider the `round()` function described in the previous module. This function rounds the given argument to the nearest whole number (or number of decimal places if specified).

```r
# round number to 1 decimal place
round(1.67, 1)  # returns 1.6
```

But recall that the `1.6` in the above example is _actually a vector of length 1_. If we instead pass a vector as an argument, the function will perform the same rounding on each element in the vector.

```r
# Create a vector of numbers
nums <- c(3.98, 8, 10.8, 3.27, 5.21)

# Perform the vectorized operation
whole.nums <- round(nums, 1)

# Print the results (each is rounded)
print(whole.nums)  # [1]  4.0  8.0 10.8  3.3  5.2
```

This vectorization process is ___extremely powerful__, and is a significant factor in what makes R an efficient language for working with large data sets (particularly in comparison to languages that require explicit iteration through elements in a collection). Thus to write really effective R code, you'll need to be comfortable applying functions to vectors of data, and getting vectors of data back as results.

- Just remember: _when you use a function on a vector, you're using that function **on each item** in the vector_!


## Vector Indices
Vectors are the fundamental collections of data. Yet we often want to only work with some of the data in a vector. This section will discuss a few ways that we can get a **subset** of elements in a vector.

In particular, we can refer to individual elements in a vector by their **index**, which is the number of their position in the vector. For example, in the vector:

```r
vowels <- c('a','e','i','o','u')
```

The `'a'` (the first element) is at _index_ 1, `'e'` (the second element) is at index 2, and so on.

- Note in R vector elements are indexed starting with `1`. This is distinct from most other programming languages which are _zero-indexed_ and so reference the first element at index `0`.

You can retrieve a value from a vector using **bracket notation**: you refer to the element at a particular index of a vector by writing the name of the vector, followed by square brackets (**`[]`**) that contain the index of interest:

```r
names <- c("Sarah", "Amit", "Zhang")

# access the element at index 1
name.first <- names[1]
print(name.first)  # [1] "Sarah"

# access the elemnt at index 2
name.second <- names[2]
print(name.second)  # [1] "Amit"

# You can also use variables inside the brackets
last.index <- length(names)  # last index is the length of the vector!
name.last <- names[last.index]  # returns "Zhang"
```

- Don't get confused by the `[1]` in the printed output&mdash;it doesn't refer to which index you got from `names`, but what index in the _extracted_ result (e.g., stored in `name.first`) is being printed!


If you specify an index that is **out-of-bounds** (e.g., greater than the number of elements in the vector) in the square brackets, you will get back the value `NA`, which stands for **N**ot **A**vailable. Note that this is _not_ the _character string_ `"NA"`, but a specific logical value.

```r
vowels <- c('a','e','i','o','u')

# Attempt to access the 10th element
vowels[10]  # returns NA
```

If you specify a **negative index** in the square-brackets, R will return all elements _except_ the (negative) index specified:

```r
vowels <- c('a','e','i','o','u')

# Return all elements EXCEPT the index 2
all.but.e <- vowels[-2]
print(all.but.e)  # [1] "a" "i" "o" "u"
```

### Multiple Indicies
Remember that in R, **everything is a vector**. This means that when you put a single number inside the square brackets, you're actually putting a _vector with a single element in it_ into the brackets. So what you're really doing is specifying a **vector of indices** that you want R to extract from the vector. As such, you can put a vector of any length inside the brackets, and R will extract _all_ the elements with those indices from the vector (producing a **subset** of the vector elements):

```r
# Create a `colors` vector
colors <- c('red', 'green', 'blue', 'yellow', 'purple')

# Vector of indices to extract
indices <- c(1,3,4)

# Retrieve the colors at those indices
extracted <- colors[indices]
print(extracted)  # [1] "red"    "blue"   "yellow"


# Specify the index array anonymously
others <- colors[c(2, 5)]
print(others)  # [1] "green"  "purple"
```

It's incredibly common to use the **colon operator** to quickly specify a range of indices to extract:

```r
# Create a `colors` vector
colors <- c('red', 'green', 'blue', 'yellow', 'purple')

# Retrieve values in positions 2 through 5
colors[2:5]  # [1] "green"  "blue"   "yellow" "purple"
```

This easily reads as _"a vector of the elements in positions 2 through 5"_.

## Vector Filtering
In the above section, we used a vector of indices (_numeric_ values) to retrieve a subset of elements from a vector. Alternatively, we can put a **vector of logical (boolean) values** inside the square brackets to specify which ones we want to extract (`TRUE` in the _corresponding position_ means extract, `FALSE` means don't extract):

```r
# Create a vector of shoe sizes
shoe.sizes <- c(7, 6.5, 4, 11, 8)

# Vector of elements to extract
filter <- c(TRUE, FALSE, FALSE, TRUE, TRUE)

# Extract every element in an index that is TRUE
shoe.sizes[filter]  # [1]  7 11  8
```

R will go through the boolean vector and extract every item at the same position as a `TRUE`. In the example above, since `filter` is `TRUE` and index 1, 4, and 5, then `shoe.sizes[filter]` returns a vector with elements from indicies 1, 4, and 5.

This may seem a bit strange, but it is actually incredibly powerful because it lets us select elements from a vector that _meet a certain criteria_ (called **filtering**). We do this by first creating a vector of boolean values that correspond with the indices meet that criteria, and then put that filter vector inside the square brackets:

```r
# Create a vector of shoe sizes
shoe.sizes <- c(7, 6.5, 4, 11, 8)

# Create a boolean vector that indicates if a shoe size is greater than 6.5
shoe.is.big <- shoe.sizes > 6.5  # T, F, F, T, T

# Use the `shoe.is.big` vector to select large shoes
big.shoes <- shoe.sizes[shoe.is.big]  # returns 7, 11, 8
```

The magic here is that we are once again using _recycling_: the relational operator `>` is _vectorized_, meaning that the shorter vector (the `6.5`) is recycled and applied to each element in the `shoe.sizes` vector, thus producing the boolean vector that we want!

We can even combine the second and third lines of code into a single statement. You can think of the following statement as saying _shoe.sizes **where** shoe.sizes is greater than 6.5_:

```r
# Create a vector of shoe sizes
shoe.sizes <- c(7, 6.5, 4, 11, 8)

# Select shoe sizes that are greater than 6.5
shoe.sizes[shoe.sizes > 6.5]  # returns 7, 11, 8
```

This is a valid statement because the equality inside of the square-brackets (`shoe.sizes > 6.5`) is evaluated first, producing the boolean vector which are then used to filter the `shoe.sizes` vector.

This kind of filtering is crucial for being able to ask real world questions of our datasets. To practice working with vectors, see [exercise-1](exercise-1).


## Modifying Vectors
As a final note, while we are unable to change the number of elements within a vector, we _are_ able to change the individual values within a vector. To achieve this, put the extracted _subset_ on the **left-hand side** of the assignment operator, and then assign the element a new value:

```r
# Create a vector of school supplies
school.supplies <- c('Backpack', 'Laptop', 'Pen')

# Replace 'Pen' (element at index 3) with 'Pencil'
school.supplies[3] <- 'Pencil'
```

And of course, there's no reason that we can't select multiple elements on the left-hand side, and assign them multiple values. The assignment operator is also _vectorized_!

```r
# Create a vector of school supplies
school.supplies <- c('Backpack', 'Laptop', 'Pen')

# Replace  'Laptop' with 'Tablet', and 'Pen' with 'Pencil'
school.supplies[c(2,3)] <- c('Tablet', 'Pencil')
```

As a more useful example, imagine you had a vector of values in which you wanted to replace all numbers greater that 10 with the number 10 (to "cap" the values). Because the assignment operator is vectorized, we can leverage _recycling_ to apply a single value to each element element that has been _filtered_ from the vector:

```r
# Element of values
v1 <- c(1, 5, 55, 1, 3, 11, 4, 27)

# Replace all values greater than 10 with 10
v1[v1>10] <- 10  # returns 1, 5, 10, 1, 3, 10, 4, 10
```
In this example, the number `10` get recycled for each element in which v1 is greater than 10 (`v1[v1>10]`). Presto!
