#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# azure-login.sh
# Prep your PERSONAL Azure account for the Terraform/CLI labs.
#
# USAGE:   source azure-login.sh          # sourced, so exports stick
#
# Unlike a sandbox, your login persists across sessions — you usually run this
# once, then only again if you switch subscriptions or the token expires.
#
# Sets:  ARM_SUBSCRIPTION_ID
#        TF_VAR_subscription_id / TF_VAR_location
# ---------------------------------------------------------------------------

# refuse to run un-sourced (exports would vanish)
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  echo "ERROR: source this script, don't execute it:  source azure-login.sh"
  exit 1
fi

REGION="${TF_VAR_location:-centralindia}"

echo "=== Personal Azure login ======================================"

# log in only if we don't already have an active session
if ! az account show >/dev/null 2>&1; then
  echo "--> not logged in; launching az login ..."
  # WSL note: if no browser opens, use:  az login --use-device-code
  az login -o none || { echo "login failed"; return 1 2>/dev/null || exit 1; }
fi

# show subscriptions and let you pick if there's more than one
COUNT="$(az account list --query 'length(@)' -o tsv 2>/dev/null)"
if [ "${COUNT:-1}" -gt 1 ]; then
  echo "--> multiple subscriptions:"
  az account list --query '[].{name:name, id:id, default:isDefault}' -o table
  read -rp "Subscription id to use [enter = current default]: " _sub
  [ -n "$_sub" ] && az account set --subscription "$_sub"
fi

SUB="$(az account show --query id -o tsv)"
NAME="$(az account show --query name -o tsv)"

export ARM_SUBSCRIPTION_ID="$SUB"
export TF_VAR_subscription_id="$SUB"
export TF_VAR_location="$REGION"

echo "==============================================================="
echo "  Subscription : $NAME"
echo "  Sub id       : $SUB"
echo "  Region       : $REGION"
echo
echo "  Ready for Terraform. After each session, remember:"
echo "     terraform destroy      # real spend on a personal account"
echo "==============================================================="
