Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35722 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab2D3UP4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:15:56 -0400
Message-ID: <20120430194845.911487654@linutronix.de>
Date: Mon, 30 Apr 2012 20:15:54 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/29] cx6: Use generic init_task
References: <20120430194725.763322463@linutronix.de>
Content-Disposition: inline; filename=cx6-use-generic-idle-task.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>
Message-ID: <20120430201554.L7-64qEOxShhEb-Y1QgZOBSl9wMPKps3qgmOBE5pf-E@z>

Same code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Salter <msalter@redhat.com>
---
 arch/c6x/Kconfig          |    1 +
 arch/c6x/kernel/process.c |   16 ----------------
 2 files changed, 1 insertion(+), 16 deletions(-)

Index: tip/arch/c6x/Kconfig
===================================================================
--- tip.orig/arch/c6x/Kconfig
+++ tip/arch/c6x/Kconfig
@@ -15,6 +15,7 @@ config TMS320C6X
 	select IRQ_DOMAIN
 	select OF
 	select OF_EARLY_FLATTREE
+	select HAVE_GENERIC_INIT_TASK
 
 config MMU
 	def_bool n
Index: tip/arch/c6x/kernel/process.c
===================================================================
--- tip.orig/arch/c6x/kernel/process.c
+++ tip/arch/c6x/kernel/process.c
@@ -26,22 +26,6 @@ void	(*c6x_halt)(void);
 
 extern asmlinkage void ret_from_fork(void);
 
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-
-/*
- * Initial thread structure.
- */
-union thread_union init_thread_union __init_task_data =	{
-	INIT_THREAD_INFO(init_task)
-};
-
-/*
- * Initial task structure.
- */
-struct task_struct init_task = INIT_TASK(init_task);
-EXPORT_SYMBOL(init_task);
-
 /*
  * power off function, if any
  */


