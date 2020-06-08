SHELL := /bin/bash
IP_ADDR := $(shell ./get_ip.sh)

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

clean:
	-rm *~

ssh:
	ssh -i ./ssh-gw.pem ubuntu@$(IP_ADDR)
