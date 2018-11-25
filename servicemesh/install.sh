#!/bin/bash

#patch
ansible-playbook /root/update-cluster.yaml

#clone
cd /root
git clone https://github.com/Maistra/openshift-ansible
git checkout maistra-0.3
cd /root/openshift-ansible/istio


#create
oc new-project istio-operator

#install
oc new-app -f istio_product_operator_template.yaml --param=OPENSHIFT_ISTIO_MASTER_PUBLIC_URL=https://lb.paas.americamovil.com


#logs
oc logs -n istio-operator $(oc -n istio-operator get pods -l name=istio-operator --output=jsonpath={.items..metadata.name})

#control plane
oc create -f cr-ocp.yaml -n istio-operator

#watch
watch oc get pods -n istio-system


#see routes
oc get routes -n istio-system


#continue to:
#https://github.com/redhat-developer-demos/istio-tutorial