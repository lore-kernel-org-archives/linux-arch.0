From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] Blackfin: Add missing dep to
	asm/irqflags.h
Date: Thu, 26 Aug 2010 15:11:31 +0100
Message-ID: <20100826141131.11132.8284.stgit@warthog.procyon.org.uk>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100826141110.11132.91931.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Add a missing dependency (mach/blackfin.h) to asm/irqflags.h so that
bfin_read_IMASK() can be used by inline functions.

Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
