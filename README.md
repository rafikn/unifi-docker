# unifi-docker
Docker image for Unifi Controller 4.8.12

## Quick Start
`$ docker run  -v /paht/to/data:/opt/unifi/data -P -t rafikn/unifi:4.8.12`

## Docker compose (1.6.+)
`$ docker-compose up`

## Data volume
The data folder needs to be rw accessible by the conainter's user.

If you are restoring data from a different installation, mongod might complain about not having the right permissions to access the db files.

#### File permission
Attach to the container and get the running user id<br>
`$ docker attach -it <continer_id/name> bash`<br>
`unifi@conainter:/opt/unifi$ id -u`<br>
`1000`
<br>
on the docker host, change ownership to that user:<br>
`$ chown -R 1000: /path/to/data`

#### SELinux centos/redhat/fedora
Sometimes this could be linked to SELinux contexts. If SELinux is enabled set the context of the data folder to docker
<br>
`$ chcon -Rt svirt_sandbox_file_t /path/to/data`
<br>
