#!/bin/sh

set -e

if ! command -v unzip >/dev/null; then
    echo "Error: unzip is required to install quickjs." 1>&2
    exit 1
fi

if ! command -v jq >/dev/null; then
    echo "Error: jq is required to install quickjs." 1>&2
    exit 1
fi

if [ "$OS" = "Windows_NT" ]; then
    target="win-x86_64"
else
    target="linux-x86_64"
fi

quickjs_realeses_uri="https://bellard.org/quickjs/binary_releases"
version=$(curl -s $quickjs_realeses_uri/LATEST.json | jq -r '.version')
quickjs_uri="$quickjs_realeses_uri/quickjs-$target-$version.zip"

quickjs_install="${QUICKJS_INSTALL:-$HOME/.quickjs}"
bin_dir="$quickjs_install/bin"
exe="$bin_dir/qjs"

if [ ! -d "$bin_dir" ]; then
    mkdir -p "$bin_dir"
fi

curl --fail --location --progress-bar --output "$exe.zip" "$quickjs_uri"
unzip -d "$bin_dir" -o "$exe.zip"
chmod +x "$exe"
rm "$exe.zip"

echo "quickjs was installed successfully to $exe"

if command -v qjs >/dev/null; then
    echo "Run 'qjs --help' to get started"
else
    case $SHELL in
    /bin/zsh) shell_profile=".zshrc" ;;
    *) shell_profile=".bashrc" ;;
    esac
    echo "Manually add the directory to your \$HOME/$shell_profile (or similar)"
    echo "  export QUICKJS_INSTALL=\"$quickjs_install\""
    echo "  export PATH=\"\$QUICKJS_INSTALL/bin:\$PATH\""
    echo "Run '$exe --help' to get started"
fi
