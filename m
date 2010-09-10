From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/17] Blackfin: Add missing dep to asm/irqflags.h
Date: Fri, 10 Sep 2010 17:24:28 +0100
Message-ID: <20100910162428.20817.84805.stgit@warthog.procyon.org.uk>
References: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org

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
 
