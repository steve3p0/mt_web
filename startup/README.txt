Put these files in /etc/systemctl/system

systemctl enable mosesMT.ende.service
systemctl --system daemon-reload
systemctl start mosesMT.ende.service