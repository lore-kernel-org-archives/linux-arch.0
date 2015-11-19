From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] Kconfig: remove HAVE_LATENCYTOP_SUPPORT
Date: Thu, 19 Nov 2015 18:11:04 +0000
Message-ID: <1447956664-2553-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37028 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754690AbbKSSLw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Nov 2015 13:11:52 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

As illustrated by a3afe70b83fd ("[S390] latencytop s390 support."),
HAVE_LATENCYTOP_SUPPORT is defined by an architecture to advertise an
implementation of save_stack_trace_tsk.

However, as of 9212ddb5eada ("stacktrace: provide save_stack_trace_tsk()
weak alias") a dummy implementation is provided if STACKTRACE=y.
Given that LATENCYTOP already depends on STACKTRACE_SUPPORT and selects
STACKTRACE, we can remove HAVE_LATENCYTOP_SUPPORT altogether.

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arc/Kconfig        | 3 ---
 arch/arm/Kconfig        | 5 -----
 arch/metag/Kconfig      | 3 ---
 arch/microblaze/Kconfig | 3 ---
 arch/parisc/Kconfig     | 3 ---
 arch/powerpc/Kconfig    | 3 ---
 arch/s390/Kconfig       | 3 ---
 arch/sh/Kconfig         | 3 ---
 arch/sparc/Kconfig      | 4 ----
 arch/unicore32/Kconfig  | 3 ---
 arch/x86/Kconfig        | 3 ---
 lib/Kconfig.debug       | 1 -
 12 files changed, 37 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2c2ac3f3ff80..6dc312fd6480 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -73,9 +73,6 @@ config STACKTRACE_SUPPORT
 	def_bool y
 	select STACKTRACE
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
 	depends on ARC_MMU_V4
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 857d39fcbad0..6322a203fece 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -162,11 +162,6 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
-config HAVE_LATENCYTOP_SUPPORT
-	bool
-	depends on !SMP
-	default y
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 0b389a81c43a..a0fa88da3e31 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -36,9 +36,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 0bce820428fc..5ecd0287a874 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -67,9 +67,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index c36546959e86..16276d505cd6 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -79,9 +79,6 @@ config TIME_LOW_RES
 	depends on SMP
 	default y
 
-config HAVE_LATENCYTOP_SUPPORT
-        def_bool y
-
 # unless you want to implement ACPI on PA-RISC ... ;-)
 config PM
 	bool
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db49e0d796b1..89210bfdfc7a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -47,9 +47,6 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3a55f493c7da..69e22b502d09 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -10,9 +10,6 @@ config LOCKDEP_SUPPORT
 config STACKTRACE_SUPPORT
 	def_bool y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d514df7e04dd..6c391a5d3e5c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -130,9 +130,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 56442d2d7bbc..3203e42190dd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -101,10 +101,6 @@ config LOCKDEP_SUPPORT
 	bool
 	default y if SPARC64
 
-config HAVE_LATENCYTOP_SUPPORT
-	bool
-	default y if SPARC64
-
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y if SPARC64
 
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c9faddc61100..910aaaaed969 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -33,9 +33,6 @@ config NO_IOPORT_MAP
 config STACKTRACE_SUPPORT
 	def_bool y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db3622f22b61..9574f7d1fe97 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -177,9 +177,6 @@ config LOCKDEP_SUPPORT
 config STACKTRACE_SUPPORT
 	def_bool y
 
-config HAVE_LATENCYTOP_SUPPORT
-	def_bool y
-
 config MMU
 	def_bool y
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8c15b29d5adc..97af31700828 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1556,7 +1556,6 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 
 config LATENCYTOP
 	bool "Latency measuring infrastructure"
-	depends on HAVE_LATENCYTOP_SUPPORT
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-- 
2.1.4
