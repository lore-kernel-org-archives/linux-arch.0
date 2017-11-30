From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 10/27] x86: head, annotate data appropriatelly
Date: Thu, 30 Nov 2017 15:46:36 +0100
Message-ID: <20171130144653.23688-11-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48131 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbdK3OrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Nov 2017 09:47:00 -0500
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END in both 32 and 64
bit heads.  In the 64-bit version, define also
SYM_DATA_START_PAGE_ALIGNED locally using the new SYM_START. It is used
in the code instead of NEXT_PAGE() which was defined in this file and
has been using the obsolete macro GLOBAL().

Now, the data in the 64-bit object file look sane:
Value   Size Type    Bind   Vis      Ndx Name
  0000  4096 OBJECT  GLOBAL DEFAULT   15 init_level4_pgt
  1000  4096 OBJECT  GLOBAL DEFAULT   15 level3_kernel_pgt
  2000  2048 OBJECT  GLOBAL DEFAULT   15 level2_kernel_pgt
  3000  4096 OBJECT  GLOBAL DEFAULT   15 level2_fixmap_pgt
  4000  4096 OBJECT  GLOBAL DEFAULT   15 level1_fixmap_pgt
  5000     2 OBJECT  GLOBAL DEFAULT   15 early_gdt_descr
  5002     8 OBJECT  LOCAL  DEFAULT   15 early_gdt_descr_base
  500a     8 OBJECT  GLOBAL DEFAULT   15 phys_base
  0000     8 OBJECT  GLOBAL DEFAULT   17 initial_code
  0008     8 OBJECT  GLOBAL DEFAULT   17 initial_gs
  0010     8 OBJECT  GLOBAL DEFAULT   17 initial_stack
  0000     4 OBJECT  GLOBAL DEFAULT   19 early_recursion_flag
  1000  4096 OBJECT  GLOBAL DEFAULT   19 early_level4_pgt
  2000 0x40000 OBJECT  GLOBAL DEFAULT   19 early_dynamic_pgts
  0000  4096 OBJECT  GLOBAL DEFAULT   22 empty_zero_page

All have correct size and type.

Note, that we can now see that it might be worth pushing
early_recursion_flag after early_dynamic_pgts -- we are wasting almost
4K of .init.data.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/head_32.S | 29 ++++++++++--------
 arch/x86/kernel/head_64.S | 78 +++++++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index a7bbb3c45faa..a2bc3e35c2c6 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -502,8 +502,7 @@ ENDPROC(early_ignore_irq)
 
 __INITDATA
 	.align 4
-GLOBAL(early_recursion_flag)
-	.long 0
+SYM_DATA(early_recursion_flag, .long 0)
 
 __REFDATA
 	.align 4
@@ -541,7 +540,7 @@ EXPORT_SYMBOL(empty_zero_page)
 __PAGE_ALIGNED_DATA
 	/* Page-aligned for the benefit of paravirt? */
 	.align PAGE_SIZE
-ENTRY(initial_page_table)
+SYM_DATA_START(initial_page_table)
 	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0	/* low identity map */
 # if KPMDS == 3
 	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0
@@ -559,17 +558,18 @@ ENTRY(initial_page_table)
 #  error "Kernel PMDs should be 1, 2 or 3"
 # endif
 	.align PAGE_SIZE		/* needs to be page-sized too */
+SYM_DATA_END(initial_page_table)
 #endif
 
 .data
 .balign 4
-ENTRY(initial_stack)
-	/*
-	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
-	 * unwinder reliably detect the end of the stack.
-	 */
-	.long init_thread_union + THREAD_SIZE - SIZEOF_PTREGS - \
-	      TOP_OF_KERNEL_STACK_PADDING;
+/*
+ * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * reliably detect the end of the stack.
+ */
+SYM_DATA(initial_stack,
+		.long init_thread_union + THREAD_SIZE -
+		SIZEOF_PTREGS - TOP_OF_KERNEL_STACK_PADDING)
 
 __INITRODATA
 int_msg:
@@ -590,22 +590,25 @@ int_msg:
 	ALIGN
 # early boot GDT descriptor (must use 1:1 address mapping)
 	.word 0				# 32 bit align gdt_desc.address
-boot_gdt_descr:
+SYM_DATA_START(boot_gdt_descr)
 	.word __BOOT_DS+7
 	.long boot_gdt - __PAGE_OFFSET
+SYM_DATA_END(boot_gdt_descr)
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
-ENTRY(early_gdt_descr)
+SYM_DATA_START(early_gdt_descr)
 	.word GDT_ENTRIES*8-1
 	.long gdt_page			/* Overwritten for secondary CPUs */
+SYM_DATA_END(early_gdt_descr)
 
 /*
  * The boot_gdt must mirror the equivalent in setup.S and is
  * used only for booting.
  */
 	.align L1_CACHE_BYTES
-ENTRY(boot_gdt)
+SYM_DATA_START(boot_gdt)
 	.fill GDT_ENTRY_BOOT_CS,8,0
 	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
+SYM_DATA_END(boot_gdt)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c8aa44e7c7f3..53d9d7f65f55 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -256,16 +256,14 @@ ENDPROC(start_cpu0)
 	/* Both SMP bootup and ACPI suspend change these variables */
 	__REFDATA
 	.balign	8
-	GLOBAL(initial_code)
-	.quad	x86_64_start_kernel
-	GLOBAL(initial_gs)
-	.quad	INIT_PER_CPU_VAR(irq_stack_union)
-	GLOBAL(initial_stack)
-	/*
-	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
-	 * unwinder reliably detect the end of the stack.
-	 */
-	.quad  init_thread_union + THREAD_SIZE - SIZEOF_PTREGS
+SYM_DATA(initial_code,	.quad x86_64_start_kernel)
+SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(irq_stack_union))
+/*
+ * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * reliably detect the end of the stack.
+ */
+SYM_DATA(initial_stack,
+		.quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)
 	__FINITDATA
 
 	__INIT
@@ -334,12 +332,10 @@ SYM_CODE_END(early_idt_handler_common)
 	__INITDATA
 
 	.balign 4
-GLOBAL(early_recursion_flag)
-	.long 0
+SYM_DATA(early_recursion_flag, .long 0)
 
-#define NEXT_PAGE(name) \
-	.balign	PAGE_SIZE; \
-GLOBAL(name)
+#define SYM_DATA_START_PAGE_ALIGNED(name)			\
+	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
 
 #ifdef CONFIG_KAISER
 /*
@@ -354,11 +350,11 @@ GLOBAL(name)
  */
 #define KAISER_USER_PGD_FILL	512
 /* This ensures they are 8k-aligned: */
-#define NEXT_PGD_PAGE(name) \
-	.balign 2 * PAGE_SIZE; \
-GLOBAL(name)
+#define SYM_DATA_START_KAISER_ALIGNED(name) \
+	SYM_START(name, SYM_L_GLOBAL, .balign 2 * PAGE_SIZE)
 #else
-#define NEXT_PGD_PAGE(name) NEXT_PAGE(name)
+#define SYM_DATA_START_KAISER_ALIGNED(name) \
+	SYM_DATA_START_PAGE_ALIGNED(name)
 #define KAISER_USER_PGD_FILL	0
 #endif
 
@@ -371,7 +367,7 @@ GLOBAL(name)
 	.endr
 
 	__INITDATA
-NEXT_PGD_PAGE(early_top_pgt)
+SYM_DATA_START_KAISER_ALIGNED(early_top_pgt)
 	.fill	511,8,0
 #ifdef CONFIG_X86_5LEVEL
 	.quad	level4_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
@@ -379,14 +375,16 @@ NEXT_PGD_PAGE(early_top_pgt)
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 #endif
 	.fill	KAISER_USER_PGD_FILL,8,0
+SYM_DATA_END(early_top_pgt)
 
-NEXT_PAGE(early_dynamic_pgts)
+SYM_DATA_START_PAGE_ALIGNED(early_dynamic_pgts)
 	.fill	512*EARLY_DYNAMIC_PAGE_TABLES,8,0
+SYM_DATA_END(early_dynamic_pgts)
 
 	.data
 
 #if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
-NEXT_PGD_PAGE(init_top_pgt)
+SYM_DATA_START_KAISER_ALIGNED(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.org    init_top_pgt + PGD_PAGE_OFFSET*8, 0
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
@@ -394,34 +392,40 @@ NEXT_PGD_PAGE(init_top_pgt)
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
 	.quad   level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	KAISER_USER_PGD_FILL,8,0
+SYM_DATA_END(init_top_pgt)
 
-NEXT_PAGE(level3_ident_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.fill	511, 8, 0
-NEXT_PAGE(level2_ident_pgt)
+SYM_DATA_END(level3_ident_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level2_ident_pgt)
 	/* Since I easily can, map the first 1G.
 	 * Don't set NX because code runs from these pages.
 	 */
 	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
+SYM_DATA_END(level2_ident_pgt)
 #else
-NEXT_PGD_PAGE(init_top_pgt)
+SYM_DATA_START_KAISER_ALIGNED(init_top_pgt)
 	.fill	512,8,0
 	.fill	KAISER_USER_PGD_FILL,8,0
+SYM_DATA_END(init_top_pgt)
 #endif
 
 #ifdef CONFIG_X86_5LEVEL
-NEXT_PAGE(level4_kernel_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level4_kernel_pgt)
 	.fill	511,8,0
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+SYM_DATA_END(level4_kernel_pgt)
 #endif
 
-NEXT_PAGE(level3_kernel_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
 	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.quad	level2_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+SYM_DATA_END(level3_kernel_pgt)
 
-NEXT_PAGE(level2_kernel_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	/*
 	 * 512 MB kernel mapping. We spend a full page on this pagetable
 	 * anyway.
@@ -434,25 +438,26 @@ NEXT_PAGE(level2_kernel_pgt)
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
+SYM_DATA_END(level2_kernel_pgt)
 
-NEXT_PAGE(level2_fixmap_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
 	.fill	506,8,0
 	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
 	.fill	5,8,0
+SYM_DATA_END(level2_fixmap_pgt)
 
-NEXT_PAGE(level1_fixmap_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level1_fixmap_pgt)
 	.fill	512,8,0
+SYM_DATA_END(level1_fixmap_pgt)
 
 #undef PMDS
 
 	.data
 	.align 16
-	.globl early_gdt_descr
-early_gdt_descr:
-	.word	GDT_ENTRIES*8-1
-early_gdt_descr_base:
-	.quad	INIT_PER_CPU_VAR(gdt_page)
+
+SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
+SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
 
 /* This must match the first entry in level2_kernel_pgt */
 SYM_DATA(phys_base, .quad 0x0000000000000000)
@@ -461,7 +466,8 @@ EXPORT_SYMBOL(phys_base)
 #include "../../x86/xen/xen-head.S"
 
 	__PAGE_ALIGNED_BSS
-NEXT_PAGE(empty_zero_page)
+SYM_DATA_START_PAGE_ALIGNED(empty_zero_page)
 	.skip PAGE_SIZE
+SYM_DATA_END(empty_zero_page)
 EXPORT_SYMBOL(empty_zero_page)
 
-- 
2.15.0
