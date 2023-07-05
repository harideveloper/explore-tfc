set -euo pipefail

echo $1
echo $2
echo $3



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


# checkout the ref and tag it with the new version number
git checkout ${GIT_REF}
git tag "${NEW_VERSION}"

# reset public to be a replica of the latest version of main from the remote
git checkout public
git reset --hard "${GIT_REF}"

# reset the git HEAD pointer to the initial commit, but keep all changes
# in the working directory & staging area
#git reset --soft 3a9865589a5af8ac1bc512e97158f06e6e963bbe
ls -ltr scripts

# redactor - remove/replace things we don't want on the public branch
rm -f "${root_dir}/scripts/test.sh"
# rm -f "${root_dir}/architecture.png"
# rm -f "${root_dir}/architecture.drawio"
# rm -f "${root_dir}/.github/workflows/refresh_runners.yml"
# rm -f "${root_dir}/.github/workflows/new_candidate.yml"
# rm -f "${root_dir}/.github/workflows/cleardown_images.yml"
# mv README.candidate.md README.md
# sed -i "s/- main/- public/" .github/workflows/monorepo_ci.yml

ls -ltr scripts

# add the redactions to the git index
#git add --all

# add everything in the working directory as a single new commit
#git commit -m "Published public version of repo"

# ask if we should push to remotes
#echo -e "\nThe local public branch is now updated. Would you like to push to remotes?"
#read -r PUSH_TO_REMOTES

PUSH_TO_REMOTES=$3

if [[ "${PUSH_TO_REMOTES}" =~ true ]]; then
  # push updated public branch to remote
  echo "Pushing updated public branch to the dev repo..."
  #git push -u origin public --force

  # push all tags
  echo "Pushing updated tags to the dev repo..."
  #git push --tags

  # push to public repo, if public remote is attached
  # if git remote | grep public; then
  #   echo -e "Pushing updated public branch to the public repo..."
  #   git push public public --force
  # else
  #   echo -e "Public repo remote is not attached, so it hasn't been updated."
  # fi
fi

# return to previous branch
git checkout "${prev_branch}"

echo -e "\nAll done!\n"
