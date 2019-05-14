By using temporal-difference methods, I built and tested various algorithms that navigated the OpenAI cliff walk environment. 
In this environment the agent had to navigate a 4x12 grid world where some grid squares meant the agent would fall off the
cliff and the episode would end. The goal was for the agent to reach the other end of the grid without falling in the grid 
squares corresponding to the cliff. For every step it took the agent to reach the end grid, the agent received a reward
of -1, and if it fell into a cliff grid square, it received a reward of -100; the goal being for the agent to reach the end
with as little time steps as possible. In order to achieve the best optimal policy, we tested multiple variations of on-policy
and off-policy TD algorithms. All of the algorithms tested converged to the optimal policy given an epsilon with GLIE 
(greedy limit w/ infinte exploration) and a sufficiently small step size, or alpha. Some of the on policy methods tested 
included Sarsa and Expected Sarsa; these methods used the same epsilon-greedy policy being evaluated and improved to 
select actions. On the other hand, Sarsamax, an off-policy algorithm, evaluated and improved a greedy policy, which was not
the same policy used to select actions; in Sarsamax an epsilon-greedy policy was used to select the next actions.
Different values of epsilon, decaying epsilon, step size (alpha) and discount rate (gamma) were tested, and the action 
values corresponding to any given step were updated at every time step.
