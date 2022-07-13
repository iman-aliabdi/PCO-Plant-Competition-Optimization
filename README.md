# PCO-Plant-Competition-Optimization
Source code of PCO, Plant Competition Optimization Algorithm

Link of the paper:
https://onlinelibrary.wiley.com/doi/abs/10.1111/exsy.12956


Abstract

Plant competition is a fundamental process in plant communities. In one neighbourhood, different plants compete with each other to access shared resources.
This paper presents a novel evolutionary algorithm, plant competition optimization (PCO) algorithm, inspired by plant competition processes. 
In this algorithm, each feasible solution to an optimization problem is assumed to be a plant, with the underlying assumption that each plant grows in 
competition with its neighbours. In contrast to other techniques inspired by natural phenomena, we attempted to fit the formulation with a known
plant growth model, Richards' growth model, and simulate what happens in nature. As the number of plants in a specific area increases, 
the available resources are decreased, and competition occurs in smaller areas. So, to use this aspect of competition, we develop some mathematical
formulation to simulate the decrease of neighbouring area for each plant related to its size to compete on the share resources with the other
neighbouring plants. This competition will conduct a smart local search around the most fitted solutions in the optimization context. 
Furthermore, the reproduction is simulated by producing some seeds in their neighbouring area, which a few of them can migrate to far distances as well.
Summing up together, the most powerful plants can grow more. Under competition pressure, their neighbouring area will decrease more than the others, 
producing more seeds in the next generation. Just as happened in nature, the losers of this competition will die. Our algorithm's efficiency is shown
by performing numerical tests on well-known optimization problems and comparing the results with the other evolutionary algorithms. 
The results confirm that PCO is effective and efficient in finding sub-optimal solutions and gives better results than genetic algorithm (GA),
particle swarm optimization (PSO), simulated annealing (SA), grasshopper optimisation algorithm (GOA), dragonfly algorithm (DA), salp swarm Algorithm (SSA),
and comparable results with whale optimization algorithm (WOA) and marine predators algorithm (MPA) on multimodal optimization functions because 
it efficiently explores the entire search space efficiently and intelligently.


