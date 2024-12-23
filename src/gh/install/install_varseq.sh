#!/usr/bin/env bash
set -ex

DOWNLOAD_URL="$1"
echo "Downloading VarSeq from ${DOWNLOAD_URL}"
wget -q "$DOWNLOAD_URL" -O /tmp/varseq.tgz
echo "Extracting VarSeq"
# Extract one directory deep into the archive
mkdir -p /opt/VarSeq
tar -xvf /tmp/varseq.tgz --strip-components=1 -C /opt/VarSeq
rm -rf /tmp/varseq.tgz

wget -q https://www.goldenhelix.com/Downloads/VarSeq/vsicon.png -O /opt/VarSeq/varseq_icon.png
ln -s /home/ghuser/Workspace/AppData /opt/VarSeq/AppData

cat >/usr/share/applications/varseq.desktop <<EOL
[Desktop Entry]
Version=1.0
Name=VarSeq $VS_VERSION
Comment=Golden Helix VarSeq
TryExec=/opt/VarSeq/VarSeq
Exec=/opt/VarSeq/VarSeq -- %u
Icon=/opt/VarSeq/varseq_icon.png
Terminal=false
StartupWMClass=VarSeqDesktop
Type=Application
Categories=Analysis;Bioinformatics;Genomics;Sequencing;
MimeType=x-scheme-handler/tg;
Keywords=analysis;bioinformatics;genomics;sequencing;varseq;
X-GNOME-UsesNotifications=true
EOL
chmod +x /usr/share/applications/varseq.desktop
cp /usr/share/applications/varseq.desktop $HOME/Desktop/varseq.desktop
chown 1000:1000 $HOME/Desktop/varseq.desktop
