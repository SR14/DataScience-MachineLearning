In this notebook, I applied advanced discretization, or tile coding, to OpenAI Gym's Acrobat-v1 environment. Tile coding 
turned acrobat's six dimensional and continuous state-space to a compilation of three discretization grids with a slight 
offset to each. This allows for a more generalized training environment than the original uniform grid done with simple 
discretization. Each grid contains action values of the possible state and action pairs in the environment.
