Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfCPGQV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 Mar 2019 02:16:21 -0400
From: guoren@kernel.org
Subject: [PATCH] csky/ftrace: Add dynamic function tracer (include graph tracer)
Date: Sat, 16 Mar 2019 14:16:12 +0800
Message-ID: <1552716972-28009-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190316061612.0HqN5od_qyZ3V70eCWpFviXjK4DDjDHA4D_gsDdWlVE@z>

From: Guo Ren <ren_guo@c-sky.com>

Support dynamic ftrace including dynamic graph tracer. Gcc-csky with -pg
will produce call site in every function prologue and we can use these
call site to hook trace function.

gcc with -pg origin call site:
	push	lr
	jbsr	_mcount
	nop
	nop
	nop
	nop

If the (callee - caller)'s offset is in range of bsr instruction, we'll
modify code with:
	push	lr
	bsr	_mcount
	nop
	nop
	nop
	nop
Else if the (callee - caller)'s offset is out of bsr instrunction, we'll
modify code with:
	push	lr
	movih	r26, ...
	ori	r26, ...
	jsr	r26

(r26 is reserved for jsr link reg in csky abiv2 spec.)

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig              |   3 +-
 arch/csky/abiv2/mcount.S       |  43 +++++++++++-
 arch/csky/include/asm/ftrace.h |  18 ++++-
 arch/csky/kernel/ftrace.c      | 148 ++++++++++++++++++++++++++++++++++++++++-
 scripts/recordmcount.pl        |   3 +
 5 files changed, 209 insertions(+), 6 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c..114cb2f 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -28,14 +28,15 @@ config CSKY
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PERF_EVENTS
-	select HAVE_C_RECORDMCOUNT
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select MAY_HAVE_SPARSE_IRQ
diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index c633379..7a66fed 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -61,10 +61,20 @@
 	addi	sp, 16
 .endm
 
+.macro nop_stub_6
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+.endm
+
 ENTRY(ftrace_stub)
 	jmp	lr
 END(ftrace_stub)
 
+#ifndef CONFIG_DYNAMIC_FTRACE
 ENTRY(_mcount)
 	mcount_enter
 
@@ -76,7 +86,7 @@ ENTRY(_mcount)
 	bf	skip_ftrace
 
 	mov	a0, lr
-	subi	a0, MCOUNT_INSN_SIZE
+	subi	a0, 4
 	ldw	a1, (sp, 24)
 
 	jsr	r26
@@ -101,13 +111,42 @@ skip_ftrace:
 	mcount_exit
 #endif
 END(_mcount)
+#else /* CONFIG_DYNAMIC_FTRACE */
+ENTRY(_mcount)
+	mov	t1, lr
+	ldw	lr, (sp, 0)
+	addi	sp, 4
+	jmp	t1
+ENDPROC(_mcount)
+
+ENTRY(ftrace_caller)
+	mcount_enter
+
+	ldw	a0, (sp, 16)
+	subi	a0, 4
+	ldw	a1, (sp, 24)
+
+	nop
+GLOBAL(ftrace_call)
+	nop_stub_6
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	nop
+GLOBAL(ftrace_graph_call)
+	nop_stub_6
+#endif
+
+	mcount_exit
+ENDPROC(ftrace_caller)
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(ftrace_graph_caller)
+GLOBAL(ftrace_graph_caller)
 	mov	a0, sp
 	addi	a0, 24
 	ldw	a1, (sp, 16)
-	subi	a1, MCOUNT_INSN_SIZE
+	subi	a1, 4
 	mov	a2, r8
 	lrw	r26, prepare_ftrace_return
 	jsr	r26
diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
index 7547c45..ba35d93 100644
--- a/arch/csky/include/asm/ftrace.h
+++ b/arch/csky/include/asm/ftrace.h
@@ -4,10 +4,26 @@
 #ifndef __ASM_CSKY_FTRACE_H
 #define __ASM_CSKY_FTRACE_H
 
-#define MCOUNT_INSN_SIZE 4
+#define MCOUNT_INSN_SIZE	14
 
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
+#define MCOUNT_ADDR	((unsigned long)_mcount)
+
+#ifndef __ASSEMBLY__
+
+extern void _mcount(unsigned long);
+
+extern void ftrace_graph_call(void);
+
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+struct dyn_arch_ftrace {
+};
+#endif /* !__ASSEMBLY__ */
 #endif /* __ASM_CSKY_FTRACE_H */
diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
index 274c431..ae3870e 100644
--- a/arch/csky/kernel/ftrace.c
+++ b/arch/csky/kernel/ftrace.c
@@ -3,6 +3,137 @@
 
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <asm/cacheflush.h>
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define NOP		0x4000
+#define PUSH_LR		0x14d0
+#define MOVIH_LINK	0xea3a
+#define ORI_LINK	0xef5a
+#define JSR_LINK	0xe8fa
+#define BSR_LINK	0xe000
+
+/*
+ * Gcc-csky with -pg will insert stub in function prologue:
+ *	push	lr
+ *	jbsr	_mcount
+ *	nop
+ *	nop
+ *	nop
+ *	nop
+ *
+ * If the (callee - current_pc) is less then 64MB, we'll use bsr:
+ *	push	lr
+ *	bsr	_mcount
+ *	nop
+ *	nop
+ *	nop
+ *	nop
+ * else we'll use (movih + ori + jsr):
+ *	push	lr
+ *	movih	r26, ...
+ *	ori	r26, ...
+ *	jsr	r26
+ *
+ * (r26 is our reserved link-reg)
+ *
+ */
+static inline void make_jbsr(unsigned long callee, unsigned long pc,
+			     uint16_t *call, bool nolr)
+{
+	long offset;
+
+	call[0]	= nolr ? NOP : PUSH_LR;
+
+	offset = (long) callee - (long) pc;
+
+	if (unlikely(offset < -67108864 || offset > 67108864)) {
+		call[1] = MOVIH_LINK;
+		call[2] = callee >> 16;
+		call[3] = ORI_LINK;
+		call[4] = callee & 0xffff;
+		call[5] = JSR_LINK;
+		call[6] = 0;
+	} else {
+		offset = offset >> 1;
+
+		call[1] = BSR_LINK |
+			 ((uint16_t)((unsigned long) offset >> 16) & 0x3ff);
+		call[2] = (uint16_t)((unsigned long) offset & 0xffff);
+		call[3] = call[4] = call[5] = call[6] = NOP;
+	}
+}
+
+static int ftrace_check_current_nop(unsigned long hook)
+{
+	uint16_t olds[7];
+	uint16_t nops[7] = {NOP, NOP, NOP, NOP, NOP, NOP, NOP};
+	unsigned long hook_pos = hook - 2;
+
+	if (probe_kernel_read((void *)olds, (void *)hook_pos, sizeof(nops)))
+		return -EFAULT;
+
+	if (memcmp((void *)nops, (void *)olds, sizeof(nops))) {
+		pr_err("%p: nop but get (%04x %04x %04x %04x %04x %04x %04x)\n",
+			(void *)hook_pos,
+			olds[0], olds[1], olds[2], olds[3], olds[4], olds[5],
+			olds[6]);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ftrace_modify_code(unsigned long hook, unsigned long target,
+			      bool enable, bool nolr)
+{
+	uint16_t call[7];
+	uint16_t nops[7] = {NOP, NOP, NOP, NOP, NOP, NOP, NOP};
+	unsigned long hook_pos = hook - 2;
+	int ret = 0;
+
+	make_jbsr(target, hook, call, nolr);
+
+	ret = probe_kernel_write((void *)hook_pos, enable ? call : nops,
+				 sizeof(nops));
+	if (ret)
+		return -EPERM;
+
+	flush_icache_range(hook_pos, hook_pos + MCOUNT_INSN_SIZE);
+
+	return 0;
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	int ret = ftrace_check_current_nop(rec->ip);
+
+	if (ret)
+		return ret;
+
+	return ftrace_modify_code(rec->ip, addr, true, false);
+}
+
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	return ftrace_modify_code(rec->ip, addr, false, false);
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	int ret = ftrace_modify_code((unsigned long)&ftrace_call,
+				(unsigned long)func, true, true);
+	return ret;
+}
+
+int __init ftrace_dyn_arch_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
@@ -43,8 +174,21 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			*(unsigned long *)frame_pointer = return_hooker;
 	}
 }
-#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_code((unsigned long)&ftrace_graph_call,
+			(unsigned long)&ftrace_graph_caller, true, true);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_code((unsigned long)&ftrace_graph_call,
+			(unsigned long)&ftrace_graph_caller, false, true);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 /* _mcount is defined in abi's mcount.S */
-extern void _mcount(void);
 EXPORT_SYMBOL(_mcount);
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 68841d0..f716668 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -397,6 +397,9 @@ if ($arch eq "x86_64") {
 } elsif ($arch eq "nds32") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_NDS32_HI20_RELA\\s+_mcount\$";
     $alignment = 2;
+} elsif ($arch eq "csky") {
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_CKCORE_PCREL_JSR_IMM26BY2\\s+_mcount\$";
+    $alignment = 2;
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
2.7.4
