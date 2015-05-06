From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH RFC 15/15] uaccess: decouple preemption from the pagefault logic
Date: Wed,  6 May 2015 19:50:39 +0200
Message-ID: <1430934639-2131-16-git-send-email-dahi@linux.vnet.ibm.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dahi@linux.vnet.ibm.com, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

As the fault handlers now all rely on the pagefault_disabled() checks
and implicit preempt_disable() calls by pagefault_disable() have been
made explicit, we can completely rely on the pagefault_disableD counter.

So let's no longer touch the preempt count when disabling/enabling
pagefaults. After a call to pagefault_disable(), pagefault_disabled()
will return true, but in_atomic() won't.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 include/linux/uaccess.h | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 23290cc..83f2a7b 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -1,7 +1,6 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
-#include <linux/preempt.h>
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 
@@ -20,17 +19,11 @@ static __always_inline void pagefault_disabled_dec(void)
  * These routines enable/disable the pagefault handler. If disabled, it will
  * not take any locks and go straight to the fixup table.
  *
- * We increase the preempt and the pagefault count, to be able to distinguish
- * whether we run in simple atomic context or in a real pagefault_disable()
- * context.
- *
- * For now, after pagefault_disabled() has been called, we run in atomic
- * context. User access methods will not sleep.
- *
+ * User access methods will not sleep when called from a pagefault_disabled()
+ * environment.
  */
 static inline void pagefault_disable(void)
 {
-	preempt_count_inc();
 	pagefault_disabled_inc();
 	/*
 	 * make sure to have issued the store before a pagefault
@@ -47,11 +40,6 @@ static inline void pagefault_enable(void)
 	 */
 	barrier();
 	pagefault_disabled_dec();
-#ifndef CONFIG_PREEMPT
-	preempt_count_dec();
-#else
-	preempt_enable();
-#endif
 }
 
 /*
-- 
2.1.4
