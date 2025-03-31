# Python code for (fast and accurate) Bayesian fitting of neural tuning curves using all types of regression models. 

## Overview
This package is intended to ease the fitting of Generalized Additive Models (GAM).


Long gone are the days for needing cross-validation, when what we really require is model condfidence and uncertainty estimates in our models. 


This package aims to provide that in an easy to use format. The main hurdle for a user is clearly defining your design matrix.


The code and optimization procedures are all written in Pyro and NumPryo, allowing efficient usage of Probabilitic programming language techniques. 


you have the options to use stochastic variational inference with different AutoGuides (Normal, multvariate, Laplace, Delta/MAP).

## Current Models

Supports Poisson and Gaussian with natural hyperparameter tuning via two approaches: sthocastic variational inference or MCMC.
Can you use any type of supplied tensor or regular basis function. 
Naturally implements wiggliness and null space coefficient constraints (a la L1).
Naturally implements (laplacian) gaussian markov field regularization in both 1D and 2D. So, 2D auto regularizaiton for things like place or grid fields is testablre.

## Example usage
if X = design matrix (n x m), and Y = data (n x 1)

import library and Instantiate a model


```{bash}
import GLM.glm as glm
import GLM.DesignMaker as dm
mod2fitall = glm.PoissonGLMbayes()
```

Add data to fit the model
```{bash}
mod2fitall.add_data(y=jnp.array(Y))
```

Build design matrices as marginal effects and tensors using patsy
```{bash}
basis_x_list, S_list, tensor_basis, tensor_S, beta_x_names = dm.pac_cont_dsgn_all_complex(X_train,
                                                                                          params={
                                                                                              'basismain': basistype,
                                                                                              'nbases': nbases,
                                                                                              'basistypeval': 'linear',
                                                                                              'nbasis': relval_bins,
                                                                                          'inter_nbases':5})
```

Define the model type, pass design bases and tensors, and call fit method
```{bash}
mod2fitall.define_model(model='prs_double_penalty', basis_x_list=basis_x_list, S_list=S_list,
                          tensor_basis_list=tensor_basis, S_tensor_list=tensor_S)

params = {'fittype': 'vi', 'guide': 'normal', 'visteps': 10000, 'optimtype': 'scheduled'}
mod2fitall.fit(params=params, beta_x_names=beta_x_names, fit_intercept=True, cauchy=3.0)
```

The model parameters posteriors can be acquired with different credibe interval levels
```{bash}
credible_interval=95
posterior_samples=5000
mod2fitall.sample_posterior(posterior_samples).summarize_posterior(credible_interval).coeff_relevance()
```

'significant' coefficients and paramters posterior paramters can be acquired as
```{bash}
posterior_mu_full= mod2fitall.posterior_means
posterior_sd_full = mod2fitall.posterior_sd
coefficients_sig = mod2fitall.coef_keep
```

## Model Nomenclature
For the model argument in .define_model, there are a few types available.


- **'prs_double_penalty'**: : implements a wiggliness parameter regularization and null-space parameter for basis funcitons (a la L1), and directly optimizes the smoothing hyperparamter

- **'prs_hyperlambda'** :implements a wiggliness parameter regulariation and directly optimizes the smoothing hyperparamter.

- **'ardG_prs_mcmc'**: implements a wiggliness parameter regulariation and an automatric relevance determination prior over whole variables (not bases). Note: if linear (non-basis ) effects are used, then the whole variable is the coeff. 

---
##Installation and dependency notes
Make sure Pytorch, Jax, and Pyro are all installed in that order.

---

Please direct questions or bugs to justfineneuro@gmail.com, or submit an issue in the GitHub repo!