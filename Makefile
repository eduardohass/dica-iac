# ifndef LOCATION
# $(error LOCATION is not set)
# endif

.PHONY: all plan apply destroy

all: plan

fmt: 
	cd terraform && \
	terraform fmt --recursive

validate: 
	cd terraform && \
	terraform validate

init:
	cd terraform && \
	terraform init

plan: init fmt validate
	cd terraform && \
	terraform plan 

apply: init
	cd terraform && \
	terraform apply

destroy: init
	cd terraform && \
	terraform destroy