Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814Ab0HZOLq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2010 10:11:46 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/7] Blackfin: Add missing dep to asm/irqflags.h
Date: Thu, 26 Aug 2010 15:11:31 +0100
Message-ID: <20100826141131.11132.8284.stgit@warthog.procyon.org.uk>
In-Reply-To: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, vapier@gentoo.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
Message-ID: <20100826141131.VTqTQXwEKiA9RrzlMQnK6pe351os9t-WcrKigPQw6Ns@z>

Add a missing dependency (mach/blackfin.h) to asm/irqflags.h so that
bfin_read_IMASK() can be used by inline functions.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/blackfin/include/asm/irqflags.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/blackfin/include/asm/irqflags.h b/arch/blackfin/include/asm/irqflags.h
index 813a1af..f3ed931 100644
--- a/arch/blackfin/include/asm/irqflags.h
+++ b/arch/blackfin/include/asm/irqflags.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_BFIN_IRQFLAGS_H__
 #define __ASM_BFIN_IRQFLAGS_H__
 
+#include <mach/blackfin.h>
+
 #ifdef CONFIG_SMP
 # include <asm/pda.h>
 # include <asm/processor.h>
@@ -185,7 +187,12 @@ static inline void raw_local_irq_enable(void)
 	bfin_sti(bfin_irq_flags);
 }
 
-#define raw_local_save_flags(flags) do { (flags) = bfin_read_IMASK(); } while (0)
+static inline unsigned long arch_local_save_flags(void)
+{
+	return bfin_read_IMASK();
+}
+
+#define raw_local_save_flags(flags) do { (flags) = arch_local_save_flags(); } while (0)
 
 #define raw_irqs_disabled_flags(flags) (((flags) & ~0x3f) == 0)
 

