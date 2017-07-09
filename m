From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH] x86: enable dead code and data elimination (LTO)
Date: Sun,  9 Jul 2017 13:13:33 +1000
Message-ID: <20170709031333.29443-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35664 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGIDNz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jul 2017 23:13:55 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Paul Burton <paul.burton@imgtec.com>, Linus Torvalds <torvalds@linux-foundation.org>

Allow x86 to select DCDE option under CONFIG_EXPERT to reduce
binary size.

This is an RFC only for ~4.14/15 kernel. Sending as a single patch
to make it easy to review and test for x86, and give other archs a
base to look at.

This is a _relatively_ simple and low overhead first step to getting
some dead code elimination working. I would like to know if people
think this is reasonable and wanted.

Enabling this option reduces size of x86-64 allnoconfig -Os build
significantly:

    text     data     bss       dec  filename
  783424   618456  185488   1587368  vmlinux
  641277   612536  185488   1439301  vmlinux.dcde
  142147     5920       0    148067  difference
     18%       1%      0%        9%

The improvement with defconfig is much smaller.

10690125  4630536  884736  16205397  vmlinux
10623912  4607432  880640  16111984  vmlinux.dcde
   66213    23104    4096     93413  difference
    0.6%     0.5%    0.5%      0.6%

There are a number of reasons for this. Firstly not everything is
built conditionally on a fine grained basis, so the allnoconfig
kernel includes lots more code that's never used. But there are
also things which pin code, for example BUG and exception tables
are marked with KEEP() and reference kernel code which may be
otherwise unused. In future, moving to a direct referencing of
such tables should allow more size reductions of larger kernel
configs.

FYI, easiest way to check if you forgot to KEEP a linker table is
to look at `readelf -S vmlinux` differences, and to see what is
being trimmed, look at nm differences or use --print-gc-sections
LD option to see what symbols you're trimming. Linker tables,
boot entry, and exception entry tends to require anchoring.

---
 arch/Kconfig                      | 15 ---------------
 arch/x86/Kconfig                  |  1 +
 arch/x86/kernel/vmlinux.lds.S     | 22 +++++++++++-----------
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 init/Kconfig                      | 27 +++++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index cae0958a2298..00edad06c71f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -555,21 +555,6 @@ config THIN_ARCHIVES
 	  Select this if the architecture wants to use thin archives
 	  instead of ld -r to create the built-in.o files.
 
-config LD_DEAD_CODE_DATA_ELIMINATION
-	bool
-	help
-	  Select this if the architecture wants to do dead code and
-	  data elimination with the linker by compiling with
-	  -ffunction-sections -fdata-sections and linking with
-	  --gc-sections.
-
-	  This requires that the arch annotates or otherwise protects
-	  its external entry points from being discarded. Linker scripts
-	  must also merge .text.*, .data.*, and .bss.* correctly into
-	  output sections. Care must be taken not to pull in unrelated
-	  sections (e.g., '.text.init'). Typically '.' in section names
-	  is used to distinguish them from label names / C identifiers.
-
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 94a18681353d..d885706d7eb9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -152,6 +152,7 @@ config X86
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_KVM
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_LIVEPATCH			if X86_64
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c8a3b61be0aa..3b5ab910bbd4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -203,14 +203,14 @@ SECTIONS
 	 * See static_cpu_has() for an example.
 	 */
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
-		*(.altinstr_aux)
+		KEEP(*(.altinstr_aux))
 	}
 
 	INIT_DATA_SECTION(16)
 
 	.x86_cpu_dev.init : AT(ADDR(.x86_cpu_dev.init) - LOAD_OFFSET) {
 		__x86_cpu_dev_start = .;
-		*(.x86_cpu_dev.init)
+		KEEP(*(.x86_cpu_dev.init))
 		__x86_cpu_dev_end = .;
 	}
 
@@ -218,7 +218,7 @@ SECTIONS
 	.x86_intel_mid_dev.init : AT(ADDR(.x86_intel_mid_dev.init) - \
 								LOAD_OFFSET) {
 		__x86_intel_mid_dev_start = .;
-		*(.x86_intel_mid_dev.init)
+		KEEP(*(.x86_intel_mid_dev.init))
 		__x86_intel_mid_dev_end = .;
 	}
 #endif
@@ -232,7 +232,7 @@ SECTIONS
 	. = ALIGN(8);
 	.parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
 		__parainstructions = .;
-		*(.parainstructions)
+		KEEP(*(.parainstructions))
 		__parainstructions_end = .;
 	}
 
@@ -244,7 +244,7 @@ SECTIONS
 	. = ALIGN(8);
 	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
 		__alt_instructions = .;
-		*(.altinstructions)
+		KEEP(*(.altinstructions))
 		__alt_instructions_end = .;
 	}
 
@@ -254,7 +254,7 @@ SECTIONS
 	 * get the address and the length of them to patch the kernel safely.
 	 */
 	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
-		*(.altinstr_replacement)
+		KEEP(*(.altinstr_replacement))
 	}
 
 	/*
@@ -265,14 +265,14 @@ SECTIONS
 	 */
 	.iommu_table : AT(ADDR(.iommu_table) - LOAD_OFFSET) {
 		__iommu_table = .;
-		*(.iommu_table)
+		KEEP(*(.iommu_table))
 		__iommu_table_end = .;
 	}
 
 	. = ALIGN(8);
 	.apicdrivers : AT(ADDR(.apicdrivers) - LOAD_OFFSET) {
 		__apicdrivers = .;
-		*(.apicdrivers);
+		KEEP(*(.apicdrivers))
 		__apicdrivers_end = .;
 	}
 
@@ -307,7 +307,7 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	.smp_locks : AT(ADDR(.smp_locks) - LOAD_OFFSET) {
 		__smp_locks = .;
-		*(.smp_locks)
+		KEEP(*(.smp_locks))
 		. = ALIGN(PAGE_SIZE);
 		__smp_locks_end = .;
 	}
@@ -323,7 +323,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
-		*(.bss)
+		*(.bss .bss.[0-9a-zA-Z_]*)
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
@@ -332,7 +332,7 @@ SECTIONS
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		KEEP(*(.brk_reservation)) /* areas brk users have reserved */
 		__brk_limit = .;
 	}
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index da0be9a8d1de..4ff42789e5e3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -441,12 +441,21 @@
  * architectures define .text.foo which is not intended to be pulled in here.
  * Those enabling LD_DEAD_CODE_DATA_ELIMINATION must ensure they don't have
  * conflicting section names, and must pull in .text.[0-9a-zA-Z_]* */
+#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
+#define TEXT_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.hot .text .text.[0-9a-zA-Z_]* .text.fixup .text.unlikely)\
+		*(.ref.text)						\
+	MEM_KEEP(init.text)						\
+	MEM_KEEP(exit.text)
+#else
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot .text .text.fixup .text.unlikely)		\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
-	MEM_KEEP(exit.text)						\
+	MEM_KEEP(exit.text)
+#endif
 
 
 /* sched.text is aling to function alignment to secure we have same
diff --git a/init/Kconfig b/init/Kconfig
index 8514b25db21c..9e209593e618 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1052,6 +1052,33 @@ config CC_OPTIMIZE_FOR_SIZE
 
 endchoice
 
+config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	bool
+	help
+	  This requires that the arch annotates or otherwise protects
+	  its external entry points from being discarded. Linker scripts
+	  must also merge .text.*, .data.*, and .bss.* correctly into
+	  output sections. Care must be taken not to pull in unrelated
+	  sections (e.g., '.text.init'). Typically '.' in section names
+	  is used to distinguish them from label names / C identifiers.
+
+config LD_DEAD_CODE_DATA_ELIMINATION
+	bool "Dead code and data elimination (EXPERIMENTAL)"
+	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	depends on EXPERT
+	help
+	  Select this if the architecture wants to do dead code and
+	  data elimination with the linker by compiling with
+	  -ffunction-sections -fdata-sections, and linking with
+	  --gc-sections.
+
+	  This can reduce on disk and in-memory size of the kernel
+	  code and static data, particularly for small configs and
+	  on small systems. This has the possibility of introducing
+	  silently broken kernel if the required annotations are not
+	  present. This option is not well tested yet, so use at your
+	  own risk.
+
 config SYSCTL
 	bool
 
-- 
2.11.0
