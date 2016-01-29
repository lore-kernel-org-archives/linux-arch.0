From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 09/12] sparc: move exports to definitions
Date: Fri, 29 Jan 2016 19:18:31 +0000
Message-ID: <1454095114-4128-9-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49618 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbcA2TSh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2016 14:18:37 -0500
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/Kbuild      |   1 +
 arch/sparc/kernel/Makefile         |   2 +-
 arch/sparc/kernel/entry.S          |   3 +
 arch/sparc/kernel/head_32.S        |   3 +
 arch/sparc/kernel/head_64.S        |   7 +-
 arch/sparc/kernel/helpers.S        |   2 +
 arch/sparc/kernel/hvcalls.S        |   4 +
 arch/sparc/kernel/sparc_ksyms.c    |  12 +++
 arch/sparc/kernel/sparc_ksyms_32.c |  31 -------
 arch/sparc/kernel/sparc_ksyms_64.c |  52 ------------
 arch/sparc/lib/Makefile            |   1 -
 arch/sparc/lib/U1memcpy.S          |   2 +
 arch/sparc/lib/VISsave.S           |   2 +
 arch/sparc/lib/ashldi3.S           |   2 +
 arch/sparc/lib/ashrdi3.S           |   2 +
 arch/sparc/lib/atomic_64.S         |  10 ++-
 arch/sparc/lib/bitops.S            |   7 ++
 arch/sparc/lib/blockops.S          |   3 +
 arch/sparc/lib/bzero.S             |   4 +
 arch/sparc/lib/checksum_32.S       |   3 +
 arch/sparc/lib/checksum_64.S       |   2 +
 arch/sparc/lib/clear_page.S        |   3 +
 arch/sparc/lib/copy_in_user.S      |   2 +
 arch/sparc/lib/copy_page.S         |   2 +
 arch/sparc/lib/copy_user.S         |   2 +
 arch/sparc/lib/csum_copy.S         |   3 +
 arch/sparc/lib/divdi3.S            |   2 +
 arch/sparc/lib/ffs.S               |   3 +
 arch/sparc/lib/hweight.S           |   5 ++
 arch/sparc/lib/ipcsum.S            |   2 +
 arch/sparc/lib/ksyms.c             | 165 -------------------------------------
 arch/sparc/lib/locks.S             |   5 ++
 arch/sparc/lib/lshrdi3.S           |   2 +
 arch/sparc/lib/mcount.S            |   2 +
 arch/sparc/lib/memcmp.S            |   2 +
 arch/sparc/lib/memcpy.S            |   4 +
 arch/sparc/lib/memmove.S           |   2 +
 arch/sparc/lib/memscan_32.S        |   4 +
 arch/sparc/lib/memscan_64.S        |   4 +
 arch/sparc/lib/memset.S            |   3 +
 arch/sparc/lib/muldi3.S            |   2 +
 arch/sparc/lib/strlen.S            |   2 +
 arch/sparc/lib/strncmp_32.S        |   2 +
 arch/sparc/lib/strncmp_64.S        |   2 +
 arch/sparc/lib/xor.S               |   9 ++
 45 files changed, 136 insertions(+), 253 deletions(-)
 create mode 100644 arch/sparc/kernel/sparc_ksyms.c
 delete mode 100644 arch/sparc/kernel/sparc_ksyms_32.c
 delete mode 100644 arch/sparc/kernel/sparc_ksyms_64.c
 delete mode 100644 arch/sparc/lib/ksyms.c

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index e9286188..17aa6b5 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += cputime.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
+generic-y += export.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += linkage.h
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 7cf9c6e..2430127 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -85,7 +85,7 @@ obj-y                     += auxio_$(BITS).o
 obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
 
 obj-$(CONFIG_MODULES)     += module.o
-obj-$(CONFIG_MODULES)     += sparc_ksyms_$(BITS).o
+obj-$(CONFIG_MODULES)     += sparc_ksyms.o
 obj-$(CONFIG_SPARC_LED)   += led.o
 obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
 
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 33c02b1..c201b2b 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -29,6 +29,7 @@
 #include <asm/unistd.h>
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 #define curptr      g6
 
@@ -1190,6 +1191,8 @@ delay_continue:
 	
 	ret
 	restore
+EXPORT_SYMBOL(__udelay)
+EXPORT_SYMBOL(__ndelay)
 
 	/* Handle a software breakpoint */
 	/* We have to inform parent that child has stopped */
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 3d92c0a..7bb317b 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -24,6 +24,7 @@
 #include <asm/thread_info.h>	/* TI_UWINMASK */
 #include <asm/errno.h>
 #include <asm/pgtsrmmu.h>	/* SRMMU_PGDIR_SHIFT */
+#include <asm/export.h>
 
 	.data
 /* The following are used with the prom_vector node-ops to figure out
@@ -60,6 +61,7 @@ sun4e_notsup:
  */
 	.globl empty_zero_page
 empty_zero_page:	.skip PAGE_SIZE
+EXPORT_SYMBOL(empty_zero_page)
 
 	.global root_flags
 	.global ram_flags
@@ -813,3 +815,4 @@ lvl14_save:
 __ret_efault:
         ret
          restore %g0, -EFAULT, %o0
+EXPORT_SYMBOL(__ret_efault)
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index f2d30ca..aae4ae0 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -32,7 +32,8 @@
 #include <asm/estate.h>
 #include <asm/sfafsr.h>
 #include <asm/unistd.h>
-	
+#include <asm/export.h>
+
 /* This section from from _start to sparc64_boot_end should fit into
  * 0x0000000000404000 to 0x0000000000408000.
  */
@@ -143,6 +144,7 @@ prom_cpu_compatible:
 	.skip	64
 prom_root_node:
 	.word	0
+EXPORT_SYMBOL(prom_root_node)
 prom_mmu_ihandle_cache:
 	.word	0
 prom_boot_mapped_pc:
@@ -158,6 +160,7 @@ is_sun4v:
 	.word	0
 sun4v_chip_type:
 	.word	SUN4V_CHIP_INVALID
+EXPORT_SYMBOL(sun4v_chip_type)
 1:
 	rd	%pc, %l0
 
@@ -928,6 +931,7 @@ swapper_4m_tsb:
 	.globl	prom_tba, tlb_type
 prom_tba:	.xword	0
 tlb_type:	.word	0	/* Must NOT end up in BSS */
+EXPORT_SYMBOL(tlb_type)
 	.section	".fixup",#alloc,#execinstr
 
 	.globl	__ret_efault, __retl_efault, __ret_one, __retl_one
@@ -935,6 +939,7 @@ ENTRY(__ret_efault)
 	ret
 	 restore %g0, -EFAULT, %o0
 ENDPROC(__ret_efault)
+EXPORT_SYMBOL(__ret_efault)
 
 ENTRY(__retl_efault)
 	retl
diff --git a/arch/sparc/kernel/helpers.S b/arch/sparc/kernel/helpers.S
index 314dd0c..e4e5b83 100644
--- a/arch/sparc/kernel/helpers.S
+++ b/arch/sparc/kernel/helpers.S
@@ -15,6 +15,7 @@ __flushw_user:
 2:	retl
 	 nop
 	.size	__flushw_user,.-__flushw_user
+EXPORT_SYMBOL(__flushw_user)
 
 	/* Flush %fp and %i7 to the stack for all register
 	 * windows active inside of the cpu.  This allows
@@ -61,3 +62,4 @@ real_hard_smp_processor_id:
 	.size		hard_smp_processor_id,.-hard_smp_processor_id
 #endif
 	.size		real_hard_smp_processor_id,.-real_hard_smp_processor_id
+EXPORT_SYMBOL_GPL(real_hard_smp_processor_id)
diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index afbaba5..64b1c2f 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -775,6 +775,7 @@ ENTRY(sun4v_niagara_getperf)
 	retl
 	 nop
 ENDPROC(sun4v_niagara_getperf)
+EXPORT_SYMBOL(sun4v_niagara_getperf)
 
 ENTRY(sun4v_niagara_setperf)
 	mov	HV_FAST_SET_PERFREG, %o5
@@ -782,6 +783,7 @@ ENTRY(sun4v_niagara_setperf)
 	retl
 	 nop
 ENDPROC(sun4v_niagara_setperf)
+EXPORT_SYMBOL(sun4v_niagara_setperf)
 
 ENTRY(sun4v_niagara2_getperf)
 	mov	%o0, %o4
@@ -791,6 +793,7 @@ ENTRY(sun4v_niagara2_getperf)
 	retl
 	 nop
 ENDPROC(sun4v_niagara2_getperf)
+EXPORT_SYMBOL(sun4v_niagara2_getperf)
 
 ENTRY(sun4v_niagara2_setperf)
 	mov	HV_FAST_N2_SET_PERFREG, %o5
@@ -798,6 +801,7 @@ ENTRY(sun4v_niagara2_setperf)
 	retl
 	 nop
 ENDPROC(sun4v_niagara2_setperf)
+EXPORT_SYMBOL(sun4v_niagara2_setperf)
 
 ENTRY(sun4v_reboot_data_set)
 	mov	HV_FAST_REBOOT_DATA_SET, %o5
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
new file mode 100644
index 0000000..09aa69e
--- /dev/null
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -0,0 +1,12 @@
+/*
+ * arch/sparc/kernel/ksyms.c: Sparc specific ksyms support.
+ *
+ * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
+ */
+
+#include <linux/init.h>
+#include <linux/export.h>
+
+/* This is needed only for drivers/sbus/char/openprom.c */
+EXPORT_SYMBOL(saved_command_line);
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
deleted file mode 100644
index bf4ccb1..0000000
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/sparc/kernel/ksyms.c: Sparc specific ksyms support.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
- */
-
-#include <linux/module.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/delay.h>
-#include <asm/head.h>
-#include <asm/dma.h>
-
-struct poll {
-	int fd;
-	short events;
-	short revents;
-};
-
-/* from entry.S */
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__ndelay);
-
-/* from head_32.S */
-EXPORT_SYMBOL(__ret_efault);
-EXPORT_SYMBOL(empty_zero_page);
-
-/* Exporting a symbol from /init/main.c */
-EXPORT_SYMBOL(saved_command_line);
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
deleted file mode 100644
index a92d5d2..0000000
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/* arch/sparc64/kernel/sparc64_ksyms.c: Sparc64 specific ksyms support.
- *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
- * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
- * Copyright (C) 1999 Jakub Jelinek (jj@ultra.linux.cz)
- */
-
-#include <linux/export.h>
-#include <linux/pci.h>
-#include <linux/bitops.h>
-
-#include <asm/cpudata.h>
-#include <asm/uaccess.h>
-#include <asm/spitfire.h>
-#include <asm/oplib.h>
-#include <asm/hypervisor.h>
-#include <asm/cacheflush.h>
-
-struct poll {
-	int fd;
-	short events;
-	short revents;
-};
-
-/* from helpers.S */
-EXPORT_SYMBOL(__flushw_user);
-EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
-
-/* from head_64.S */
-EXPORT_SYMBOL(__ret_efault);
-EXPORT_SYMBOL(tlb_type);
-EXPORT_SYMBOL(sun4v_chip_type);
-EXPORT_SYMBOL(prom_root_node);
-
-/* from hvcalls.S */
-EXPORT_SYMBOL(sun4v_niagara_getperf);
-EXPORT_SYMBOL(sun4v_niagara_setperf);
-EXPORT_SYMBOL(sun4v_niagara2_getperf);
-EXPORT_SYMBOL(sun4v_niagara2_setperf);
-
-/* from hweight.S */
-EXPORT_SYMBOL(__arch_hweight8);
-EXPORT_SYMBOL(__arch_hweight16);
-EXPORT_SYMBOL(__arch_hweight32);
-EXPORT_SYMBOL(__arch_hweight64);
-
-/* from ffs_ffz.S */
-EXPORT_SYMBOL(ffs);
-EXPORT_SYMBOL(__ffs);
-
-/* Exporting a symbol from /init/main.c */
-EXPORT_SYMBOL(saved_command_line);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 3269b02..885f00e 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -43,5 +43,4 @@ lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
-obj-y                 += ksyms.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index 3e6209e..97e1b21 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -7,6 +7,7 @@
 #ifdef __KERNEL__
 #include <asm/visasm.h>
 #include <asm/asi.h>
+#include <asm/export.h>
 #define GLOBAL_SPARE	g7
 #else
 #define GLOBAL_SPARE	g5
@@ -567,3 +568,4 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 	 mov		EX_RETVAL(%o4), %o0
 
 	.size		FUNC_NAME, .-FUNC_NAME
+EXPORT_SYMBOL(FUNC_NAME)
diff --git a/arch/sparc/lib/VISsave.S b/arch/sparc/lib/VISsave.S
index 62c2647b..1c7b6a3 100644
--- a/arch/sparc/lib/VISsave.S
+++ b/arch/sparc/lib/VISsave.S
@@ -13,6 +13,7 @@
 #include <asm/ptrace.h>
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
+#include <asm/export.h>
 
 	/* On entry: %o5=current FPRS value, %g7 is callers address */
 	/* May clobber %o5, %g1, %g2, %g3, %g7, %icc, %xcc */
@@ -79,3 +80,4 @@ vis1:	ldub		[%g6 + TI_FPSAVED], %g3
 80:	jmpl		%g7 + %g0, %g0
 	 nop
 ENDPROC(VISenter)
+EXPORT_SYMBOL(VISenter)
diff --git a/arch/sparc/lib/ashldi3.S b/arch/sparc/lib/ashldi3.S
index 86f60de..c8b1cf7 100644
--- a/arch/sparc/lib/ashldi3.S
+++ b/arch/sparc/lib/ashldi3.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(__ashldi3)
@@ -33,3 +34,4 @@ ENTRY(__ashldi3)
 	retl
 	 nop
 ENDPROC(__ashldi3)
+EXPORT_SYMBOL(__ashldi3)
diff --git a/arch/sparc/lib/ashrdi3.S b/arch/sparc/lib/ashrdi3.S
index 6eb8ba2..4310256 100644
--- a/arch/sparc/lib/ashrdi3.S
+++ b/arch/sparc/lib/ashrdi3.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(__ashrdi3)
@@ -35,3 +36,4 @@ ENTRY(__ashrdi3)
 	jmpl	%o7 + 8, %g0
 	 nop
 ENDPROC(__ashrdi3)
+EXPORT_SYMBOL(__ashrdi3)
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index d6b0363..52c927c 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -6,6 +6,7 @@
 #include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/backoff.h>
+#include <asm/export.h>
 
 	.text
 
@@ -28,6 +29,7 @@ ENTRY(atomic_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
 	 nop;								\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
 ENDPROC(atomic_##op);							\
+EXPORT_SYMBOL(atomic_##op);						\
 
 #define ATOMIC_OP_RETURN(op)						\
 ENTRY(atomic_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
@@ -41,7 +43,8 @@ ENTRY(atomic_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
 	retl;								\
 	 sra	%g1, 0, %o0;						\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic_##op##_return);
+ENDPROC(atomic_##op##_return);						\
+EXPORT_SYMBOL(atomic_##op##_return);					\
 
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
 
@@ -68,6 +71,7 @@ ENTRY(atomic64_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
 	 nop;								\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
 ENDPROC(atomic64_##op);							\
+EXPORT_SYMBOL(atomic64_##op);						\
 
 #define ATOMIC64_OP_RETURN(op)						\
 ENTRY(atomic64_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
@@ -81,7 +85,8 @@ ENTRY(atomic64_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
 	retl;								\
 	 op	%g1, %o0, %o0;						\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic64_##op##_return);
+ENDPROC(atomic64_##op##_return);					\
+EXPORT_SYMBOL(atomic64_##op##_return);
 
 #define ATOMIC64_OPS(op) ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op)
 
@@ -108,3 +113,4 @@ ENTRY(atomic64_dec_if_positive) /* %o0 = atomic_ptr */
 	 sub	%g1, 1, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
 ENDPROC(atomic64_dec_if_positive)
+EXPORT_SYMBOL(atomic64_dec_if_positive)
diff --git a/arch/sparc/lib/bitops.S b/arch/sparc/lib/bitops.S
index 36f72cc..7031bf1 100644
--- a/arch/sparc/lib/bitops.S
+++ b/arch/sparc/lib/bitops.S
@@ -6,6 +6,7 @@
 #include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/backoff.h>
+#include <asm/export.h>
 
 	.text
 
@@ -29,6 +30,7 @@ ENTRY(test_and_set_bit)	/* %o0=nr, %o1=addr */
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
 ENDPROC(test_and_set_bit)
+EXPORT_SYMBOL(test_and_set_bit)
 
 ENTRY(test_and_clear_bit) /* %o0=nr, %o1=addr */
 	BACKOFF_SETUP(%o3)
@@ -50,6 +52,7 @@ ENTRY(test_and_clear_bit) /* %o0=nr, %o1=addr */
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
 ENDPROC(test_and_clear_bit)
+EXPORT_SYMBOL(test_and_clear_bit)
 
 ENTRY(test_and_change_bit) /* %o0=nr, %o1=addr */
 	BACKOFF_SETUP(%o3)
@@ -71,6 +74,7 @@ ENTRY(test_and_change_bit) /* %o0=nr, %o1=addr */
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
 ENDPROC(test_and_change_bit)
+EXPORT_SYMBOL(test_and_change_bit)
 
 ENTRY(set_bit) /* %o0=nr, %o1=addr */
 	BACKOFF_SETUP(%o3)
@@ -90,6 +94,7 @@ ENTRY(set_bit) /* %o0=nr, %o1=addr */
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
 ENDPROC(set_bit)
+EXPORT_SYMBOL(set_bit)
 
 ENTRY(clear_bit) /* %o0=nr, %o1=addr */
 	BACKOFF_SETUP(%o3)
@@ -109,6 +114,7 @@ ENTRY(clear_bit) /* %o0=nr, %o1=addr */
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
 ENDPROC(clear_bit)
+EXPORT_SYMBOL(clear_bit)
 
 ENTRY(change_bit) /* %o0=nr, %o1=addr */
 	BACKOFF_SETUP(%o3)
@@ -128,3 +134,4 @@ ENTRY(change_bit) /* %o0=nr, %o1=addr */
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
 ENDPROC(change_bit)
+EXPORT_SYMBOL(change_bit)
diff --git a/arch/sparc/lib/blockops.S b/arch/sparc/lib/blockops.S
index 3c77101..1f2692d5 100644
--- a/arch/sparc/lib/blockops.S
+++ b/arch/sparc/lib/blockops.S
@@ -6,6 +6,7 @@
 
 #include <linux/linkage.h>
 #include <asm/page.h>
+#include <asm/export.h>
 
 	/* Zero out 64 bytes of memory at (buf + offset).
 	 * Assumes %g1 contains zero.
@@ -64,6 +65,7 @@ ENTRY(bzero_1page)
 	retl
 	 nop
 ENDPROC(bzero_1page)
+EXPORT_SYMBOL(bzero_1page)
 
 ENTRY(__copy_1page)
 /* NOTE: If you change the number of insns of this routine, please check
@@ -87,3 +89,4 @@ ENTRY(__copy_1page)
 	retl
 	 nop
 ENDPROC(__copy_1page)
+EXPORT_SYMBOL(__copy_1page)
diff --git a/arch/sparc/lib/bzero.S b/arch/sparc/lib/bzero.S
index 8c05811..3bb1914 100644
--- a/arch/sparc/lib/bzero.S
+++ b/arch/sparc/lib/bzero.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 
@@ -78,6 +79,8 @@ __bzero_done:
 	 mov		%o3, %o0
 ENDPROC(__bzero)
 ENDPROC(memset)
+EXPORT_SYMBOL(__bzero)
+EXPORT_SYMBOL(memset)
 
 #define EX_ST(x,y)		\
 98:	x,y;			\
@@ -143,3 +146,4 @@ __clear_user_done:
 	retl
 	 clr		%o0
 ENDPROC(__clear_user)
+EXPORT_SYMBOL(__clear_user)
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 0084c33..c9d8b62 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -14,6 +14,7 @@
  */
 
 #include <asm/errno.h>
+#include <asm/export.h>
 
 #define CSUM_BIGCHUNK(buf, offset, sum, t0, t1, t2, t3, t4, t5)	\
 	ldd	[buf + offset + 0x00], t0;			\
@@ -104,6 +105,7 @@ csum_partial_fix_alignment:
 	 * buffer of size 0x20.  Follow the code path for that case.
 	 */
 	.globl	csum_partial
+	EXPORT_SYMBOL(csum_partial)
 csum_partial:			/* %o0=buf, %o1=len, %o2=sum */
 	andcc	%o0, 0x7, %g0				! alignment problems?
 	bne	csum_partial_fix_alignment		! yep, handle it
@@ -335,6 +337,7 @@ cc_dword_align:
 	 */
 	.align	8
 	.globl	__csum_partial_copy_sparc_generic
+	EXPORT_SYMBOL(__csum_partial_copy_sparc_generic)
 __csum_partial_copy_sparc_generic:
 					/* %o0=src, %o1=dest, %g1=len, %g7=sum */
 	xor	%o0, %o1, %o4		! get changing bits
diff --git a/arch/sparc/lib/checksum_64.S b/arch/sparc/lib/checksum_64.S
index 1d230f6..f673217 100644
--- a/arch/sparc/lib/checksum_64.S
+++ b/arch/sparc/lib/checksum_64.S
@@ -13,6 +13,7 @@
  *	BSD4.4 portable checksum routine
  */
 
+#include <asm/export.h>
 	.text
 
 csum_partial_fix_alignment:
@@ -37,6 +38,7 @@ csum_partial_fix_alignment:
 
 	.align		32
 	.globl		csum_partial
+	EXPORT_SYMBOL(csum_partial)
 csum_partial:		/* %o0=buff, %o1=len, %o2=sum */
 	prefetch	[%o0 + 0x000], #n_reads
 	clr		%o4
diff --git a/arch/sparc/lib/clear_page.S b/arch/sparc/lib/clear_page.S
index 46272df..f30d6b7 100644
--- a/arch/sparc/lib/clear_page.S
+++ b/arch/sparc/lib/clear_page.S
@@ -10,6 +10,7 @@
 #include <asm/pgtable.h>
 #include <asm/spitfire.h>
 #include <asm/head.h>
+#include <asm/export.h>
 
 	/* What we used to do was lock a TLB entry into a specific
 	 * TLB slot, clear the page with interrupts disabled, then
@@ -26,6 +27,7 @@
 	.text
 
 	.globl		_clear_page
+	EXPORT_SYMBOL(_clear_page)
 _clear_page:		/* %o0=dest */
 	ba,pt		%xcc, clear_page_common
 	 clr		%o4
@@ -35,6 +37,7 @@ _clear_page:		/* %o0=dest */
 	 */
 	.align		32
 	.globl		clear_user_page
+	EXPORT_SYMBOL(clear_user_page)
 clear_user_page:	/* %o0=dest, %o1=vaddr */
 	lduw		[%g6 + TI_PRE_COUNT], %o2
 	sethi		%hi(PAGE_OFFSET), %g2
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 302c0e6..482de09 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -5,6 +5,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asi.h>
+#include <asm/export.h>
 
 #define XCC xcc
 
@@ -90,3 +91,4 @@ ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 	retl
 	 clr		%o0
 ENDPROC(___copy_in_user)
+EXPORT_SYMBOL(___copy_in_user)
diff --git a/arch/sparc/lib/copy_page.S b/arch/sparc/lib/copy_page.S
index dd16c61..7197b72 100644
--- a/arch/sparc/lib/copy_page.S
+++ b/arch/sparc/lib/copy_page.S
@@ -10,6 +10,7 @@
 #include <asm/pgtable.h>
 #include <asm/spitfire.h>
 #include <asm/head.h>
+#include <asm/export.h>
 
 	/* What we used to do was lock a TLB entry into a specific
 	 * TLB slot, clear the page with interrupts disabled, then
@@ -44,6 +45,7 @@
 	.align		32
 	.globl		copy_user_page
 	.type		copy_user_page,#function
+	EXPORT_SYMBOL(copy_user_page)
 copy_user_page:		/* %o0=dest, %o1=src, %o2=vaddr */
 	lduw		[%g6 + TI_PRE_COUNT], %o4
 	sethi		%hi(PAGE_OFFSET), %g2
diff --git a/arch/sparc/lib/copy_user.S b/arch/sparc/lib/copy_user.S
index ef095b6..cea644d 100644
--- a/arch/sparc/lib/copy_user.S
+++ b/arch/sparc/lib/copy_user.S
@@ -15,6 +15,7 @@
 #include <asm/asmmacro.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
+#include <asm/export.h>
 
 /* Work around cpp -rob */
 #define ALLOC #alloc
@@ -119,6 +120,7 @@
 __copy_user_begin:
 
 	.globl	__copy_user
+	EXPORT_SYMBOL(__copy_user)
 dword_align:
 	andcc	%o1, 1, %g0
 	be	4f
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index e566c77..0ecbafc 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -3,6 +3,8 @@
  * Copyright (C) 2005 David S. Miller <davem@davemloft.net>
  */
 
+#include <asm/export.h>
+
 #ifdef __KERNEL__
 #define GLOBAL_SPARE	%g7
 #else
@@ -63,6 +65,7 @@
 	 add		%o5, %o4, %o4
 
 	.globl		FUNC_NAME
+	EXPORT_SYMBOL(FUNC_NAME)
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len, %o3=sum */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
diff --git a/arch/sparc/lib/divdi3.S b/arch/sparc/lib/divdi3.S
index 9614b48..a2b5a97 100644
--- a/arch/sparc/lib/divdi3.S
+++ b/arch/sparc/lib/divdi3.S
@@ -17,6 +17,7 @@ along with GNU CC; see the file COPYING.  If not, write to
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
 
+#include <asm/export.h>
 	.text
 	.align 4
 	.globl __divdi3
@@ -279,3 +280,4 @@ __divdi3:
 .LL81:
 	ret
 	restore
+EXPORT_SYMBOL(__divdi3)
diff --git a/arch/sparc/lib/ffs.S b/arch/sparc/lib/ffs.S
index b39389f..23aab14 100644
--- a/arch/sparc/lib/ffs.S
+++ b/arch/sparc/lib/ffs.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.register	%g2,#scratch
 
@@ -65,6 +66,8 @@ ENTRY(__ffs)
 	 add	%o2, %g1, %o0
 ENDPROC(ffs)
 ENDPROC(__ffs)
+EXPORT_SYMBOL(__ffs)
+EXPORT_SYMBOL(ffs)
 
 	.section	.popc_6insn_patch, "ax"
 	.word		ffs
diff --git a/arch/sparc/lib/hweight.S b/arch/sparc/lib/hweight.S
index 95414e0..f9985f1 100644
--- a/arch/sparc/lib/hweight.S
+++ b/arch/sparc/lib/hweight.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 	.align	32
@@ -7,6 +8,7 @@ ENTRY(__arch_hweight8)
 	 nop
 	nop
 ENDPROC(__arch_hweight8)
+EXPORT_SYMBOL(__arch_hweight8)
 	.section	.popc_3insn_patch, "ax"
 	.word		__arch_hweight8
 	sllx		%o0, 64-8, %g1
@@ -19,6 +21,7 @@ ENTRY(__arch_hweight16)
 	 nop
 	nop
 ENDPROC(__arch_hweight16)
+EXPORT_SYMBOL(__arch_hweight16)
 	.section	.popc_3insn_patch, "ax"
 	.word		__arch_hweight16
 	sllx		%o0, 64-16, %g1
@@ -31,6 +34,7 @@ ENTRY(__arch_hweight32)
 	 nop
 	nop
 ENDPROC(__arch_hweight32)
+EXPORT_SYMBOL(__arch_hweight32)
 	.section	.popc_3insn_patch, "ax"
 	.word		__arch_hweight32
 	sllx		%o0, 64-32, %g1
@@ -43,6 +47,7 @@ ENTRY(__arch_hweight64)
 	 nop
 	nop
 ENDPROC(__arch_hweight64)
+EXPORT_SYMBOL(__arch_hweight64)
 	.section	.popc_3insn_patch, "ax"
 	.word		__arch_hweight64
 	retl
diff --git a/arch/sparc/lib/ipcsum.S b/arch/sparc/lib/ipcsum.S
index 4742d59..5d61648 100644
--- a/arch/sparc/lib/ipcsum.S
+++ b/arch/sparc/lib/ipcsum.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(ip_fast_csum) /* %o0 = iph, %o1 = ihl */
@@ -31,3 +32,4 @@ ENTRY(ip_fast_csum) /* %o0 = iph, %o1 = ihl */
 	retl
 	 and	%o2, %o1, %o0
 ENDPROC(ip_fast_csum)
+EXPORT_SYMBOL(ip_fast_csum)
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
deleted file mode 100644
index 8eb454c..0000000
--- a/arch/sparc/lib/ksyms.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Export of symbols defined in assembler
- */
-
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/types.h>
-
-#include <asm/checksum.h>
-#include <asm/uaccess.h>
-#include <asm/ftrace.h>
-
-/* string functions */
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncmp);
-
-/* mem* functions */
-extern void *__memscan_zero(void *, size_t);
-extern void *__memscan_generic(void *, int, size_t);
-extern void *__bzero(void *, size_t);
-
-EXPORT_SYMBOL(memscan);
-EXPORT_SYMBOL(__memscan_zero);
-EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(__bzero);
-
-/* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial);
-
-#ifdef CONFIG_MCOUNT
-EXPORT_SYMBOL(_mcount);
-#endif
-
-/*
- * sparc
- */
-#ifdef CONFIG_SPARC32
-extern int __ashrdi3(int, int);
-extern int __ashldi3(int, int);
-extern int __lshrdi3(int, int);
-extern int __muldi3(int, int);
-extern int __divdi3(int, int);
-
-extern void (*__copy_1page)(void *, const void *);
-extern void (*bzero_1page)(void *);
-
-extern void ___rw_read_enter(void);
-extern void ___rw_read_try(void);
-extern void ___rw_read_exit(void);
-extern void ___rw_write_enter(void);
-
-/* Networking helper routines. */
-EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
-
-/* Special internal versions of library functions. */
-EXPORT_SYMBOL(__copy_1page);
-EXPORT_SYMBOL(__memmove);
-EXPORT_SYMBOL(bzero_1page);
-
-/* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(__copy_user);
-
-/* Used by asm/spinlock.h */
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(___rw_read_enter);
-EXPORT_SYMBOL(___rw_read_try);
-EXPORT_SYMBOL(___rw_read_exit);
-EXPORT_SYMBOL(___rw_write_enter);
-#endif
-
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__muldi3);
-EXPORT_SYMBOL(__divdi3);
-#endif
-
-/*
- * sparc64
- */
-#ifdef CONFIG_SPARC64
-/* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
-EXPORT_SYMBOL(__csum_partial_copy_from_user);
-EXPORT_SYMBOL(__csum_partial_copy_to_user);
-EXPORT_SYMBOL(ip_fast_csum);
-
-/* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(___copy_to_user);
-EXPORT_SYMBOL(___copy_from_user);
-EXPORT_SYMBOL(___copy_in_user);
-EXPORT_SYMBOL(__clear_user);
-
-/* Atomic counter implementation. */
-#define ATOMIC_OP(op)							\
-EXPORT_SYMBOL(atomic_##op);						\
-EXPORT_SYMBOL(atomic64_##op);
-
-#define ATOMIC_OP_RETURN(op)						\
-EXPORT_SYMBOL(atomic_##op##_return);					\
-EXPORT_SYMBOL(atomic64_##op##_return);
-
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
-
-ATOMIC_OPS(add)
-ATOMIC_OPS(sub)
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
-
-#undef ATOMIC_OPS
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
-
-EXPORT_SYMBOL(atomic64_dec_if_positive);
-
-/* Atomic bit operations. */
-EXPORT_SYMBOL(test_and_set_bit);
-EXPORT_SYMBOL(test_and_clear_bit);
-EXPORT_SYMBOL(test_and_change_bit);
-EXPORT_SYMBOL(set_bit);
-EXPORT_SYMBOL(clear_bit);
-EXPORT_SYMBOL(change_bit);
-
-/* Special internal versions of library functions. */
-EXPORT_SYMBOL(_clear_page);
-EXPORT_SYMBOL(clear_user_page);
-EXPORT_SYMBOL(copy_user_page);
-
-/* RAID code needs this */
-void VISenter(void);
-EXPORT_SYMBOL(VISenter);
-
-extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
-		unsigned long *);
-extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
-		unsigned long *, unsigned long *);
-extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
-		unsigned long *, unsigned long *, unsigned long *);
-EXPORT_SYMBOL(xor_vis_2);
-EXPORT_SYMBOL(xor_vis_3);
-EXPORT_SYMBOL(xor_vis_4);
-EXPORT_SYMBOL(xor_vis_5);
-
-extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
-		unsigned long *);
-extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
-		unsigned long *, unsigned long *);
-extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
-		unsigned long *, unsigned long *, unsigned long *);
-
-EXPORT_SYMBOL(xor_niagara_2);
-EXPORT_SYMBOL(xor_niagara_3);
-EXPORT_SYMBOL(xor_niagara_4);
-EXPORT_SYMBOL(xor_niagara_5);
-#endif
diff --git a/arch/sparc/lib/locks.S b/arch/sparc/lib/locks.S
index 64f53f2..f38c4e5 100644
--- a/arch/sparc/lib/locks.S
+++ b/arch/sparc/lib/locks.S
@@ -10,6 +10,7 @@
 #include <asm/psr.h>
 #include <asm/smp.h>
 #include <asm/spinlock.h>
+#include <asm/export.h>
 
 	.text
 	.align	4
@@ -48,6 +49,7 @@ ___rw_write_enter_spin_on_wlock:
 	 ld	[%g1], %g2
 
 	.globl	___rw_read_enter
+EXPORT_SYMBOL(___rw_read_enter)
 ___rw_read_enter:
 	orcc	%g2, 0x0, %g0
 	bne,a	___rw_read_enter_spin_on_wlock
@@ -59,6 +61,7 @@ ___rw_read_enter:
 	 mov	%g4, %o7
 
 	.globl	___rw_read_exit
+EXPORT_SYMBOL(___rw_read_exit)
 ___rw_read_exit:
 	orcc	%g2, 0x0, %g0
 	bne,a	___rw_read_exit_spin_on_wlock
@@ -70,6 +73,7 @@ ___rw_read_exit:
 	 mov	%g4, %o7
 
 	.globl	___rw_read_try
+EXPORT_SYMBOL(___rw_read_try)
 ___rw_read_try:
 	orcc	%g2, 0x0, %g0
 	bne	___rw_read_try_spin_on_wlock
@@ -81,6 +85,7 @@ ___rw_read_try:
 	 mov	%g4, %o7
 
 	.globl	___rw_write_enter
+EXPORT_SYMBOL(___rw_write_enter)
 ___rw_write_enter:
 	orcc	%g2, 0x0, %g0
 	bne	___rw_write_enter_spin_on_wlock
diff --git a/arch/sparc/lib/lshrdi3.S b/arch/sparc/lib/lshrdi3.S
index 60ebc7c..c9b9373 100644
--- a/arch/sparc/lib/lshrdi3.S
+++ b/arch/sparc/lib/lshrdi3.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 ENTRY(__lshrdi3)
 	cmp	%o2, 0
@@ -25,3 +26,4 @@ ENTRY(__lshrdi3)
 	retl 
 	 nop 
 ENDPROC(__lshrdi3)
+EXPORT_SYMBOL(__lshrdi3)
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index 0b0ed4d..194f383 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 /*
  * This is the main variant and is called by C code.  GCC's -pg option
@@ -16,6 +17,7 @@
 	.align		32
 	.globl		_mcount
 	.type		_mcount,#function
+	EXPORT_SYMBOL(_mcount)
 	.globl		mcount
 	.type		mcount,#function
 _mcount:
diff --git a/arch/sparc/lib/memcmp.S b/arch/sparc/lib/memcmp.S
index efa106c..cee7f30 100644
--- a/arch/sparc/lib/memcmp.S
+++ b/arch/sparc/lib/memcmp.S
@@ -6,6 +6,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asm.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(memcmp)
@@ -25,3 +26,4 @@ ENTRY(memcmp)
 2:	retl
 	 mov	0, %o0
 ENDPROC(memcmp)
+EXPORT_SYMBOL(memcmp)
diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index 4d8c497..1dc8ec5 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -7,6 +7,7 @@
  * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
+#include <asm/export.h>
 #define FUNC(x) 		\
 	.globl	x;		\
 	.type	x,@function;	\
@@ -143,8 +144,10 @@ x:
 #ifdef __KERNEL__
 FUNC(amemmove)
 FUNC(__memmove)
+EXPORT_SYMBOL(__memmove)
 #endif
 FUNC(memmove)
+EXPORT_SYMBOL(memmove)
 	cmp		%o0, %o1
 	mov		%o0, %g7
 	bleu		9f
@@ -202,6 +205,7 @@ FUNC(memmove)
 	 add		%o0, 2, %o0
 
 FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
+EXPORT_SYMBOL(memcpy)
 
 	sub		%o0, %o1, %o4
 	mov		%o0, %g7
diff --git a/arch/sparc/lib/memmove.S b/arch/sparc/lib/memmove.S
index 857ad4f..012cdb6 100644
--- a/arch/sparc/lib/memmove.S
+++ b/arch/sparc/lib/memmove.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(memmove) /* o0=dst o1=src o2=len */
@@ -57,3 +58,4 @@ ENTRY(memmove) /* o0=dst o1=src o2=len */
 	 stb		%g7, [%o0 - 0x1]
 	ba,a,pt		%xcc, 99b
 ENDPROC(memmove)
+EXPORT_SYMBOL(memmove)
diff --git a/arch/sparc/lib/memscan_32.S b/arch/sparc/lib/memscan_32.S
index 4ff1657..51ce690 100644
--- a/arch/sparc/lib/memscan_32.S
+++ b/arch/sparc/lib/memscan_32.S
@@ -4,6 +4,8 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <asm/export.h>
+
 /* In essence, this is just a fancy strlen. */
 
 #define LO_MAGIC 0x01010101
@@ -13,6 +15,8 @@
 	.align	4
 	.globl	__memscan_zero, __memscan_generic
 	.globl	memscan
+EXPORT_SYMBOL(__memscan_zero)
+EXPORT_SYMBOL(__memscan_generic)
 __memscan_zero:
 	/* %o0 = addr, %o1 = size */
 	cmp	%o1, 0
diff --git a/arch/sparc/lib/memscan_64.S b/arch/sparc/lib/memscan_64.S
index 5686dfa..daa96f4 100644
--- a/arch/sparc/lib/memscan_64.S
+++ b/arch/sparc/lib/memscan_64.S
@@ -5,6 +5,8 @@
  * Copyright (C) 1998 David S. Miller (davem@redhat.com)
  */
 
+	#include <asm/export.h>
+
 #define HI_MAGIC	0x8080808080808080
 #define LO_MAGIC	0x0101010101010101
 #define ASI_PL		0x88
@@ -13,6 +15,8 @@
 	.align	32
 	.globl		__memscan_zero, __memscan_generic
 	.globl		memscan
+	EXPORT_SYMBOL(__memscan_zero)
+	EXPORT_SYMBOL(__memscan_generic)
 
 __memscan_zero:
 	/* %o0 = bufp, %o1 = size */
diff --git a/arch/sparc/lib/memset.S b/arch/sparc/lib/memset.S
index f75e690..bb539b4 100644
--- a/arch/sparc/lib/memset.S
+++ b/arch/sparc/lib/memset.S
@@ -9,6 +9,7 @@
  */
 
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 /* Work around cpp -rob */
 #define ALLOC #alloc
@@ -63,6 +64,8 @@ __bzero_begin:
 
 	.globl	__bzero
 	.globl	memset
+	EXPORT_SYMBOL(__bzero)
+	EXPORT_SYMBOL(memset)
 	.globl	__memset_start, __memset_end
 __memset_start:
 memset:
diff --git a/arch/sparc/lib/muldi3.S b/arch/sparc/lib/muldi3.S
index 9794939..17a0f49 100644
--- a/arch/sparc/lib/muldi3.S
+++ b/arch/sparc/lib/muldi3.S
@@ -17,6 +17,7 @@ along with GNU CC; see the file COPYING.  If not, write to
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
 
+#include <asm/export.h>
 	.text
 	.align 4
 	.globl __muldi3
@@ -74,3 +75,4 @@ __muldi3:
 	add  %l2, %l0, %i0
 	ret 
 	restore  %g0, %l3, %o1
+EXPORT_SYMBOL(__muldi3)
diff --git a/arch/sparc/lib/strlen.S b/arch/sparc/lib/strlen.S
index 536f835..ca0e7077e 100644
--- a/arch/sparc/lib/strlen.S
+++ b/arch/sparc/lib/strlen.S
@@ -7,6 +7,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asm.h>
+#include <asm/export.h>
 
 #define LO_MAGIC 0x01010101
 #define HI_MAGIC 0x80808080
@@ -78,3 +79,4 @@ ENTRY(strlen)
 	retl
 	 mov	2, %o0
 ENDPROC(strlen)
+EXPORT_SYMBOL(strlen)
diff --git a/arch/sparc/lib/strncmp_32.S b/arch/sparc/lib/strncmp_32.S
index c0d1b56..e3fe014 100644
--- a/arch/sparc/lib/strncmp_32.S
+++ b/arch/sparc/lib/strncmp_32.S
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(strncmp)
@@ -116,3 +117,4 @@ ENTRY(strncmp)
 	retl
 	 sub	%o3, %o0, %o0
 ENDPROC(strncmp)
+EXPORT_SYMBOL(strncmp)
diff --git a/arch/sparc/lib/strncmp_64.S b/arch/sparc/lib/strncmp_64.S
index 0656627..efb5f88 100644
--- a/arch/sparc/lib/strncmp_64.S
+++ b/arch/sparc/lib/strncmp_64.S
@@ -6,6 +6,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asi.h>
+#include <asm/export.h>
 
 	.text
 ENTRY(strncmp)
@@ -28,3 +29,4 @@ ENTRY(strncmp)
 	retl
 	 clr	%o0
 ENDPROC(strncmp)
+EXPORT_SYMBOL(strncmp)
diff --git a/arch/sparc/lib/xor.S b/arch/sparc/lib/xor.S
index 2c05641..45a49cb 100644
--- a/arch/sparc/lib/xor.S
+++ b/arch/sparc/lib/xor.S
@@ -13,6 +13,7 @@
 #include <asm/asi.h>
 #include <asm/dcu.h>
 #include <asm/spitfire.h>
+#include <asm/export.h>
 
 /*
  *	Requirements:
@@ -90,6 +91,7 @@ ENTRY(xor_vis_2)
 	retl
 	  wr	%g0, 0, %fprs
 ENDPROC(xor_vis_2)
+EXPORT_SYMBOL(xor_vis_2)
 
 ENTRY(xor_vis_3)
 	rd	%fprs, %o5
@@ -156,6 +158,7 @@ ENTRY(xor_vis_3)
 	retl
 	 wr	%g0, 0, %fprs
 ENDPROC(xor_vis_3)
+EXPORT_SYMBOL(xor_vis_3)
 
 ENTRY(xor_vis_4)
 	rd	%fprs, %o5
@@ -241,6 +244,7 @@ ENTRY(xor_vis_4)
 	retl
 	 wr	%g0, 0, %fprs
 ENDPROC(xor_vis_4)
+EXPORT_SYMBOL(xor_vis_4)
 
 ENTRY(xor_vis_5)
 	save	%sp, -192, %sp
@@ -347,6 +351,7 @@ ENTRY(xor_vis_5)
 	ret
 	 restore
 ENDPROC(xor_vis_5)
+EXPORT_SYMBOL(xor_vis_5)
 
 	/* Niagara versions. */
 ENTRY(xor_niagara_2) /* %o0=bytes, %o1=dest, %o2=src */
@@ -393,6 +398,7 @@ ENTRY(xor_niagara_2) /* %o0=bytes, %o1=dest, %o2=src */
 	ret
 	 restore
 ENDPROC(xor_niagara_2)
+EXPORT_SYMBOL(xor_niagara_2)
 
 ENTRY(xor_niagara_3) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2 */
 	save		%sp, -192, %sp
@@ -454,6 +460,7 @@ ENTRY(xor_niagara_3) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2 */
 	ret
 	 restore
 ENDPROC(xor_niagara_3)
+EXPORT_SYMBOL(xor_niagara_3)
 
 ENTRY(xor_niagara_4) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3 */
 	save		%sp, -192, %sp
@@ -536,6 +543,7 @@ ENTRY(xor_niagara_4) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3 */
 	ret
 	 restore
 ENDPROC(xor_niagara_4)
+EXPORT_SYMBOL(xor_niagara_4)
 
 ENTRY(xor_niagara_5) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3, %o5=src4 */
 	save		%sp, -192, %sp
@@ -634,3 +642,4 @@ ENTRY(xor_niagara_5) /* %o0=bytes, %o1=dest, %o2=src1, %o3=src2, %o4=src3, %o5=s
 	ret
 	 restore
 ENDPROC(xor_niagara_5)
+EXPORT_SYMBOL(xor_niagara_5)
-- 
2.1.4
