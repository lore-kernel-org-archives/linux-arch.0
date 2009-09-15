From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Make more use of unreachable()
Date: Tue, 15 Sep 2009 10:39:04 +0200
Message-ID: <20090915083904.GA13796@linux-mips.org>
References: <4AAEBAC2.1050905@caviumnetworks.com> <1252965340-31735-3-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756599AbZIOIjB@vger.kernel.org>
Received: from localhost.localdomain ([127.0.0.1]:37224 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492214AbZIOIiy (ORCPT <rfc822;linux-arch@vger.kernel.org>
	+ 1 other); Tue, 15 Sep 2009 10:38:54 +0200
Content-Disposition: inline
In-Reply-To: <1252965340-31735-3-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Further uses of unreachable().

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/fw/arc/memory.c     |    5 +++--
 arch/mips/kernel/signal.c     |    5 +++--
 arch/mips/kernel/signal32.c   |    5 +++--
 arch/mips/kernel/signal_n32.c |    3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/mips/fw/arc/memory.c b/arch/mips/fw/arc/memory.c
index 8b8eea2..d248f64 100644
--- a/arch/mips/fw/arc/memory.c
+++ b/arch/mips/fw/arc/memory.c
@@ -11,6 +11,7 @@
  * because on some machines like SGI IP27 the ARC memory configuration data
  * completly bogus and alternate easier to use mechanisms are available.
  */
+#include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -80,7 +81,7 @@ static inline int memtype_classify_arcs(union linux_memtypes type)
 	default:
 		BUG();
 	}
-	while(1);				/* Nuke warning.  */
+	unreachable();				/* Nuke warning.  */
 }
 
 static inline int memtype_classify_arc(union linux_memtypes type)
@@ -100,7 +101,7 @@ static inline int memtype_classify_arc(union linux_memtypes type)
 	default:
 		BUG();
 	}
-	while(1);				/* Nuke warning.  */
+	unreachable();				/* Nuke warning.  */
 }
 
 static int __init prom_memtype_classify(union linux_memtypes type)
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 6254041..eefd278 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/personality.h>
@@ -422,7 +423,7 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"j\tsyscall_exit"
 		:/* no outputs */
 		:"r" (&regs));
-	/* Unreached */
+	unreachable();
 
 badframe:
 	force_sig(SIGSEGV, current);
@@ -468,7 +469,7 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"j\tsyscall_exit"
 		:/* no outputs */
 		:"r" (&regs));
-	/* Unreached */
+	unreachable();
 
 badframe:
 	force_sig(SIGSEGV, current);
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 2e74075..d41e267 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -9,6 +9,7 @@
  */
 #include <linux/cache.h>
 #include <linux/compat.h>
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -526,7 +527,7 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"j\tsyscall_exit"
 		:/* no outputs */
 		:"r" (&regs));
-	/* Unreached */
+	unreachable();
 
 badframe:
 	force_sig(SIGSEGV, current);
@@ -583,7 +584,7 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"j\tsyscall_exit"
 		:/* no outputs */
 		:"r" (&regs));
-	/* Unreached */
+	unreachable();
 
 badframe:
 	force_sig(SIGSEGV, current);
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index bb277e8..24ebaa5 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 #include <linux/cache.h>
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -167,7 +168,7 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"j\tsyscall_exit"
 		:/* no outputs */
 		:"r" (&regs));
-	/* Unreached */
+	unreachable();
 
 badframe:
 	force_sig(SIGSEGV, current);
