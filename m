From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 72/93] clocksources: Switch back to the clksrc table
Date: Thu,  7 Jul 2016 10:01:45 +0200
Message-ID: <1467878526-1238-72-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: tglx@linutronix.de, daniel.lezcano@linaro.org
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Vineet Gupta <vgupta@synopsys.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@st.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>, Santosh Shilimkar <ssantosh@kernel.org>, Noam Camus <noamca@mellanox.com>, Eric Anholt <eric@anholt.net>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org, kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org, bcm-ke
List-Id: linux-arch.vger.kernel.org

All the clocksource drivers's init function are now converted to return
an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the
clksrc-of table.

Let's convert back the names:
 - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
 - clksrc-of-ret              => clksrc-of

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

For exynos_mct and samsung_pwm_timer:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

For arch/arc:
Acked-by: Vineet Gupta <vgupta@synopsys.com>

For mediatek driver:
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>

For STi :
Acked-by: Patrice Chotard <patrice.chotard@st.com>

For the mps2-timer.c and versatile.c changes:
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

For the OXNAS part :
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

For LPC32xx driver:
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

For Broadcom Kona timer change:
Acked-by: Ray Jui <ray.jui@broadcom.com>

For Sun4i and Sun5i:
Acked-by: Chen-Yu Tsai <wens@csie.org>

For Meson6:
Acked-by: Carlo Caione <carlo@caione.org>

For Keystone:
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

For NPS:
Acked-by: Noam Camus <noamca@mellanox.com>

For bcm2835:
Acked-by: Eric Anholt <eric@anholt.net>
---
 arch/arc/kernel/time.c                    |  6 +++---
 arch/arm/kernel/smp_twd.c                 |  6 +++---
 arch/microblaze/kernel/timer.c            |  2 +-
 arch/mips/ralink/cevt-rt3352.c            |  2 +-
 arch/nios2/kernel/time.c                  |  2 +-
 drivers/clocksource/arm_arch_timer.c      |  6 +++---
 drivers/clocksource/arm_global_timer.c    |  2 +-
 drivers/clocksource/armv7m_systick.c      |  2 +-
 drivers/clocksource/asm9260_timer.c       |  2 +-
 drivers/clocksource/bcm2835_timer.c       |  2 +-
 drivers/clocksource/bcm_kona_timer.c      |  4 ++--
 drivers/clocksource/cadence_ttc_timer.c   |  2 +-
 drivers/clocksource/clksrc-dbx500-prcmu.c |  2 +-
 drivers/clocksource/clksrc-probe.c        | 14 --------------
 drivers/clocksource/clksrc_st_lpc.c       |  2 +-
 drivers/clocksource/clps711x-timer.c      |  2 +-
 drivers/clocksource/dw_apb_timer_of.c     |  8 ++++----
 drivers/clocksource/exynos_mct.c          |  4 ++--
 drivers/clocksource/fsl_ftm_timer.c       |  2 +-
 drivers/clocksource/h8300_timer16.c       |  2 +-
 drivers/clocksource/h8300_timer8.c        |  2 +-
 drivers/clocksource/h8300_tpu.c           |  2 +-
 drivers/clocksource/meson6_timer.c        |  2 +-
 drivers/clocksource/mips-gic-timer.c      |  2 +-
 drivers/clocksource/moxart_timer.c        |  2 +-
 drivers/clocksource/mps2-timer.c          |  2 +-
 drivers/clocksource/mtk_timer.c           |  2 +-
 drivers/clocksource/mxs_timer.c           |  2 +-
 drivers/clocksource/nomadik-mtu.c         |  2 +-
 drivers/clocksource/pxa_timer.c           |  2 +-
 drivers/clocksource/qcom-timer.c          |  4 ++--
 drivers/clocksource/rockchip_timer.c      |  8 ++++----
 drivers/clocksource/samsung_pwm_timer.c   |  8 ++++----
 drivers/clocksource/sun4i_timer.c         |  2 +-
 drivers/clocksource/tango_xtal.c          |  2 +-
 drivers/clocksource/tegra20_timer.c       |  4 ++--
 drivers/clocksource/time-armada-370-xp.c  |  6 +++---
 drivers/clocksource/time-efm32.c          |  4 ++--
 drivers/clocksource/time-lpc32xx.c        |  2 +-
 drivers/clocksource/time-orion.c          |  2 +-
 drivers/clocksource/time-pistachio.c      |  2 +-
 drivers/clocksource/timer-atlas7.c        |  2 +-
 drivers/clocksource/timer-atmel-pit.c     |  2 +-
 drivers/clocksource/timer-atmel-st.c      |  2 +-
 drivers/clocksource/timer-digicolor.c     |  2 +-
 drivers/clocksource/timer-imx-gpt.c       | 24 ++++++++++++------------
 drivers/clocksource/timer-integrator-ap.c |  2 +-
 drivers/clocksource/timer-keystone.c      |  2 +-
 drivers/clocksource/timer-nps.c           |  4 ++--
 drivers/clocksource/timer-oxnas-rps.c     |  4 ++--
 drivers/clocksource/timer-prima2.c        |  2 +-
 drivers/clocksource/timer-sp804.c         |  4 ++--
 drivers/clocksource/timer-stm32.c         |  2 +-
 drivers/clocksource/timer-sun5i.c         |  4 ++--
 drivers/clocksource/timer-ti-32k.c        |  2 +-
 drivers/clocksource/timer-u300.c          |  2 +-
 drivers/clocksource/versatile.c           |  4 ++--
 drivers/clocksource/vf_pit_timer.c        |  2 +-
 drivers/clocksource/vt8500_timer.c        |  2 +-
 drivers/clocksource/zevio-timer.c         |  2 +-
 include/asm-generic/vmlinux.lds.h         |  2 --
 include/linux/clocksource.h               |  5 +----
 62 files changed, 98 insertions(+), 117 deletions(-)

diff --git a/arch/arc/kernel/time.c b/arch/arc/kernel/time.c
index 09de669..98f22d2 100644
--- a/arch/arc/kernel/time.c
+++ b/arch/arc/kernel/time.c
@@ -130,7 +130,7 @@ static int __init arc_cs_setup_gfrc(struct device_node *node)
 
 	return clocksource_register_hz(&arc_counter_gfrc, arc_timer_freq);
 }
-CLOCKSOURCE_OF_DECLARE_RET(arc_gfrc, "snps,archs-timer-gfrc", arc_cs_setup_gfrc);
+CLOCKSOURCE_OF_DECLARE(arc_gfrc, "snps,archs-timer-gfrc", arc_cs_setup_gfrc);
 
 #endif
 
@@ -192,7 +192,7 @@ static int __init arc_cs_setup_rtc(struct device_node *node)
 
 	return clocksource_register_hz(&arc_counter_rtc, arc_timer_freq);
 }
-CLOCKSOURCE_OF_DECLARE_RET(arc_rtc, "snps,archs-timer-rtc", arc_cs_setup_rtc);
+CLOCKSOURCE_OF_DECLARE(arc_rtc, "snps,archs-timer-rtc", arc_cs_setup_rtc);
 
 #endif
 
@@ -379,7 +379,7 @@ static int __init arc_of_timer_init(struct device_node *np)
 
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(arc_clkevt, "snps,arc-timer", arc_of_timer_init);
+CLOCKSOURCE_OF_DECLARE(arc_clkevt, "snps,arc-timer", arc_of_timer_init);
 
 /*
  * Called from start_kernel() - boot CPU only
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2b24be4..b6ec65e 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -412,7 +412,7 @@ out:
 	WARN(err, "twd_local_timer_of_register failed (%d)\n", err);
 	return err;
 }
-CLOCKSOURCE_OF_DECLARE_RET(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
-CLOCKSOURCE_OF_DECLARE_RET(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
-CLOCKSOURCE_OF_DECLARE_RET(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);
 #endif
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index 7f35e7b..5bbf38b 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -332,5 +332,5 @@ static int __init xilinx_timer_init(struct device_node *timer)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(xilinx_timer, "xlnx,xps-timer-1.00.a",
+CLOCKSOURCE_OF_DECLARE(xilinx_timer, "xlnx,xps-timer-1.00.a",
 		       xilinx_timer_init);
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index f2d3c79..f24eee0 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -150,4 +150,4 @@ static int __init ralink_systick_init(struct device_node *np)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(systick, "ralink,cevt-systick", ralink_systick_init);
+CLOCKSOURCE_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index b75e40e..d9563dd 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -352,4 +352,4 @@ void __init time_init(void)
 	clocksource_probe();
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(nios2_timer, ALTR_TIMER_COMPATIBLE, nios2_time_init);
+CLOCKSOURCE_OF_DECLARE(nios2_timer, ALTR_TIMER_COMPATIBLE, nios2_time_init);
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d0cda68..9e33309 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -784,8 +784,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	return arch_timer_init();
 }
-CLOCKSOURCE_OF_DECLARE_RET(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
-CLOCKSOURCE_OF_DECLARE_RET(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
+CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
+CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
 static int __init arch_timer_mem_init(struct device_node *np)
 {
@@ -868,7 +868,7 @@ out:
 	of_node_put(best_frame);
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(armv7_arch_timer_mem, "arm,armv7-timer-mem",
+CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 40104fc..2a9ceb6 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -358,5 +358,5 @@ out_unmap:
 }
 
 /* Only tested on r2p2 and r3p0  */
-CLOCKSOURCE_OF_DECLARE_RET(arm_gt, "arm,cortex-a9-global-timer",
+CLOCKSOURCE_OF_DECLARE(arm_gt, "arm,cortex-a9-global-timer",
 			global_timer_of_register);
diff --git a/drivers/clocksource/armv7m_systick.c b/drivers/clocksource/armv7m_systick.c
index 2b55410..e93af1f 100644
--- a/drivers/clocksource/armv7m_systick.c
+++ b/drivers/clocksource/armv7m_systick.c
@@ -81,5 +81,5 @@ out_unmap:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(arm_systick, "arm,armv7m-systick",
+CLOCKSOURCE_OF_DECLARE(arm_systick, "arm,armv7m-systick",
 			system_timer_of_register);
diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index d113c02..1ba871b 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -238,5 +238,5 @@ static int __init asm9260_timer_init(struct device_node *np)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(asm9260_timer, "alphascale,asm9260-timer",
+CLOCKSOURCE_OF_DECLARE(asm9260_timer, "alphascale,asm9260-timer",
 		asm9260_timer_init);
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 2dcf896..e71acf2 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -142,5 +142,5 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(bcm2835, "brcm,bcm2835-system-timer",
+CLOCKSOURCE_OF_DECLARE(bcm2835, "brcm,bcm2835-system-timer",
 			bcm2835_timer_init);
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index c251aa6..86f87be3d 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -195,9 +195,9 @@ static int __init kona_timer_init(struct device_node *node)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(brcm_kona, "brcm,kona-timer", kona_timer_init);
+CLOCKSOURCE_OF_DECLARE(brcm_kona, "brcm,kona-timer", kona_timer_init);
 /*
  * bcm,kona-timer is deprecated by brcm,kona-timer
  * being kept here for driver compatibility
  */
-CLOCKSOURCE_OF_DECLARE_RET(bcm_kona, "bcm,kona-timer", kona_timer_init);
+CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer", kona_timer_init);
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index e2e7631..388a77b 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -539,4 +539,4 @@ static int __init ttc_timer_init(struct device_node *timer)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(ttc, "cdns,ttc", ttc_timer_init);
+CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 5a59d29..77a365f 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -86,5 +86,5 @@ static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 #endif
 	return clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
-CLOCKSOURCE_OF_DECLARE_RET(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
+CLOCKSOURCE_OF_DECLARE(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
 		       clksrc_dbx500_prcmu_init);
diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index 5fa6a55..bc62be9 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -20,19 +20,14 @@
 #include <linux/clocksource.h>
 
 extern struct of_device_id __clksrc_of_table[];
-extern struct of_device_id __clksrc_ret_of_table[];
 
 static const struct of_device_id __clksrc_of_table_sentinel
 	__used __section(__clksrc_of_table_end);
 
-static const struct of_device_id __clksrc_ret_of_table_sentinel
-	__used __section(__clksrc_ret_of_table_end);
-
 void __init clocksource_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
-	of_init_fn_1 init_func;
 	of_init_fn_1_ret init_func_ret;
 	unsigned clocksources = 0;
 	int ret;
@@ -41,15 +36,6 @@ void __init clocksource_probe(void)
 		if (!of_device_is_available(np))
 			continue;
 
-		init_func = match->data;
-		init_func(np);
-		clocksources++;
-	}
-
-	for_each_matching_node_and_match(np, __clksrc_ret_of_table, &match) {
-		if (!of_device_is_available(np))
-			continue;
-
 		init_func_ret = match->data;
 
 		ret = init_func_ret(np);
diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index c9022a9..03cc492 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -132,4 +132,4 @@ static int __init st_clksrc_of_register(struct device_node *np)
 
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(ddata, "st,stih407-lpc", st_clksrc_of_register);
+CLOCKSOURCE_OF_DECLARE(ddata, "st,stih407-lpc", st_clksrc_of_register);
diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index 3b66198..84aed78 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -119,5 +119,5 @@ static int __init clps711x_timer_init(struct device_node *np)
 		return -EINVAL;
 	}
 }
-CLOCKSOURCE_OF_DECLARE_RET(clps711x, "cirrus,clps711x-timer", clps711x_timer_init);
+CLOCKSOURCE_OF_DECLARE(clps711x, "cirrus,clps711x-timer", clps711x_timer_init);
 #endif
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 4985a2c..aee6c0d 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -167,7 +167,7 @@ static int __init dw_apb_timer_init(struct device_node *timer)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(pc3x2_timer, "picochip,pc3x2-timer", dw_apb_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(apb_timer_osc, "snps,dw-apb-timer-osc", dw_apb_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(apb_timer_sp, "snps,dw-apb-timer-sp", dw_apb_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(apb_timer, "snps,dw-apb-timer", dw_apb_timer_init);
+CLOCKSOURCE_OF_DECLARE(pc3x2_timer, "picochip,pc3x2-timer", dw_apb_timer_init);
+CLOCKSOURCE_OF_DECLARE(apb_timer_osc, "snps,dw-apb-timer-osc", dw_apb_timer_init);
+CLOCKSOURCE_OF_DECLARE(apb_timer_sp, "snps,dw-apb-timer-sp", dw_apb_timer_init);
+CLOCKSOURCE_OF_DECLARE(apb_timer, "snps,dw-apb-timer", dw_apb_timer_init);
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index f6caed0..0d18dd4b 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -627,5 +627,5 @@ static int __init mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-CLOCKSOURCE_OF_DECLARE_RET(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
-CLOCKSOURCE_OF_DECLARE_RET(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
+CLOCKSOURCE_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
+CLOCKSOURCE_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
index 9ad4ca3..738515b 100644
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -369,4 +369,4 @@ err:
 	kfree(priv);
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(flextimer, "fsl,ftm-timer", ftm_timer_init);
+CLOCKSOURCE_OF_DECLARE(flextimer, "fsl,ftm-timer", ftm_timer_init);
diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index 9d99fc8..07d9d5b 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -187,5 +187,5 @@ free_clk:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(h8300_16bit, "renesas,16bit-timer",
+CLOCKSOURCE_OF_DECLARE(h8300_16bit, "renesas,16bit-timer",
 			   h8300_16timer_init);
diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 0292a19..546bb18 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -215,4 +215,4 @@ free_clk:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(h8300_8bit, "renesas,8bit-timer", h8300_8timer_init);
+CLOCKSOURCE_OF_DECLARE(h8300_8bit, "renesas,8bit-timer", h8300_8timer_init);
diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
index 4faf718..7bdf199 100644
--- a/drivers/clocksource/h8300_tpu.c
+++ b/drivers/clocksource/h8300_tpu.c
@@ -154,4 +154,4 @@ free_clk:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(h8300_tpu, "renesas,tpu", h8300_tpu_init);
+CLOCKSOURCE_OF_DECLARE(h8300_tpu, "renesas,tpu", h8300_tpu_init);
diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 3a6e78f..52af591 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -174,5 +174,5 @@ static int __init meson6_timer_init(struct device_node *node)
 					1, 0xfffe);
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(meson6, "amlogic,meson6-timer",
+CLOCKSOURCE_OF_DECLARE(meson6, "amlogic,meson6-timer",
 		       meson6_timer_init);
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b164b87..1572c7a 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -222,5 +222,5 @@ static void __init gic_clocksource_of_init(struct device_node *node)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(mips_gic_timer, "mti,gic-timer",
+CLOCKSOURCE_OF_DECLARE(mips_gic_timer, "mti,gic-timer",
 		       gic_clocksource_of_init);
diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index b9c30cd..8414544 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -178,4 +178,4 @@ static int __init moxart_timer_init(struct device_node *node)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(moxart, "moxa,moxart-timer", moxart_timer_init);
+CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);
diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
index c303fa9..3e4431e 100644
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -274,4 +274,4 @@ static int __init mps2_timer_init(struct device_node *np)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(mps2_timer, "arm,mps2-timer", mps2_timer_init);
+CLOCKSOURCE_OF_DECLARE(mps2_timer, "arm,mps2-timer", mps2_timer_init);
diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 432a2c0..9065949 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -265,4 +265,4 @@ err_kzalloc:
 
 	return -EINVAL;
 }
-CLOCKSOURCE_OF_DECLARE_RET(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
+CLOCKSOURCE_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index 17b9d19..630a8d3 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -295,4 +295,4 @@ static int __init mxs_timer_init(struct device_node *np)
 
 	return setup_irq(irq, &mxs_timer_irq);
 }
-CLOCKSOURCE_OF_DECLARE_RET(mxs, "fsl,timrot", mxs_timer_init);
+CLOCKSOURCE_OF_DECLARE(mxs, "fsl,timrot", mxs_timer_init);
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index d2be5b3..3c124d1 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -284,5 +284,5 @@ static int __init nmdk_timer_of_init(struct device_node *node)
 
 	return nmdk_timer_init(base, irq, pclk, clk);
 }
-CLOCKSOURCE_OF_DECLARE_RET(nomadik_mtu, "st,nomadik-mtu",
+CLOCKSOURCE_OF_DECLARE(nomadik_mtu, "st,nomadik-mtu",
 		       nmdk_timer_of_init);
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 59af75c..937e10b 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -213,7 +213,7 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 
 	return pxa_timer_common_init(irq, clk_get_rate(clk));
 }
-CLOCKSOURCE_OF_DECLARE_RET(pxa_timer, "marvell,pxa-timer", pxa_timer_dt_init);
+CLOCKSOURCE_OF_DECLARE(pxa_timer, "marvell,pxa-timer", pxa_timer_dt_init);
 
 /*
  * Legacy timer init for non device-tree boards.
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
index 79f73bd..6625763 100644
--- a/drivers/clocksource/qcom-timer.c
+++ b/drivers/clocksource/qcom-timer.c
@@ -273,5 +273,5 @@ static int __init msm_dt_timer_init(struct device_node *np)
 
 	return msm_timer_init(freq, 32, irq, !!percpu_offset);
 }
-CLOCKSOURCE_OF_DECLARE_RET(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
+CLOCKSOURCE_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
+CLOCKSOURCE_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 85aee69..23e267a 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -205,7 +205,7 @@ static int __init rk3399_timer_init(struct device_node *np)
 	return rk_timer_init(np, TIMER_CONTROL_REG3399);
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(rk3288_timer, "rockchip,rk3288-timer",
-			   rk3288_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(rk3399_timer, "rockchip,rk3399-timer",
-			   rk3399_timer_init);
+CLOCKSOURCE_OF_DECLARE(rk3288_timer, "rockchip,rk3288-timer",
+		       rk3288_timer_init);
+CLOCKSOURCE_OF_DECLARE(rk3399_timer, "rockchip,rk3399-timer",
+		       rk3399_timer_init);
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 27a9797..54565bd 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -466,7 +466,7 @@ static int __init s3c2410_pwm_clocksource_init(struct device_node *np)
 {
 	return samsung_pwm_alloc(np, &s3c24xx_variant);
 }
-CLOCKSOURCE_OF_DECLARE_RET(s3c2410_pwm, "samsung,s3c2410-pwm", s3c2410_pwm_clocksource_init);
+CLOCKSOURCE_OF_DECLARE(s3c2410_pwm, "samsung,s3c2410-pwm", s3c2410_pwm_clocksource_init);
 
 static const struct samsung_pwm_variant s3c64xx_variant = {
 	.bits		= 32,
@@ -479,7 +479,7 @@ static int __init s3c64xx_pwm_clocksource_init(struct device_node *np)
 {
 	return samsung_pwm_alloc(np, &s3c64xx_variant);
 }
-CLOCKSOURCE_OF_DECLARE_RET(s3c6400_pwm, "samsung,s3c6400-pwm", s3c64xx_pwm_clocksource_init);
+CLOCKSOURCE_OF_DECLARE(s3c6400_pwm, "samsung,s3c6400-pwm", s3c64xx_pwm_clocksource_init);
 
 static const struct samsung_pwm_variant s5p64x0_variant = {
 	.bits		= 32,
@@ -492,7 +492,7 @@ static int __init s5p64x0_pwm_clocksource_init(struct device_node *np)
 {
 	return samsung_pwm_alloc(np, &s5p64x0_variant);
 }
-CLOCKSOURCE_OF_DECLARE_RET(s5p6440_pwm, "samsung,s5p6440-pwm", s5p64x0_pwm_clocksource_init);
+CLOCKSOURCE_OF_DECLARE(s5p6440_pwm, "samsung,s5p6440-pwm", s5p64x0_pwm_clocksource_init);
 
 static const struct samsung_pwm_variant s5p_variant = {
 	.bits		= 32,
@@ -505,5 +505,5 @@ static int __init s5p_pwm_clocksource_init(struct device_node *np)
 {
 	return samsung_pwm_alloc(np, &s5p_variant);
 }
-CLOCKSOURCE_OF_DECLARE_RET(s5pc100_pwm, "samsung,s5pc100-pwm", s5p_pwm_clocksource_init);
+CLOCKSOURCE_OF_DECLARE(s5pc100_pwm, "samsung,s5pc100-pwm", s5p_pwm_clocksource_init);
 #endif
diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 4453730..97669ee 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -226,5 +226,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(sun4i, "allwinner,sun4i-a10-timer",
+CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
diff --git a/drivers/clocksource/tango_xtal.c b/drivers/clocksource/tango_xtal.c
index 7dc716c..12fcef8 100644
--- a/drivers/clocksource/tango_xtal.c
+++ b/drivers/clocksource/tango_xtal.c
@@ -53,4 +53,4 @@ static int __init tango_clocksource_init(struct device_node *np)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(tango, "sigma,tick-counter", tango_clocksource_init);
+CLOCKSOURCE_OF_DECLARE(tango, "sigma,tick-counter", tango_clocksource_init);
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 543c37e..f960891 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -237,7 +237,7 @@ static int __init tegra20_init_timer(struct device_node *np)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
+CLOCKSOURCE_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 
 static int __init tegra20_init_rtc(struct device_node *np)
 {
@@ -261,4 +261,4 @@ static int __init tegra20_init_rtc(struct device_node *np)
 
 	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
 }
-CLOCKSOURCE_OF_DECLARE_RET(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
+CLOCKSOURCE_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index bc4ab48..a4e5923 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -371,7 +371,7 @@ static int __init armada_xp_timer_init(struct device_node *np)
 
 	return armada_370_xp_timer_common_init(np);
 }
-CLOCKSOURCE_OF_DECLARE_RET(armada_xp, "marvell,armada-xp-timer",
+CLOCKSOURCE_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
 		       armada_xp_timer_init);
 
 static int __init armada_375_timer_init(struct device_node *np)
@@ -409,7 +409,7 @@ static int __init armada_375_timer_init(struct device_node *np)
 
 	return armada_370_xp_timer_common_init(np);
 }
-CLOCKSOURCE_OF_DECLARE_RET(armada_375, "marvell,armada-375-timer",
+CLOCKSOURCE_OF_DECLARE(armada_375, "marvell,armada-375-timer",
 		       armada_375_timer_init);
 
 static int __init armada_370_timer_init(struct device_node *np)
@@ -432,5 +432,5 @@ static int __init armada_370_timer_init(struct device_node *np)
 
 	return armada_370_xp_timer_common_init(np);
 }
-CLOCKSOURCE_OF_DECLARE_RET(armada_370, "marvell,armada-370-timer",
+CLOCKSOURCE_OF_DECLARE(armada_370, "marvell,armada-370-timer",
 		       armada_370_timer_init);
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index 6e2f79f..5ac344b 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -283,5 +283,5 @@ static int __init efm32_timer_init(struct device_node *np)
 
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(efm32compat, "efm32,timer", efm32_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(efm32, "energymicro,efm32-timer", efm32_timer_init);
+CLOCKSOURCE_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
+CLOCKSOURCE_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index cb5b866..9649cfd 100644
--- a/drivers/clocksource/time-lpc32xx.c
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -311,4 +311,4 @@ static int __init lpc32xx_timer_init(struct device_node *np)
 
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
+CLOCKSOURCE_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index 5fdeb5d..a28f496 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -167,4 +167,4 @@ static int __init orion_timer_init(struct device_node *np)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(orion_timer, "marvell,orion-timer", orion_timer_init);
+CLOCKSOURCE_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index adaaec5..a7d9a08 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -214,5 +214,5 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 	sched_clock_register(pistachio_read_sched_clock, 32, rate);
 	return clocksource_register_hz(&pcs_gpt.cs, rate);
 }
-CLOCKSOURCE_OF_DECLARE_RET(pistachio_gptimer, "img,pistachio-gptimer",
+CLOCKSOURCE_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
 		       pistachio_clksrc_of_init);
diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
index 7b1a007..90f8fbc 100644
--- a/drivers/clocksource/timer-atlas7.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -304,4 +304,4 @@ static int __init sirfsoc_of_timer_init(struct device_node *np)
 
 	return sirfsoc_atlas7_timer_init(np);
 }
-CLOCKSOURCE_OF_DECLARE_RET(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
+CLOCKSOURCE_OF_DECLARE(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index ffaca7c..1ffac0c 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -270,5 +270,5 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 
 	return at91sam926x_pit_common_init(data);
 }
-CLOCKSOURCE_OF_DECLARE_RET(at91sam926x_pit, "atmel,at91sam9260-pit",
+CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);
diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index e9331d3..e90ab5b 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -260,5 +260,5 @@ static int __init atmel_st_timer_init(struct device_node *node)
 	/* register clocksource */
 	return clocksource_register_hz(&clk32k, sclk_rate);
 }
-CLOCKSOURCE_OF_DECLARE_RET(atmel_st_timer, "atmel,at91rm9200-st",
+CLOCKSOURCE_OF_DECLARE(atmel_st_timer, "atmel,at91rm9200-st",
 		       atmel_st_timer_init);
diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index b929061..10318cc 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -202,5 +202,5 @@ static int __init digicolor_timer_init(struct device_node *node)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(conexant_digicolor, "cnxt,cx92755-timer",
+CLOCKSOURCE_OF_DECLARE(conexant_digicolor, "cnxt,cx92755-timer",
 		       digicolor_timer_init);
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index d5640a74..f595460 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -545,15 +545,15 @@ static int __init imx6dl_timer_init_dt(struct device_node *np)
 	return mxc_timer_init_dt(np, GPT_TYPE_IMX6DL);
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(imx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx21_timer, "fsl,imx21-gpt", imx21_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx27_timer, "fsl,imx27-gpt", imx21_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx31_timer, "fsl,imx31-gpt", imx31_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx25_timer, "fsl,imx25-gpt", imx31_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx50_timer, "fsl,imx50-gpt", imx31_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx51_timer, "fsl,imx51-gpt", imx31_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx53_timer, "fsl,imx53-gpt", imx31_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx6q_timer, "fsl,imx6q-gpt", imx31_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx6dl_timer, "fsl,imx6dl-gpt", imx6dl_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx6sl_timer, "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE_RET(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx21_timer, "fsl,imx21-gpt", imx21_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx27_timer, "fsl,imx27-gpt", imx21_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx31_timer, "fsl,imx31-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx25_timer, "fsl,imx25-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx50_timer, "fsl,imx50-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx51_timer, "fsl,imx51-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx53_timer, "fsl,imx53-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6q_timer, "fsl,imx6q-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt", imx6dl_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6sl_timer, "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 675face..df6e672 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -232,5 +232,5 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(integrator_ap_timer, "arm,integrator-timer",
+CLOCKSOURCE_OF_DECLARE(integrator_ap_timer, "arm,integrator-timer",
 		       integrator_ap_timer_init_of);
diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 4199823..ab68a47 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -226,5 +226,5 @@ err:
 	return error;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(keystone_timer, "ti,keystone-timer",
+CLOCKSOURCE_OF_DECLARE(keystone_timer, "ti,keystone-timer",
 			   keystone_timer_init);
diff --git a/drivers/clocksource/timer-nps.c b/drivers/clocksource/timer-nps.c
index b5c7b2b..70c149a 100644
--- a/drivers/clocksource/timer-nps.c
+++ b/drivers/clocksource/timer-nps.c
@@ -96,5 +96,5 @@ static int __init nps_timer_init(struct device_node *node)
 	return nps_setup_clocksource(node, clk);
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(ezchip_nps400_clksrc, "ezchip,nps400-timer",
-			   nps_timer_init);
+CLOCKSOURCE_OF_DECLARE(ezchip_nps400_clksrc, "ezchip,nps400-timer",
+		       nps_timer_init);
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index 0d99f40..bd887e2 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -293,5 +293,5 @@ err_alloc:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(ox810se_rps,
-			   "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
+CLOCKSOURCE_OF_DECLARE(ox810se_rps,
+		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 7b1084d..dae8a66 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -246,5 +246,5 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(sirfsoc_prima2_timer,
+CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer,
 	"sirf,prima2-tick", sirfsoc_prima2_timer_init);
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 3dc47ef..d078633 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -287,7 +287,7 @@ err:
 	iounmap(base);
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(sp804, "arm,sp804", sp804_of_init);
+CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
 
 static int __init integrator_cp_of_init(struct device_node *np)
 {
@@ -335,4 +335,4 @@ err:
 	iounmap(base);
 	return ret;
 }
-CLOCKSOURCE_OF_DECLARE_RET(intcp, "arm,integrator-cp-timer", integrator_cp_of_init);
+CLOCKSOURCE_OF_DECLARE(intcp, "arm,integrator-cp-timer", integrator_cp_of_init);
diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index d5bf352..1b2574c 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -187,4 +187,4 @@ err_clk_get:
 	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(stm32, "st,stm32-timer", stm32_clockevent_init);
+CLOCKSOURCE_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index f0a3ffb..c184eb8 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -346,7 +346,7 @@ static int __init sun5i_timer_init(struct device_node *node)
 
 	return sun5i_setup_clockevent(node, timer_base, clk, irq);
 }
-CLOCKSOURCE_OF_DECLARE_RET(sun5i_a13, "allwinner,sun5i-a13-hstimer",
+CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
 			   sun5i_timer_init);
-CLOCKSOURCE_OF_DECLARE_RET(sun7i_a20, "allwinner,sun7i-a20-hstimer",
+CLOCKSOURCE_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
 			   sun5i_timer_init);
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index e4ad3c6e..92b7e39 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -124,5 +124,5 @@ static int __init ti_32k_timer_init(struct device_node *np)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(ti_32k_timer, "ti,omap-counter32k",
+CLOCKSOURCE_OF_DECLARE(ti_32k_timer, "ti,omap-counter32k",
 		ti_32k_timer_init);
diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index a6a0dec..704e40c 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -458,5 +458,5 @@ static int __init u300_timer_init_of(struct device_node *np)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(u300_timer, "stericsson,u300-apptimer",
+CLOCKSOURCE_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
 		       u300_timer_init_of);
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/versatile.c
index 8daeffa..220b490 100644
--- a/drivers/clocksource/versatile.c
+++ b/drivers/clocksource/versatile.c
@@ -38,7 +38,7 @@ static int __init versatile_sched_clock_init(struct device_node *node)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE_RET(vexpress, "arm,vexpress-sysreg",
+CLOCKSOURCE_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
 		       versatile_sched_clock_init);
-CLOCKSOURCE_OF_DECLARE_RET(versatile, "arm,versatile-sysreg",
+CLOCKSOURCE_OF_DECLARE(versatile, "arm,versatile-sysreg",
 		       versatile_sched_clock_init);
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index ca4dff4..55d8d84 100644
--- a/drivers/clocksource/vf_pit_timer.c
+++ b/drivers/clocksource/vf_pit_timer.c
@@ -201,4 +201,4 @@ static int __init pit_timer_init(struct device_node *np)
 
 	return pit_clockevent_init(clk_rate, irq);
 }
-CLOCKSOURCE_OF_DECLARE_RET(vf610, "fsl,vf610-pit", pit_timer_init);
+CLOCKSOURCE_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 1bc8707..b150694 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -165,4 +165,4 @@ static int __init vt8500_timer_init(struct device_node *np)
 	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(vt8500, "via,vt8500-timer", vt8500_timer_init);
+CLOCKSOURCE_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index cb4cf056..9a53f5e 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -215,4 +215,4 @@ static int __init zevio_timer_init(struct device_node *node)
 	return zevio_timer_add(node);
 }
 
-CLOCKSOURCE_OF_DECLARE_RET(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
+CLOCKSOURCE_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8c6c626..6a67ab9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -173,7 +173,6 @@
 	*(__##name##_of_table_end)
 
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
-#define CLKSRC_RET_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc_ret)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
@@ -532,7 +531,6 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	CLKSRC_OF_TABLES()						\
-	CLKSRC_RET_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 15c3839..0839818 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -244,10 +244,7 @@ extern int clocksource_mmio_init(void __iomem *, const char *,
 extern int clocksource_i8253_init(void);
 
 #define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \
-	OF_DECLARE_1(clksrc, name, compat, fn)
-
-#define CLOCKSOURCE_OF_DECLARE_RET(name, compat, fn) \
-	OF_DECLARE_1_RET(clksrc_ret, name, compat, fn)
+	OF_DECLARE_1_RET(clksrc, name, compat, fn)
 
 #ifdef CONFIG_CLKSRC_PROBE
 extern void clocksource_probe(void);
-- 
1.9.1
