# DataPower automation pipelines

This repository can be used to automate the build, test and deploy of your
DataPower gateway to OpenShift Kubernetes.

## Overview

This branch contains the pipelines for the following diagram:

![diagram1](./docs/images/diagram1.drawio.png)


## Install Tekton

- for first pass, install manually
- medium term install via ArgoCD app
- might be best to have ArgoCD app in `dpxx-ops` repo?
  - or is it best to install Tekton manually and
  - have a pipeline that installs ArgoCD in dpxx-ops repo?
  - the advantgae of this is one starting point; source repo and pipelines...   

## Install ArgoCD

- medium term, would be bettter to install ArgoCD first, then 
- install Tekton with ArgoCD app

