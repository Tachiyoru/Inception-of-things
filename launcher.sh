#!/bin/bash

# 🚀 Script principal pour automatiser chaque partie du projet IoT

set -e  # Arrêter le script en cas d'erreur

# Variables globales
PROJECT_DIR=$(pwd)
VAGRANT_PART1="$PROJECT_DIR/p1"
VAGRANT_PART2="$PROJECT_DIR/p2"
K3D_PART3="$PROJECT_DIR/p3"

# 1️⃣ Automatisation de la Partie 1 : K3s et Vagrant
function setup_part1() {
  echo "➡️ Début de la configuration pour la Partie 1..."
  cd "$VAGRANT_PART1"
  vagrant up
  echo "✅ Partie 1 configurée avec succès !"
}

# 2️⃣ Automatisation de la Partie 2 : Déploiement des Applications sur K3s
function setup_part2() {
  echo "➡️ Début de la configuration pour la Partie 2..."
  cd "$VAGRANT_PART2"
  vagrant up
  vagrant ssh
  
  echo "✅ Applications déployées avec succès sur K3s !"
}

# 3️⃣ Automatisation de la Partie 3 : K3d et Argo CD
function setup_part3() {
  echo "➡️ Début de la configuration pour la Partie 3..."

  # Vérifier si K3d est installé
  if ! command -v k3d &> /dev/null; then
    echo "❌ K3d n'est pas installé. Exécutez le script d'installation en premier."
    exit 1
  fi

  sudo bash "./p3/scripts/argocd.sh"
}

# 4️⃣ Automatisation de la Partie Bonus : K3d, Argo CD et gitlab
function setup_bonus() {
  echo "➡️ Début de la configuration pour la Partie Bonus..."

  # Vérifier si K3d est installé
  if ! command -v k3d &> /dev/null; then
    echo "❌ K3d n'est pas installé. Exécutez le script d'installation en premier."
    exit 1
  fi

  bash "./bonus/launch.sh"

  echo "✅ Partie Bonus configurée et application déployée avec succès !"
}

# 🧹 Nettoyage des ressources
function cleanup() {
  echo "➡️ Nettoyage de toutes les ressources mises en place..."

  # Partie 1 : Supprimer les VM Vagrant
  echo "🛑 Arrêt des machines Vagrant..."
  cd "$VAGRANT_PART1" && vagrant destroy -f
  cd "$VAGRANT_PART2" && vagrant destroy -f

  cd ..
  # Partie 3 : Supprimer le cluster K3d
  echo "🛑 Suppression du cluster K3d..."

  rm -rf ./p1/.vagrant
  rm -rf ./p2/.vagrant
  rm -rf ./bonus/confs/argo_passwd
  rm -rf ./bonus/confs/gitlab_passwd
  rm -rf ./bonus/confs/sleon


  for ns in gitlab argocd dev; do
    if kubectl get namespace "$ns" &>/dev/null; then
      kubectl delete namespace "$ns"
    else
      echo "Namespace $ns doesn't exists."
    fi
  done

  if sudo k3d cluster list | grep -q dev-cluster; then
    echo "deleting k3d cluster..."
    sudo k3d cluster delete dev-cluster
  else
    echo "Cluster dev-cluster doesn't exists."
  fi

  echo "✅ Toutes les ressources ont été nettoyées avec succès !"
}

# Menu principal
function main_menu() {
  echo -e "\n🌐 Automatisation du Projet IoT"
  echo "1️⃣ Configurer la Partie 1 : K3s et Vagrant"
  echo "2️⃣ Configurer la Partie 2 : Déploiement des Applications"
  echo "3️⃣ Configurer la Partie 3 : K3d et Argo CD"
  echo "4️⃣ Configurer la Partie Bonus : K3d, Argo CD et gitlab"
  echo "5️⃣ Nettoyer toutes les ressources"
  echo "6️⃣ Quitter"
  echo -n "Choisissez une option : "
  read OPTION

  case $OPTION in
    1) setup_part1 ;;
    2) setup_part2 ;;
    3) setup_part3 ;;
    4) setup_bonus ;;
    5) cleanup ;;
    6) exit 0 ;;
    *) echo "❌ Option invalide"; main_menu ;;
  esac
}

# Démarrer le menu principal
main_menu
