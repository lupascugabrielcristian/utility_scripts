# TODO
# Are cum sa primeasca working directory
# --working-directory=DIRNAME     Set the working directory


# Minio
gnome-terminal -- bash -c "minio server ~/apps/minio/minio-store/ --console-address :5053 --address :9091" -t Minio
echo [+] Started minio

# Redis
service redis-server start
echo [+] Started redis

# Medusa server
pushd ~/projects/midocean/medusa/medusa-server >> /dev/null
gnome-terminal -- bash -c "~/Downloads/node-v16.14.0-linux-x64/bin/medusa develop" -t Server
popd >> /dev/null

# Medusa admin client
pushd ~/projects/midocean/medusa/medusa-admin-broporomotionals >> /dev/null
gnome-terminal -- bash -c "npm run start" -t Admin
popd >> /dev/null
echo [+] Started admin

