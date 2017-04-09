docker run -it --rm -v `pwd`/terraform-otc:/data --workdir=/data -e TF_LOG=TRACE hashicorp/terraform apply

