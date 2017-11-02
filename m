From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
Date: Thu, 2 Nov 2017 09:38:19 +0100
Message-ID: <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 2, 2017 at 3:51 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> We need to add "clean-files" in Makfiles to clean up DT blobs, but we
> often miss to do so.
>
> Since there are no source files that end with .dtb or .dtb.S, so we
> can clean-up those files from the top-level Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>


On a (barely) related note, I'm struggling with another problem in the
way we handle
the .dtb files in arm64 when CONFIG_OF_ALL_DTBS is enabled: when building
on a lot of CPUs, we try to build the same files from both
arch/arm64/boot/dts/Makefile
and arch/arm64/boot/dts/*/Makefile, which then results in a failed
build when writing
the temporary files.

I have come up with a workaround that I use locally, but it seemed too ugly to
submit that for inclusion. Maybe you can come up with a nicer a solution for
this as well?

      Arnd

commit c5cf15db53470ccc9026e2a5b5a04eecbb1d3a1f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Oct 18 12:58:25 2017 +0200

    experimental arm64 dtb fix

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 8e1951273fd7..ae48c508e9e7 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -28,6 +28,6 @@ subdir-y := $(dts-dirs)

 dtstree := $(srctree)/$(src)

-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb,
$(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
+#dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb,
$(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))

 always := $(dtb-y)
diff --git a/arch/arm64/boot/dts/actions/Makefile
b/arch/arm64/boot/dts/actions/Makefile
index 62922d688ce3..5d0c27433cbc 100644
--- a/arch/arm64/boot/dts/actions/Makefile
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/al/Makefile
index 8a6cde4f9b23..b7af2ab37181 100644
--- a/arch/arm64/boot/dts/al/Makefile
+++ b/arch/arm64/boot/dts/al/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_ALPINE) += alpine-v2-evp.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/allwinner/Makefile
b/arch/arm64/boot/dts/allwinner/Makefile
index 5d88df3533e1..7549f7961c51 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/altera/Makefile
b/arch/arm64/boot/dts/altera/Makefile
index d7a641698d77..a815d975272b 100644
--- a/arch/arm64/boot/dts/altera/Makefile
+++ b/arch/arm64/boot/dts/altera/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_STRATIX10) += socfpga_stratix10_socdk.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
index ba84770f789f..df4367e9cb45 100644
--- a/arch/arm64/boot/dts/amd/Makefile
+++ b/arch/arm64/boot/dts/amd/Makefile
@@ -1,6 +1,7 @@
 dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive.dtb \
  amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb \
  husky.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amlogic/Makefile
b/arch/arm64/boot/dts/amlogic/Makefile
index 3d6b088d2160..7c5b95cf4572 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/apm/Makefile b/arch/arm64/boot/dts/apm/Makefile
index c75f17a49471..a1ee4a7f3c03 100644
--- a/arch/arm64/boot/dts/apm/Makefile
+++ b/arch/arm64/boot/dts/apm/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-merlin.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 25f82c377f67..9ede5a4853dc 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += \
 dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/broadcom/Makefile
b/arch/arm64/boot/dts/broadcom/Makefile
index 3eaef3895d66..ac89a3d35dc4 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,4 +1,6 @@
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 dts-dirs += northstar2
 dts-dirs += stingray
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/Makefile
b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
index e01a1485b813..5f07c858c8ad 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/Makefile
+++ b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-xmc.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)    += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/broadcom/stingray/Makefile
b/arch/arm64/boot/dts/broadcom/stingray/Makefile
index f70028edad63..0c11df9f89b9 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/Makefile
+++ b/arch/arm64/boot/dts/broadcom/stingray/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742k.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742t.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)    += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/cavium/Makefile
b/arch/arm64/boot/dts/cavium/Makefile
index 581b2c1c400a..4f312008578e 100644
--- a/arch/arm64/boot/dts/cavium/Makefile
+++ b/arch/arm64/boot/dts/cavium/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
 dtb-$(CONFIG_ARCH_THUNDER2) += thunder2-99xx.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/exynos/Makefile
b/arch/arm64/boot/dts/exynos/Makefile
index 7ddea53769a7..27aa03276d70 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -3,6 +3,8 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
  exynos5433-tm2e.dtb \
  exynos7-espresso.dtb

+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
+
 always := $(dtb-y)
 subdir-y := $(dts-dirs)
 clean-files := *.dtb
diff --git a/arch/arm64/boot/dts/freescale/Makefile
b/arch/arm64/boot/dts/freescale/Makefile
index 72c4b525726f..9b6ba7d373e4 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/hisilicon/Makefile
b/arch/arm64/boot/dts/hisilicon/Makefile
index 8960ecafd37d..db22d2bdc4dd 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/lg/Makefile b/arch/arm64/boot/dts/lg/Makefile
index 5c7b54c12adc..34aedd89aa3b 100644
--- a/arch/arm64/boot/dts/lg/Makefile
+++ b/arch/arm64/boot/dts/lg/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_LG1K) += lg1312-ref.dtb
 dtb-$(CONFIG_ARCH_LG1K) += lg1313-ref.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/marvell/Makefile
b/arch/arm64/boot/dts/marvell/Makefile
index 6cff81eeaae2..13b691f83360 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/mediatek/Makefile
b/arch/arm64/boot/dts/mediatek/Makefile
index 151723b5c733..5a715507dc5c 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/nvidia/Makefile
b/arch/arm64/boot/dts/nvidia/Makefile
index 18941458cb4d..b527b397edca 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -5,5 +5,6 @@ dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
 dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb

+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
 always := $(dtb-y)
 clean-files := *.dtb
diff --git a/arch/arm64/boot/dts/qcom/Makefile
b/arch/arm64/boot/dts/qcom/Makefile
index ff81d7e5805e..c8ccb103c5bd 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8992-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM) += msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM) += msm8996-mtp.dtb

+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
 always := $(dtb-y)
 subdir-y := $(dts-dirs)
 clean-files := *.dtb
diff --git a/arch/arm64/boot/dts/realtek/Makefile
b/arch/arm64/boot/dts/realtek/Makefile
index ee9bcf332c77..f1561c3290a9 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-mele-v9.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb

+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
 always := $(dtb-y)
 subdir-y := $(dts-dirs)
 clean-files := *.dtb
diff --git a/arch/arm64/boot/dts/renesas/Makefile
b/arch/arm64/boot/dts/renesas/Makefile
index 53a91225ec06..c9fd3307b1e2 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -8,5 +8,6 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb

+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
 always := $(dtb-y)
 clean-files := *.dtb
diff --git a/arch/arm64/boot/dts/rockchip/Makefile
b/arch/arm64/boot/dts/rockchip/Makefile
index f1c9b13cea5c..8b8476b03346 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/socionext/Makefile
b/arch/arm64/boot/dts/socionext/Makefile
index 4bc091b365fd..5f8b5446abd4 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -5,5 +5,7 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
  uniphier-ld20-ref.dtb \
  uniphier-pxs3-ref.dtb

+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)
+
 always := $(dtb-y)
 clean-files := *.dtb
diff --git a/arch/arm64/boot/dts/sprd/Makefile
b/arch/arm64/boot/dts/sprd/Makefile
index f0535e6eaaaa..048ac20a68a7 100644
--- a/arch/arm64/boot/dts/sprd/Makefile
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
  sp9860g-1h10.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/xilinx/Makefile
b/arch/arm64/boot/dts/xilinx/Makefile
index ae16427f6a4a..48e5020bb9b3 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
index d86c4def6bc9..9a4c262f71a4 100644
--- a/arch/arm64/boot/dts/zte/Makefile
+++ b/arch/arm64/boot/dts/zte/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_ZX) += zx296718-evb.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296718-pcbox.dtb
+dtb-$(CONFIG_OF_ALL_DTBS)  += $(dtb-)

 always := $(dtb-y)
 subdir-y := $(dts-dirs)
