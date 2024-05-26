# ifndef LOCATION
# $(error LOCATION is not set)
# endif

.PHONY: all plan apply destroy

all: plan

init:
	cd terraform && \
	terraform init

plan: init
	cd terraform && \
	terraform plan 

apply: init
	cd terraform && \
	terraform apply

destroy: init
	cd terraform && \
	terraform destroy