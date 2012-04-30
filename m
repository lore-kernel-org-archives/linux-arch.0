From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 23/29] sparc: Use generic init_task
Date: Mon, 30 Apr 2012 20:16:03 -0000
Message-ID: <20120430194846.989528598@linutronix.de>
References: <20120430194725.763322463@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=sparc-use-generic-init-task.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Same code. Use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/Kconfig            |    1 +
 arch/sparc/kernel/init_task.c |   22 ----------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

Index: tip/arch/sparc/Kconfig
===================================================================
--- tip.orig/arch/sparc/Kconfig
+++ tip/arch/sparc/Kconfig
@@ -31,6 +31,7 @@ config SPARC
 	select GENERIC_PCI_IOMAP
 	select HAVE_NMI_WATCHDOG if SPARC64
 	select GENERIC_SMP_IDLE_THREAD
+	select HAVE_GENERIC_INIT_TASK
 
 config SPARC32
 	def_bool !64BIT
Index: tip/arch/sparc/kernel/init_task.c
===================================================================
--- tip.orig/arch/sparc/kernel/init_task.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include <linux/mm.h>
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init_task.h>
-#include <linux/mqueue.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct task_struct init_task = INIT_TASK(init_task);
-EXPORT_SYMBOL(init_task);
-
-/* .text section in head.S is aligned at 8k boundary and this gets linked
- * right after that so that the init_thread_union is aligned properly as well.
- * If this is not aligned on a 8k boundary, then you should change code
- * in etrap.S which assumes it.
- */
-union thread_union init_thread_union __init_task_data =
-	{ INIT_THREAD_INFO(init_task) };
