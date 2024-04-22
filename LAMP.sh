ckages
sudo apt update -y

#Install Apache
sudo apt -y install apache2

#Add the php ondrej repository
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php --yes

#Update repository
sudo apt update

# Install php8.2
sudo apt -y install php8.2

#Install some of those php dependencies required for laraveL
sudo apt install php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-mysql zip unzip -y

#Enable rewrite
sudo a2enmod rewrite

#Restart Apache
sudo systemctl restart apache2

#Change directory to the bin directory
cd /usr/bin
install composer globally -y
sudo curl -sS https://getcomposer.org/installer | sudo php -q

#Move the content of composer.phar to composer
sudo mv composer.phar composer

#Change directory to /var/www directory to clone the laravel repsitory
cd /var/www/
sudo git clone https://github.com/laravel/laravel.git
sudo chown -R $USER:$USER /var/www/laravel
cd laravel/
install composer autoloader
composer install --optimize-autoloader --no-dev --no-interaction
composer update --no-interaction

#Copy the content of the default env file to .env
sudo cp .env.example .env
sudo chown -R www-data storage
sudo chown -R www-data bootstrap/cache
cd
cd /etc/apache2/sites-available/
sudo touch cloudexam.conf
sudo echo '<VirtualHost *:80>
  ServerName localhost
  DocumentRoot /var/www/laravel/public

  <Directory /var/www/laravel>
    AllowOverride All
  </Directory>

  ErrorLog ${APACHE_LOG_DIR}/laravel-error.log
  CustomLog ${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/cloudexam.conf
sudo a2ensite cloudexam.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

#Configure and Install mysql database
sudo apt -y install mysql-server
sudo apt -y install mysql-client
sudo systemctl start mysql

#Create a database
sudo mysql -uroot -e "CREATE DATABASE CloudexamDB;"
sudo mysql -uroot -e "CREATE USER 'Virginia'@'localhost' IDENTIFIED BY 'Olufunke';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON CloudexamDB.* TO 'Virginia'@'localhost';"

#Edit .env file
cd /var/www/laravel
sudo sed -i "23 s/^#//g" /var/www/laravel/.env
sudo sed -i "24 s/^#//g" /var/www/laravel/.env
sudo sed -i "25 s/^#//g" /var/www/laravel/.env
sudo sed -i "26 s/^#//g" /var/www/laravel/.env
sudo sed -i "27 s/^#//g" /var/www/laravel/.env
sudo sed -i '22 s/=sqlite/=mysql/' /var/www/laravel/.env
sudo sed -i '23 s/=127.0.0.1/=localhost/' /var/www/laravel/.env
sudo sed -i '24 s/=3306/=3306/' /var/www/laravel/.env
sudo sed -i '25 s/=laravel/=CloudexamDB/' /var/www/laravel/.env
sudo sed -i '26 s/=root/=Virginia/' /var/www/laravel/.env
sudo sed -i '27 s/=/=Olufunke/' /var/www/laravel/.env

sudo php artisan key:generate --force
sudo php artisan storage:link
sudo php artisan migrate --force
sudo php artisan db:seed --force
sudo systemctl restart apache2

