from setuptools import setup, find_packages

setup(
    name="BayesBrain",
    version="0.1.0",
    author="Your Name",
    description="Bayesian Generalized linear modeling and GAMs utilizing NumPyro",
    packages=find_packages(),
    install_requires=[
        "jax[cpu]",
        "pandas",
        "arviz",
        "numpyro",
        "pyro-ppl",
        "optax",
        "numpy",
        "patsy",
        "scikit-learn",
        "scipy",
        "patsy"
    ],
    python_requires=">=3.8",
)
