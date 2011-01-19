From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/37] h8300: Use generic irq Kconfig
Date: Wed, 19 Jan 2011 21:48:13 -0000
Message-ID: <20110119210838.952039472@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=h8300-use-generic-irq-kconfig.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

Switch to the generic irq Kconfig. h8300 has all irq chips converted
to the new functions, so select the GENERIC_HARDIRQS_NO_DEPRECATED
switch as well. Fixup the resulting fallout in show_interrupts().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/h8300/Kconfig      |    6 ++----
 arch/h8300/kernel/irq.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/h8300/Kconfig
===================================================================
--- linux-2.6.orig/arch/h8300/Kconfig
+++ linux-2.6/arch/h8300/Kconfig
@@ -2,6 +2,8 @@ config H8300
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_HARDIRQS_NO_DEPRECATED
 
 config SYMBOL_PREFIX
 	string
@@ -47,10 +49,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Index: linux-2.6/arch/h8300/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/irq.c
+++ linux-2.6/arch/h8300/kernel/irq.c
@@ -182,7 +182,7 @@ int show_interrupts(struct seq_file *p, 
 			goto unlock;
 		seq_printf(p, "%3d: ",i);
 		seq_printf(p, "%10u ", kstat_irqs(i));
-		seq_printf(p, " %14s", irq_desc[i].chip->name);
+		seq_printf(p, " %14s", irq_desc[i].irq_data.chip->name);
 		seq_printf(p, "-%-8s", irq_desc[i].name);
 		seq_printf(p, "  %s", action->name);
 
