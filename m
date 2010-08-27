Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046Ab0H0CA5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2010 22:00:57 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 21/22] Fix SH irqflags
Date: Fri, 27 Aug 2010 03:00:53 +0100
Message-ID: <20100827020053.27277.553.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
References: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <20100827020053.dFfQKX6QGRQ-1vvsK0AqWISxi6h4oWP8FHBfDRdcJbY@z>


---

 arch/sh/kernel/irq_32.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/irq_32.c b/arch/sh/kernel/irq_32.c
index e33ab15..14d2477 100644
--- a/arch/sh/kernel/irq_32.c
+++ b/arch/sh/kernel/irq_32.c
@@ -10,7 +10,7 @@
 #include <linux/irqflags.h>
 #include <linux/module.h>
 
-void notrace raw_local_irq_restore(unsigned long flags)
+void notrace arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __dummy0, __dummy1;
 
@@ -38,9 +38,9 @@ void notrace raw_local_irq_restore(unsigned long flags)
 		);
 	}
 }
-EXPORT_SYMBOL(raw_local_irq_restore);
+EXPORT_SYMBOL(arch_local_irq_restore);
 
-unsigned long notrace __raw_local_save_flags(void)
+unsigned long notrace __arch_local_save_flags(void)
 {
 	unsigned long flags;
 
@@ -54,4 +54,4 @@ unsigned long notrace __raw_local_save_flags(void)
 
 	return flags;
 }
-EXPORT_SYMBOL(__raw_local_save_flags);
+EXPORT_SYMBOL(__arch_local_save_flags);

