From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 33/37] powerpc: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:50:02 -0000
Message-ID: <20110119210840.471901095@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=powerpc-use-generic-irq-Kconfig.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -36,20 +36,12 @@ config GENERIC_TIME_VSYSCALL
 config GENERIC_CLOCKEVENTS
 	def_bool y
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool PPC64
 
 config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool PPC64
 
-config IRQ_PER_CPU
-	bool
-	default y
-
 config NR_IRQS
 	int "Number of virtual interrupt numbers"
 	range 32 32768
@@ -139,6 +131,9 @@ config PPC
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
+	select HAVE_GENERIC_HARDIRQS
+	select HAVE_SPARSE_IRQ
+	select IRQ_PER_CPU
 
 config EARLY_PRINTK
 	bool
@@ -388,19 +383,6 @@ config IRQ_ALL_CPUS
 	  CPU.  Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.
 
-config SPARSE_IRQ
-	bool "Support sparse irq numbering"
-	default n
-	help
-	  This enables support for sparse irqs. This is useful for distro
-	  kernels that want to define a high CONFIG_NR_CPUS value but still
-	  want to have low kernel memory footprint on smaller machines.
-
-	  ( Sparse IRQs can also be beneficial on NUMA boxes, as they spread
-	    out the irq_desc[] array in a more NUMA-friendly way. )
-
-	  If you don't know what to do here, say N.
-
 config NUMA
 	bool "NUMA support"
 	depends on PPC64
