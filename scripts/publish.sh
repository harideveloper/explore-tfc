set -euo pipefail

echo $1
echo $2



root_dir="$(git rev-parse --show-toplevel)"

echo -e "WARNING: continuing may lose any uncommitted changes you have on your CURRENT and PUBLIC branches. Do you want to continue?"
#read -r CONFIRMATION

# if [[ ! "${CONFIRMATION}" =~ yes|YES|Yes ]]; then
#   echo -e "Cancelled."
#   exit 1
# fi

git fetch
echo "To which git ref (tag, commit hash, branch) do you want to reset the PUBLIC branch? [default=origin/main]"
#read -r GIT_REF
#GIT_REF=${GIT_REF:-origin/main}
GIT_REF=$1

if ! git rev-parse --quiet "${GIT_REF}" 2>/dev/null; then
  echo -e "Not a valid git reference. Cancelled."
  exit 2
else
  echo "Selected GIT REF is $GIT_REF"
fi

# store which branch we are currently on, so we can come back here later
prev_branch="$(git branch --show-current)"

# ask for the new version number
echo "The most recent version tag is $(git describe --tags --abbrev=0): what new version tag would you like to create?"
#read -r NEW_VERSION
NEW_VERSION=$2

if [[ ! "${NEW_VERSION}" =~ ^v(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$ ]]; then
  echo -e "Version number is not valid. Must be vX.X.X. Aborting."
  exit 1
fi

echo $GIT_REF
echo $NEW_VERSION
