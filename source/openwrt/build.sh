#!/bin/bash

set -euo pipefail

#URL_ROOTFS_MIRROR="https://archive.openwrt.org"
URL_ROOTFS_MIRROR="https://mirrors.aliyun.com/openwrt"

declare -A oldname_list=(
    ["18.06.0"]="1eb0731291135e5b5abfc6db530afe1c79f5d2556e157b632429e0149a97895c"
    ["18.06.1"]="8e66a308fac92baca36af3f83a3af05e5a51d93b0f98b6c6d4683ee868d52cd2"
    ["18.06.2"]="80258f2aa876c3696c3044d24891f340492b92232142160d967879b272cd25bb"
    ["18.06.3"]="c03db7278f84bca67d2ab84421fa80324a48a7d0392949447b995dd4cff7823e"
    ["18.06.4"]="adf9875c2532ea70fc4aea8dc6a2e730176edabb91f2670e39f7ef57f3135585"
    ["18.06.5"]="bd6718057ae3f951bceb63e915d2de1465940004da8e7121f23e61f005e786d8"
    ["18.06.6"]="aeae84b8b5aa2c90cbfd8f5b7fdf3789f1cc46a4b5e30bf02510ea0b9031a858"
    ["18.06.7"]="4a1dcdf685db21677146b7aae7cd45ddde5c152af549681814af971f75d3325c"
    ["18.06.8"]="63deb82a8d95484d76544c1996362c285487857e1fa9f72ad9dfa479f3a960c7"
    ["18.06.9"]="c2390b5deee9bdd9d49a9764776acb685166664387c92bfd3e7c21f45712f768"

    ["19.07.0"]="ddceb591c09223e0aeb8a588bf039b3ef6a63bf84d58bda3b5a963ef25fcd3a4"
    ["19.07.1"]="023c32c4c9a744c3a11f28d7bd720d72b14ede05352ae7e8eaf61611b126c21a"
    ["19.07.2"]="d8212e5e3d1625c537a1286664beefc53143aa0f2bd7943aa8990fe54ac3d2e3"
    ["19.07.3"]="336dc70669bb8c1fd9fb64a8375e736dd7795a81c66a5a456a5f671f6bf8ef93"
    ["19.07.4"]="0714d1a2b1e182a208e1f952b17398d54b72b062881030143ba4c3bcbaf0a50e"
    ["19.07.5"]="8a0fb9498d7dcd795b52492f203d99d4fb1300d289c11b8ff3d9f7dd0ded15ea"
    ["19.07.6"]="56ea54cec104c9082199b0c465ba53ca985ebd627483b03ff4d9c8376a851ec1"
    ["19.07.7"]="02cd917022deb6e95bdd72fa36bbb8921da4e83f646510a6cd26efbea6eea2c3"
    ["19.07.8"]="432df6cbaf50388beace599ccd54c13ac0f0fd335c029c02ce09f86c7d45dcd4"
    ["19.07.9"]="cde67b6e5fe3711179f52f40ba490801396ee83e3ffc665a7f41e6c755a8e3f9"
    ["19.07.10"]="12e7747f48d607eb782240c5c8c5fff6409d19f8fa853786e9642c86adb26287"
)

declare -A openwrt_rootfs_list=(
    ["18.06.0"]="1eb0731291135e5b5abfc6db530afe1c79f5d2556e157b632429e0149a97895c"
    ["18.06.1"]="8e66a308fac92baca36af3f83a3af05e5a51d93b0f98b6c6d4683ee868d52cd2"
    ["18.06.2"]="80258f2aa876c3696c3044d24891f340492b92232142160d967879b272cd25bb"
    ["18.06.3"]="c03db7278f84bca67d2ab84421fa80324a48a7d0392949447b995dd4cff7823e"
    ["18.06.4"]="adf9875c2532ea70fc4aea8dc6a2e730176edabb91f2670e39f7ef57f3135585"
    ["18.06.5"]="bd6718057ae3f951bceb63e915d2de1465940004da8e7121f23e61f005e786d8"
    ["18.06.6"]="aeae84b8b5aa2c90cbfd8f5b7fdf3789f1cc46a4b5e30bf02510ea0b9031a858"
    ["18.06.7"]="4a1dcdf685db21677146b7aae7cd45ddde5c152af549681814af971f75d3325c"
    ["18.06.8"]="63deb82a8d95484d76544c1996362c285487857e1fa9f72ad9dfa479f3a960c7"
    ["18.06.9"]="c2390b5deee9bdd9d49a9764776acb685166664387c92bfd3e7c21f45712f768"

    ["19.07.0"]="ddceb591c09223e0aeb8a588bf039b3ef6a63bf84d58bda3b5a963ef25fcd3a4"
    ["19.07.1"]="023c32c4c9a744c3a11f28d7bd720d72b14ede05352ae7e8eaf61611b126c21a"
    ["19.07.2"]="d8212e5e3d1625c537a1286664beefc53143aa0f2bd7943aa8990fe54ac3d2e3"
    ["19.07.3"]="336dc70669bb8c1fd9fb64a8375e736dd7795a81c66a5a456a5f671f6bf8ef93"
    ["19.07.4"]="0714d1a2b1e182a208e1f952b17398d54b72b062881030143ba4c3bcbaf0a50e"
    ["19.07.5"]="8a0fb9498d7dcd795b52492f203d99d4fb1300d289c11b8ff3d9f7dd0ded15ea"
    ["19.07.6"]="56ea54cec104c9082199b0c465ba53ca985ebd627483b03ff4d9c8376a851ec1"
    ["19.07.7"]="02cd917022deb6e95bdd72fa36bbb8921da4e83f646510a6cd26efbea6eea2c3"
    ["19.07.8"]="432df6cbaf50388beace599ccd54c13ac0f0fd335c029c02ce09f86c7d45dcd4"
    ["19.07.9"]="cde67b6e5fe3711179f52f40ba490801396ee83e3ffc665a7f41e6c755a8e3f9"
    ["19.07.10"]="12e7747f48d607eb782240c5c8c5fff6409d19f8fa853786e9642c86adb26287"

    ["21.02.0"]="4b097e77a54c76e0e8c159e7658d09cee29fc016229a223b6a397d045a4dbda8"
    ["21.02.1"]="eca0293e6bdab52b68f4a915c47542222908ce07136926ed6d4f128bcc43eb9f"
    ["21.02.2"]="ccbeb5f6ef09b53b7dce816e7d2890c2c7a37111f1414ddcb2de3095e072113e"
    ["21.02.3"]="efafd6dcee92c0e8838cfcafad40b210d53e43c48abe00cde003a238ff6eecc6"
    ["21.02.4"]="9fa9e619150605d97588d63186572d0df57402b330970b8106a9fd5956d29d86"
    ["21.02.5"]="99d3c353b214304b24ec28a6499715a1b00fad7eabb34e55b2db5f90440646cf"
    ["21.02.6"]="3fddfc2bc441a5c382bc608f458ef81de8d51819c78458f5d013d45b1c6fba96"
    ["21.02.7"]="876f179f0bfde1f3e578814856a0e3518b1a7b6892090f7e855b94f61dbcd5e9"

    ["22.03.0"]="28f3e00f97b5e2365f28f3d209723b694f2f1f480958cbaa237406c1c50c643b"
    ["22.03.1"]="4124855dcc697566817f89752ebd993d9980015406ae723bee50821582987696"
    ["22.03.2"]="5dbc55591fd554e6075a9bf4cfb4ba4780720568a37327add1f4963794f713d2"
    ["22.03.3"]="375ab32bcfa290afda55813e3e694cb0c58a8f2c42cb7b0d9c976ac52e038ba2"
    ["22.03.4"]="33789ee468bcb3f67c134ed725697a3742e2d3e70a564901f091bccae507ce03"
    ["22.03.5"]="597d1dc8b806785d9a3764749f6cdbdf76fa6025928ed8f90ee76a837536fd6d"
    ["22.03.6"]="de5bfc2ea7e205ce21bea6204ca48af4ac5f5014379f6823ea27a7294f98fa42"
    ["22.03.7"]="a5fb7e4b7d4c304fe83d29254030bf596ca042e8e9acdf7b29a6f40aefc8b1c1"

    ["23.05.0"]="6f76a43e3b0e498b6c48263e02cb836187ff8c49726ad4ca1f793d450839b587"
    ["23.05.1"]="bb212073a8aecd5221dda4c84ec8f14b901808ed28e8fbfd08c0cc51bdcb7ece"
    ["23.05.2"]="dc5379af73ebd6845da419ccf034987dc0c8b26e503cefd5231b05a1ff8cc26c"
    ["23.05.3"]="7a1dc79ebff5f6b6d4176369afa1fadce8ce9fe9d19f85a1d6e2a923c7db6036"
    ["23.05.4"]="11eb5baedf16b56e8ba59419b502da7866cf7329372730cbc63a559aa99da710"
)

download_rootfs() {

    local version="${1}"
    local sha256sum="${2}"

    local save_file_dir="download"
    local filename="openwrt-${version}-x86-64-rootfs.tar.gz"
    if [[ -v oldname_list[$version] ]]; then
        filename="openwrt-${version}-x86-64-generic-rootfs.tar.gz"
    fi

    local filepath="${save_file_dir}/${filename}"
    local url_rootfs="${URL_ROOTFS_MIRROR}/releases/${version}/targets/x86/64/${filename}"

    mkdir -p "${save_file_dir}"

    if [[ -f "$filepath" ]]; then
        echo "文件已存在: $filepath"
        local actual_sha256=$(sha256sum "$filepath" | awk '{print $1}')

        if [[ "$actual_sha256" == "$sha256sum" ]]; then
            echo "SHA256 校验成功: $filepath"
            return 0
        else
            echo "SHA256 校验失败: $filepath"
            echo "期望的SHA256: $sha256sum"
            echo "实际的SHA256: $actual_sha256"
            echo "删除文件并重新下载..."
            rm -f "$filepath"
        fi
    fi

    echo "正在下载文件: $filename"
    wget --quiet -O "$filepath" "$url_rootfs"
    if [[ $? -ne 0 ]]; then
        echo "下载失败: $url_rootfs"
        return 1
    fi

    local actual_sha256=$(sha256sum "$filepath" | awk '{print $1}')
    if [[ "$actual_sha256" == "$sha256sum" ]]; then
        echo "SHA256 校验成功: $filepath"
    else
        echo "SHA256 校验失败: $filepath"
        echo "期望的SHA256: $sha256sum"
        echo "实际的SHA256: $actual_sha256"
        return 1
    fi
}
for sound in "${!openwrt_rootfs_list[@]}"; do
    download_rootfs "${sound}" "${openwrt_rootfs_list[$sound]}"
done
