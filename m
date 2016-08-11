From: Arnd Bergmann <arnd@arndb.de>
Subject: [EXPERIMENTAL] enable thin archives and --gc-sections on ARM
Date: Thu, 11 Aug 2016 15:55:08 +0200
Message-ID: <3116731.ej669o70yG@wuerfel>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

This goes on top of Nick's latest version of "[PATCH 0/6 v2] kbuild changes,
thin archives, --gc-sections" and enables both features on ARM.

It's a bit half-baked, these are known problems:

- as big-endian support is still broken, I disable it in Kconfig
  so an allyesconfig build ends up as little-endian

- I've thrown in a change to include/asm-generic/vmlinux.lds.h
  but don't know whether this is the right way or not. We have
  to keep .text.fixup linked together with .text, but I separate
  out .text.unlikely and .text.hot again. This has not caused
  any link failures for me (yet).

- I mark a ton of sections as KEEP() in vmlinux.lds.S. Some of
  them might not actually be needed, and I have not spent much
  time checking what they actually are. However, I did build
  a few hundred randconfigs without new issues.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b62ae32f8a1e..9bf37a6e7384 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,6 +83,7 @@ config ARM
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
+	select LD_DEAD_CODE_DATA_ELIMINATION
 	select MODULES_USE_ELF_REL
 	select NO_BOOTMEM
 	select OF_EARLY_FLATTREE if OF
@@ -92,6 +93,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select THIN_ARCHIVES
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8c7e1e..b7f2a41fd940 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,6 +13,9 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
+ccflags-y              += -fno-function-sections -fno-data-sections
+subdir-ccflags-y       += -fno-function-sections -fno-data-sections
+
 # Object file lists.
 
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 56c8bdf776bd..77c2c607cdd9 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -12,17 +12,17 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define IDMAP_TEXT							\
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
-	*(.idmap.text)							\
+	KEEP(*(.idmap.text))						\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
-	*(.hyp.idmap.text)						\
+	KEEP(*(.hyp.idmap.text))					\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -93,7 +93,7 @@ SECTIONS
 		_stext = .;		/* Text and read-only data	*/
 			IDMAP_TEXT
 			__exception_text_start = .;
-			*(.exception.text)
+			KEEP(*(.exception.text))
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			TEXT_TEXT
@@ -114,7 +114,7 @@ SECTIONS
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
 #ifdef CONFIG_MMU
-		*(__ex_table)
+		KEEP(*(__ex_table))
 #endif
 		__stop___ex_table = .;
 	}
@@ -126,12 +126,12 @@ SECTIONS
 	. = ALIGN(8);
 	.ARM.unwind_idx : {
 		__start_unwind_idx = .;
-		*(.ARM.exidx*)
+		KEEP(*(.ARM.exidx*))
 		__stop_unwind_idx = .;
 	}
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
-		*(.ARM.extab*)
+		KEEP(*(.ARM.extab*))
 		__stop_unwind_tab = .;
 	}
 #endif
@@ -146,14 +146,14 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
 	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
-		*(.stubs)
+		KEEP(*(.stubs))
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
@@ -169,24 +169,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7396a5f00c5f..61b9b8784036 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -17,7 +17,7 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define HYPERVISOR_TEXT							\
@@ -104,7 +104,7 @@ SECTIONS
 		_stext = .;		/* Text and read-only data	*/
 			IDMAP_TEXT
 			__exception_text_start = .;
-			*(.exception.text)
+			KEEP(*(.exception.text))
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
@@ -169,14 +169,14 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
 	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
-		*(.stubs)
+		KEEP(*(.stubs))
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
@@ -192,24 +192,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 6a09cc204b07..7117b8e99de8 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -717,6 +717,7 @@ config SWP_EMULATE
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on ARCH_SUPPORTS_BIG_ENDIAN
+	depends on !THIN_ARCHIVES
 	help
 	  Say Y if you plan on running a kernel in big-endian mode.
 	  Note that your board must be properly built and your board
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9136c3afd3c6..e01f0b00a678 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -433,7 +433,9 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text .text.fixup .text.unlikely .text.*)	\
+		*(.text.hot .text.hot.*)				\
+		*(.text.unlikely .text.unlikely.*)			\
+		*(.text .text.*)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\

