## secrets
> it's any data you not prefer not to be on "news page" like:
>
> username and passwords, TLS certificates and keys like ssh and ...

- secrets storage easiest "secure" solution for storing sercrets in swarm

- secrets storage support content up to 500kb in size

- secrets storage built into swarm

- swarm `raft database` is encrypted on disk and only stored on 
manager node disk and these nodes have keys to unlock or decrypt
the `raft database` on disk.

- the way secrets get down to the proper container is via `control plane`
or encrypted TLS network communication between managers and workers and
that connection was already secured and uses TLS + mutual PKI authentication
and that's a secure chanal to brings secrets to the containers.

- so secrets are stored in swarm and assigned to the services and only
assigned service can see its secrets.

- assigned secrets, look like files but they are in memory FS (file system)

### using in swarm services

- pass value from file: `docker secret crate psql_user path_ti_file.txt`,
the drawback is that you store that file in hard drive

- pass value from stdin: `echo "pass" | docker secret crate psql_pass -`,
the draw back is that attacker can access it from bash history

- `docker service create --name psql --secret psql_user --secret psql_pass -e POSTGRES_USER_FILE=/run/secrets/psql_user -e POSTGRES_PASSWORD_FILE=/run/secrets/psql_pass postgres`

- `docker exec -it psql.1.<id> bash`
    
    - `ls /run/secrets/`

    - `cat /run/secrets/psql_user`

- when you update a config in service, the service will recreate it with new config

### using in swarm stacks

- in the repo, go to `swarm-stack-3`

- in compose file, external means accept secret from input so first 
echo the pass to create a secret, and then use that secret into swarm

### notes

- secrets are stored in swarm raft database

- in development environment, you may not have docker swarm and want to
use secrets so what can we do to use secrets for testing purposes ?
it mounts the secrets to the fs memory directly from hard drive to the container
and foucs that `docker-compose` only works with file based not external secrets
because external reads secrets from swarm raft database

- service updates will replace containers one-by-one and limits the downtime
