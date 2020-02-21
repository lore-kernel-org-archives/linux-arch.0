Return-Path: <SRS0=0XgO=4J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgBUNup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:45 -0500
Message-ID: <20200221134215.793377175@infradead.org>
Date: Fri, 21 Feb 2020 14:34:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 13/27] x86,tracing: Add comments to do_nmi()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200221133429.zLaIFBgqKJdRG3B6XMZUwg5qmlz5B8fosUeU4a4Tpq4@z>

Add a few comments to do_nmi() as a result of the audit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/nmi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -529,11 +529,14 @@ do_nmi(struct pt_regs *regs, long error_
 	 * continue to use the NMI stack.
 	 */
 	if (unlikely(is_debug_stack(regs->sp))) {
-		debug_stack_set_zero();
+		debug_stack_set_zero(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 1);
 	}
 #endif
 
+	/*
+	 * It is important that no tracing happens before nmi_enter()!
+	 */
 	nmi_enter();
 
 	inc_irq_stat(__nmi_count);
@@ -542,10 +545,13 @@ do_nmi(struct pt_regs *regs, long error_
 		default_do_nmi(regs);
 
 	nmi_exit();
+	/*
+	 * No tracing after nmi_exit()!
+	 */
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
+		debug_stack_reset(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 0);
 	}
 #endif
