#!/usr/bin/env bash

set -ev

if [ -n "$TRAVIS_TAG" ]; then
    REF=refs/tags/$TRAVIS_TAG
else
    REF=refs/heads/master
fi

# Install Go and splits
eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=1.4 bash)"
export GOPATH=$HOME/gopath
go get -d github.com/libgit2/git2go
cd $GOPATH/src/github.com/libgit2/git2go
git checkout next
git submodule update --init
make install
go get github.com/splitsh/lite
go build -o ~/bin/splitsh-lite github.com/splitsh/lite

cp /tmp/cached/splitsh.db .git/splitsh.db || true

# Clone again to overcome limited cloning depth on Travis
git clone https://github.com/$TRAVIS_REPO_SLUG.git /tmp/ginger
cd /tmp/ginger

SHA1=`splitsh-lite --prefix=modules/mod_ginger_base/`
git push git@github.com:driebit/mod_ginger_base.git $SHA1:$REF

SHA1=`splitsh-lite --prefix=modules/mod_ginger_tagger/`
git push git@github.com:driebit/mod_ginger_tagger.git $SHA1:$REF

SHA1=`splitsh-lite --prefix=modules/mod_ginger_timeline/`
git push git@github.com:driebit/mod_ginger_timeline.git $SHA1:$REF
