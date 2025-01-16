# Docker Homelab Setup on Debian 12

This guide provides step-by-step instructions for setting up a Docker homelab environment on Debian 12, with Portainer for management and NVIDIA GPU support for containers.

---

## System Requirements
- Debian 12 installed on your server.
- Sudo or root access.

---

## Installation Steps

### 1. Install Debian 12
Download and install Debian 12 on your server. Once installed, log in and proceed with the following steps.

### 2. Initial System Update
Run these commands to ensure the system is up-to-date:
```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y btop nano ncdu
```

### 3. Installer Docker
3.1 Installer les Prérequis Docker
```bash
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2
```

3.2 Ajouter la Clé GPG Officielle de Docker et le Dépôt
```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

3.3 Installer Docker Engine
```bash
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
```

### 4. Installer Portainer
Portainer est un outil de gestion pour Docker. Exécutez les commandes suivantes pour l'installer :
```bash
docker volume create portainer_data
docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
```

### 5. Support GPU NVIDIA
5.1 Ajouter les Pilotes NVIDIA
```bash
sudo add-apt-repository contrib non-free-firmware
curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-drivers.gpg
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list
sudo apt-get update
#sudo apt-get install -y nvidia-driver nvidia-smi nvidia-settings

# install the meta package cuda-drivers
# it will install all packages. nvidia-smi binary also has moved from nvidia-smi to the nvidia-cuda-driver package.
sudo apt-get -y install cuda-drivers

sudo systemctl reboot
```

5.2 Installer NVIDIA Docker Toolkit
Après le redémarrage, installez le toolkit NVIDIA pour Docker :
```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

5.3 Activer l'Accès GPU pour Docker
Configurez Docker pour utiliser le GPU en activant les paramètres nécessaires dans vos configurations de conteneurs.


5.4 Stress test GPU
```bash
 docker run --gpus all --rm oguzpastirmaci/gpu-burn 60
```

5.5 compile ollama sans support AVX
```bash

git clone https://github.com/ollama/ollama.git
cd ollama
DOCKER_BUILDKIT=1 docker build --build-arg VERSION=noavx --build-arg CUSTOM_CPU_FLAGS= --build-arg OLLAMA_SKIP_ROCM_GENERATE=1 --build-arg OLLAMA_FAST_BUILD=1 --platform=linux/amd64 -t ollama-noavx .
```
