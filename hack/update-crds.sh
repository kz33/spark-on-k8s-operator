#!/usr/bin/env bash

set -e

ORIGIN=$(pwd)
cd $(dirname ${BASH_SOURCE[0]})

crd_path=../deploy/crds

unset GOOS GOARCH

echo "Generating CRDs"
go run ../vendor/sigs.k8s.io/controller-tools/cmd/controller-gen/main.go \
  crd:crdVersions=v1,allowDangerousTypes=true paths=../pkg/apis/... output:crd:artifacts:config=$crd_path

echo "Formatting CRDs"
go run ../hack/update-crd/main.go $crd_path

cd $ORIGIN
