############################################
# Assignment 4 | OSC 6610, Decision Models #
#------------------------------------------#
# Adam Bushman, u6049169, 3/18/2025        #
############################################


# install.packages('lpSolve')
# install.packages('lpSolveAPI')

library('lpSolve')
library('lpSolveAPI')



# Question #2 | Sweater retailer
# -----------------------------------------

# Setup the LP object
LP.Q2 <- make.lp(0,15)


# Add constraints
add.constraint(LP.Q2, c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), "<=", 3 * 29.9)
add.constraint(LP.Q2, c(1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0), ">=", 0)
add.constraint(LP.Q2, c(0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1), ">=", 0)
add.constraint(LP.Q2, c(1,0,0,1,0,0,1,0,0,1,0,0,1,0,0), "<=", 1)
add.constraint(LP.Q2, c(0,1,0,0,1,0,1,0,0,0,1,0,0,1,0), "<=", 1)
add.constraint(LP.Q2, c(0,0,1,1,0,1,0,0,1,0,0,1,0,0,1), "<=", 1)


# Define objective function and control
set.objfn(LP.Q2 ,c(
  24.9 * c(150, 170, 250), 
  29.9 * c(135, 75, 220), 
  34.9 * c(120, 60, 190), 
  39.9 * c(100, 45, 100), 
  44.9 * c(60, 40, 90)
))
set.type(LP.Q2, columns = 1:15, type = "binary")
lp.control(LP.Q2, sense = "max")


# Define names
table = expand.grid(
  paste0("S", 1:3), 
  paste0("P", seq(249, 449, 50) / 10)
)

# Generate solution
result <- solve(LP.Q2)
result


# Evaluate solution
get.objective(LP.Q2)
table$selection <- get.variables(LP.Q2)

table[table$selection == 1,]
