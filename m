Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab0IJQZh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Sep 2010 12:25:37 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/17] Fix SH irqflags.
Date: Fri, 10 Sep 2010 17:25:24 +0100
Message-ID: <20100910162524.20817.26196.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
References: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Message-ID: <20100910162524.NuezX2VHBqZqb02YpHYkieRtGBXf1z_qRsmcA5zqAHQ@z>

This (sub)patch is separated out for reviewing purposes.  Once ACK'd it will
need to be rolled into the main patch.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
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

