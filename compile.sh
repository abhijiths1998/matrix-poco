#!/bin/bash

export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="abhijiths0098"
export KBUILD_BUILD_HOST="matrix"
GCC="/home/abhivarma362/disk/gcc64/bin/aarch64-maestro-linux-gnu-"
GCC32="/home/abhivarma362/disk/gcc32/bin/arm-maestro-linux-gnueabi-"
CLANG_PATH="/home/abhivarma362/disk/clang/bin/clang"

mkdir -p out

make clean
make mrproper

make O=out ARCH=arm64 matrix_defconfig

make -j$(nproc --all) O=out ARCH=arm64 \
                        CC="${CLANG_PATH}" \
                        CLANG_TRIPLE="aarch64-maestro-linux-gnu-" \
			CROSS_COMPILE="${GCC}" \
			CROSS_COMPILE_ARM32="${GCC32}"

mv out/arch/arm64/boot/Image.gz-dtb ../anykernel

