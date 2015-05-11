Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:45637 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbbEKPxC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2015 11:53:02 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Mon, 11 May 2015 16:53:00 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 14/15] mips: properly lock access to the fpu
Date: Mon, 11 May 2015 17:52:19 +0200
Message-ID: <1431359540-32227-15-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
Message-ID: <20150511155219.0FnstLP1GL1Q1nWDOSVj_ksT13Vpyre58Pt9GZnteAs@z>

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

