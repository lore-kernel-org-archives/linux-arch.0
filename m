From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/5] Remove asm/clkdev.h and privatize __clk{get,put}()
Date: Tue,  2 Jan 2018 17:35:11 -0800
Message-ID: <20180103013516.18844-1-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-arch.vger.kernel.org

These patches remove the asm-generic/clkdev.h header file
and fold it into the linux/clkdev.h file.

I'd like to merge this into the clk tree for the upcoming merge
window, so please ack if things look good. The later patches

I also want to drop the slab.h include from clkdev.h, but that will
require including slab.h in various files that are relying on the
implicit include in clkdev.h right now. Here's that list of files
that don't include slab.h but include clkdev.h for the interested
folks.

arch/arm/mach-davinci/clock.h
arch/arm/mach-davinci/da850.c
arch/arm/mach-ep93xx/clock.c
arch/arm/mach-highbank/highbank.c
arch/arm/mach-imx/mach-imx53.c
arch/arm/mach-imx/mach-imx6q.c
arch/arm/mach-mmp/clock.h
arch/arm/mach-mxs/mach-mxs.c
arch/arm/mach-nspire/nspire.c
arch/arm/mach-omap1/board-nokia770.c
arch/arm/mach-omap1/clock.c
arch/arm/mach-omap1/clock.h
arch/arm/mach-omap2/clock.h
arch/arm/mach-pxa/eseries.c
arch/arm/mach-pxa/pxa27x.c
arch/arm/mach-pxa/tosa.c
arch/arm/mach-sa1100/clock.c
arch/arm/mach-w90x900/clock.h
arch/arm/plat-orion/common.c
arch/blackfin/mach-bf609/clock.c
arch/c6x/kernel/setup.c
arch/c6x/platforms/pll.c
arch/c6x/platforms/plldata.c
arch/mips/ath79/clock.c
arch/mips/bcm63xx/clk.c
arch/mips/lantiq/clk.c
arch/mips/lantiq/clk.h
arch/mips/lantiq/falcon/sysctrl.c
arch/mips/lantiq/xway/sysctrl.c
arch/mips/ralink/clk.c
arch/powerpc/platforms/512x/clock-commonclk.c
arch/sh/boards/mach-highlander/setup.c
arch/sh/boards/mach-sdk7786/setup.c
arch/sh/kernel/cpu/sh2a/clock-sh7264.c
arch/sh/kernel/cpu/sh2a/clock-sh7269.c
arch/sh/kernel/cpu/sh4/clock-sh4-202.c
arch/sh/kernel/cpu/sh4a/clock-sh7343.c
arch/sh/kernel/cpu/sh4a/clock-sh7366.c
arch/sh/kernel/cpu/sh4a/clock-sh7722.c
arch/sh/kernel/cpu/sh4a/clock-sh7723.c
arch/sh/kernel/cpu/sh4a/clock-sh7724.c
arch/sh/kernel/cpu/sh4a/clock-sh7734.c
arch/sh/kernel/cpu/sh4a/clock-sh7757.c
arch/sh/kernel/cpu/sh4a/clock-sh7763.c
arch/sh/kernel/cpu/sh4a/clock-sh7780.c
arch/sh/kernel/cpu/sh4a/clock-sh7785.c
arch/sh/kernel/cpu/sh4a/clock-sh7786.c
arch/sh/kernel/cpu/sh4a/clock-shx3.c
drivers/acpi/acpi_amba.c
drivers/acpi/acpi_apd.c
drivers/acpi/acpi_lpss.c
drivers/clk/at91/clk-generated.c
drivers/clk/at91/clk-h32mx.c
drivers/clk/at91/clk-main.c
drivers/clk/at91/clk-master.c
drivers/clk/at91/clk-peripheral.c
drivers/clk/at91/clk-pll.c
drivers/clk/at91/clk-plldiv.c
drivers/clk/at91/clk-programmable.c
drivers/clk/at91/clk-slow.c
drivers/clk/at91/clk-smd.c
drivers/clk/at91/clk-system.c
drivers/clk/at91/clk-usb.c
drivers/clk/at91/clk-utmi.c
drivers/clk/at91/pmc.c
drivers/clk/at91/sckc.c
drivers/clk/bcm/clk-cygnus.c
drivers/clk/bcm/clk-iproc-asiu.c
drivers/clk/bcm/clk-iproc-pll.c
drivers/clk/clk-asm9260.c
drivers/clk/clk-moxart.c
drivers/clk/clk-s2mps11.c
drivers/clk/clk-xgene.c
drivers/clk/clkdev.c
drivers/clk/imx/clk-imx1.c
drivers/clk/imx/clk-imx21.c
drivers/clk/imx/clk-imx25.c
drivers/clk/imx/clk-imx27.c
drivers/clk/imx/clk-imx31.c
drivers/clk/imx/clk-imx35.c
drivers/clk/imx/clk-imx51-imx53.c
drivers/clk/imx/clk-imx6q.c
drivers/clk/imx/clk-imx6sl.c
drivers/clk/imx/clk-imx6sx.c
drivers/clk/imx/clk-imx6ul.c
drivers/clk/imx/clk-imx7d.c
drivers/clk/loongson1/clk-loongson1b.c
drivers/clk/loongson1/clk-loongson1c.c
drivers/clk/microchip/clk-pic32mzda.c
drivers/clk/mmp/clk.h
drivers/clk/mxs/clk-imx28.c
drivers/clk/pxa/clk-pxa.c
drivers/clk/pxa/clk-pxa25x.c
drivers/clk/pxa/clk-pxa27x.c
drivers/clk/pxa/clk-pxa3xx.c
drivers/clk/renesas/clk-emev2.c
drivers/clk/renesas/clk-mstp.c
drivers/clk/rockchip/clk-rockchip.c
drivers/clk/sirf/clk-atlas6.c
drivers/clk/sirf/clk-prima2.c
drivers/clk/spear/spear1310_clock.c
drivers/clk/spear/spear1340_clock.c
drivers/clk/spear/spear3xx_clock.c
drivers/clk/spear/spear6xx_clock.c
drivers/clk/sunxi/clk-sun9i-core.c
drivers/clk/tegra/clk-emc.c
drivers/clk/tegra/clk-tegra-periph.c
drivers/clk/tegra/clk-tegra-pmc.c
drivers/clk/tegra/clk-tegra124.c
drivers/clk/tegra/clk-tegra20.c
drivers/clk/tegra/clk-tegra210.c
drivers/clk/tegra/clk-tegra30.c
drivers/clk/tegra/clk.c
drivers/clk/tegra/clk.h
drivers/clk/ti/adpll.c
drivers/clk/ti/clk-44xx.c
drivers/clk/ti/clk-54xx.c
drivers/clk/ti/clk-7xx.c
drivers/clk/ti/clk.c
drivers/clk/ti/dpll3xxx.c
drivers/clk/ux500/abx500-clk.c
drivers/clk/ux500/u8540_clk.c
drivers/clk/versatile/clk-impd1.c
drivers/gpu/ipu-v3/ipu-csi.c
drivers/i2c/busses/i2c-altera.c
drivers/i2c/busses/i2c-axxia.c
drivers/media/platform/atmel/atmel-isc.c
drivers/memory/tegra/tegra124-emc.c
drivers/mfd/intel-lpss.c
drivers/mfd/intel_quark_i2c_gpio.c
drivers/net/ethernet/ti/cpts.h
drivers/pinctrl/pinctrl-lantiq.h
drivers/spi/spi-pic32.c
drivers/staging/board/board.c
include/linux/clk/ti.h
sound/soc/sh/migor.c

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>

Stephen Boyd (5):
  blackfin: Use generic clkdev.h header
  clk: Prepare to remove asm-generic/clkdev.h
  arch: Remove clkdev.h asm-generic from Kbuild
  clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks
  clk: Move __clk_{get,put}() into private clk.h API

 arch/alpha/include/asm/Kbuild      |  1 -
 arch/arc/include/asm/Kbuild        |  1 -
 arch/arm/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/blackfin/include/asm/clkdev.h | 17 -----------------
 arch/c6x/include/asm/Kbuild        |  1 -
 arch/cris/include/asm/Kbuild       |  1 -
 arch/frv/include/asm/Kbuild        |  1 -
 arch/h8300/include/asm/Kbuild      |  1 -
 arch/hexagon/include/asm/Kbuild    |  1 -
 arch/ia64/include/asm/Kbuild       |  1 -
 arch/m32r/include/asm/Kbuild       |  1 -
 arch/m68k/include/asm/Kbuild       |  1 -
 arch/metag/include/asm/Kbuild      |  1 -
 arch/microblaze/include/asm/Kbuild |  1 -
 arch/mips/include/asm/Kbuild       |  1 -
 arch/mn10300/include/asm/Kbuild    |  1 -
 arch/nios2/include/asm/Kbuild      |  1 -
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/powerpc/include/asm/Kbuild    |  1 -
 arch/riscv/include/asm/Kbuild      |  1 -
 arch/s390/include/asm/Kbuild       |  1 -
 arch/score/include/asm/Kbuild      |  1 -
 arch/sh/include/asm/Kbuild         |  1 -
 arch/sparc/include/asm/Kbuild      |  1 -
 arch/tile/include/asm/Kbuild       |  1 -
 arch/um/include/asm/Kbuild         |  1 -
 arch/unicore32/include/asm/Kbuild  |  1 -
 arch/x86/include/asm/Kbuild        |  1 -
 arch/xtensa/include/asm/Kbuild     |  1 -
 drivers/clk/clk.h                  |  4 ++++
 drivers/clk/clkdev.c               |  2 +-
 drivers/clk/sunxi/clk-factors.c    | 26 +++++++++++++++++++++-----
 drivers/clk/sunxi/clk-factors.h    |  4 ++++
 drivers/clk/sunxi/clk-mod0.c       |  9 ++-------
 drivers/clk/sunxi/clk-sun8i-mbus.c |  7 ++-----
 drivers/clk/sunxi/clk-sun9i-core.c |  9 ++-------
 drivers/clk/sunxi/clk-sunxi.c      | 36 +++++++++++++-----------------------
 include/asm-generic/clkdev.h       | 30 ------------------------------
 include/linux/clkdev.h             |  7 +------
 41 files changed, 50 insertions(+), 131 deletions(-)
 delete mode 100644 arch/blackfin/include/asm/clkdev.h
 delete mode 100644 include/asm-generic/clkdev.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
