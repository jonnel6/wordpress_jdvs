# -*- encoding: utf-8 -*-
# Instalar WP CLI
remote_file '/tmp/wp' do
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Mover WP CLI a /bin
execute 'Move WP CLI' do
  command 'mv /tmp/wp /bin/wp'
  not_if { ::File.exist?('/bin/wp') }
end

# Hacer WP CLI ejecutable
file '/bin/wp' do
  mode '0755'
end

# Instalar Wordpress y configurar
execute 'Finish Wordpress installation' do
  command 'sudo -u vagrant -i -- wp core install --path=/opt/wordpress/ --url="192.168.56.2" --title="EPNEWMAN - Herramientas de automatización de despliegues" --admin_user=admin --admin_password="Epnewman123" --admin_email=admin@epnewman.edu.pe --locale=es_ES'
  not_if 'wp core is-installed', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end