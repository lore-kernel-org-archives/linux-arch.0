From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 28/37] ia64: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:49:45 -0000
Message-ID: <20110119210840.241519669@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=ia64-use-generic-irq-Kconfig.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/ia64/Kconfig |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig
+++ linux-2.6/arch/ia64/Kconfig
@@ -22,6 +22,10 @@ config IA64
 	select HAVE_KVM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_IRQ_PROBE
+	select GENERIC_PENDING_IRQ if SMP
+	select IRQ_PER_CPU
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
@@ -678,25 +682,6 @@ source "arch/ia64/kvm/Kconfig"
 
 source "lib/Kconfig"
 
-#
-# Use the generic interrupt handling code in kernel/irq/:
-#
-config GENERIC_HARDIRQS
-	def_bool y
-
-config GENERIC_IRQ_PROBE
-	bool
-	default y
-
-config GENERIC_PENDING_IRQ
-	bool
-	depends on GENERIC_HARDIRQS && SMP
-	default y
-
-config IRQ_PER_CPU
-	bool
-	default y
-
 config IOMMU_HELPER
 	def_bool (IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB || IA64_GENERIC || SWIOTLB)
 
