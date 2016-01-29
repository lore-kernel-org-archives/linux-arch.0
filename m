From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 03/12] x86: move exports to actual definitions
Date: Fri, 29 Jan 2016 19:18:25 +0000
Message-ID: <1454095114-4128-3-git-send-email-viro@ZenIV.linux.org.uk>
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
 arch/x86/entry/entry_32.S        |  2 +
 arch/x86/entry/entry_64.S        |  2 +
 arch/x86/entry/thunk_32.S        |  3 ++
 arch/x86/entry/thunk_64.S        |  3 ++
 arch/x86/include/asm/export.h    |  4 ++
 arch/x86/kernel/Makefile         |  4 +-
 arch/x86/kernel/head_32.S        |  2 +
 arch/x86/kernel/head_64.S        |  3 ++
 arch/x86/kernel/i386_ksyms_32.c  | 44 ----------------------
 arch/x86/kernel/mcount_64.S      |  2 +
 arch/x86/kernel/x8664_ksyms_64.c | 79 ----------------------------------------
 arch/x86/lib/checksum_32.S       |  3 ++
 arch/x86/lib/clear_page_64.S     |  2 +
 arch/x86/lib/cmpxchg8b_emu.S     |  2 +
 arch/x86/lib/copy_page_64.S      |  2 +
 arch/x86/lib/copy_user_64.S      |  8 ++++
 arch/x86/lib/csum-partial_64.c   |  1 +
 arch/x86/lib/getuser.S           |  5 +++
 arch/x86/lib/memcpy_64.S         |  3 ++
 arch/x86/lib/memmove_64.S        |  3 ++
 arch/x86/lib/memset_64.S         |  3 ++
 arch/x86/lib/putuser.S           |  5 +++
 arch/x86/lib/strstr_32.c         |  3 +-
 arch/x86/um/Makefile             |  2 +-
 arch/x86/um/checksum_32.S        |  2 +
 arch/x86/um/ksyms.c              | 13 -------
 26 files changed, 64 insertions(+), 141 deletions(-)
 create mode 100644 arch/x86/include/asm/export.h
 delete mode 100644 arch/x86/kernel/i386_ksyms_32.c
 delete mode 100644 arch/x86/kernel/x8664_ksyms_64.c
 delete mode 100644 arch/x86/um/ksyms.c

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 77d8c51..90087bf 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -44,6 +44,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/export.h>
 
 	.section .entry.text, "ax"
 
@@ -865,6 +866,7 @@ trace:
 	jmp	ftrace_stub
 END(mcount)
 #endif /* CONFIG_DYNAMIC_FTRACE */
+EXPORT_SYMBOL(mcount)
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9d34d3c..772f3a2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -35,6 +35,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/pgtable_types.h>
+#include <asm/export.h>
 #include <linux/err.h>
 
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
@@ -854,6 +855,7 @@ gs_change:
 	popfq
 	ret
 END(native_load_gs_index)
+EXPORT_SYMBOL(native_load_gs_index)
 
 	_ASM_EXTABLE(gs_change, bad_gs)
 	.section .fixup, "ax"
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index e5a1711..fee6bc7 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -6,6 +6,7 @@
  */
 	#include <linux/linkage.h>
 	#include <asm/asm.h>
+	#include <asm/export.h>
 
 	/* put return address in eax (arg1) */
 	.macro THUNK name, func, put_ret_addr_in_eax=0
@@ -36,5 +37,7 @@
 #ifdef CONFIG_PREEMPT
 	THUNK ___preempt_schedule, preempt_schedule
 	THUNK ___preempt_schedule_notrace, preempt_schedule_notrace
+	EXPORT_SYMBOL(___preempt_schedule)
+	EXPORT_SYMBOL(___preempt_schedule_notrace)
 #endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index efb2b93..6fb1f3c 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -8,6 +8,7 @@
 #include <linux/linkage.h>
 #include "calling.h"
 #include <asm/asm.h>
+#include <asm/export.h>
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func, put_ret_addr_in_rdi=0
@@ -47,6 +48,8 @@
 #ifdef CONFIG_PREEMPT
 	THUNK ___preempt_schedule, preempt_schedule
 	THUNK ___preempt_schedule_notrace, preempt_schedule_notrace
+	EXPORT_SYMBOL(___preempt_schedule)
+	EXPORT_SYMBOL(___preempt_schedule_notrace)
 #endif
 
 #if defined(CONFIG_TRACE_IRQFLAGS) \
diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export.h
new file mode 100644
index 0000000..138de56
--- /dev/null
+++ b/arch/x86/include/asm/export.h
@@ -0,0 +1,4 @@
+#ifdef CONFIG_64BIT
+#define KSYM_ALIGN 16
+#endif
+#include <asm-generic/export.h>
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b1b78ff..c707445 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -30,9 +30,7 @@ obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
 obj-y			+= setup.o x86_init.o i8259.o irqinit.o jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
-obj-$(CONFIG_X86_32)	+= i386_ksyms_32.o
-obj-$(CONFIG_X86_64)	+= sys_x86_64.o x8664_ksyms_64.o
-obj-$(CONFIG_X86_64)	+= mcount_64.o
+obj-$(CONFIG_X86_64)	+= sys_x86_64.o mcount_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
 obj-y			+= bootflag.o e820.o
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 6bc9ae2..0034632 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -23,6 +23,7 @@
 #include <asm/percpu.h>
 #include <asm/nops.h>
 #include <asm/bootparam.h>
+#include <asm/export.h>
 
 /* Physical address */
 #define pa(X) ((X) - __PAGE_OFFSET)
@@ -678,6 +679,7 @@ ENTRY(empty_zero_page)
 	.fill 4096,1,0
 ENTRY(swapper_pg_dir)
 	.fill 1024,4,0
+EXPORT_SYMBOL(empty_zero_page)
 
 /*
  * This starts the data section.
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ffdc0e8..33a4ad9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -20,6 +20,7 @@
 #include <asm/processor-flags.h>
 #include <asm/percpu.h>
 #include <asm/nops.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -523,10 +524,12 @@ early_gdt_descr_base:
 ENTRY(phys_base)
 	/* This must match the first entry in level2_kernel_pgt */
 	.quad   0x0000000000000000
+EXPORT_SYMBOL(phys_base)
 
 #include "../../x86/xen/xen-head.S"
 	
 	__PAGE_ALIGNED_BSS
 NEXT_PAGE(empty_zero_page)
 	.skip PAGE_SIZE
+EXPORT_SYMBOL(empty_zero_page)
 
diff --git a/arch/x86/kernel/i386_ksyms_32.c b/arch/x86/kernel/i386_ksyms_32.c
deleted file mode 100644
index 64341aa..0000000
--- a/arch/x86/kernel/i386_ksyms_32.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include <linux/module.h>
-
-#include <asm/checksum.h>
-#include <asm/pgtable.h>
-#include <asm/desc.h>
-#include <asm/ftrace.h>
-
-#ifdef CONFIG_FUNCTION_TRACER
-/* mcount is defined in assembly */
-EXPORT_SYMBOL(mcount);
-#endif
-
-/*
- * Note, this is a prototype to get at the symbol for
- * the export, but dont use it from C code, it is used
- * by assembly code and is not using C calling convention!
- */
-#ifndef CONFIG_X86_CMPXCHG64
-extern void cmpxchg8b_emu(void);
-EXPORT_SYMBOL(cmpxchg8b_emu);
-#endif
-
-/* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy_generic);
-
-EXPORT_SYMBOL(__get_user_1);
-EXPORT_SYMBOL(__get_user_2);
-EXPORT_SYMBOL(__get_user_4);
-EXPORT_SYMBOL(__get_user_8);
-
-EXPORT_SYMBOL(__put_user_1);
-EXPORT_SYMBOL(__put_user_2);
-EXPORT_SYMBOL(__put_user_4);
-EXPORT_SYMBOL(__put_user_8);
-
-EXPORT_SYMBOL(strstr);
-
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(empty_zero_page);
-
-#ifdef CONFIG_PREEMPT
-EXPORT_SYMBOL(___preempt_schedule);
-EXPORT_SYMBOL(___preempt_schedule_notrace);
-#endif
diff --git a/arch/x86/kernel/mcount_64.S b/arch/x86/kernel/mcount_64.S
index 87e1762..02c2864 100644
--- a/arch/x86/kernel/mcount_64.S
+++ b/arch/x86/kernel/mcount_64.S
@@ -7,6 +7,7 @@
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
+#include <asm/export.h>
 
 
 	.code64
@@ -291,6 +292,7 @@ trace:
 	jmp fgraph_trace
 END(function_hook)
 #endif /* CONFIG_DYNAMIC_FTRACE */
+EXPORT_SYMBOL(function_hook)
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/arch/x86/kernel/x8664_ksyms_64.c b/arch/x86/kernel/x8664_ksyms_64.c
deleted file mode 100644
index a0695be..0000000
--- a/arch/x86/kernel/x8664_ksyms_64.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/* Exports for assembly files.
-   All C exports should go in the respective C files. */
-
-#include <linux/module.h>
-#include <linux/smp.h>
-
-#include <net/checksum.h>
-
-#include <asm/processor.h>
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/desc.h>
-#include <asm/ftrace.h>
-
-#ifdef CONFIG_FUNCTION_TRACER
-/* mcount and __fentry__ are defined in assembly */
-#ifdef CC_USING_FENTRY
-EXPORT_SYMBOL(__fentry__);
-#else
-EXPORT_SYMBOL(mcount);
-#endif
-#endif
-
-EXPORT_SYMBOL(__get_user_1);
-EXPORT_SYMBOL(__get_user_2);
-EXPORT_SYMBOL(__get_user_4);
-EXPORT_SYMBOL(__get_user_8);
-EXPORT_SYMBOL(__put_user_1);
-EXPORT_SYMBOL(__put_user_2);
-EXPORT_SYMBOL(__put_user_4);
-EXPORT_SYMBOL(__put_user_8);
-
-EXPORT_SYMBOL(copy_user_generic_string);
-EXPORT_SYMBOL(copy_user_generic_unrolled);
-EXPORT_SYMBOL(copy_user_enhanced_fast_string);
-EXPORT_SYMBOL(__copy_user_nocache);
-EXPORT_SYMBOL(_copy_from_user);
-EXPORT_SYMBOL(_copy_to_user);
-
-EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
-
-EXPORT_SYMBOL(csum_partial);
-
-/*
- * Export string functions. We normally rely on gcc builtin for most of these,
- * but gcc sometimes decides not to inline them.
- */
-#undef memcpy
-#undef memset
-#undef memmove
-
-extern void *__memset(void *, int, __kernel_size_t);
-extern void *__memcpy(void *, const void *, __kernel_size_t);
-extern void *__memmove(void *, const void *, __kernel_size_t);
-extern void *memset(void *, int, __kernel_size_t);
-extern void *memcpy(void *, const void *, __kernel_size_t);
-extern void *memmove(void *, const void *, __kernel_size_t);
-
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memmove);
-
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-
-#ifndef CONFIG_DEBUG_VIRTUAL
-EXPORT_SYMBOL(phys_base);
-#endif
-EXPORT_SYMBOL(empty_zero_page);
-#ifndef CONFIG_PARAVIRT
-EXPORT_SYMBOL(native_load_gs_index);
-#endif
-
-#ifdef CONFIG_PREEMPT
-EXPORT_SYMBOL(___preempt_schedule);
-EXPORT_SYMBOL(___preempt_schedule_notrace);
-#endif
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index c1e6232..4d34bb5 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -28,6 +28,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
+#include <asm/export.h>
 				
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
@@ -251,6 +252,7 @@ ENTRY(csum_partial)
 ENDPROC(csum_partial)
 				
 #endif
+EXPORT_SYMBOL(csum_partial)
 
 /*
 unsigned int csum_partial_copy_generic (const char *src, char *dst,
@@ -490,3 +492,4 @@ ENDPROC(csum_partial_copy_generic)
 #undef ROUND1		
 		
 #endif
+EXPORT_SYMBOL(csum_partial_copy_generic)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index a2fe51b..192a26b 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,6 +1,7 @@
 #include <linux/linkage.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/export.h>
 
 /*
  * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
@@ -23,6 +24,7 @@ ENTRY(clear_page)
 	rep stosq
 	ret
 ENDPROC(clear_page)
+EXPORT_SYMBOL(clear_page)
 
 ENTRY(clear_page_orig)
 
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index ad53497..03a186f 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -7,6 +7,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 .text
 
@@ -48,3 +49,4 @@ ENTRY(cmpxchg8b_emu)
 	ret
 
 ENDPROC(cmpxchg8b_emu)
+EXPORT_SYMBOL(cmpxchg8b_emu)
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index 009f982..d704dde 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/export.h>
 
 /*
  * Some CPUs run faster using the string copy instructions (sane microcode).
@@ -17,6 +18,7 @@ ENTRY(copy_page)
 	rep	movsq
 	ret
 ENDPROC(copy_page)
+EXPORT_SYMBOL(copy_page)
 
 ENTRY(copy_page_regs)
 	subq	$2*8,	%rsp
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 982ce34..264c951 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -14,6 +14,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/export.h>
 
 /* Standard copy_to_user with segment limit checking */
 ENTRY(_copy_to_user)
@@ -29,6 +30,7 @@ ENTRY(_copy_to_user)
 		      "jmp copy_user_enhanced_fast_string",	\
 		      X86_FEATURE_ERMS
 ENDPROC(_copy_to_user)
+EXPORT_SYMBOL(_copy_to_user)
 
 /* Standard copy_from_user with segment limit checking */
 ENTRY(_copy_from_user)
@@ -44,6 +46,8 @@ ENTRY(_copy_from_user)
 		      "jmp copy_user_enhanced_fast_string",	\
 		      X86_FEATURE_ERMS
 ENDPROC(_copy_from_user)
+EXPORT_SYMBOL(_copy_from_user)
+
 
 	.section .fixup,"ax"
 	/* must zero dest */
@@ -155,6 +159,7 @@ ENTRY(copy_user_generic_unrolled)
 	_ASM_EXTABLE(21b,50b)
 	_ASM_EXTABLE(22b,50b)
 ENDPROC(copy_user_generic_unrolled)
+EXPORT_SYMBOL(copy_user_generic_unrolled)
 
 /* Some CPUs run faster using the string copy instructions.
  * This is also a lot simpler. Use them when possible.
@@ -200,6 +205,7 @@ ENTRY(copy_user_generic_string)
 	_ASM_EXTABLE(1b,11b)
 	_ASM_EXTABLE(3b,12b)
 ENDPROC(copy_user_generic_string)
+EXPORT_SYMBOL(copy_user_generic_string)
 
 /*
  * Some CPUs are adding enhanced REP MOVSB/STOSB instructions.
@@ -229,6 +235,7 @@ ENTRY(copy_user_enhanced_fast_string)
 
 	_ASM_EXTABLE(1b,12b)
 ENDPROC(copy_user_enhanced_fast_string)
+EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
@@ -319,3 +326,4 @@ ENTRY(__copy_user_nocache)
 	_ASM_EXTABLE(21b,50b)
 	_ASM_EXTABLE(22b,50b)
 ENDPROC(__copy_user_nocache)
+EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 9845371..f6ffcaa 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -135,6 +135,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 	return (__force __wsum)add32_with_carry(do_csum(buff, len),
 						(__force u32)sum);
 }
+EXPORT_SYMBOL(csum_partial);
 
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 46668cd..6fcdb2b 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -32,6 +32,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(__get_user_1)
@@ -44,6 +45,7 @@ ENTRY(__get_user_1)
 	ASM_CLAC
 	ret
 ENDPROC(__get_user_1)
+EXPORT_SYMBOL(__get_user_1)
 
 ENTRY(__get_user_2)
 	add $1,%_ASM_AX
@@ -57,6 +59,7 @@ ENTRY(__get_user_2)
 	ASM_CLAC
 	ret
 ENDPROC(__get_user_2)
+EXPORT_SYMBOL(__get_user_2)
 
 ENTRY(__get_user_4)
 	add $3,%_ASM_AX
@@ -70,6 +73,7 @@ ENTRY(__get_user_4)
 	ASM_CLAC
 	ret
 ENDPROC(__get_user_4)
+EXPORT_SYMBOL(__get_user_4)
 
 ENTRY(__get_user_8)
 #ifdef CONFIG_X86_64
@@ -97,6 +101,7 @@ ENTRY(__get_user_8)
 	ret
 #endif
 ENDPROC(__get_user_8)
+EXPORT_SYMBOL(__get_user_8)
 
 
 bad_get_user:
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 16698bb..320812c 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/export.h>
 
 /*
  * We build a jump to memcpy_orig by default which gets NOPped out on
@@ -39,6 +40,8 @@ ENTRY(memcpy)
 	ret
 ENDPROC(memcpy)
 ENDPROC(__memcpy)
+EXPORT_SYMBOL(memcpy)
+EXPORT_SYMBOL(__memcpy)
 
 /*
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index ca2afdd..8ee6b25 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -8,6 +8,7 @@
 #include <linux/linkage.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/export.h>
 
 #undef memmove
 
@@ -207,3 +208,5 @@ ENTRY(__memmove)
 	retq
 ENDPROC(__memmove)
 ENDPROC(memmove)
+EXPORT_SYMBOL(__memmove)
+EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 2661fad..8f43a22 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/export.h>
 
 .weak memset
 
@@ -43,6 +44,8 @@ ENTRY(__memset)
 	ret
 ENDPROC(memset)
 ENDPROC(__memset)
+EXPORT_SYMBOL(memset)
+EXPORT_SYMBOL(__memset)
 
 /*
  * ISO C memset - set a memory block to a byte value. This function uses
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index e0817a1..eb94317 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -15,6 +15,7 @@
 #include <asm/errno.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/export.h>
 
 
 /*
@@ -43,6 +44,7 @@ ENTRY(__put_user_1)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_1)
+EXPORT_SYMBOL(__put_user_1)
 
 ENTRY(__put_user_2)
 	ENTER
@@ -55,6 +57,7 @@ ENTRY(__put_user_2)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_2)
+EXPORT_SYMBOL(__put_user_2)
 
 ENTRY(__put_user_4)
 	ENTER
@@ -67,6 +70,7 @@ ENTRY(__put_user_4)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_4)
+EXPORT_SYMBOL(__put_user_4)
 
 ENTRY(__put_user_8)
 	ENTER
@@ -82,6 +86,7 @@ ENTRY(__put_user_8)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_8)
+EXPORT_SYMBOL(__put_user_8)
 
 bad_put_user:
 	movl $-EFAULT,%eax
diff --git a/arch/x86/lib/strstr_32.c b/arch/x86/lib/strstr_32.c
index 8e2d55f..a03b1c7 100644
--- a/arch/x86/lib/strstr_32.c
+++ b/arch/x86/lib/strstr_32.c
@@ -1,4 +1,5 @@
 #include <linux/string.h>
+#include <linux/export.h>
 
 char *strstr(const char *cs, const char *ct)
 {
@@ -28,4 +29,4 @@ __asm__ __volatile__(
 	: "dx", "di");
 return __res;
 }
-
+EXPORT_SYMBOL(strstr);
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 3ee2bb6..e7e7055 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -8,7 +8,7 @@ else
 	BITS := 64
 endif
 
-obj-y = bug.o bugs_$(BITS).o delay.o fault.o ksyms.o ldt.o \
+obj-y = bug.o bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
diff --git a/arch/x86/um/checksum_32.S b/arch/x86/um/checksum_32.S
index fa4b8b9..b9933eb 100644
--- a/arch/x86/um/checksum_32.S
+++ b/arch/x86/um/checksum_32.S
@@ -27,6 +27,7 @@
 
 #include <asm/errno.h>
 #include <asm/asm.h>
+#include <asm/export.h>
 				
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
@@ -214,3 +215,4 @@ csum_partial:
 	ret
 				
 #endif
+	EXPORT_SYMBOL(csum_partial)
diff --git a/arch/x86/um/ksyms.c b/arch/x86/um/ksyms.c
deleted file mode 100644
index 2e8f43e..0000000
--- a/arch/x86/um/ksyms.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include <linux/module.h>
-#include <asm/string.h>
-#include <asm/checksum.h>
-
-#ifndef CONFIG_X86_32
-/*XXX: we need them because they would be exported by x86_64 */
-#if (__GNUC__ == 4 && __GNUC_MINOR__ >= 3) || __GNUC__ > 4
-EXPORT_SYMBOL(memcpy);
-#else
-EXPORT_SYMBOL(__memcpy);
-#endif
-#endif
-EXPORT_SYMBOL(csum_partial);
-- 
2.1.4
