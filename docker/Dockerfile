FROM ljfranklin/terraform-resource

RUN mkdir -p "$HOME/.terraform.d/providers"

RUN wget https://github.com/orange-cloudfoundry/terraform-provider-cloudfoundry/releases/download/v0.10.0/terraform-provider-cloudfoundry_0.10_linux_386 \
  && mv terraform-provider-cloudfoundry_0.10_linux_386 $HOME/.terraform.d/providers/ \
  && chmod +x $HOME/.terraform.d/providers/terraform-provider-cloudfoundry_0.10_linux_386

RUN echo 'providers{cloudfoundry = "/root/.terraform.d/providers/terraform-provider-cloudfoundry"}' > $HOME/.terraformrc