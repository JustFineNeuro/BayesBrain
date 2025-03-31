from setuptools import setup, find_packages
from pathlib import Path

# Read the README.md
this_dir = Path(__file__).parent
long_description = (this_dir / "README.md").read_text()

setup(
    name="BayesBrain",
    version="0.1.1",
    author="Your Name",
    description="Bayesian Generalized linear modeling and GAMs utilizing NumPyro",
    long_description=long_description,
    long_description_content_type="text/markdown",  # <-- tells PyPI it's Markdown
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
        "scipy"
    ],
    python_requires=">=3.8",
)