export FERMITOOLS_VERSION=$(cat $RECIPE_DIR/meta.yaml | \
  grep '{% set version =' | awk '{ print $5 }' | tr -d \")

label_for_build=${LABEL_BUILD:-dev}
echo -e "Fermitools Version: ${FERMITOOLS_VERSION}"
echo -e "The build_label variable value is: $label_for_build"

export BUILD_NUMBER="${BUILD_NUMBER:-$(conda search \
  -c fermi/label/$label_for_build/osx-64 \
  -c fermi/label/$label_for_build/osx-arm64 \
  -c fermi/label/$label_for_build/linux-aarch64 \
  -c fermi/label/$label_for_build/linux-64 \
  fermitools=${FERMITOOLS_VERSION} --info --json | jq -r '.fermitools | [.[] | .build_number] | max + 1')}"

echo -e "Version Build Number: ${BUILD_NUMBER}"
