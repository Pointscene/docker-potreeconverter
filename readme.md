# Docker PotreeConverter

A Docker image for PotreeConverter on Ubuntu 14.04

## Usage

```
docker run -v /local/path:/data pointscene/potreeconverter PotreeConverter /data/lasdir/ -o /data/output --output-format LAS --scale 0.01 --overwrite
```

