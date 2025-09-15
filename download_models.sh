#!/bin/sh
set -e

# Télécharge un fichier si absent
download_urls() {
    local dest_dir="$1"; shift
    mkdir -p "$dest_dir"

    for url in "$@"; do
        local filename=$(basename "${url%%\?*}")  # enlève ?download=true
        local target="$dest_dir/$filename"

        if [ ! -f "$target" ]; then
            echo "➡️ Téléchargement : $target"
            wget -nv -O "$target" "$url"
        else
            echo "✅ Déjà présent : $target"
        fi
    done
}

#############################################
# LISTES DES TÉLÉCHARGEMENTS
#############################################

# UNET
download_urls /models/unet \
  "https://huggingface.co/city96/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q8_0.gguf?download=true" \
  "https://huggingface.co/city96/FLUX.1-schnell-gguf/resolve/main/flux1-schnell-Q8_0.gguf?download=true" \
  "https://huggingface.co/city96/HiDream-I1-Full-gguf/resolve/main/hidream-i1-full-Q8_0.gguf?download=true" \
  "https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_I2V-Q8_0.gguf?download=true" \
  "https://huggingface.co/Aitrepreneur/FLX/resolve/main/Wan2.1-VACE-14B-Q4_K_S.gguf?download=true" \
  "https://huggingface.co/silveroxides/Chroma-GGUF/resolve/main/chroma-unlocked-v31/chroma-unlocked-v31-Q5_0.gguf" \
  "https://huggingface.co/bullerwins/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q6_K.gguf"

# CLIP
download_urls /models/clip \
  "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors?download=true"

# TEXT ENCODERS
download_urls /models/text_encoders \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/clip_l.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/llava_llama3_fp8_scaled.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/clip_l_hidream.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/clip_g_hidream.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/t5xxl_fp8_e4m3fn_scaled.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/llama_3.1_8b_instruct_fp8_scaled.safetensors?download=true" \
  "https://huggingface.co/Aitrepreneur/FLX/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# VAE
download_urls /models/vae \
  "https://huggingface.co/foxmail/flux_vae/resolve/main/ae.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/vae/hunyuan_video_vae_bf16.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/vae/ae.safetensors?download=true" \
  "https://huggingface.co/Aitrepreneur/FLX/resolve/main/wan_2.1_vae.safetensors?download=true"

# DIFFUSION MODELS
download_urls /models/diffusion_models \
  "https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors?download=true" \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/diffusion_models/hunyuan_video_v2_replace_image_to_video_720p_bf16.safetensors?download=true"

# CLIP VISION
download_urls /models/clip_vision \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/clip_vision/llava_llama3_vision.safetensors?download=true"

# CHECKPOINTS
download_urls /models/checkpoints \
  "https://huggingface.co/Comfy-Org/ACE-Step_ComfyUI_repackaged/resolve/main/all_in_one/ace_step_v1_3.5b.safetensors?download=true" \
  "https://huggingface.co/boricuapab/Bagel-7B-MoT-fp8/resolve/main/ema-fp8.safetensors" \
  "https://huggingface.co/cyberdelia/CyberIllustrious/resolve/main/CyberIllustrious_V4.safetensors"

# LORAS
download_urls /models/loras \
  "https://huggingface.co/Aitrepreneur/FLX/resolve/main/Wan21_CausVid_14B_T2V_lora_rank32.safetensors?download=true"
