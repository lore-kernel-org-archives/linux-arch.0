From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v4 4/4] nmi_backtrace: generate one-line reports for idle cpus
Date: Wed, 30 Mar 2016 13:16:10 -0400
Message-ID: <1459358170-27745-5-git-send-email-cmetcalf@mellanox.com>
References: <1459358170-27745-1-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0092.outbound.protection.outlook.com ([157.56.112.92]:4777
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932296AbcC3RQn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Mar 2016 13:16:43 -0400
In-Reply-To: <1459358170-27745-1-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>

When doing an nmi backtrace of many cores, most of which are idle,
the output is a little overwhelming and very uninformative.  Suppress
messages for cpus that are idling when they are interrupted and just
emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".

We do this by grouping all the cpuidle code together into a new
.cpuidle.text section, and then checking the address of the
interrupted PC to see if it lies within that section.

This commit suitably tags x86, arm64, and tile idle routines,
and only adds in the minimal framework for other architectures.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/alpha/kernel/vmlinux.lds.S      |  1 +
 arch/arc/kernel/vmlinux.lds.S        |  1 +
 arch/arm/kernel/vmlinux.lds.S        |  1 +
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 arch/arm64/mm/proc.S                 |  2 ++
 arch/avr32/kernel/vmlinux.lds.S      |  1 +
 arch/blackfin/kernel/vmlinux.lds.S   |  1 +
 arch/c6x/kernel/vmlinux.lds.S        |  1 +
 arch/cris/kernel/vmlinux.lds.S       |  1 +
 arch/frv/kernel/vmlinux.lds.S        |  1 +
 arch/h8300/kernel/vmlinux.lds.S      |  1 +
 arch/hexagon/kernel/vmlinux.lds.S    |  1 +
 arch/ia64/kernel/vmlinux.lds.S       |  1 +
 arch/m32r/kernel/vmlinux.lds.S       |  1 +
 arch/m68k/kernel/vmlinux-nommu.lds   |  1 +
 arch/m68k/kernel/vmlinux-std.lds     |  1 +
 arch/m68k/kernel/vmlinux-sun3.lds    |  1 +
 arch/metag/kernel/vmlinux.lds.S      |  1 +
 arch/microblaze/kernel/vmlinux.lds.S |  1 +
 arch/mips/kernel/vmlinux.lds.S       |  1 +
 arch/mn10300/kernel/vmlinux.lds.S    |  1 +
 arch/nios2/kernel/vmlinux.lds.S      |  1 +
 arch/openrisc/kernel/vmlinux.lds.S   |  1 +
 arch/parisc/kernel/vmlinux.lds.S     |  1 +
 arch/powerpc/kernel/vmlinux.lds.S    |  1 +
 arch/s390/kernel/vmlinux.lds.S       |  1 +
 arch/score/kernel/vmlinux.lds.S      |  1 +
 arch/sh/kernel/vmlinux.lds.S         |  1 +
 arch/sparc/kernel/vmlinux.lds.S      |  1 +
 arch/tile/kernel/entry.S             |  2 +-
 arch/tile/kernel/vmlinux.lds.S       |  1 +
 arch/um/kernel/dyn.lds.S             |  1 +
 arch/um/kernel/uml.lds.S             |  1 +
 arch/unicore32/kernel/vmlinux.lds.S  |  1 +
 arch/x86/kernel/acpi/cstate.c        |  2 +-
 arch/x86/kernel/process.c            |  4 ++--
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 arch/xtensa/kernel/vmlinux.lds.S     |  3 +++
 drivers/acpi/processor_idle.c        |  5 +++--
 drivers/cpuidle/driver.c             |  5 +++--
 drivers/idle/intel_idle.c            |  4 ++--
 include/asm-generic/vmlinux.lds.h    |  6 ++++++
 include/linux/cpu.h                  |  5 +++++
 kernel/sched/idle.c                  | 13 +++++++++++--
 lib/nmi_backtrace.c                  | 16 +++++++++++-----
 scripts/mod/modpost.c                |  2 +-
 scripts/recordmcount.c               |  1 +
 scripts/recordmcount.pl              |  1 +
 48 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 647b84c15382..cebecfb76fbf 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -22,6 +22,7 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		*(.fixup)
 		*(.gnu.warning)
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 894e696bddaa..65652160cfda 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -97,6 +97,7 @@ SECTIONS
 		_text = .;
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		*(.fixup)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index e2c6da096cef..b5376e87e61c 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -111,6 +111,7 @@ SECTIONS
 			SOFTIRQENTRY_TEXT
 			TEXT_TEXT
 			SCHED_TEXT
+			CPUIDLE_TEXT
 			LOCK_TEXT
 			HYPERVISOR_TEXT
 			KPROBES_TEXT
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5a1939a74ff3..fbedb7f489c7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -106,6 +106,7 @@ SECTIONS
 			SOFTIRQENTRY_TEXT
 			TEXT_TEXT
 			SCHED_TEXT
+			CPUIDLE_TEXT
 			LOCK_TEXT
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 543f5198005a..580fec01f009 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -50,11 +50,13 @@
  *
  *	Idle the processor (wait for interrupt).
  */
+	.pushsection ".cpuidle.text","ax"
 ENTRY(cpu_do_idle)
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
 	ret
 ENDPROC(cpu_do_idle)
+	.popsection
 
 #ifdef CONFIG_CPU_PM
 /**
diff --git a/arch/avr32/kernel/vmlinux.lds.S b/arch/avr32/kernel/vmlinux.lds.S
index a4589176bed5..17f2730eb497 100644
--- a/arch/avr32/kernel/vmlinux.lds.S
+++ b/arch/avr32/kernel/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 		KPROBES_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		*(.fixup)
 		*(.gnu.warning)
diff --git a/arch/blackfin/kernel/vmlinux.lds.S b/arch/blackfin/kernel/vmlinux.lds.S
index d920b959ff3a..68069a120055 100644
--- a/arch/blackfin/kernel/vmlinux.lds.S
+++ b/arch/blackfin/kernel/vmlinux.lds.S
@@ -33,6 +33,7 @@ SECTIONS
 #ifndef CONFIG_SCHEDULE_L1
 		SCHED_TEXT
 #endif
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index 50bc10f97bcb..a1a5c166bc9b 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -70,6 +70,7 @@ SECTIONS
 		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
diff --git a/arch/cris/kernel/vmlinux.lds.S b/arch/cris/kernel/vmlinux.lds.S
index 7552c2557506..979586261520 100644
--- a/arch/cris/kernel/vmlinux.lds.S
+++ b/arch/cris/kernel/vmlinux.lds.S
@@ -43,6 +43,7 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		*(.fixup)
 		*(.text.__*)
diff --git a/arch/frv/kernel/vmlinux.lds.S b/arch/frv/kernel/vmlinux.lds.S
index 7e958d829ec9..aa6e573d57da 100644
--- a/arch/frv/kernel/vmlinux.lds.S
+++ b/arch/frv/kernel/vmlinux.lds.S
@@ -63,6 +63,7 @@ SECTIONS
 	*(.text..tlbmiss)
 	TEXT_TEXT
 	SCHED_TEXT
+	CPUIDLE_TEXT
 	LOCK_TEXT
 #ifdef CONFIG_DEBUG_INFO
 	INIT_TEXT
diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index cb5dfb02c88d..7f11da1b895e 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -29,6 +29,7 @@ SECTIONS
 	_stext = . ;
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 #if defined(CONFIG_ROMKERNEL)
 		*(.int_redirect)
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 5f268c1071b3..ec87e67feb19 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -50,6 +50,7 @@ SECTIONS
 		_text = .;
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		*(.fixup)
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index dc506b05ffbd..f89d20c97412 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ SECTIONS {
 		__end_ivt_text = .;
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		*(.gnu.linkonce.t*)
diff --git a/arch/m32r/kernel/vmlinux.lds.S b/arch/m32r/kernel/vmlinux.lds.S
index 018e4a711d79..ad1fe56455aa 100644
--- a/arch/m32r/kernel/vmlinux.lds.S
+++ b/arch/m32r/kernel/vmlinux.lds.S
@@ -31,6 +31,7 @@ SECTIONS
 	HEAD_TEXT
 	TEXT_TEXT
 	SCHED_TEXT
+	CPUIDLE_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
index 06a763f49fd3..d2c8abf1c8c4 100644
--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -45,6 +45,7 @@ SECTIONS {
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		*(.fixup)
 		. = ALIGN(16);
diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index d0993594f558..5b5ce1e4d1ed 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -16,6 +16,7 @@ SECTIONS
 	HEAD_TEXT
 	TEXT_TEXT
 	SCHED_TEXT
+	CPUIDLE_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index 8080469ee6c1..fe5ea1974b16 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -16,6 +16,7 @@ SECTIONS
 	HEAD_TEXT
 	TEXT_TEXT
 	SCHED_TEXT
+	CPUIDLE_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
diff --git a/arch/metag/kernel/vmlinux.lds.S b/arch/metag/kernel/vmlinux.lds.S
index 150ace92c7ad..e6c700eaf207 100644
--- a/arch/metag/kernel/vmlinux.lds.S
+++ b/arch/metag/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@ SECTIONS
   .text : {
 	TEXT_TEXT
 	SCHED_TEXT
+	CPUIDLE_TEXT
 	LOCK_TEXT
 	KPROBES_TEXT
 	IRQENTRY_TEXT
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index 0a47f0410554..289d0e7f3e3a 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -33,6 +33,7 @@ SECTIONS {
 		EXIT_TEXT
 		EXIT_CALL
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 54d653ee17e1..f6ca8e5caaf6 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -55,6 +55,7 @@ SECTIONS
 	.text : {
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/mn10300/kernel/vmlinux.lds.S b/arch/mn10300/kernel/vmlinux.lds.S
index 13c4814c29f8..2d5f1c3f1afb 100644
--- a/arch/mn10300/kernel/vmlinux.lds.S
+++ b/arch/mn10300/kernel/vmlinux.lds.S
@@ -30,6 +30,7 @@ SECTIONS
 	HEAD_TEXT
 	TEXT_TEXT
 	SCHED_TEXT
+	CPUIDLE_TEXT
 	LOCK_TEXT
 	KPROBES_TEXT
 	*(.fixup)
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index e23e89539967..6a8045bb1a77 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -37,6 +37,7 @@ SECTIONS
 	.text : {
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index d936de4c07ca..d68b9ede8423 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -47,6 +47,7 @@ SECTIONS
           _stext = .;
 	  TEXT_TEXT
 	  SCHED_TEXT
+	  CPUIDLE_TEXT
 	  LOCK_TEXT
 	  KPROBES_TEXT
 	  IRQENTRY_TEXT
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index f3ead0b6ce46..9ec8ec075dae 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -69,6 +69,7 @@ SECTIONS
 	.text ALIGN(PAGE_SIZE) : {
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2dd91f79de05..ac425ff39b4d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 		/* careful! __ftr_alt_* sections need to be close to .text */
 		*(.text .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 0f41a8286378..b1c8958e72ad 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -25,6 +25,7 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/score/kernel/vmlinux.lds.S b/arch/score/kernel/vmlinux.lds.S
index 7274b5c4287e..4117890b1db1 100644
--- a/arch/score/kernel/vmlinux.lds.S
+++ b/arch/score/kernel/vmlinux.lds.S
@@ -40,6 +40,7 @@ SECTIONS
 		_text = .;	/* Text and read-only data */
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		*(.text.*)
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 235a4101999f..5b9a3cc90c58 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -36,6 +36,7 @@ SECTIONS
 		TEXT_TEXT
 		EXTRA_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index aadd321aa05d..846a734e3882 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -45,6 +45,7 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/tile/kernel/entry.S b/arch/tile/kernel/entry.S
index 670a3569450f..101de132e363 100644
--- a/arch/tile/kernel/entry.S
+++ b/arch/tile/kernel/entry.S
@@ -50,7 +50,7 @@ STD_ENTRY(smp_nap)
  * When interrupted at _cpu_idle_nap, we bump the PC forward 8, and
  * as a result return to the function that called _cpu_idle().
  */
-STD_ENTRY(_cpu_idle)
+STD_ENTRY_SECTION(_cpu_idle, .cpuidle.text)
 	movei r1, 1
 	IRQ_ENABLE_LOAD(r2, r3)
 	mtspr INTERRUPT_CRITICAL_SECTION, r1
diff --git a/arch/tile/kernel/vmlinux.lds.S b/arch/tile/kernel/vmlinux.lds.S
index 378f5d8d1ec8..9e54bee9c048 100644
--- a/arch/tile/kernel/vmlinux.lds.S
+++ b/arch/tile/kernel/vmlinux.lds.S
@@ -42,6 +42,7 @@ SECTIONS
   .text : AT (ADDR(.text) - LOAD_OFFSET) {
     HEAD_TEXT
     SCHED_TEXT
+    CPUIDLE_TEXT
     LOCK_TEXT
     KPROBES_TEXT
     IRQENTRY_TEXT
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index adde088aeeff..4fdbcf958cd5 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -68,6 +68,7 @@ SECTIONS
     _stext = .;
     TEXT_TEXT
     SCHED_TEXT
+    CPUIDLE_TEXT
     LOCK_TEXT
     *(.fixup)
     *(.stub .text.* .gnu.linkonce.t.*)
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 6899195602b7..1840f55ed042 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -28,6 +28,7 @@ SECTIONS
     _stext = .;
     TEXT_TEXT
     SCHED_TEXT
+    CPUIDLE_TEXT
     LOCK_TEXT
     *(.fixup)
     /* .gnu.warning sections are handled specially by elf32.em.  */
diff --git a/arch/unicore32/kernel/vmlinux.lds.S b/arch/unicore32/kernel/vmlinux.lds.S
index 77e407e49a63..56e788e8ee83 100644
--- a/arch/unicore32/kernel/vmlinux.lds.S
+++ b/arch/unicore32/kernel/vmlinux.lds.S
@@ -37,6 +37,7 @@ SECTIONS
 	.text : {		/* Real text segment */
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 
 		*(.fixup)
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 4b28159e0421..7efbb4d19024 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -152,7 +152,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
-void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
+void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cstate_entry *percpu_entry;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2915d54e9dd5..3e1db7fdd69d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -301,7 +301,7 @@ void arch_cpu_idle(void)
 /*
  * We use this if we don't have any better idle routine..
  */
-void default_idle(void)
+void __cpuidle default_idle(void)
 {
 	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	safe_halt();
@@ -416,7 +416,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
  * with interrupts enabled and no flags, which is backwards compatible with the
  * original MWAIT implementation.
  */
-static void mwait_idle(void)
+static __cpuidle void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
 		trace_cpu_idle_rcuidle(1, smp_processor_id());
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4c941f88d405..e611d0dc9942 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -97,6 +97,7 @@ SECTIONS
 		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
+		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		ENTRY_TEXT
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index c417cbe4ec87..18a174c7fb87 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -93,6 +93,9 @@ SECTIONS
     VMLINUX_SYMBOL(__sched_text_start) = .;
     *(.sched.literal .sched.text)
     VMLINUX_SYMBOL(__sched_text_end) = .;
+    VMLINUX_SYMBOL(__cpuidle_text_start) = .;
+    *(.cpuidle.literal .cpuidle.text)
+    VMLINUX_SYMBOL(__cpuidle_text_end) = .;
     VMLINUX_SYMBOL(__lock_text_start) = .;
     *(.spinlock.literal .spinlock.text)
     VMLINUX_SYMBOL(__lock_text_end) = .;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 444e3745c8b3..2477f9a351d3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -31,6 +31,7 @@
 #include <linux/sched.h>       /* need_resched() */
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu.h>
 #include <acpi/processor.h>
 
 /*
@@ -109,7 +110,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
  * Callers should disable interrupts before the call and enable
  * interrupts after return.
  */
-static void acpi_safe_halt(void)
+static void __cpuidle acpi_safe_halt(void)
 {
 	if (!tif_need_resched()) {
 		safe_halt();
@@ -640,7 +641,7 @@ static int acpi_idle_bm_check(void)
  *
  * Caller disables interrupt before call and enables interrupt after return.
  */
-static void acpi_idle_do_entry(struct acpi_processor_cx *cx)
+static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 389ade4572be..ab264d393233 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -14,6 +14,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/tick.h>
+#include <linux/cpu.h>
 
 #include "cpuidle.h"
 
@@ -178,8 +179,8 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 }
 
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
-static int poll_idle(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
+static int __cpuidle poll_idle(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int index)
 {
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ba947df5a8c7..d30127a0f3ac 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -745,8 +745,8 @@ static struct cpuidle_state knl_cstates[] = {
  *
  * Must be called under local_irq_disable().
  */
-static int intel_idle(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
+static __cpuidle int intel_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
 {
 	unsigned long ecx = 1; /* break on interrupt flag */
 	struct cpuidle_state *state = &drv->states[index];
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 339125bb4d2c..5ed7075f7ef1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -444,6 +444,12 @@
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;
 
+#define CPUIDLE_TEXT							\
+		ALIGN_FUNCTION();					\
+		VMLINUX_SYMBOL(__cpuidle_text_start) = .;		\
+		*(.cpuidle.text)					\
+		VMLINUX_SYMBOL(__cpuidle_text_end) = .;
+
 #define KPROBES_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index f9b1fab4388a..07642073989c 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -268,6 +268,11 @@ void cpu_startup_entry(enum cpuhp_state state);
 
 void cpu_idle_poll_ctrl(bool enable);
 
+/* Attach to any functions which should be considered cpuidle. */
+#define __cpuidle	__attribute__((__section__(".cpuidle.text")))
+
+bool cpu_in_idle(unsigned long pc);
+
 void arch_cpu_idle(void);
 void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index bd12c6c714ec..d4dc16e6749b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -16,6 +16,9 @@
 
 #include "sched.h"
 
+/* Linker adds these: start and end of __cpuidle functions */
+extern char __cpuidle_text_start[], __cpuidle_text_end[];
+
 /**
  * sched_idle_set_state - Record idle state for the current CPU.
  * @idle_state: State to record.
@@ -53,7 +56,7 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 __setup("hlt", cpu_idle_nopoll_setup);
 #endif
 
-static inline int cpu_idle_poll(void)
+static noinline int __cpuidle cpu_idle_poll(void)
 {
 	rcu_idle_enter();
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
@@ -84,7 +87,7 @@ void __weak arch_cpu_idle(void)
  *
  * To use when the cpuidle framework cannot be used.
  */
-void default_idle_call(void)
+void __cpuidle default_idle_call(void)
 {
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
@@ -269,6 +272,12 @@ static void cpu_idle_loop(void)
 	}
 }
 
+bool cpu_in_idle(unsigned long pc)
+{
+	return pc >= (unsigned long)__cpuidle_text_start &&
+		pc < (unsigned long)__cpuidle_text_end;
+}
+
 void cpu_startup_entry(enum cpuhp_state state)
 {
 	/*
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 9375c0279b73..ac41f3c84e8d 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -17,6 +17,7 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 #include <linux/seq_buf.h>
+#include <linux/cpu.h>
 
 #ifdef arch_trigger_cpumask_backtrace
 /* For reliability, we're prepared to waste bits here. */
@@ -160,11 +161,16 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 
 		/* Replace printk to write into the NMI seq */
 		this_cpu_write(printk_func, nmi_vprintk);
-		pr_warn("NMI backtrace for cpu %d\n", cpu);
-		if (regs)
-			show_regs(regs);
-		else
-			dump_stack();
+		if (regs != NULL && cpu_in_idle(instruction_pointer(regs))) {
+			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
+				cpu, instruction_pointer(regs));
+		} else {
+			pr_warn("NMI backtrace for cpu %d\n", cpu);
+			if (regs)
+				show_regs(regs);
+			else
+				dump_stack();
+		}
 		this_cpu_write(printk_func, printk_func_save);
 
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 48958d3cec9e..bd8349759095 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -888,7 +888,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
-		".kprobes.text"
+		".kprobes.text", ".cpuidle.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
 		".coldtext"
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e167592793a7..9a6ec6ce00b5 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -357,6 +357,7 @@ is_mcounted_section_name(char const *const txtname)
 		strcmp(".spinlock.text", txtname) == 0 ||
 		strcmp(".irqentry.text", txtname) == 0 ||
 		strcmp(".kprobes.text", txtname) == 0 ||
+		strcmp(".cpuidle.text", txtname) == 0 ||
 		strcmp(".text.unlikely", txtname) == 0;
 }
 
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 96e2486a6fc4..29cecf9b504f 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -135,6 +135,7 @@ my %text_sections = (
      ".spinlock.text" => 1,
      ".irqentry.text" => 1,
      ".kprobes.text" => 1,
+     ".cpuidle.text" => 1,
      ".text.unlikely" => 1,
 );
 
-- 
2.7.2
