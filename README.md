# Tangerine support environment  

This is just a simple environment for testing docker dependencies. It changes whenever I test different applications. 

## Install

You can either pull from `chrisekelley/docker-testbed`:

```
docker pull chrisekelley/docker-testbed
```

If there is no entrypoint, or the entrypoint does not have a never-ending process, run it like this:

```
docker run -it --name testbed --entrypoint=/bin/bash chrisekelley/docker-testbed
```

otherwise, do this:

```
docker run -it -name testbed -chrisekelley/docker-testbed /bin/bash
```


