From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 06/12] s390: move exports to definitions
Date: Fri, 29 Jan 2016 19:18:28 +0000
Message-ID: <1454095114-4128-6-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/include/asm/Kbuild  |  1 +
 arch/s390/kernel/Makefile     |  2 +-
 arch/s390/kernel/entry.S      |  6 ++++++
 arch/s390/kernel/mcount.S     |  3 +++
 arch/s390/kernel/s390_ksyms.c | 15 ---------------
 arch/s390/lib/mem.S           |  3 +++
 6 files changed, 14 insertions(+), 16 deletions(-)
 delete mode 100644 arch/s390/kernel/s390_ksyms.c

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 9043d2e1..20f196b8 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 
 generic-y += clkdev.h
+generic-y += export.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 2f5586a..32bbf01 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -50,7 +50,7 @@ obj-y	+= entry.o reipl.o relocate_kernel.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
-obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
+obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SCHED_TOPOLOGY)	+= topology.o
 obj-$(CONFIG_HIBERNATION)	+= suspend.o swsusp.o
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index cd5a191..ca5bf0e 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -23,6 +23,7 @@
 #include <asm/vx-insn.h>
 #include <asm/setup.h>
 #include <asm/nmi.h>
+#include <asm/export.h>
 
 __PT_R0      =	__PT_GPRS
 __PT_R1      =	__PT_GPRS + 8
@@ -249,6 +250,8 @@ sie_exit:
 
 	EX_TABLE(.Lrewind_pad,.Lsie_fault)
 	EX_TABLE(sie_exit,.Lsie_fault)
+EXPORT_SYMBOL(sie64a)
+EXPORT_SYMBOL(sie_exit)
 #endif
 
 /*
@@ -815,6 +818,9 @@ ENTRY(save_fpu_regs)
 	oi	__LC_CPU_FLAGS+7,_CIF_FPU
 	br	%r14
 .Lsave_fpu_regs_end:
+#if IS_ENABLED(CONFIG_KVM)
+EXPORT_SYMBOL(save_fpu_regs)
+#endif
 
 /*
  * Load floating-point controls and floating-point or vector registers.
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index e499370..9a17e44 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -9,6 +9,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 	.section .kprobes.text, "ax"
 
@@ -23,6 +24,8 @@ ENTRY(ftrace_stub)
 ENTRY(_mcount)
 	br	%r14
 
+EXPORT_SYMBOL(_mcount)
+
 ENTRY(ftrace_caller)
 	.globl	ftrace_regs_caller
 	.set	ftrace_regs_caller,ftrace_caller
diff --git a/arch/s390/kernel/s390_ksyms.c b/arch/s390/kernel/s390_ksyms.c
deleted file mode 100644
index e67453b..0000000
--- a/arch/s390/kernel/s390_ksyms.c
+++ /dev/null
@@ -1,15 +0,0 @@
-#include <linux/module.h>
-#include <linux/kvm_host.h>
-#include <asm/fpu/api.h>
-#include <asm/ftrace.h>
-
-#ifdef CONFIG_FUNCTION_TRACER
-EXPORT_SYMBOL(_mcount);
-#endif
-#if IS_ENABLED(CONFIG_KVM)
-EXPORT_SYMBOL(sie64a);
-EXPORT_SYMBOL(sie_exit);
-EXPORT_SYMBOL(save_fpu_regs);
-#endif
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index c6d553e..be9fa65 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 /*
  * memset implementation
@@ -60,6 +61,7 @@ ENTRY(memset)
 	xc	0(1,%r1),0(%r1)
 .Lmemset_mvc:
 	mvc	1(1,%r1),0(%r1)
+EXPORT_SYMBOL(memset)
 
 /*
  * memcpy implementation
@@ -86,3 +88,4 @@ ENTRY(memcpy)
 	j	.Lmemcpy_rest
 .Lmemcpy_mvc:
 	mvc	0(1,%r1),0(%r3)
+EXPORT_SYMBOL(memcpy)
-- 
2.1.4
