#!/bin/bash

# Use:
# curl -s https://raw.githubusercontent.com/greglamb/laradock/master/make.sh | bash -s

# For WSL:
# sudo ln -s /mnt/c/Program\ Files/Docker/Docker/resources/bin/docker-compose.exe /usr/local/bin/docker-compose
# sudo ln -s /mnt/c/Program\ Files/Docker/Docker/resources/bin/docker.exe /usr/local/bin/docker

containers="$@"
[ -z "$containers" ] && containers="nginx mysql php-fpm"

contname=$(basename $PWD)_$(date +%Y%m%d%H%M%S)
git submodule add https://github.com/greglamb/laradock.git laradock

laradock/envtobash.sh laradock/.env > laradock/env.sh

cat >laradock-up.sh <<EOL
#!/bin/bash
source laradock/env.sh
docker-compose -f laradock/docker-compose.yml -p ${contname} up -d ${containers}
EOL

cat >laradock-down.sh <<EOL
#!/bin/bash
source laradock/env.sh
docker-compose -f laradock/docker-compose.yml -p ${contname} down
EOL

chmod 755 laradock-up.sh
chmod 755 laradock-down.sh
