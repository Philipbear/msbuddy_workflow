# msbuddy Nextflow pipeline

`msbuddy` is developed for molecular formula analysis in MS-based small molecule studies.

This is a nextflow workflow for msbuddy (ver 0.3.7) deployment on GNPS2.

[msbuddy GitHub repository](https://github.com/Philipbear/msbuddy)

[msbuddy documentation](https://msbuddy.readthedocs.io/en/latest/)


## File Input
Within this nextflow, we allow two file formats: mgf files and csv files (USI list).

See [demo files here](https://github.com/Philipbear/msbuddy/tree/main/demo).


## Deployment to GNPS2

In order to deploy, we have a set of deployment tools that will enable deployment to the various gnps systems. To run the deployment, use the following commands from the deploy_gnps2 folder. 

```
make deploy-prod
```

You might need to checkout the module, do this by running

```
git submodule init
git submodule update
```
