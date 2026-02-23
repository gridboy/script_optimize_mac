#!/bin/bash

# ==============================================================================
# Script d'Optimisation et de Maintenance Avancé pour macOS
# Version 2.2
#
# Ce script exécute des tâches de maintenance approfondies.
# ==============================================================================

# Définition des couleurs pour l'affichage
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Pas de couleur

# S'assurer que le script s'arrête en cas d'erreur non gérée
set -e

# --- FONCTIONS DE MAINTENANCE ---

# Nettoyage des caches
clean_caches() {
    echo -e "\\n${BLUE}--- Étape 1: Nettoyage des caches système, utilisateur et logs ---${NC}"
    sudo rm -rf /Library/Caches/* &> /dev/null || true
    rm -rf ~/Library/Caches/* &> /dev/null || true
    rm -rf ~/Library/Logs/* &> /dev/null || true
    echo -e "${GREEN}✓ Caches et logs nettoyés.${NC}"
}

# Nettoyage des fichiers temporaires système
clean_temp_files() {
    echo -e "\\n${BLUE}--- Étape 2: Nettoyage des fichiers temporaires système ---${NC}"
    sudo rm -rf /private/var/tmp/* &> /dev/null || true
    sudo rm -rf /private/var/folders/* &> /dev/null || true
    echo -e "${GREEN}✓ Fichiers temporaires nettoyés.${NC}"
}

# Purge de la RAM
purge_ram() {
    echo -e "\\n${BLUE}--- Étape 3: Purge de la mémoire vive (RAM) ---${NC}"
    sudo purge
    echo -e "${GREEN}✓ Mémoire purgée.${NC}"
}

# Nettoyage du cache DNS
flush_dns() {
    echo -e "\\n${BLUE}--- Étape 4: Nettoyage du cache DNS ---${NC}"
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo -e "${GREEN}✓ Cache DNS vidé.${NC}"
}

# Nettoyage des snapshots Time Machine locaux
clean_time_machine_snapshots() {
    echo -e "\\n${BLUE}--- Étape 5: Suppression des snapshots Time Machine locaux ---${NC}"
    local snapshots=$(tmutil listlocalsnapshots / 2>/dev/null | grep "com.apple.TimeMachine" || true)
    if [ -z "$snapshots" ]; then
        echo -e "${YELLOW}Aucun snapshot local trouvé.${NC}"
    else
        echo "$snapshots" | while read snapshot; do
            sudo tmutil deletelocalsnapshots "${snapshot##*/}" &> /dev/null || true
        done
        echo -e "${GREEN}✓ Snapshots locaux supprimés.${NC}"
    fi
}

# Maintenance de Homebrew (si installé)
maintain_homebrew() {
    if command -v brew &> /dev/null; then
        echo -e "\\n${BLUE}--- Étape 6: Maintenance de Homebrew ---${NC}"
        brew update && brew upgrade && brew autoremove && brew cleanup -s
        echo -e "${GREEN}✓ Maintenance de Homebrew terminée.${NC}"
    else
        echo -e "\\n${YELLOW}--- Étape 6: Homebrew non détecté, étape ignorée. ---${NC}"
    fi
}

# Réindexation de Spotlight
reindex_spotlight() {
    echo -e "\\n${BLUE}--- Étape 7: Réindexation de Spotlight ---${NC}"
    echo -e "${YELLOW}Cette opération peut prendre du temps et augmenter l'usage du CPU temporairement.${NC}"
    sudo mdutil -E /
    echo -e "${GREEN}✓ La réindexation de Spotlight a commencé en arrière-plan.${NC}"
}

# Vérification et réparation des permissions du disque
repair_disk_permissions() {
    echo -e "\\n${BLUE}--- Étape 8: Vérification du système de fichiers ---${NC}"
    echo -e "${YELLOW}Cette opération peut prendre quelques minutes...${NC}"
    diskutil verifyVolume / || true
    echo -e "${GREEN}✓ Vérification terminée.${NC}"
}

# --- SCRIPT PRINCIPAL ---

main() {
    echo -e "${YELLOW}========================= ATTENTION =========================${NC}"
    echo "Ce script va effectuer des opérations de maintenance profondes."
    echo "Assurez-vous d'avoir une sauvegarde récente de vos données."
    echo -e "${YELLOW}=============================================================${NC}"
    read -p "Voulez-vous continuer? (o/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Oo]$ ]]; then
        echo "Opération annulée."
        exit 1
    fi

    echo "Le mot de passe administrateur sera requis."
    sudo -v

    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Exécution des fonctions
    clean_caches
    clean_temp_files
    purge_ram
    flush_dns
    clean_time_machine_snapshots
    maintain_homebrew
    reindex_spotlight
    repair_disk_permissions

    echo -e "\\n\\n${GREEN}========================================${NC}"
    echo -e "${GREEN}✅ Maintenance avancée terminée avec succès !${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo -e "\\n${YELLOW}⚠️  Pour un effet optimal, REDÉMARREZ votre Mac maintenant.${NC}"
    echo -e "${YELLOW}Tapez: sudo shutdown -r now${NC}\\n"
}

main
