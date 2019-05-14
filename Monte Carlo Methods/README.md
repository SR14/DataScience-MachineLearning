Implemented many Monte Carlo algorithms using the Blackjack game environment. Some examples of techniques used in the 
notebook include the use of epsilon to balance the exploration-exploitation dilemma, incremental mean for updating a 
state's action value and gamma for discounting further rewards. In order for the algorithm to keep learning from more 
recent episodes as the number of episodes increases, incremental mean's count of episodes has to be replaced by alpha; 
alpha is a value that determines how much importance is put on later encountered episodes. If alpha is 0 it only remembers 
the first episode, and if set at 1 it will forget all previous episodes and remember only the last encountered episode.
