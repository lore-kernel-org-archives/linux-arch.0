From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 7/7] kprobes: port to linker table
Date: Fri, 19 Feb 2016 05:45:59 -0800
Message-ID: <1455889559-9428-8-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-arch.vger.kernel.org

kprobe makes use of two custom sections:

type       name                  begin                    end
init.data _kprobe_blacklist __start_kprobe_blacklist	__stop_kprobe_blacklist
text      .kprobes.text     __kprobes_text_start        __kprobes_text_end

Port these to the linker table generic solution. This lets
us remove all the custom kprobe section declarations on the
linker script.

Tested with CONFIG_KPROBES_SANITY_TEST, it passes with:

Kprobe smoke test: started
Kprobe smoke test: passed successfully

Then tested CONFIG_SAMPLE_KPROBES on do_fork, and the
kprobe bites and kicks as expected. Lastly tried registering
a kprobe on a kprobe blacklisted symbol (NOKPROBE_SYMBOL()),
and confirms that fails to work.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/arc/kernel/vmlinux.lds.S        |  1 -
 arch/arm/kernel/entry-armv.S         |  2 +-
 arch/arm/kernel/vmlinux.lds.S        |  1 -
 arch/avr32/kernel/entry-avr32b.S     |  4 ++--
 arch/avr32/kernel/vmlinux.lds.S      |  1 -
 arch/blackfin/kernel/vmlinux.lds.S   |  1 -
 arch/c6x/kernel/vmlinux.lds.S        |  1 -
 arch/hexagon/kernel/vmlinux.lds.S    |  1 -
 arch/ia64/kernel/jprobes.S           |  2 +-
 arch/ia64/kernel/vmlinux.lds.S       |  1 -
 arch/ia64/lib/flush.S                |  4 ++--
 arch/metag/kernel/vmlinux.lds.S      |  1 -
 arch/microblaze/kernel/vmlinux.lds.S |  1 -
 arch/mips/kernel/vmlinux.lds.S       |  1 -
 arch/mn10300/kernel/vmlinux.lds.S    |  1 -
 arch/nios2/kernel/vmlinux.lds.S      |  1 -
 arch/openrisc/kernel/vmlinux.lds.S   |  1 -
 arch/parisc/kernel/vmlinux.lds.S     |  1 -
 arch/powerpc/include/asm/ppc_asm.h   |  6 +++---
 arch/powerpc/kernel/vmlinux.lds.S    |  1 -
 arch/s390/kernel/entry.S             |  4 ++--
 arch/s390/kernel/kprobes.c           |  2 +-
 arch/s390/kernel/mcount.S            |  2 +-
 arch/s390/kernel/vmlinux.lds.S       |  1 -
 arch/score/kernel/vmlinux.lds.S      |  1 -
 arch/sh/kernel/vmlinux.lds.S         |  1 -
 arch/sparc/kernel/vmlinux.lds.S      |  1 -
 arch/sparc/mm/ultra.S                |  2 +-
 arch/tile/kernel/vmlinux.lds.S       |  1 -
 arch/x86/kernel/kprobes/core.c       | 10 ++++++----
 arch/x86/kernel/vmlinux.lds.S        |  1 -
 include/asm-generic/sections.h       |  4 ++--
 include/asm-generic/vmlinux.lds.h    | 16 ----------------
 include/linux/compiler.h             |  3 ++-
 include/linux/kprobes.h              |  7 +++++--
 kernel/kprobes.c                     | 16 +++++++---------
 scripts/mod/modpost.c                |  3 ++-
 scripts/recordmcount.c               |  3 ++-
 scripts/recordmcount.pl              |  2 +-
 39 files changed, 41 insertions(+), 72 deletions(-)

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 894e696bddaa..52f23df2b9b6 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -98,7 +98,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 	}
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3ce377f7251f..4959a83833fd 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -83,7 +83,7 @@
 	.endm
 
 #ifdef CONFIG_KPROBES
-	.section	.kprobes.text,"ax",%progbits
+	.section	.text.tbl.kprobes.all,"ax",%progbits
 #else
 	.text
 #endif
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 8b60fde5ce48..8de7921ac331 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -108,7 +108,6 @@ SECTIONS
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
-			KPROBES_TEXT
 			*(.gnu.warning)
 			*(.glue_7)
 			*(.glue_7t)
diff --git a/arch/avr32/kernel/entry-avr32b.S b/arch/avr32/kernel/entry-avr32b.S
index 7301f4806bbe..c0fe699d0a21 100644
--- a/arch/avr32/kernel/entry-avr32b.S
+++ b/arch/avr32/kernel/entry-avr32b.S
@@ -605,7 +605,7 @@ fault_exit_work:
 	brcc	fault_resume_user
 	rjmp	enter_monitor_mode
 
-	.section .kprobes.text, "ax", @progbits
+	.section .text.tbl.kprobes.all, "ax", @progbits
 	.type	handle_debug, @function
 handle_debug:
 	sub	sp, 4		/* r12_orig */
@@ -826,7 +826,7 @@ irq_level\level:
 	IRQ_LEVEL 2
 	IRQ_LEVEL 3
 
-	.section .kprobes.text, "ax", @progbits
+	.section .text.tbl.kprobes.all, "ax", @progbits
 	.type	enter_monitor_mode, @function
 enter_monitor_mode:
 	/*
diff --git a/arch/avr32/kernel/vmlinux.lds.S b/arch/avr32/kernel/vmlinux.lds.S
index a4589176bed5..bf4f3f1f9dbb 100644
--- a/arch/avr32/kernel/vmlinux.lds.S
+++ b/arch/avr32/kernel/vmlinux.lds.S
@@ -49,7 +49,6 @@ SECTIONS
 		_stext = .;
 		*(.ex.text)
 		*(.irq.text)
-		KPROBES_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
diff --git a/arch/blackfin/kernel/vmlinux.lds.S b/arch/blackfin/kernel/vmlinux.lds.S
index c9eec84aa258..8a193fad4c5d 100644
--- a/arch/blackfin/kernel/vmlinux.lds.S
+++ b/arch/blackfin/kernel/vmlinux.lds.S
@@ -35,7 +35,6 @@ SECTIONS
 #endif
 		LOCK_TEXT
 		IRQENTRY_TEXT
-		KPROBES_TEXT
 #ifdef CONFIG_ROMKERNEL
 		__sinittext = .;
 		INIT_TEXT
diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index 5a6e141d1641..a23bed62cec3 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -72,7 +72,6 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		IRQENTRY_TEXT
-		KPROBES_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 	}
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 5f268c1071b3..a358b699ec64 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -51,7 +51,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		*(.fixup)
 	}
 	_etext = .;
diff --git a/arch/ia64/kernel/jprobes.S b/arch/ia64/kernel/jprobes.S
index f69389c7be1d..c6c23a3e92fb 100644
--- a/arch/ia64/kernel/jprobes.S
+++ b/arch/ia64/kernel/jprobes.S
@@ -50,7 +50,7 @@
 	/*
 	 * void jprobe_break(void)
 	 */
-	.section .kprobes.text, "ax"
+	.section .text.tbl.kprobes.all, "ax"
 ENTRY(jprobe_break)
 	break.m __IA64_BREAK_JPROBE
 END(jprobe_break)
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index dc506b05ffbd..884f36d38989 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -47,7 +47,6 @@ SECTIONS {
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		*(.gnu.linkonce.t*)
 	}
 
diff --git a/arch/ia64/lib/flush.S b/arch/ia64/lib/flush.S
index 1d8c88860063..7f257810e858 100644
--- a/arch/ia64/lib/flush.S
+++ b/arch/ia64/lib/flush.S
@@ -20,7 +20,7 @@
 	 *
 	 *	Note: "in0" and "in1" are preserved for debugging purposes.
 	 */
-	.section .kprobes.text,"ax"
+	.section .text.tbl.kprobes.all,"ax"
 GLOBAL_ENTRY(flush_icache_range)
 
 	.prologue
@@ -72,7 +72,7 @@ END(flush_icache_range)
 	 *
 	 *	Note: "in0" and "in1" are preserved for debugging purposes.
 	 */
-	.section .kprobes.text,"ax"
+	.section .text.tbl.kprobes.all,"ax"
 GLOBAL_ENTRY(clflush_cache_range)
 
 	.prologue
diff --git a/arch/metag/kernel/vmlinux.lds.S b/arch/metag/kernel/vmlinux.lds.S
index e12055e88bfe..da1689c85bc8 100644
--- a/arch/metag/kernel/vmlinux.lds.S
+++ b/arch/metag/kernel/vmlinux.lds.S
@@ -22,7 +22,6 @@ SECTIONS
 	TEXT_TEXT
 	SCHED_TEXT
 	LOCK_TEXT
-	KPROBES_TEXT
 	IRQENTRY_TEXT
 	*(.text.*)
 	*(.gnu.warning)
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index be9488d69734..94c1c5574a77 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -34,7 +34,6 @@ SECTIONS {
 		EXIT_CALL
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 		. = ALIGN (4) ;
 		_etext = . ;
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 0a93e83cd014..9183e9235651 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -56,7 +56,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 		*(.text.*)
 		*(.fixup)
diff --git a/arch/mn10300/kernel/vmlinux.lds.S b/arch/mn10300/kernel/vmlinux.lds.S
index 13c4814c29f8..ead5efc01802 100644
--- a/arch/mn10300/kernel/vmlinux.lds.S
+++ b/arch/mn10300/kernel/vmlinux.lds.S
@@ -31,7 +31,6 @@ SECTIONS
 	TEXT_TEXT
 	SCHED_TEXT
 	LOCK_TEXT
-	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0xcb
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index 326fab40a9de..dc8a84183700 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -39,7 +39,6 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		IRQENTRY_TEXT
-		KPROBES_TEXT
 	} =0
 	_etext = .;
 
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 2d69a853b742..b010cb75edc4 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -48,7 +48,6 @@ SECTIONS
 	  TEXT_TEXT
 	  SCHED_TEXT
 	  LOCK_TEXT
-	  KPROBES_TEXT
 	  IRQENTRY_TEXT
 	  *(.fixup)
 	  *(.text.__*)
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 308f29081d46..9d9dc4984465 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -70,7 +70,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 		*(.text.do_softirq)
 		*(.text.sys_exit)
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 499d9f89435a..4e36e86338f3 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -218,7 +218,7 @@ name: \
 	.localentry name,.-name
 
 #define _KPROBE(name) \
-	.section ".kprobes.text","a"; \
+	.section ".text.tbl.kprobes.all","a"; \
 	.align 2 ; \
 	.type name,@function; \
 	.globl name; \
@@ -248,7 +248,7 @@ GLUE(.,name):
 #define _GLOBAL_TOC(name) _GLOBAL(name)
 
 #define _KPROBE(name) \
-	.section ".kprobes.text","a"; \
+	.section ".text.tbl.kprobes.all","a"; \
 	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
@@ -280,7 +280,7 @@ n:
 #define _GLOBAL_TOC(name) _GLOBAL(name)
 
 #define _KPROBE(n)	\
-	.section ".kprobes.text","a";	\
+	.section ".text.tbl.kprobes.all","a";	\
 	.globl	n;	\
 n:
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index d41fd0af8980..8779ae180783 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -53,7 +53,6 @@ SECTIONS
 		*(.text .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 
 #ifdef CONFIG_PPC32
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index cd5a191381b9..b09aa9ab5a1f 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -162,7 +162,7 @@ _PIF_WORK	= (_PIF_PER_TRAP)
 		tm	off+\addr, \mask
 	.endm
 
-	.section .kprobes.text, "ax"
+	.section .text.tbl.kprobes.all, "ax"
 
 /*
  * Scheduler resume function, called by switch_to
@@ -965,7 +965,7 @@ ENTRY(restart_int_handler)
 	brc	2,2b
 3:	j	3b
 
-	.section .kprobes.text, "ax"
+	.section .text.tbl.kprobes.all, "ax"
 
 #ifdef CONFIG_CHECK_STACK
 /*
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 250f5972536a..376d4bd487c5 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -288,7 +288,7 @@ static void kprobe_reenter_check(struct kprobe_ctlblk *kcb, struct kprobe *p)
 	default:
 		/*
 		 * A kprobe on the code path to single step an instruction
-		 * is a BUG. The code path resides in the .kprobes.text
+		 * is a BUG. The code path resides in the .text.tbl.kprobes.all
 		 * section and is executed with interrupts disabled.
 		 */
 		printk(KERN_EMERG "Invalid kprobe detected at %p.\n", p->addr);
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index e499370fbccb..4572045b968e 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -10,7 +10,7 @@
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
 
-	.section .kprobes.text, "ax"
+	.section .text.tbl.kprobes.all, "ax"
 
 ENTRY(ftrace_stub)
 	br	%r14
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 445657fe658c..4614b5bcab5e 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -26,7 +26,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
diff --git a/arch/score/kernel/vmlinux.lds.S b/arch/score/kernel/vmlinux.lds.S
index 7274b5c4287e..36ebcb3b1215 100644
--- a/arch/score/kernel/vmlinux.lds.S
+++ b/arch/score/kernel/vmlinux.lds.S
@@ -41,7 +41,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		*(.text.*)
 		*(.fixup)
 		. = ALIGN (4) ;
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index db88cbf9eafd..af4f37375345 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -37,7 +37,6 @@ SECTIONS
 		EXTRA_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index f1a2f688b28a..a1c8e3a3ebb6 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -46,7 +46,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		IRQENTRY_TEXT
 		*(.gnu.warning)
 	} = 0
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index b4f4733abc6e..a08fb40656ac 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -148,7 +148,7 @@ __spitfire_flush_tlb_mm_slow:
 /*
  * The following code flushes one page_size worth.
  */
-	.section .kprobes.text, "ax"
+	.section .text.tbl.kprobes.all, "ax"
 	.align		32
 	.globl		__flush_icache_page
 __flush_icache_page:	/* %o0 = phys_page */
diff --git a/arch/tile/kernel/vmlinux.lds.S b/arch/tile/kernel/vmlinux.lds.S
index 0e059a0101ea..0f04268fc394 100644
--- a/arch/tile/kernel/vmlinux.lds.S
+++ b/arch/tile/kernel/vmlinux.lds.S
@@ -43,7 +43,6 @@ SECTIONS
     HEAD_TEXT
     SCHED_TEXT
     LOCK_TEXT
-    KPROBES_TEXT
     IRQENTRY_TEXT
     __fix_text_end = .;   /* tile-cpack won't rearrange before this */
     ALIGN_FUNCTION();
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 1deffe6cc873..dde4ec0e0185 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -577,7 +577,10 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 	case KPROBE_REENTER:
 		/* A probe has been hit in the codepath leading up to, or just
 		 * after, single-stepping of a probed instruction. This entire
-		 * codepath should strictly reside in .kprobes.text section.
+		 * codepath should strictly reside in the kprobes section:
+		 *
+		 * SECTION_TBL(SECTION_TEXT, kprobes, all)
+		 *
 		 * Raise a BUG or we'll continue in an endless reentering loop
 		 * and eventually a stack overflow.
 		 */
@@ -1114,10 +1117,9 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
-	return  (addr >= (unsigned long)__kprobes_text_start &&
-		 addr < (unsigned long)__kprobes_text_end) ||
+	return  (LINKTABLE_ADDR_WITHIN(kprobes, addr) ||
 		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
+		 addr < (unsigned long)__entry_text_end));
 }
 
 int __init arch_init_kprobes(void)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 74e4bf11f562..80a9f9106d2a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -99,7 +99,6 @@ SECTIONS
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
-		KPROBES_TEXT
 		ENTRY_TEXT
 		IRQENTRY_TEXT
 		*(.fixup)
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index f5ea98bd85d2..0438aab5cb58 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -24,7 +24,7 @@
  * Following global variables are optional and may be unavailable on some
  * architectures and/or kernel configurations.
  *	_text, _data
- *	__kprobes_text_start, __kprobes_text_end
+ *	LINKTABLE_START(kprobes), LINKTABLE_END(kprobes)
  *	__entry_text_start, __entry_text_end
  *	__ctors_start, __ctors_end
  */
@@ -35,7 +35,7 @@ extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
 extern char _end[];
 extern char __per_cpu_load[], __per_cpu_start[], __per_cpu_end[];
-extern char __kprobes_text_start[], __kprobes_text_end[];
+DECLARE_LINKTABLE_TEXT(char, kprobes);
 extern char __entry_text_start[], __entry_text_end[];
 extern char __start_rodata[], __end_rodata[];
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c5fcac902cbe..f1420714a549 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -112,15 +112,6 @@
 #define BRANCH_PROFILE()
 #endif
 
-#ifdef CONFIG_KPROBES
-#define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
-				VMLINUX_SYMBOL(__start_kprobe_blacklist) = .; \
-				*(_kprobe_blacklist)			      \
-				VMLINUX_SYMBOL(__stop_kprobe_blacklist) = .;
-#else
-#define KPROBE_BLACKLIST()
-#endif
-
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()	. = ALIGN(8);					\
 			VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
@@ -433,12 +424,6 @@
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;
 
-#define KPROBES_TEXT							\
-		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
-		*(.kprobes.text)					\
-		VMLINUX_SYMBOL(__kprobes_text_end) = .;
-
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__entry_text_start) = .;			\
@@ -504,7 +489,6 @@
 	*(.init.rodata)							\
 	FTRACE_EVENTS()							\
 	TRACE_SYSCALLS()						\
-	KPROBE_BLACKLIST()						\
 	MEM_DISCARD(init.rodata)					\
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 00b042c49ccd..8e33fc1ffd3c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -546,7 +546,8 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 
 /* Ignore/forbid kprobes attach on very low level functions marked by this attribute: */
 #ifdef CONFIG_KPROBES
-# define __kprobes	__attribute__((__section__(".kprobes.text")))
+#include <linux/sections.h>
+# define __kprobes	__attribute__((__section__(SECTION_TBL(SECTION_TEXT, kprobes, all))))
 # define nokprobe_inline	__always_inline
 #else
 # define __kprobes
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8f6849084248..544eb59cdbb9 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -42,8 +42,12 @@
 #include <linux/ftrace.h>
 
 #ifdef CONFIG_KPROBES
+#include <linux/tables.h>
 #include <asm/kprobes.h>
 
+DECLARE_LINKTABLE_TEXT(char, kprobes);
+DECLARE_LINKTABLE_INIT_DATA(unsigned long, _kprobe_blacklist);
+
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
 #define KPROBE_HIT_SS		0x00000002
@@ -487,8 +491,7 @@ static inline int enable_jprobe(struct jprobe *jp)
  * by using this macro.
  */
 #define __NOKPROBE_SYMBOL(fname)			\
-static unsigned long __used				\
-	__attribute__((section("_kprobe_blacklist")))	\
+static LINKTABLE_INIT_DATA(_kprobe_blacklist, all)		\
 	_kbl_addr_##fname = (unsigned long)fname;
 #define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
 #else
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d10ab6b9b5e0..d816c659f358 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1328,8 +1328,7 @@ out:
 bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 {
 	/* The __kprobes marked functions and entry code must not be probed */
-	return addr >= (unsigned long)__kprobes_text_start &&
-	       addr < (unsigned long)__kprobes_text_end;
+	return LINKTABLE_ADDR_WITHIN(kprobes, addr);
 }
 
 bool within_kprobe_blacklist(unsigned long addr)
@@ -2054,14 +2053,13 @@ NOKPROBE_SYMBOL(dump_kprobe);
  * since a kprobe need not necessarily be at the beginning
  * of a function.
  */
-static int __init populate_kprobe_blacklist(unsigned long *start,
-					     unsigned long *end)
+static int __init populate_kprobe_blacklist(void)
 {
 	unsigned long *iter;
 	struct kprobe_blacklist_entry *ent;
 	unsigned long entry, offset = 0, size = 0;
 
-	for (iter = start; iter < end; iter++) {
+	LINKTABLE_FOR_EACH(iter, _kprobe_blacklist) {
 		entry = arch_deref_entry_point((void *)*iter);
 
 		if (!kernel_text_address(entry) ||
@@ -2126,8 +2124,9 @@ static struct notifier_block kprobe_module_nb = {
 };
 
 /* Markers of _kprobe_blacklist section */
-extern unsigned long __start_kprobe_blacklist[];
-extern unsigned long __stop_kprobe_blacklist[];
+DEFINE_LINKTABLE_INIT_DATA(unsigned long, _kprobe_blacklist);
+/* Actual kprobes linker table */
+DEFINE_LINKTABLE_TEXT(char, kprobes);
 
 static int __init init_kprobes(void)
 {
@@ -2141,8 +2140,7 @@ static int __init init_kprobes(void)
 		raw_spin_lock_init(&(kretprobe_table_locks[i].lock));
 	}
 
-	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
-					__stop_kprobe_blacklist);
+	err = populate_kprobe_blacklist();
 	if (err) {
 		pr_err("kprobes: failed to populate blacklist: %d\n", err);
 		pr_err("Please take care of using kprobes.\n");
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 48958d3cec9e..b0a8f519efb8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -22,6 +22,7 @@
 #include "../../include/generated/autoconf.h"
 #include "../../include/linux/license.h"
 #include "../../include/linux/export.h"
+#include "../../include/linux/sections.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
 static int modversions = 0;
@@ -888,7 +889,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
-		".kprobes.text"
+		SECTION_TBL(SECTION_TEXT, kprobes, all)
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
 		".coldtext"
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e167592793a7..f37dac17f033 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -32,6 +32,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include "../../include/linux/sections.h"
 
 #ifndef EM_METAG
 /* Remove this when these make it to the standard system elf.h. */
@@ -356,7 +357,7 @@ is_mcounted_section_name(char const *const txtname)
 		strcmp(".sched.text",    txtname) == 0 ||
 		strcmp(".spinlock.text", txtname) == 0 ||
 		strcmp(".irqentry.text", txtname) == 0 ||
-		strcmp(".kprobes.text", txtname) == 0 ||
+		strcmp(SECTION_TBL(SECTION_TEXT, kprobe, all), txtname) == 0 ||
 		strcmp(".text.unlikely", txtname) == 0;
 }
 
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 96e2486a6fc4..63e13009dda9 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -134,7 +134,7 @@ my %text_sections = (
      ".sched.text" => 1,
      ".spinlock.text" => 1,
      ".irqentry.text" => 1,
-     ".kprobes.text" => 1,
+     ".text.tbl.kprobes.all" => 1,
      ".text.unlikely" => 1,
 );
 
-- 
2.7.0
