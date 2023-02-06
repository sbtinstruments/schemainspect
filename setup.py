"""Setup of the GMDB Python package."""
import os
from setuptools import find_packages, setup


name = "schemainspect"


# TODO: Get version from 'git describe --tags ...'
try:
    version = "3.2"
except IndexError:
    raise RuntimeError("Unable to determine version.")


# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...
def _read(fname):
    with open(os.path.join(os.path.dirname(__file__), fname)) as readme:
        return readme.read()

## DEV NOTE:
# This setup.py file is only for Yocto's deployment into the distro.
# This means we can simply exclude all the licensegenerator-related
# packages.

setup(
    name=name,
    version=version,
    author="Robert Lechte",
    author_email="robertlechte@gmail.com",
    description=("Schema inspection for PostgreSQL"),
    license="Unlicense",
    keywords="postgres schema",
    url="https://github.com/djrobstep/schemainspect",
    long_description=_read("README.md"),
    packages=["schemainspect"],
    include_package_data=True,
    package_data={"schemainspect": ["pg/sql/*.sql"],},
)
