#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/yhakbar/ya"
export TOOL_NAME="ya"
export TOOL_TEST="ya --version"
export SECONDARY_TOOL_NAME="yadayada"
export SECONDARY_TOOL_TEST="yadayada --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3-
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename toolname url
	version="$1"
	filename="$2"
	toolname="$3"

	url="$GH_REPO/releases/download/${version}/${toolname}-$(get_arch)-$(get_platform).tar.gz"

	echo "* Downloading $toolname release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local tool_name="$3"
	local tool_test="$4"
	local install_path="${5%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$tool_name supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$tool_test" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$tool_name $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $tool_name $version."
	)
}

get_arch() {
	local arch
	arch=$(uname -m)
	case $arch in
	"x86_64")
		echo "x86_64"
		;;
	"arm64")
		echo "aarch64"
		;;
	*)
		exit 1
		;;
	esac
}

get_platform() {
	local platform
	platform=$(uname -s | tr '[:upper:]' '[:lower:]')
	case $platform in
	"darwin")
		echo "apple-darwin"
		;;
	"linux")
		echo "unknown-linux-musl"
		;;
	*)
		exit 1
		;;
	esac
}
