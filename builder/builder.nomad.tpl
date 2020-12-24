    job "builder" {
      datacenters = ["dc1"]

      type = "service"

      update {
        stagger      = "60s"
        max_parallel = 1
      }

      group "dev" {
        count = 1
        network {
            port "ssh" { to = 22 }
        }

        task "builder-service" {
            driver = "docker"
            config {
                image = "docker-registry.7onetella.net:5000/7onetella/builder:__tag__"
                ports = [ "ssh" ]
                volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ]

                logging {
                   type = "elasticsearch"
                   config {
                        elasticsearch-url="http://elasticsearch-dev.7onetella.net:80"
                        elasticsearch-sniff=false
                        elasticsearch-index="docker-%F"
                        elasticsearch-type="_doc"
                        elasticsearch-timeout="60s"
                        elasticsearch-version=5
                        elasticsearch-fields="containerID,containerName,containerImageName"
                        elasticsearch-bulk-workers=1
                        elasticsearch-bulk-actions=1000
                        elasticsearch-bulk-size=1024
                        elasticsearch-bulk-flush-interval="1s"
                    }
                }
            }

            resources {
                cpu = 3300
                memory = 1024
            }

            service {
                port = "ssh"
            }

            env {
                URL = "http://docker-registry.7onetella.net:5000"
                DELETE_IMAGES = "true"
            }
        }
      }
    }