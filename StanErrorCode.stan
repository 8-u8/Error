data {
  int N;
  int<lower=0> Y[N];
  real<lower=0> X[N];
  int<lower=0, upper=1> f[N];
}

parameters {
  real b[3];
}

transformed parameters {
  real lambda[N];
  for (i in 1:N)
    lambda[i] = b[1] + b[2]*X[i] + b[3]*f[i];
}

model {
  for (i in 1:N)
    Y[i] ~ poisson_log(lambda[i]);
}

//Maybe this function is something wrong?
generated quantities {
  int y_pred[N];
  for (i in 1:N)
    y_pred[i]=poisson_log_rng(lambda[i]);
}
