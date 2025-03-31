from setuptools import setup, find_packages

setup(
    name="BayesBrain",
    version="0.1.0",
    author="Your Name",
    description="Bayesian Generalized linear modeling and GAMs utilizing NumPyro",
    packages=find_packages(),
    install_requires=[
        "pandas",
        "arviz",
        "numpyro",
        "optax",
        "numpy",
        "patsy",
        "jax",
        "scikit-learn",
        "scipy"
    ],
    python_requires=">=3.8",
)
