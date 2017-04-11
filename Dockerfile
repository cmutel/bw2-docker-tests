FROM jupyter/minimal-notebook

# Some stuff from https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
MAINTAINER Chris Mutel <cmutel@gmail.com>

USER root

# Need mercurial for hg to get test coverage info
RUN apt-get install mercurial

USER $NB_USER

RUN conda install --quiet --yes wheel && \
    conda update --yes pip wheel setuptools

# Install Python 3 packages
RUN conda install --quiet --yes nomkl pandas matplotlib seaborn scikit-learn cython flask lxml requests nose docopt whoosh xlsxwriter xlrd unidecode psutil && \
    pip install --user --no-cache-dir eight && \
    pip install --user --no-cache-dir brightway2 && \
    conda clean -tipsy

RUN mkdir /home/jovyan/data
RUN mkdir /home/jovyan/notebooks
RUN mkdir /home/jovyan/output

ENV BRIGHTWAY2_DIR /home/jovyan/data
ENV BRIGHTWAY2_DOCKER 1
ENV BRIGHTWAY2_OUTPUT_DIR /home/jovyan/output

WORKDIR /home/jovyan/notebooks
