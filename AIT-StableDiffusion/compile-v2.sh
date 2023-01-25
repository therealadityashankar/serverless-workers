# usage: sh compile.sh

sh update.sh

docker run merrell/ait-sd-2-runpod bash -c 'rm -rf /tmp/*'
con2_id=$(docker ps -lq)
docker commit $con2_id merrell/ait-sd-2-runpod
docker rm -v $con2_id

docker run merrell/ait-sd-2-runpod bash -c 'rm -rf /AITemplate/diffusers-cache'
con2_id=$(docker ps -lq)
docker commit $con2_id merrell/ait-sd-2-runpod
docker rm -v $con2_id

docker run --gpus all merrell/ait-sd-2-runpod:latest bash -c "cd AITemplate; python3 -u examples/05_stable_diffusion-v1.5/compile.py"
con_id=$(docker ps -lq)
docker commit $con_id merrell/ait-sd-2-runpod:latest
docker rm -v $con_id

docker run merrell/ait-sd-2-runpod:latest rm -f /AITemplate/test_input.json
con2_id=$(docker ps -lq)
docker commit $con2_id merrell/ait-sd-2-runpod:latest
docker rm -v $con2_id