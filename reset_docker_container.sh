#/bin/bash
if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

# stop tout les container actuel
docker stop $(docker ps -a -q); 

# supprime tout les container
docker rm $(docker ps -a -q); 

# supprime tout les volumes
docker volume prune -y; 

# telecharge le docker-compose.yml

# execute le docker-compose
docker-compose up -d;

# ajoute un model a ollama
docker exec -ti ollama ollama run smallthinker ;


