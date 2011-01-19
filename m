From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 36/37] tile: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:50:12 -0000
Message-ID: <20110119210840.631350392@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:40791 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881Ab1ASVuU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Jan 2011 16:50:20 -0500
Content-Disposition: inline; filename=tile-use-generic-irq-Kconfig.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Chris Metcalf <cmetcalf@tilera.com>

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/Kconfig |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

Index: linux-2.6/arch/tile/Kconfig
===================================================================
--- linux-2.6.orig/arch/tile/Kconfig
+++ linux-2.6/arch/tile/Kconfig
@@ -1,22 +1,18 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 
+config TILE
+       def_bool y
+       select HAVE_GENERIC_HARDIRQS
+       select GENERIC_IRQ_PROBE
+       select GENERIC_PENDING_IRQ if SMP
+
 config MMU
 	def_bool y
 
 config GENERIC_CSUM
 	def_bool y
 
-config GENERIC_HARDIRQS
-	def_bool y
-
-config GENERIC_IRQ_PROBE
-	def_bool y
-
-config GENERIC_PENDING_IRQ
-	def_bool y
-	depends on GENERIC_HARDIRQS && SMP
-
 config SEMAPHORE_SLEEPERS
 	def_bool y
 
