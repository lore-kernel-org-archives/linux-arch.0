Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:6009 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbYBMWbC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2008 17:31:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so111588fga.17
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2008 14:31:00 -0800 (PST)
From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
Date: Wed, 13 Feb 2008 23:30:23 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200802132330.23817.alessandro.guido@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: davej@codemonkey.org.uk
Cc: cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>

---

 arch/arm/Kconfig                    |    4 ----
 arch/avr32/Kconfig                  |    4 ----
 arch/blackfin/Kconfig               |   12 ++----------
 arch/powerpc/platforms/Kconfig      |    5 ++---
 arch/sh/Kconfig                     |    4 ----
 arch/x86/kernel/cpu/cpufreq/Kconfig |    4 ----
 drivers/cpufreq/Kconfig             |    2 +-
 7 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9619c43..2e21703 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -948,8 +948,6 @@ endmenu
 
 if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_IMX || ARCH_PXA)
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_SA1100
@@ -988,8 +986,6 @@ config CPU_FREQ_PXA
 	default y
 	select CPU_FREQ_DEFAULT_GOV_USERSPACE
 
-endmenu
-
 endif
 
 menu "Floating point emulation"
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index c75d708..2274523 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -197,8 +197,6 @@ endmenu
 
 menu "Power management options"
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_AT32AP
@@ -214,8 +212,6 @@ config CPU_FREQ_AT32AP
 
 endmenu
 
-endmenu
-
 menu "Bus options"
 
 config PCI
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 589c6ac..c565d7c 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -964,18 +964,10 @@ endmenu
 
 if (BF537 || BF533 || BF54x)
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ
-	bool
-	default n
-	help
-	  If you want to enable this option, you should select the
-	  DPMC driver from Character Devices.
-endmenu
-
+comment "You should select the DPMC driver from Character Devices for this to work"
+	depends on CPU_FREQ
 endif
 
 source "net/Kconfig"
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fcedbec..f00f8d4 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -180,8 +180,7 @@ config GENERIC_IOMAP
 
 source "drivers/cpufreq/Kconfig"
 
-menu "CPU Frequency drivers"
-	depends on CPU_FREQ
+if CPU_FREQ
 
 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
@@ -209,7 +208,7 @@ config PPC_PASEMI_CPUFREQ
 	  This adds the support for frequency switching on PA Semi
 	  PWRficient processors.
 
-endmenu
+endif # CPU_FREQ
 
 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d87d4bf..a6a128c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -599,8 +599,6 @@ source "kernel/time/Kconfig"
 
 endmenu
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config SH_CPU_FREQ
@@ -615,8 +613,6 @@ config SH_CPU_FREQ
 
 	  If unsure, say N.
 
-endmenu
-
 source "arch/sh/drivers/Kconfig"
 
 endmenu
diff --git a/arch/x86/kernel/cpu/cpufreq/Kconfig b/arch/x86/kernel/cpu/cpufreq/Kconfig
index cb7a571..fc5254d 100644
--- a/arch/x86/kernel/cpu/cpufreq/Kconfig
+++ b/arch/x86/kernel/cpu/cpufreq/Kconfig
@@ -2,8 +2,6 @@
 # CPU Frequency scaling
 #
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 if CPU_FREQ
@@ -271,5 +269,3 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
 	  parameter "relaxed_check=1" is passed to the module.
 
 endif	# CPU_FREQ
-
-endmenu
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index c159ae6..ef80bd0 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -1,4 +1,4 @@
-config CPU_FREQ
+menuconfig CPU_FREQ
 	bool "CPU Frequency scaling"
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
