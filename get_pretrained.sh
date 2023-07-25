#!/bin/bash
# https://qiita.com/namakemono/items/c963e75e0af3f7eed732
FILE_ID=1jlhtm8BoChczSMks3WjChQ_SGLXyZ9ka
# 1XCdNiKx0qCJW_BryERJLLJ2ivppW80Cu
# 10V4swYfUvcpHMw76hZL-ggtTuIAraLGQ
# 1hvbXHzAxs9MJfCj8rVNj4iqsrhA5MGUs
# 1XhVcrQx_pzcfAw7aHsB410i379HWHSsr
# 1kFljZ5uUvcTan6dZG0_m2aq9v7DJzpiP

FILE_NAME=pretrained_models.tar.gz
# inpainting_g_ema.pt
# superresolution_g_ema.pt
# superresolution_full.pt
# retouching_g_ema.pt
# tdmm_lizhen.pt

# args=("create" "start" "stop" "ssh" "list" "describe")

# model 0 (face-inpainting): https://drive.google.com/file/d/1XCdNiKx0qCJW_BryERJLLJ2ivppW80Cu/view?usp=sharing
# model 1 (face-superresolution): https://drive.google.com/file/d/10V4swYfUvcpHMw76hZL-ggtTuIAraLGQ/view?usp=sharing
# model 1 with discriminator (face-superresolution): https://drive.google.com/file/d/1hvbXHzAxs9MJfCj8rVNj4iqsrhA5MGUs/view?usp=sharing
# model 2 (face-retouching): https://drive.google.com/file/d/1XhVcrQx_pzcfAw7aHsB410i379HWHSsr/view?usp=sharing
# model 3 of lizhen (3dmm-to-portrait image): https://drive.google.com/file/d/1kFljZ5uUvcTan6dZG0_m2aq9v7DJzpiP/view?usp=sharing

# kit.zip
#t2m.zip#smpl.zip

# wget "https://drive.google.com/uc?export=download&id=${FILE_ID}" -O ${FILE_NAME}

# file_ids=(
#     "1XCdNiKx0qCJW_BryERJLLJ2ivppW80Cu"
#     "10V4swYfUvcpHMw76hZL-ggtTuIAraLGQ"
#     "1hvbXHzAxs9MJfCj8rVNj4iqsrhA5MGUs"
#     "1XhVcrQx_pzcfAw7aHsB410i379HWHSsr"
#     "1kFljZ5uUvcTan6dZG0_m2aq9v7DJzpiP"
# )

# file_names=(
#   "inpainting_g_ema.pt"
#   "superresolution_g_ema.pt"
#   "superresolution_full.pt"
#   "retouching_g_ema.pt"
#   "tdmm_lizhen.pt"
# )

# PRETRAINED_DIR="styleunet/pretrained"
# if [ ! -d "$PRETRAINED_DIR" ]; then
#   mkdir "$PRETRAINED_DIR"
#   echo "'$PRETRAINED_DIR' is made"
# else
#   echo "$PRETRAINED_DIR' already exists"
# fi

# for ((i=0; i<${#file_names[@]}; i++)); do
# # for file_name in "${file_names[@]}"; do
# #   echo "$file_name"
#   FILE_NAME=${file_names[i]}
#   FILE_ID=${file_ids[i]}
#   curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
#   CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"  
#   curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${PRETRAINED_DIR}/${FILE_NAME}
# #   curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${FILE_NAME}
# done

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"  
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${FILE_NAME}

mkdir -p ./logs/
tar -zxf pretrained_models.tar.gz -C ./logs/
echo "pretrained models have been extracted to ./logs/"
