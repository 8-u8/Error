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
  for (n in 1:N)
    lambda[n] = b[1] + b[2]*X[n] + b[3]*f[n];
}

model {
  for (n in 1:N)
    Y[n] ~ poisson_log(lambda[n]);
}

generated quantities {
  int y_pred[N];
  for (i in 1:N)
    y_pred[i]=poisson_log_rng(lambda[i]);
}

//In Japanese.
//poisson_logにするとエラー
//[1] "Error in sampler$call_sampler(args_list[[i]]) : "
//[2] "  Exception: poisson_log_rng: Log rate parameter is 21.2, but must be less than 20.7944
//(in 'model35cc4e7fc1a_lastex' at line 26)"
//[1] "error occurred during calling the sampler; sampling not done"
//パラメータがstanが想定する数値を上回っているらしい,なぜ？
//どうやら右辺のfor文処理でパラメータ値がおかしくなっている
