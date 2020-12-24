[docker-hub]
port   = 80
memory = 128
health = /
log_driver = elasticsearch

env.URL           = http://docker-registry.7onetella.net:5000
env.DELETE_IMAGES = true
