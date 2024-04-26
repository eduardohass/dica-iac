# ifndef LOCATION
# $(error LOCATION is not set)
# endif

.PHONY: all plan apply destroy

all: plan

init:
    cd terraform && \
    terraform init

plan:
    cd $(LOCATION) && \
    terraform plan -var-file terraform.tfvars -out terraform.tfplan

apply:
    cd $(LOCATION) && \
    terraform apply -var-file terraform.tfvars

destroy:
    cd $(LOCATION) && \
    terraform plan -destroy -var-file terraform.tfvars -out terraform.tfplan
    terraform apply terraform.tfplan