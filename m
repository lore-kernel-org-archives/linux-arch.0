From: akpm@linux-foundation.org
Subject: [patch 130/141] lib: consolidate DEBUG_PER_CPU_MAPS
Date: Tue, 24 May 2011 17:13:32 -0700
Message-ID: <201105250013.p4P0DW8E025213@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59214 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754753Ab1EYANw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 May 2011 20:13:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sboyd@codeaurora.org, benh@kernel.crashing.org, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de

From: Stephen Boyd <sboyd@codeaurora.org>

DEBUG_PER_CPU_MAPS is used in lib/cpumask.c as well as in
inlcude/linux/cpumask.h and thus it has outgrown its use within x86 and
powerpc alone.  Any arch with SMP support may want to get some more
debugging, so make this option generic.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/Kconfig.debug |   12 ------------
 arch/x86/Kconfig.debug     |   11 -----------
 lib/Kconfig.debug          |   11 +++++++++++
 3 files changed, 11 insertions(+), 23 deletions(-)

diff -puN arch/powerpc/Kconfig.debug~lib-consolidate-debug_per_cpu_maps arch/powerpc/Kconfig.debug
--- a/arch/powerpc/Kconfig.debug~lib-consolidate-debug_per_cpu_maps
+++ a/arch/powerpc/Kconfig.debug
@@ -44,18 +44,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUG_PER_CPU_MAPS
-	bool "Debug access to per_cpu maps"
-	depends on DEBUG_KERNEL
-	depends on SMP
-	default n
-	---help---
-	  Say Y to verify that the per_cpu map being accessed has
-	  been setup.  Adds a fair amount of code to kernel memory
-	  and decreases performance.
-
-	  Say N if unsure.
-
 config HCALL_STATS
 	bool "Hypervisor call instrumentation"
 	depends on PPC_PSERIES && DEBUG_FS && TRACEPOINTS
diff -puN arch/x86/Kconfig.debug~lib-consolidate-debug_per_cpu_maps arch/x86/Kconfig.debug
--- a/arch/x86/Kconfig.debug~lib-consolidate-debug_per_cpu_maps
+++ a/arch/x86/Kconfig.debug
@@ -75,17 +75,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUG_PER_CPU_MAPS
-	bool "Debug access to per_cpu maps"
-	depends on DEBUG_KERNEL
-	depends on SMP
-	---help---
-	  Say Y to verify that the per_cpu map being accessed has
-	  been setup.  Adds a fair amount of code to kernel memory
-	  and decreases performance.
-
-	  Say N if unsure.
-
 config X86_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
diff -puN lib/Kconfig.debug~lib-consolidate-debug_per_cpu_maps lib/Kconfig.debug
--- a/lib/Kconfig.debug~lib-consolidate-debug_per_cpu_maps
+++ a/lib/Kconfig.debug
@@ -983,6 +983,17 @@ config DEBUG_FORCE_WEAK_PER_CPU
 	  To ensure that generic code follows the above rules, this
 	  option forces all percpu variables to be defined as weak.
 
+config DEBUG_PER_CPU_MAPS
+	bool "Debug access to per_cpu maps"
+	depends on DEBUG_KERNEL
+	depends on SMP
+	help
+	  Say Y to verify that the per_cpu map being accessed has
+	  been set up. This adds a fair amount of code to kernel memory
+	  and decreases performance.
+
+	  Say N if unsure.
+
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_FS
_
