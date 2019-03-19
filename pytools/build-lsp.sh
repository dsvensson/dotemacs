#!/bin/bash

# https://docs.microsoft.com/en-us/dotnet/core/rid-catalog
# linux-x64, linux-musl-x64
TARGET=osx.10.14-x64

if [[ ! -d "python-language-server" ]]; then
	git clone --depth 1 https://github.com/Microsoft/python-language-server.git
else
	(cd python-language-server && git pull)
fi

docker run --rm \
       -v "$PWD/python-language-server:/python-language-server" \
       -w "/python-language-server/src/LanguageServer/Impl" \
       mcr.microsoft.com/dotnet/core/sdk:2.2 \
       dotnet publish -c Release -r "$TARGET"

mv python-language-server/output/bin/Release bin

(cd python-language-server && git clean -xdf)
