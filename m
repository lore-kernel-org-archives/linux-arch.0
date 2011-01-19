From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 35/37] sparc: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:50:09 -0000
Message-ID: <20110119210840.572978979@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=sparc-use-generic-irq-Kconfig.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6/arch/sparc/Kconfig
===================================================================
--- linux-2.6.orig/arch/sparc/Kconfig
+++ linux-2.6/arch/sparc/Kconfig
@@ -50,6 +50,7 @@ config SPARC64
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
+	select HAVE_GENERIC_HARDIRQS
 
 config ARCH_DEFCONFIG
 	string
@@ -272,10 +273,6 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
-config GENERIC_HARDIRQS
-	bool
-	default y if SPARC64
-
 source "kernel/time/Kconfig"
 
 if SPARC64
