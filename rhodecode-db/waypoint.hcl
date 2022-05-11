project = "forge/rhodecode/rhodecode-db"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/erickriegel/rhodecode.git"
        ref  = "var.datacenter"
	path = "rhodecode-db/"
	ignore_changes_outside_path = true
    }
}

app "rhodecode-db" {

    build {
        use "docker-pull" {
            image = var.image
            tag   = var.tag
	    disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-postgres.nomad.tpl", {
            	datacenter = var.datacenter
		image = var.image
		tag   = var.tag
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "dc1"
}

variable "image" {
    type    = string
    default = "ans/rhodecode-database"
}

variable "tag" {
    type    = string
    default = "13.5"
}
