From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Date: Wed, 19 Feb 2020 15:47:28 +0100
Message-ID: <20200219150744.604459293@infradead.org>
References: <20200219144724.800607165@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBSPOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:37 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

Hitting the tracer or a kprobes from #DF is 'interesting', lets avoid
that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c   |    3 ++-
 arch/x86/lib/memcpy_32.c  |    7 ++++++-
 arch/x86/lib/memmove_64.S |    5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -271,7 +271,8 @@ dotraplinkage void do_double_fault(struc
 	 * The net result is that our #GP handler will think that we
 	 * entered from usermode with the bad user context.
 	 *
-	 * No need for nmi_enter() here because we don't use RCU.
+	 * No need for nmi_enter() here because we don't call out to anything
+	 * except memmove() and that is notrace/NOKPROBE.
 	 */
 	if (((long)regs->sp >> P4D_SHIFT) == ESPFIX_PGD_ENTRY &&
 		regs->cs == __KERNEL_CS &&
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
 }
 EXPORT_SYMBOL(memset);
 
-__visible void *memmove(void *dest, const void *src, size_t n)
+__visible notrace void *memmove(void *dest, const void *src, size_t n)
 {
 	int d0,d1,d2,d3,d4,d5;
 	char *ret = dest;
@@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
 
 }
 EXPORT_SYMBOL(memmove);
+/*
+ * The double fault handler uses memmove(), do not mess with it or risk a
+ * tripple fault.
+ */
+NOKPROBE_SYMBOL(memmove);
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,3 +212,8 @@ SYM_FUNC_END(__memmove)
 SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
+/*
+ * The double fault handler uses memmove(), do not mess with it or risk a
+ * tripple fault.
+ */
+_ASM_NOKPROBE(__memmove)
