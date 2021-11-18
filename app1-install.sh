#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>Welcome to Assignment2 - APP-1</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Assignment2 - APP-1</h1> <p>Terraform Magic Mojo :D</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html

#Prometheus Exporter Installation that will scrape the instance metadata
useradd -m -s /bin/bash prometheus

# Download node_exporter release from original repo
curl -L -O  https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz

tar -xzvf node_exporter-0.17.0.linux-amd64.tar.gz
mv node_exporter-0.17.0.linux-amd64 /home/prometheus/node_exporter
rm node_exporter-0.17.0.linux-amd64.tar.gz
chown -R prometheus:prometheus /home/prometheus/node_exporter

# Add node_exporter as systemd service
tee -a /etc/systemd/system/node_exporter.service << END
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
ExecStart=/home/prometheus/node_exporter/node_exporter
[Install]
WantedBy=default.target
END

systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter



