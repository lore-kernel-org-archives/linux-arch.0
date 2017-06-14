From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 16/23] clocksource/drivers: Rename CLKSRC_OF to TIMER_OF
Date: Wed, 14 Jun 2017 14:39:37 +0200
Message-ID: <1497443984-12371-16-git-send-email-daniel.lezcano@linaro.org>
References: <20170614123800.GH2261@mai>
 <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX..." <bcm-kernel-feedback-list@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.>
List-Id: linux-arch.vger.kernel.org

The config option name is now renamed to 'TIMER_OF' for consistency with
the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                        | 10 +++---
 arch/arm/mach-bcm/Kconfig               |  2 +-
 arch/arm/mach-clps711x/Kconfig          |  2 +-
 arch/arm/mach-s3c24xx/Kconfig           |  2 +-
 arch/arm/mach-s3c64xx/Kconfig           |  2 +-
 arch/arm64/Kconfig.platforms            |  4 +--
 arch/h8300/Kconfig                      |  2 +-
 arch/microblaze/Kconfig                 |  2 +-
 arch/mips/ralink/Kconfig                |  2 +-
 arch/nios2/Kconfig                      |  2 +-
 arch/sh/boards/Kconfig                  |  2 +-
 drivers/clocksource/Kconfig             | 60 ++++++++++++++++-----------------
 drivers/clocksource/Makefile            |  2 +-
 drivers/clocksource/clksrc-probe.c      | 55 ------------------------------
 drivers/clocksource/clps711x-timer.c    |  2 +-
 drivers/clocksource/samsung_pwm_timer.c |  2 +-
 drivers/clocksource/timer-probe.c       | 55 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h       |  2 +-
 include/linux/clocksource.h             |  2 +-
 19 files changed, 106 insertions(+), 106 deletions(-)
 delete mode 100644 drivers/clocksource/clksrc-probe.c
 create mode 100644 drivers/clocksource/timer-probe.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f..1c7e165 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -337,7 +337,7 @@ config ARCH_MULTIPLATFORM
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
-	select CLKSRC_OF
+	select TIMER_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
@@ -351,7 +351,7 @@ config ARM_SINGLE_ARMV7M
 	depends on !MMU
 	select ARM_NVIC
 	select AUTO_ZRELADDR
-	select CLKSRC_OF
+	select TIMER_OF
 	select COMMON_CLK
 	select CPU_V7M
 	select GENERIC_CLOCKEVENTS
@@ -532,7 +532,7 @@ config ARCH_PXA
 	select CLKDEV_LOOKUP
 	select CLKSRC_PXA
 	select CLKSRC_MMIO
-	select CLKSRC_OF
+	select TIMER_OF
 	select CPU_XSCALE if !CPU_XSC3
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
@@ -571,7 +571,7 @@ config ARCH_SA1100
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_PXA
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	select CPU_FREQ
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
@@ -1357,7 +1357,7 @@ config HAVE_ARM_ARCH_TIMER
 
 config HAVE_ARM_TWD
 	bool
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f9389c5..f23a239 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -150,7 +150,7 @@ config ARCH_BCM2835
 	select ARM_ERRATA_411920 if ARCH_MULTI_V6
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
-	select CLKSRC_OF
+	select TIMER_OF
 	select BCM2835_TIMER
 	select PINCTRL
 	select PINCTRL_BCM2835
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index 61284b9..f385b1f 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -2,7 +2,7 @@ menuconfig ARCH_CLPS711X
 	bool "Cirrus Logic EP721x/EP731x-based"
 	depends on ARCH_MULTI_V4T
 	select AUTO_ZRELADDR
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLPS711X_TIMER
 	select COMMON_CLK
 	select CPU_ARM720T
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 4b1690a..f07da82 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -394,7 +394,7 @@ config MACH_SMDK2416
 
 config MACH_S3C2416_DT
 	bool "Samsung S3C2416 machine using devicetree"
-	select CLKSRC_OF
+	select TIMER_OF
 	select USE_OF
 	select PINCTRL
 	select PINCTRL_S3C24XX
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 459214f..71a4934 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -336,7 +336,7 @@ config MACH_WLF_CRAGG_6410
 
 config MACH_S3C64XX_DT
 	bool "Samsung S3C6400/S3C6410 machine using Device Tree"
-	select CLKSRC_OF
+	select TIMER_OF
 	select CPU_S3C6400
 	select CPU_S3C6410
 	select PINCTRL
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 73272f4..9ed0a65 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -18,7 +18,7 @@ config ARCH_ALPINE
 
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
-	select CLKSRC_OF
+	select TIMER_OF
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_BCM2835
@@ -178,7 +178,7 @@ config ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select CLKSRC_OF
+	select TIMER_OF
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
 	select PINCTRL
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3ae8525..6e3d36f 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -15,7 +15,7 @@ config H8300
 	select OF_IRQ
 	select OF_EARLY_FLATTREE
 	select HAVE_MEMBLOCK
-	select CLKSRC_OF
+	select TIMER_OF
 	select H8300_TMR8
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 85885a5..8e47121 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -4,7 +4,7 @@ config MICROBLAZE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
 	select GENERIC_ATOMIC64
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 9825dee..710b04c 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -4,7 +4,7 @@ config CLKEVT_RT3352
 	bool
 	depends on SOC_RT305X || SOC_MT7620
 	default y
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 
 config RALINK_ILL_ACC
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index a72d5f0..c587764 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,6 @@
 config NIOS2
 	def_bool y
-	select CLKSRC_OF
+	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 4e21949..3554fca 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -10,7 +10,7 @@ config SH_DEVICE_TREE
 	bool "Board Described by Device Tree"
 	select OF
 	select OF_EARLY_FLATTREE
-	select CLKSRC_OF
+	select TIMER_OF
 	select COMMON_CLK
 	select GENERIC_CALIBRATE_DELAY
 	help
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 623fcc6..90f062e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -1,15 +1,15 @@
 menu "Clock Source drivers"
 	depends on !ARCH_USES_GETTIMEOFFSET
 
-config CLKSRC_OF
+config TIMER_OF
 	bool
-	select CLKSRC_PROBE
+	select TIMER_PROBE
 
 config CLKSRC_ACPI
 	bool
-	select CLKSRC_PROBE
+	select TIMER_PROBE
 
-config CLKSRC_PROBE
+config TIMER_PROBE
 	bool
 
 config CLKSRC_I8253
@@ -58,14 +58,14 @@ config DW_APB_TIMER
 config DW_APB_TIMER_OF
 	bool
 	select DW_APB_TIMER
-	select CLKSRC_OF
+	select TIMER_OF
 
 config FTTMR010_TIMER
 	bool "Faraday Technology timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
-	select CLKSRC_OF
+	select TIMER_OF
 	select MFD_SYSCON
 	help
 	  Enables support for the Faraday Technology timer block
@@ -74,7 +74,7 @@ config FTTMR010_TIMER
 config ROCKCHIP_TIMER
 	bool "Rockchip timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Enables the support for the rockchip timer driver.
@@ -82,7 +82,7 @@ config ROCKCHIP_TIMER
 config ARMADA_370_XP_TIMER
 	bool "Armada 370 and XP timer driver" if COMPILE_TEST
 	depends on ARM
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Enables the support for the Armada 370 and XP timer driver.
@@ -97,7 +97,7 @@ config MESON6_TIMER
 config ORION_TIMER
 	bool "Orion timer driver" if COMPILE_TEST
 	depends on ARM
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Enables the support for the Orion timer driver
@@ -141,7 +141,7 @@ config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
-	select CLKSRC_OF
+	select TIMER_OF
 	help
 	  Enables support for the ASM9260 timer.
 
@@ -247,21 +247,21 @@ config CLKSRC_LPC32XX
 	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM
 	depends on ARM
 	select CLKSRC_MMIO
-	select CLKSRC_OF
+	select TIMER_OF
 	help
 	  Support for the LPC32XX clocksource.
 
 config CLKSRC_PISTACHIO
 	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
 	depends on HAS_IOMEM
-	select CLKSRC_OF
+	select TIMER_OF
 	help
 	  Enables the clocksource for the Pistachio SoC.
 
 config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
 	  available on many OMAP-like platforms.
@@ -270,7 +270,7 @@ config CLKSRC_NPS
 	bool "NPS400 clocksource driver" if COMPILE_TEST
 	depends on !PHYS_ADDR_T_64BIT
 	select CLKSRC_MMIO
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	help
 	  NPS400 clocksource support.
 	  Got 64 bit counter with update rate up to 1000MHz.
@@ -285,12 +285,12 @@ config CLKSRC_MPS2
 	bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK
 	select CLKSRC_MMIO
-	select CLKSRC_OF
+	select TIMER_OF
 
 config ARC_TIMERS
 	bool "Support for 32-bit TIMERn counters in ARC Cores" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
-	select CLKSRC_OF
+	select TIMER_OF
 	help
 	  These are legacy 32-bit TIMER0 and TIMER1 counters found on all ARC cores
 	  (ARC700 as well as ARC HS38).
@@ -300,7 +300,7 @@ config ARC_TIMERS_64BIT
 	bool "Support for 64-bit counters in ARC HS38 cores" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
 	depends on ARC_TIMERS
-	select CLKSRC_OF
+	select TIMER_OF
 	help
 	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP)
 	  RTC is implemented inside the core, while GFRC sits outside the core in
@@ -309,7 +309,7 @@ config ARC_TIMERS_64BIT
 
 config ARM_ARCH_TIMER
 	bool
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	select CLKSRC_ACPI if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
@@ -367,7 +367,7 @@ config ARM64_ERRATUM_858921
 
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	depends on ARM
 	help
 	  This options enables support for the ARM global timer unit
@@ -376,7 +376,7 @@ config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 
 config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	bool
@@ -387,19 +387,19 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 
 config ARMV7M_SYSTICK
 	bool "Support for the ARMv7M system time" if COMPILE_TEST
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	select CLKSRC_MMIO
 	help
 	  This options enables support for the ARMv7M system timer unit
 
 config ATMEL_PIT
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	def_bool SOC_AT91SAM9 || SOC_SAMA5
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
-	select CLKSRC_OF
+	select TIMER_OF
 	select MFD_SYSCON
 	help
 	  Support for the Atmel ST timer.
@@ -442,7 +442,7 @@ config VF_PIT_TIMER
 config OXNAS_RPS_TIMER
 	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
@@ -453,7 +453,7 @@ config SYS_SUPPORTS_SH_CMT
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Support for Mediatek timer driver.
@@ -526,7 +526,7 @@ config EM_TIMER_STI
 config CLKSRC_QCOM
 	bool "Qualcomm MSM timer" if COMPILE_TEST
 	depends on ARM
-	select CLKSRC_OF
+	select TIMER_OF
 	help
 	  This enables the clocksource and the per CPU clockevent driver for the
 	  Qualcomm SoCs.
@@ -534,7 +534,7 @@ config CLKSRC_QCOM
 config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
-	select CLKSRC_OF
+	select TIMER_OF
 	default y if MFD_VEXPRESS_SYSREG
 	help
 	  This option enables clock source based on free running
@@ -545,12 +545,12 @@ config CLKSRC_VERSATILE
 config CLKSRC_MIPS_GIC
 	bool
 	depends on MIPS_GIC
-	select CLKSRC_OF
+	select TIMER_OF
 
 config CLKSRC_TANGO_XTAL
 	bool "Clocksource for Tango SoC" if COMPILE_TEST
 	depends on ARM
-	select CLKSRC_OF
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  This enables the clocksource for Tango SoC
@@ -591,7 +591,7 @@ config CLKSRC_IMX_GPT
 
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
-	select CLKSRC_OF if OF
+	select TIMER_OF if OF
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cad713c..ec55921 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
+obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
deleted file mode 100644
index da81e5d..0000000
--- a/drivers/clocksource/clksrc-probe.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/clocksource.h>
-
-extern struct of_device_id __timer_of_table[];
-
-static const struct of_device_id __timer_of_table_sentinel
-	__used __section(__timer_of_table_end);
-
-void __init timer_probe(void)
-{
-	struct device_node *np;
-	const struct of_device_id *match;
-	of_init_fn_1_ret init_func_ret;
-	unsigned timers = 0;
-	int ret;
-
-	for_each_matching_node_and_match(np, __timer_of_table, &match) {
-		if (!of_device_is_available(np))
-			continue;
-
-		init_func_ret = match->data;
-
-		ret = init_func_ret(np);
-		if (ret) {
-			pr_err("Failed to initialize '%s': %d\n",
-			       of_node_full_name(np), ret);
-			continue;
-		}
-
-		timers++;
-	}
-
-	timers += acpi_probe_device_table(timer);
-
-	if (!timers)
-		pr_crit("%s: no matching timers found\n", __func__);
-}
diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index fc9e025..a8dd805 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -103,7 +103,7 @@ void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
 	BUG_ON(_clps711x_clkevt_init(tc2, tc2_base, irq));
 }
 
-#ifdef CONFIG_CLKSRC_OF
+#ifdef CONFIG_TIMER_OF
 static int __init clps711x_timer_init(struct device_node *np)
 {
 	unsigned int irq = irq_of_parse_and_map(np, 0);
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 21cd72c..6d5d126 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -418,7 +418,7 @@ void __init samsung_pwm_clocksource_init(void __iomem *base,
 	_samsung_pwm_clocksource_init();
 }
 
-#ifdef CONFIG_CLKSRC_OF
+#ifdef CONFIG_TIMER_OF
 static int __init samsung_pwm_alloc(struct device_node *np,
 				    const struct samsung_pwm_variant *variant)
 {
diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
new file mode 100644
index 0000000..da81e5d
--- /dev/null
+++ b/drivers/clocksource/timer-probe.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/clocksource.h>
+
+extern struct of_device_id __timer_of_table[];
+
+static const struct of_device_id __timer_of_table_sentinel
+	__used __section(__timer_of_table_end);
+
+void __init timer_probe(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	of_init_fn_1_ret init_func_ret;
+	unsigned timers = 0;
+	int ret;
+
+	for_each_matching_node_and_match(np, __timer_of_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		init_func_ret = match->data;
+
+		ret = init_func_ret(np);
+		if (ret) {
+			pr_err("Failed to initialize '%s': %d\n",
+			       of_node_full_name(np), ret);
+			continue;
+		}
+
+		timers++;
+	}
+
+	timers += acpi_probe_device_table(timer);
+
+	if (!timers)
+		pr_crit("%s: no matching timers found\n", __func__);
+}
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c6a4ef50..0d64658 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -172,7 +172,7 @@
 	KEEP(*(__##name##_of_table))					\
 	KEEP(*(__##name##_of_table_end))
 
-#define TIMER_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, timer)
+#define TIMER_OF_TABLES()	OF_TABLE(CONFIG_TIMER_OF, timer)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7cd38b2..c48ceef 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -252,7 +252,7 @@ extern int clocksource_i8253_init(void);
 #define TIMER_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1_RET(timer, name, compat, fn)
 
-#ifdef CONFIG_CLKSRC_PROBE
+#ifdef CONFIG_TIMER_PROBE
 extern void timer_probe(void);
 #else
 static inline void timer_probe(void) {}
-- 
2.7.4

