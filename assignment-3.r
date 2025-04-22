############################################
# Assignment 3 | OSC 6610, Decision Models #
#------------------------------------------#
# Adam Bushman, u6049169, 3/11/2025        #
############################################


# install.packages('lpSolve')
# install.packages('lpSolveAPI')

library('lpSolve')
library('lpSolveAPI')



# Question #1 | Move-It Company
# -----------------------------------------

# Setup the LP object
LP.Q1 <- make.lp(0,8)


# Add constraints
add.constraint(LP.Q1, c(1,0,0,0,0,0,0,0), "<=", 50) # Plant A production
add.constraint(LP.Q1, c(0,1,0,0,0,0,0,0), "<=", 50) # Plant B production

add.constraint(LP.Q1, c(1,1,0,0,0,0,0,0), "<=", 60) # Total weekly production

add.constraint(LP.Q1, c(-1,0,1,1,1,0,0,0), "=", 0) # Plant A production matches shipments from Plant A
add.constraint(LP.Q1, c(0,-1,0,0,0,1,1,1), "=", 0) # Plant B production matches shipments from Plant B

add.constraint(LP.Q1, c(0,0,1,0,0,1,0,0), "=", 20) # Shipments received at DC 1
add.constraint(LP.Q1, c(0,0,0,1,0,0,1,0), "=", 20) # Shipments received at DC 2
add.constraint(LP.Q1, c(0,0,0,0,1,0,0,1), "=", 20) # Shipments received at DC 3


# Define objective function and control
set.objfn(LP.Q1 ,c(0,0,800,700,400,600,800,500))
lp.control(LP.Q1, sense = "min")


# Define names
names = c(
  "Prod-PA", "Prod-Plant B",
  "Ship-PA to DC1", "Ship-PA to DC2", "Ship-PA to DC3", 
  "Ship-PB to DC1", "Ship-PB to DC2", "Ship-PB to DC3"
)


# Generate solution
result <- solve(LP.Q1)
result


# Evaluate solution
get.objective(LP.Q1)
get.variables(LP.Q1)


# Interpretation
data.frame(
  decision = names, 
  value = get.variables(LP.Q1)
)





# Question #2 | Truck from NY to LA
# -----------------------------------------

# Setup the LP object
LP.Q2 <- make.lp(0,14)


# Add constraints
add.constraint(LP.Q2, c(1,0,0,0,0,0,0,0,0,0,0,0,0,0), "<=", 1) # Origin
add.constraint(LP.Q2, c(0,0,0,0,0,0,0,0,0,0,-1,0,-1,-1), "<=", -1) # Destination

add.constraint(LP.Q2, c(-1,0,0,1,1,0,0,0,0,0,0,0,0,0), "=", 0) # Cleveland
add.constraint(LP.Q2, c(0,-1,0,0,0,1,1,0,0,0,0,0,0,0), "=", 0) # St. Louis
add.constraint(LP.Q2, c(0,0,-1,0,0,0,0,8,9,0,0,0,0,0), "=", 0) # Nashville
add.constraint(LP.Q2, c(0,0,0,-1,0,-1,0,0,0,-1,0,0,1,0), "=", 0) # Phoenix
add.constraint(LP.Q2, c(0,0,0,0,1,0,1,1,0,-1,-1,-1,0,0), "=", 0) # Dallas
add.constraint(LP.Q2, c(0,0,0,0,0,0,0,0,-1,0,0,-1,0,1), "=", 0) # SLC


# Define objective function and control
set.objfn(LP.Q2 ,c(400,950,800,1800,900,1100,600,600,1200,900,1300,1000,400,600))
lp.control(LP.Q2, sense = "min")


# Define names
table = data.frame(
  path = c(
    "R12", "R13", "R14", "R25", "R26", "R35", "R46", "R46", "R47", "R65", "R68", "R67", "R58", "R78"
  ), 
  path_expanded = c(
    "NY to CLE", "NY to STL", "NY to NSH", "CLE to PHX", "CLE to DAL", "STL to PHX", "STL to DAL", 
    "NSH to DAL", "NSH to SLC", "DAL to PHX", "DAL to LA", "DAL to SLC", "PHX to LA", "SLC to LA"
  )
)

# Generate solution
result <- solve(LP.Q2)
result


# Evaluate solution
get.objective(LP.Q2)
paths <- get.variables(LP.Q2)
paths


# Interpretation
table[as.logical(paths),]




# Question #3 | Jane Driver's Car Maintenance
# -----------------------------------------

# Setup the LP object
LP.Q3 <- make.lp(0,15)


# Add constraints
add.constraint(LP.Q3, c(1,1,1,1,1,0,0,0,0,0,0,0,0,0), "<=", 0) # Origin
add.constraint(LP.Q3, c(0,0,0,0,-1,0,0,0,-1,0,-1,0,-1,-1), "<=", -1) # Destination

# ... others, couldn't finish in time

# Define objective function and control
set.objfn(LP.Q3 ,c(7,12,21,31,44,7,12,21,31,7,12,21,7,12,7))
lp.control(LP.Q3, sense = "min")


# Define names
names = c()


# Generate solution
result <- solve(LP.Q3)
result


# Evaluate solution
get.objective(LP.Q3)
get.variables(LP.Q3)


# Interpretation