#!/bin/bash

# چک کردن دسترسی روت
if [[ $EUID -ne 0 ]]; then
    echo "لطفاً اسکریپت را با دسترسی root اجرا کنید: sudo bash $0"
    exit 1
fi

# ایجاد فایل اسکریپت
SCRIPT_PATH="/root/block_ips.sh"

cat > $SCRIPT_PATH << 'EOF'
#!/bin/bash

# لیست رنج‌های IP برای مسدود کردن خروجی
BLOCKED_RANGES=(
    "10.0.0.0/8"
    "172.16.0.0/12"
    "192.168.0.0/16"
    "100.64.0.0/10"
    "198.18.0.0/15"
    "169.254.0.0/16"
    "102.236.0.0/16"
    "2.60.0.0/16"
    "5.1.41.0/12"
    "102.217.115.0/24"
    "185.121.225.0/24"
    "5.178.105.0/14"
    "102.200.15.0/24"
    "89.35.131.0/24"
    "102.199.33.0/24"
    "102.200.123.0/24"
    "205.185.208.0/24"
    "192.0.2.0/24"
    "185.222.28.0/24"
    "151.139.128.0/24"
    "108.165.67.0/24"
    "102.240.162.0/24"
    "169.136.112.0/24"
    "103.69.224.0/24"
    "185.165.204.0/24"
    "102.197.106.0/24"
    "69.16.175.0/24"
    "25.18.254.0/24"
    "31.24.237.0/24"
    "45.94.254.0/24"
    "81.12.7.0/24"
    "102.197.255.0/24"
    "25.22.155.0/24"
    "213.195.21.0/24"
    "45.35.33.0/24"
    "102.143.146.0/24"
    "91.207.138.0/24"
    "91.207.139.0/24"
    "102.128.241.0/24"
    "102.241.56.0/24"
    "102.230.220.0/24"
    "25.5.145.0/24"
    "139.177.229.0/24"
    "25.4.130.0/24"
    "192.0.0.0/24"
    "25.21.80.0/24"
    "25.8.26.0/24"
    "25.2.181.0/24"
    "216.40.145.0/24"
    "102.240.241.0/24"
    "25.6.127.0/24"
    "102.197.39.0/24"
    "103.61.90.0/24"
    "102.237.195.0/24"
    "25.0.0.0/8"
    "52.0.0.0/8"
    "54.0.0.0/8"
    "102.0.0.0/8"
    "185.180.143.0/24"
    "154.16.192.0/24"
    "109.237.96.0/24"
    "104.244.79.0/24"
)

# اعمال قوانین در UFW
for ip in "${BLOCKED_RANGES[@]}"; do
    ufw deny out from any to $ip
done

# فعال‌سازی UFW
ufw enable
EOF

# دادن مجوز اجرا به اسکریپت
chmod +x $SCRIPT_PATH

# اجرای اسکریپت
bash $SCRIPT_PATH
