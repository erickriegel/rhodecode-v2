project = "forge/rhodecode/rhodecode-tools"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/ansforge/rhodecode-v2.git"
        ref  = "var.datacenter"
		path = "rhodecode-tools/"
		ignore_changes_outside_path = true
    }
}

app "rhodecode-tools" {

    build {
        use "docker-pull" {
            image = var.image
            tag   = var.tag
			      disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-tools.nomad.tpl", {
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
    default = "ans/rhodecode-app"
}

variable "tag" {
    type    = string
    default = "4.26.0"
}
