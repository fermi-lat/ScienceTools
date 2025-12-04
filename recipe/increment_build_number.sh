export FERMITOOLS_VERSION=$(cat $RECIPE_DIR/meta.yaml | \
  grep '{% set version =' | awk '{ print $5 }' | tr -d \")

echo -e "Fermitools Version: ${FERMITOOLS_VERSION}"
echo -e "The build_label variable value is: $LABEL_FOR_BUILD"

export BUILD_NUMBER="${BUILD_NUMBER:-$(conda search \
  -c fermi/label/$LABEL_FOR_BUILD/osx-64 \
  -c fermi/label/$LABEL_FOR_BUILD/osx-arm64 \
  -c fermi/label/$LABEL_FOR_BUILD/linux-aarch64 \
  -c fermi/label/$LABEL_FOR_BUILD/linux-64 \
  fermitools=${FERMITOOLS_VERSION} --info --json | jq -r '.fermitools | [.[] | .build_number] | max + 1')}"

echo -e "Version Build Number: ${BUILD_NUMBER}"
