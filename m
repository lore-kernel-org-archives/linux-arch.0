Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33488 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab1ASVtr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Jan 2011 16:49:47 -0500
Message-ID: <20110119210839.993106232@linutronix.de>
Date: Wed, 19 Jan 2011 21:49:26 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 23/37] m32r: Convert to generic irq Kconfig
References: <20110119205258.462759212@linutronix.de>
Content-Disposition: inline; filename=m32r-convert-to-generic-irq-Kconfig
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Hirokazu Takata <takata@linux-m32r.org>, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20110119214926.Zu2mIKfMLoUCSH4teE3_nmqScChNwyl5J5oJnPjpE5Y@z>

Use the generic irq Kconfig. Select GENERIC_HARDIRQS_NO_DEPRECATED as
we have converted all irq_chip functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/m32r/Kconfig |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/m32r/Kconfig
===================================================================
--- linux-2.6.orig/arch/m32r/Kconfig
+++ linux-2.6/arch/m32r/Kconfig
@@ -7,6 +7,9 @@ config M32R
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZMA
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select GENERIC_IRQ_PROBE
 
 config SBUS
 	bool
@@ -19,14 +22,6 @@ config ZONE_DMA
 	bool
 	default y
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
-config GENERIC_IRQ_PROBE
-	bool
-	default y
-
 config NO_IOPORT
 	def_bool y
 


