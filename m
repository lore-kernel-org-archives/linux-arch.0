Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:40760 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849Ab1ASVuO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Jan 2011 16:50:14 -0500
Message-ID: <20110119210840.337412061@linutronix.de>
Date: Wed, 19 Jan 2011 21:49:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 30/37] microblaze: Use generic irq Kconfig
References: <20110119205258.462759212@linutronix.de>
Content-Disposition: inline; filename=microblaze-use-generic-irq-Kconfig.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Michal Simek <monstr@monstr.eu>
Message-ID: <20110119214952.t8129MXHa6T9O6m3hv5zip8wh0Cb7J2YqSj6I8cYenM@z>

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/Kconfig |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/microblaze/Kconfig
===================================================================
--- linux-2.6.orig/arch/microblaze/Kconfig
+++ linux-2.6/arch/microblaze/Kconfig
@@ -15,6 +15,8 @@ config MICROBLAZE
 	select TRACING_SUPPORT
 	select OF
 	select OF_EARLY_FLATTREE
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_IRQ_PROBE
 
 config SWAP
 	def_bool n
@@ -37,12 +39,6 @@ config GENERIC_FIND_NEXT_BIT
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_HARDIRQS
-	def_bool y
-
-config GENERIC_IRQ_PROBE
-	def_bool y
-
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 


