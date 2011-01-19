From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 31/37] mn10300: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:49:55 -0000
Message-ID: <20110119210840.381111598@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:40789 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877Ab1ASVuU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Jan 2011 16:50:20 -0500
Content-Disposition: inline; filename=mn10300-use-generic-irq-Kconfig.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
---
 arch/mn10300/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6/arch/mn10300/Kconfig
===================================================================
--- linux-2.6.orig/arch/mn10300/Kconfig
+++ linux-2.6/arch/mn10300/Kconfig
@@ -1,6 +1,7 @@
 config MN10300
 	def_bool y
 	select HAVE_OPROFILE
+	select GENERIC_HARDIRQS
 
 config AM33_2
 	def_bool n
@@ -76,10 +77,6 @@ config QUICKLIST
 config ARCH_HAS_ILOG2_U32
 	def_bool y
 
-# Use the generic interrupt handling code in kernel/irq/
-config GENERIC_HARDIRQS
-	def_bool y
-
 config HOTPLUG_CPU
 	def_bool n
 
