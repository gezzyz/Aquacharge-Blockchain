#!/usr/bin/env bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using OrgEVOwner
ORG=${1:-OrgEVOwner}

# Exit on first error, print all commands.
set -e
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.."; pwd )"

ORDERER_CA=${DIR}/test-network/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
PEER0_ORGEVOWNER_CA=${DIR}/test-network/organizations/peerOrganizations/orgevowner.example.com/tlsca/tlsca.orgevowner.example.com-cert.pem
PEER0_ORGPSO_CA=${DIR}/test-network/organizations/peerOrganizations/orgpso.example.com/tlsca/tlsca.orgpso.example.com-cert.pem
PEER0_ORG3_CA=${DIR}/test-network/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem


if [[ ${ORG,,} == "orgevowner" ]]; then

   CORE_PEER_LOCALMSPID=OrgEVOwnerMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/orgevowner.example.com/users/Admin@orgevowner.example.com/msp
   CORE_PEER_ADDRESS=localhost:7051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/orgevowner.example.com/tlsca/tlsca.orgevowner.example.com-cert.pem

elif [[ ${ORG,,} == "orgpso" ]]; then

   CORE_PEER_LOCALMSPID=OrgPSOMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/orgpso.example.com/users/Admin@orgpso.example.com/msp
   CORE_PEER_ADDRESS=localhost:9051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/orgpso.example.com/tlsca/tlsca.orgpso.example.com-cert.pem

else
   echo "Unknown \"$ORG\", please choose OrgEVOwner or OrgPSO"
   echo "For example to get the environment variables to set up an OrgPSO shell environment run:  ./setOrgEnv.sh OrgPSO"
   echo
   echo "This can be automated to set them as well with:"
   echo
   echo 'export $(./setOrgEnv.sh OrgPSO | xargs)'
   exit 1
fi

# output the variables that need to be set
echo "CORE_PEER_TLS_ENABLED=true"
echo "ORDERER_CA=${ORDERER_CA}"
echo "PEER0_ORGEVOWNER_CA=${PEER0_ORGEVOWNER_CA}"
echo "PEER0_ORGPSO_CA=${PEER0_ORGPSO_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG3_CA}"

echo "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
