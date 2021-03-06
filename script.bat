#!/bin/bash

echo Cleaning...
rm -rf ./dist

if [ -z "$GIT_COMMIT" ]; then
  export GIT_COMMIT=$(git rev-parse HEAD)
  export GIT_URL=$(git config --get remote.origin.url)
fi

# Remove .git from url in order to get https link to repo (assumes https url for GitHub)
export GITHUB_URL=$(echo $GIT_URL | rev | cut -c 5- | rev)

echo "GIT_COMMIT=$(echo (git rev-parse HEAD))" >> .env
echo "1!!!!!!!!!!"

echo Building app
npm run build

rc=$?
if [[ $rc != 0 ]] ; then
    echo "Npm build failed with exit code " $rc
    exit $rc
fi
mkdir dist
cat > ./dist/githash.txt <<_EOF_
$GIT_COMMIT
_EOF_

mkdir ./dist/public
cat > ./dist/public/version.html << _EOF_
<!doctype html>
<head>
   <title>App version information</title>
</head>
<body>
   <span>Origin:</span> <span>$GITHUB_URL</span>
   <span>Revision:</span> <span>$GIT_COMMIT</span>
   <p>
   <div><a href="$GITHUB_URL/commits/$GIT_COMMIT">History of current version</a></div>
</body>
_EOF_


cp ./Dockerfile ./build/
cp package.json ./build/

cd build
echo Building docker image

sudo docker build -t fridjon14/tictactoe:$GIT_COMMIT .

rc=$?
if [[ $rc != 0 ]] ; then
    echo "Docker build failed " $rc
    exit $rc
fi

sudo docker push fridjon14/tictactoe:$GIT_COMMIT
rc=$?
if [[ $rc != 0 ]] ; then
    echo "Docker push failed " $rc
    exit $rc
fi

echo "Done"
