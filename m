From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH RFC 14/15] mips: properly lock access to the fpu
Date: Wed,  6 May 2015 19:50:38 +0200
Message-ID: <1430934639-2131-15-git-send-email-dahi@linux.vnet.ibm.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dahi@linux.vnet.ibm.com, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Let's always disable preemption and pagefaults when locking the fpu,
so we can be sure that the owner won't change in between.

This is a preparation for pagefault_disable() not touching preemption
anymore.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/mips/kernel/signal-common.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 06805e0..0b85f82 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -28,12 +28,7 @@ extern void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 extern int fpcsr_pending(unsigned int __user *fpcsr);
 
 /* Make sure we will not lose FPU ownership */
-#ifdef CONFIG_PREEMPT
-#define lock_fpu_owner()	preempt_disable()
-#define unlock_fpu_owner()	preempt_enable()
-#else
-#define lock_fpu_owner()	pagefault_disable()
-#define unlock_fpu_owner()	pagefault_enable()
-#endif
+#define lock_fpu_owner()	({ preempt_disable(); pagefault_disable(); })
+#define unlock_fpu_owner()	({ pagefault_enable(); preempt_enable(); })
 
 #endif	/* __SIGNAL_COMMON_H */
-- 
2.1.4
