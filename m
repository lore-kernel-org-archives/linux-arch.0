From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 27/37] frv: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:49:41 -0000
Message-ID: <20110119210840.190567318@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=frv-use-generic-irq-Kconfig.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
---
 arch/frv/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6/arch/frv/Kconfig
===================================================================
--- linux-2.6.orig/arch/frv/Kconfig
+++ linux-2.6/arch/frv/Kconfig
@@ -5,6 +5,7 @@ config FRV
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_IRQ_WORK
 	select HAVE_PERF_EVENTS
+	select HAVE_GENERIC_HARDIRQS
 
 config ZONE_DMA
 	bool
@@ -29,10 +30,6 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default n
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
 config TIME_LOW_RES
 	bool
 	default y
