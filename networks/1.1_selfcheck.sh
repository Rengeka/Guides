#!/bin/sh

SITE=$1
OUTPUT_FILE="dns_report.txt"

check_install() {
    CMD_NAME=$1      
    PKG_NAME=$2      

    if ! command -v "$CMD_NAME" >/dev/null 2>&1; then
        echo "$CMD_NAME is not installed, installing..."
        sudo apt update && sudo apt install -y "$PKG_NAME"
    else
        echo "$CMD_NAME is installed"
    fi
}

check_install dig bind9-dnsutils
check_install traceroute traceroute
check_install nmap nmap
check_install curl curl

A_DNS_RECORD=$(dig $SITE A +short | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
AAAA_DNS_RECORD=$(dig $SITE AAAA +short | grep ':')

{
    printf "\n===== DNS-report for %s =====\n\n" "$SITE"

    printf "A (IPv4):\n"
    printf "%s\n" "$A_DNS_RECORD"

    printf "\nAAAA (IPv6):\n"
    printf "%s\n" "$AAAA_DNS_RECORD"

    printf "\n===== Traceroute to %s =====\n\n" "$SITE"

    traceroute -n $SITE | while read line; do
        HOP=$(echo $line | awk '{print $1}')
        IP=$(echo $line | awk '{for(i=2;i<=NF;i++) if($i ~ /^[0-9.]+$/) {print $i; exit}}')

        if [ -z "$IP" ]; then
            IP="*"
        fi

        printf "%2s | %s\n" "$HOP" "$IP"
    done

    printf "\n===== Open Ports (nmap) for %s =====\n\n" "$SITE"
    nmap -Pn $SITE | awk '/open/ {print $1, $3}'

    printf "\n===== HTTP headers for %s =====\n\n" "$SITE"
    curl -sS -D - -o /dev/null https://$SITE


    printf "\n===== SSL Certificate for %s =====\n\n" "$SITE"
    echo | openssl s_client -connect $SITE:443 -servername $SITE 2>/dev/null | openssl x509 -noout -dates -issuer -subject


    printf "\n===============================\n"

} | tee "$OUTPUT_FILE"

exit 0