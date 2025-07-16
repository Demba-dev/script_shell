#!/bin/bash

echo "🌐 Adresse IP de ta machine (interne) :"
hostname -I | awk '{print $1}'

echo ""

echo "🌍 Adresse IP publique (externe) :"
curl -s ifconfig.me

