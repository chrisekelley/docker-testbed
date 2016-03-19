# Tangerine support environment  

This is just a simple environment for testing docker dependencies. It changes whenever I test different applications. 

## Install

You can either pull from `chrisekelley/docker-testbed`:

```
docker pull chrisekelley/docker-testbed
```

```
docker run -i -t chrisekelley/docker-testbed /bin/bash
```

or add it to your Dockerfile:

```
FROM chrisekelley/docker-testbed
```

