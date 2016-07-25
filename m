From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 02/14] x86: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:35 -0400
Message-ID: <20160725034247.109173-3-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 arch/x86/kernel/kprobes/opt.c  | 2 +-
 arch/x86/mm/extable.c          | 2 +-
 arch/x86/mm/fault.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7847e5c0e0b5..28cee019209c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -45,7 +45,7 @@
 #include <linux/slab.h>
 #include <linux/hardirq.h>
 #include <linux/preempt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 4425f593f0ec..3bb4c5f021f6 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/hardirq.h>
 #include <linux/preempt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 832b98f822be..79ae939970d3 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -1,4 +1,4 @@
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <asm/uaccess.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index dc8023060456..79ae05477d94 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -5,7 +5,7 @@
  */
 #include <linux/sched.h>		/* test_thread_flag(), ...	*/
 #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
-#include <linux/module.h>		/* search_exception_table	*/
+#include <linux/extable.h>		/* search_exception_table	*/
 #include <linux/bootmem.h>		/* max_low_pfn			*/
 #include <linux/kprobes.h>		/* NOKPROBE_SYMBOL, ...		*/
 #include <linux/mmiotrace.h>		/* kmmio_handler, ...		*/
-- 
2.8.4
