random_h = 0.06 + 0.08*randn(3000, 1);
random_s = 0.3 + (0.4)*randn(3000, 1);

h_3 = [random_h; h_1];
s_3 = [random_s; s_1];

raand = randperm(length(h_3));
h_3 = h_3(raand);
s_3 = s_3(raand);

h_4 = [0.06 + 0.06*h_1; h_1];
s_4 = [0.3 + 0.4*s_1; s_1];
raand2 = randperm(length(h_4));
h_4 = h_4(raand2);
s_4 = s_4(raand2);