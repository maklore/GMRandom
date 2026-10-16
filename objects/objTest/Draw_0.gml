draw_text(100, 100, "Seed : " + string(GMRandom.seed_get()[0]))
draw_text(100, 125, "Iteration : " + string(GMRandom.seed_get()[1]))
draw_text(100, 150, "Number : " + string(GMRandom.__generate()))