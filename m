From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from top-level
 Makefile
Date: Thu,  2 Nov 2017 11:51:25 +0900
Message-ID: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

We need to add "clean-files" in Makfiles to clean up DT blobs, but we
often miss to do so.

Since there are no source files that end with .dtb or .dtb.S, so we
can clean-up those files from the top-level Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Remove clean-files

 Documentation/kbuild/makefiles.txt               | 1 -
 Makefile                                         | 2 +-
 arch/arc/boot/dts/Makefile                       | 1 -
 arch/arm/boot/dts/Makefile                       | 1 -
 arch/arm64/boot/dts/actions/Makefile             | 1 -
 arch/arm64/boot/dts/al/Makefile                  | 1 -
 arch/arm64/boot/dts/allwinner/Makefile           | 1 -
 arch/arm64/boot/dts/altera/Makefile              | 1 -
 arch/arm64/boot/dts/amd/Makefile                 | 1 -
 arch/arm64/boot/dts/amlogic/Makefile             | 1 -
 arch/arm64/boot/dts/apm/Makefile                 | 1 -
 arch/arm64/boot/dts/arm/Makefile                 | 1 -
 arch/arm64/boot/dts/broadcom/Makefile            | 1 -
 arch/arm64/boot/dts/broadcom/northstar2/Makefile | 1 -
 arch/arm64/boot/dts/broadcom/stingray/Makefile   | 1 -
 arch/arm64/boot/dts/cavium/Makefile              | 1 -
 arch/arm64/boot/dts/exynos/Makefile              | 1 -
 arch/arm64/boot/dts/freescale/Makefile           | 1 -
 arch/arm64/boot/dts/hisilicon/Makefile           | 1 -
 arch/arm64/boot/dts/lg/Makefile                  | 1 -
 arch/arm64/boot/dts/marvell/Makefile             | 1 -
 arch/arm64/boot/dts/mediatek/Makefile            | 1 -
 arch/arm64/boot/dts/nvidia/Makefile              | 1 -
 arch/arm64/boot/dts/qcom/Makefile                | 1 -
 arch/arm64/boot/dts/realtek/Makefile             | 1 -
 arch/arm64/boot/dts/renesas/Makefile             | 1 -
 arch/arm64/boot/dts/rockchip/Makefile            | 1 -
 arch/arm64/boot/dts/socionext/Makefile           | 1 -
 arch/arm64/boot/dts/sprd/Makefile                | 1 -
 arch/arm64/boot/dts/xilinx/Makefile              | 1 -
 arch/arm64/boot/dts/zte/Makefile                 | 1 -
 arch/c6x/boot/dts/Makefile                       | 2 --
 arch/cris/boot/dts/Makefile                      | 2 --
 arch/h8300/boot/dts/Makefile                     | 1 -
 arch/metag/boot/dts/Makefile                     | 1 -
 arch/microblaze/boot/Makefile                    | 2 +-
 arch/mips/boot/dts/Makefile                      | 1 -
 arch/mips/boot/dts/brcm/Makefile                 | 1 -
 arch/mips/boot/dts/cavium-octeon/Makefile        | 1 -
 arch/mips/boot/dts/img/Makefile                  | 1 -
 arch/mips/boot/dts/ingenic/Makefile              | 1 -
 arch/mips/boot/dts/lantiq/Makefile               | 1 -
 arch/mips/boot/dts/mti/Makefile                  | 1 -
 arch/mips/boot/dts/netlogic/Makefile             | 1 -
 arch/mips/boot/dts/ni/Makefile                   | 1 -
 arch/mips/boot/dts/pic32/Makefile                | 1 -
 arch/mips/boot/dts/qca/Makefile                  | 1 -
 arch/mips/boot/dts/ralink/Makefile               | 1 -
 arch/mips/boot/dts/xilfpga/Makefile              | 1 -
 arch/nios2/boot/Makefile                         | 2 --
 arch/openrisc/boot/dts/Makefile                  | 2 --
 arch/powerpc/boot/Makefile                       | 2 +-
 arch/sh/boot/dts/Makefile                        | 2 --
 arch/xtensa/boot/dts/Makefile                    | 2 --
 54 files changed, 3 insertions(+), 60 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index f6f8038..71e9fee 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1158,7 +1158,6 @@ When kbuild executes, the following steps are followed (roughly):
 
 	Example:
 		targets += $(dtb-y)
-		clean-files += *.dtb
 		DTC_FLAGS ?= -p 1024
 
 --- 6.8 Custom kbuild commands
diff --git a/Makefile b/Makefile
index 63a4c0e..c577c63 100644
--- a/Makefile
+++ b/Makefile
@@ -1544,7 +1544,7 @@ clean: $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
-		-o -name '*.ko.*' \
+		-o -name '*.ko.*' -o -name '*.dtb' -o -name '*.dtb.S' \
 		-o -name '*.dwo'  \
 		-o -name '*.su'  \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index a09f11b..1257db1 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -14,4 +14,3 @@ dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
 
 always := $(dtb-y)
-clean-files := *.dtb  *.dtb.S
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faf46ab..5eeefbc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1074,4 +1074,3 @@ dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
 
 always		:= $(dtb-y)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
index 62922d6..89bb1b5 100644
--- a/arch/arm64/boot/dts/actions/Makefile
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -2,4 +2,3 @@ dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/al/Makefile
index 8a6cde4..8606a57 100644
--- a/arch/arm64/boot/dts/al/Makefile
+++ b/arch/arm64/boot/dts/al/Makefile
@@ -2,4 +2,3 @@ dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v2-evp.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 19c3fbd..871ed768 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -11,4 +11,3 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
index d7a6416..7511b51 100644
--- a/arch/arm64/boot/dts/altera/Makefile
+++ b/arch/arm64/boot/dts/altera/Makefile
@@ -2,4 +2,3 @@ dtb-$(CONFIG_ARCH_STRATIX10) += socfpga_stratix10_socdk.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
index ba84770..cb1c779 100644
--- a/arch/arm64/boot/dts/amd/Makefile
+++ b/arch/arm64/boot/dts/amd/Makefile
@@ -4,4 +4,3 @@ dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive.dtb \
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 7a9f48c..d864403 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -22,4 +22,3 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/apm/Makefile b/arch/arm64/boot/dts/apm/Makefile
index c75f17a4..4334978 100644
--- a/arch/arm64/boot/dts/apm/Makefile
+++ b/arch/arm64/boot/dts/apm/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_XGENE) += apm-merlin.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 75cc2aa..01c342f 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -5,4 +5,3 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 3eaef38..d720d0d 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -4,4 +4,3 @@ dts-dirs	+= northstar2
 dts-dirs	+= stingray
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/Makefile b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
index e01a148..c589b9b 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/Makefile
+++ b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-xmc.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/stingray/Makefile b/arch/arm64/boot/dts/broadcom/stingray/Makefile
index f70028e..8edcc52 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/Makefile
+++ b/arch/arm64/boot/dts/broadcom/stingray/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742t.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/cavium/Makefile b/arch/arm64/boot/dts/cavium/Makefile
index 581b2c1..c63145e 100644
--- a/arch/arm64/boot/dts/cavium/Makefile
+++ b/arch/arm64/boot/dts/cavium/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_THUNDER2) += thunder2-99xx.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 7ddea53..4633adf 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -5,4 +5,3 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 72c4b52..fe18e3d 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -15,4 +15,3 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
  
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index 8960eca..cb25d7a 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -7,4 +7,3 @@ dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/lg/Makefile b/arch/arm64/boot/dts/lg/Makefile
index 5c7b54c1..c0bbe06 100644
--- a/arch/arm64/boot/dts/lg/Makefile
+++ b/arch/arm64/boot/dts/lg/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_LG1K) += lg1313-ref.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 6cff81e..b471235 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -12,4 +12,3 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 151723b..80d1743 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -7,4 +7,3 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
index 1894145..a9d5196 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -6,4 +6,3 @@ dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
 dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
 
 always		:= $(dtb-y)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index ff81d7e..65af6f9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -8,4 +8,3 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 8521e92..88cb515 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -2,4 +2,3 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 381928b..960dade 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -5,4 +5,3 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
 
 always		:= $(dtb-y)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index f1c9b13..6b6bb1d 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -13,4 +13,3 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index 4bc091b..5eed3ce 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -6,4 +6,3 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-pxs3-ref.dtb
 
 always		:= $(dtb-y)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
index f0535e6..c91b62e 100644
--- a/arch/arm64/boot/dts/sprd/Makefile
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index ae16427..74e1956 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -2,4 +2,3 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
index d86c4de..71e0708 100644
--- a/arch/arm64/boot/dts/zte/Makefile
+++ b/arch/arm64/boot/dts/zte/Makefile
@@ -3,4 +3,3 @@ dtb-$(CONFIG_ARCH_ZX) += zx296718-pcbox.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
diff --git a/arch/c6x/boot/dts/Makefile b/arch/c6x/boot/dts/Makefile
index c7528b0..cb4874c 100644
--- a/arch/c6x/boot/dts/Makefile
+++ b/arch/c6x/boot/dts/Makefile
@@ -16,5 +16,3 @@ $(obj)/builtin.dtb: $(obj)/$(DTB).dtb
 	$(call if_changed,cp)
 
 $(obj)/linked_dtb.o: $(obj)/builtin.dtb
-
-clean-files := *.dtb
diff --git a/arch/cris/boot/dts/Makefile b/arch/cris/boot/dts/Makefile
index faf69fb..4a97c7d 100644
--- a/arch/cris/boot/dts/Makefile
+++ b/arch/cris/boot/dts/Makefile
@@ -2,5 +2,3 @@ BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_BUILTIN_DTB)).dtb.o
 ifneq ($(CONFIG_BUILTIN_DTB),"")
 obj-$(CONFIG_OF) += $(BUILTIN_DTB)
 endif
-
-clean-files := *.dtb.S
diff --git a/arch/h8300/boot/dts/Makefile b/arch/h8300/boot/dts/Makefile
index 6c08467..6f3fe47 100644
--- a/arch/h8300/boot/dts/Makefile
+++ b/arch/h8300/boot/dts/Makefile
@@ -12,4 +12,3 @@ dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
 
 always	    := $(dtb-y)
-clean-files := *.dtb.S *.dtb
diff --git a/arch/metag/boot/dts/Makefile b/arch/metag/boot/dts/Makefile
index 097c6da..83d5b88 100644
--- a/arch/metag/boot/dts/Makefile
+++ b/arch/metag/boot/dts/Makefile
@@ -18,4 +18,3 @@ dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dts
 .SECONDARY: $(obj)/$(builtindtb-y).dtb.S
 
 always += $(dtb-y)
-clean-files += *.dtb *.dtb.S
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 91d2068..1cb84cf 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -34,4 +34,4 @@ $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,strip)
 	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
-clean-files += simpleImage.*.unstrip linux.bin.ub dts/*.dtb
+clean-files += simpleImage.*.unstrip linux.bin.ub
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index cbac26c..7891ffa 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -18,4 +18,3 @@ dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dt
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index d61bc2a..69a69d1 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -40,4 +40,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
index 5b99c40..a6fb331 100644
--- a/arch/mips/boot/dts/cavium-octeon/Makefile
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -6,4 +6,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
index 3d70958..135f987 100644
--- a/arch/mips/boot/dts/img/Makefile
+++ b/arch/mips/boot/dts/img/Makefile
@@ -7,4 +7,3 @@ obj-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb.o
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index f2b864f..e3d0ec1 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -7,4 +7,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index 0906c62..5976f08 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -6,4 +6,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index fcabd69..9a1a6dc 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -7,4 +7,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
index 9868057..6b2cf49 100644
--- a/arch/mips/boot/dts/netlogic/Makefile
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -10,4 +10,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/ni/Makefile b/arch/mips/boot/dts/ni/Makefile
index 66cfdff..094da72 100644
--- a/arch/mips/boot/dts/ni/Makefile
+++ b/arch/mips/boot/dts/ni/Makefile
@@ -4,4 +4,3 @@ dtb-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= 169445.dtb
 obj-					+= dummy.o
 
 always					:= $(dtb-y)
-clean-files				:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
index 7ac7905..0ee591b 100644
--- a/arch/mips/boot/dts/pic32/Makefile
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -9,4 +9,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 63a9ddf..87cf351c 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -9,4 +9,3 @@ dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index 55e2937..e0e3a9d 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -11,4 +11,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 913a752..8b9ea11 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -6,4 +6,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 obj-				+= dummy.o
 
 always				:= $(dtb-y)
-clean-files	:= *.dtb *.dtb.S
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index c899876..2ba23a6 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -53,7 +53,5 @@ $(obj)/%.dtb: $(src)/dts/%.dts FORCE
 
 $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
 
-clean-files := *.dtb
-
 install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
diff --git a/arch/openrisc/boot/dts/Makefile b/arch/openrisc/boot/dts/Makefile
index b092d30..0a5017c 100644
--- a/arch/openrisc/boot/dts/Makefile
+++ b/arch/openrisc/boot/dts/Makefile
@@ -5,6 +5,4 @@ BUILTIN_DTB :=
 endif
 obj-y += $(BUILTIN_DTB)
 
-clean-files := *.dtb.S
-
 #DTC_FLAGS ?= -p 1024
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c4e6fe3..c3caa5b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -439,7 +439,7 @@ zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
 	zImage.miboot zImage.pmac zImage.pseries \
-	zImage.maple simpleImage.* otheros.bld *.dtb
+	zImage.maple simpleImage.* otheros.bld
 
 # clean up files cached by wrapper
 clean-kernel-base := vmlinux.strip vmlinux.bin
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index e5ce3a0..715def0 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,3 +1 @@
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
-
-clean-files := *.dtb.S
diff --git a/arch/xtensa/boot/dts/Makefile b/arch/xtensa/boot/dts/Makefile
index a15e241..c62dd6c 100644
--- a/arch/xtensa/boot/dts/Makefile
+++ b/arch/xtensa/boot/dts/Makefile
@@ -16,5 +16,3 @@ dtstree := $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
 
 always += $(dtb-y)
-clean-files += *.dtb *.dtb.S
-
-- 
2.7.4
