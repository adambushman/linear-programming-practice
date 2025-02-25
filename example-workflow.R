# install.packages('lpSolve')
# install.packages('lpSolveAPI')

library('lpSolve')
library('lpSolveAPI')



# Step 1
# ----------------
# Set up an object

LP.1 <- make.lp(
  0   # Number of constraints
  ,2  # Number of decision variables
)



# Step 2
# ---------------
# Add constraints

add.constraint(
  LP.1  # The linear programming object
  ,c(1,1) # The coefficients for decision variables above
  ,"<=" # The type of operator for the constraint
  ,300 # The constant on the right side of the constraint
)

add.constraint(LP.1, c(2,1), "<=", 400)
add.constraint(LP.1, c(0,1), "<=", 250)



# Step 3
# ---------------------------
# Create unpward/lower bounds

set.bounds(
  LP.1 # Out LP object
  ,lower = c(0,0) # The lower bounds for each coefficient
)


# Step 4
# -------------------------
# Define objective function

set.objfn(
  LP.1 # Our LP object
  ,c(3,2) # The objectie function coefficients
)

lp.control(
  LP.1 # Our LP object
  ,sense = "max" # The goal is to "maximize"
)



# Step 5
# ------------------------------
# Set names for interpretability

cnames <- c("Product A", "Product B")
rnames <- c("Molding", "Painting", "Cutting")



# Step 6
# -----------------
# Solve the problem

result <- solve(LP.1)

result # Result = 0, which means "Optimal solution found"



# Step 7
# -----------------
# Get the solution

get.objective(LP.1)

# 700 was the maximized output of the objective function

get.variables(LP.1)

# 700 was produced with values of c(100, 200), inputs for "Product A" & "Product B" respectively