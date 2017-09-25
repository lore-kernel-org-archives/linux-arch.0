From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 2/3] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
Date: Tue, 26 Sep 2017 00:00:34 +0300
Message-ID: <20170925210035.31514-3-ynorov@caviumnetworks.com>
References: <20170925210035.31514-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170925210035.31514-1-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

All new 32-bit architectures should have 64-bit userspace off_t type, but
existing architectures has 32-bit ones.

To handle it, new config option is added to arch/Kconfig that defaults
ARCH_32BIT_OFF_T to be disabled for non-64 bit architectures. All existing
32-bit architectures enable it explicitly here.

New option affects force_o_largefile() behaviour. Namely, if userspace off_t
is 64-bits long, we have no reason to reject user to open big files.

Note that even if architectures has only 64-bit off_t in the kernel
(arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
a libc may use 32-bit off_t, and therefore want to limit the file size
to 4GB unless specified differently in the open flags.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/Kconfig            | 15 +++++++++++++++
 arch/arc/Kconfig        |  1 +
 arch/arm/Kconfig        |  1 +
 arch/blackfin/Kconfig   |  1 +
 arch/cris/Kconfig       |  1 +
 arch/frv/Kconfig        |  1 +
 arch/h8300/Kconfig      |  1 +
 arch/hexagon/Kconfig    |  1 +
 arch/m32r/Kconfig       |  1 +
 arch/m68k/Kconfig       |  1 +
 arch/metag/Kconfig      |  1 +
 arch/microblaze/Kconfig |  1 +
 arch/mips/Kconfig       |  1 +
 arch/mn10300/Kconfig    |  1 +
 arch/nios2/Kconfig      |  1 +
 arch/openrisc/Kconfig   |  1 +
 arch/parisc/Kconfig     |  1 +
 arch/powerpc/Kconfig    |  1 +
 arch/score/Kconfig      |  1 +
 arch/sh/Kconfig         |  1 +
 arch/sparc/Kconfig      |  1 +
 arch/tile/Kconfig       |  1 +
 arch/unicore32/Kconfig  |  1 +
 arch/x86/Kconfig        |  1 +
 arch/x86/um/Kconfig     |  1 +
 arch/xtensa/Kconfig     |  1 +
 include/linux/fcntl.h   |  2 +-
 27 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e02d07ca9c50..88bf4d1af1f2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -249,6 +249,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
 
+config ARCH_32BIT_OFF_T
+	bool
+	depends on !64BIT
+	help
+	  All new 32-bit architectures should have 64-bit off_t type on
+	  userspace side which corresponds to the loff_t kernel type. This
+	  is the requirement for modern ABIs. Some existing architectures
+	  already have 32-bit off_t. This option is enabled for all such
+	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
+	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
+	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
+	  unicore32, x86_32 and xtensa. This is the complete list. Any
+	  new 32-bit architecture should declare 64-bit off_t type on user
+	  side and so should not enable this option.
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index a598641eed98..a2560dec14ff 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -11,6 +11,7 @@ config ARC
 	select ARC_TIMERS
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
+	select ARCH_32BIT_OFF_T
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7888c9803eb0..b848d4bd8292 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 89bdb8264305..e8de6acf7493 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -12,6 +12,7 @@ config RWSEM_XCHGADD_ALGORITHM
 
 config BLACKFIN
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 71b758dc3a96..8c059f07ddb6 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -50,6 +50,7 @@ config LOCKDEP_SUPPORT
 config CRIS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 1cce8243449e..428d5d6f0197 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -1,6 +1,7 @@
 config FRV
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_PERF_EVENTS
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3089f7fe2abd..180f576542d5 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,5 +1,6 @@
 config H8300
         def_bool y
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 1941e4baaee6..bbcea8c33e44 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -3,6 +3,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 87cde1e4b38c..19805316e808 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -1,6 +1,7 @@
 config M32R
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select INIT_ALL_POSSIBLE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 353d90487c2b..78ee42ca616b 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -1,6 +1,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_IDE
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 7d8b322e5101..9b7d12ceca18 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -1,5 +1,6 @@
 config METAG
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select EMBEDDED
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 9d26abdf0dc1..55945abdc8e9 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cb7fcc4216fd..c543005baed7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1,6 +1,7 @@
 config MIPS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 38e3494bfb63..75f226e6e819 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -1,5 +1,6 @@
 config MN10300
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select HAVE_EXIT_THREAD
 	select HAVE_OPROFILE
 	select HAVE_UID16
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index c587764b9c5a..aafa81ea6e0b 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,5 +1,6 @@
 config NIOS2
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index a0f2e4a323c1..2b56b8011d19 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -5,6 +5,7 @@
 
 config OPENRISC
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index bb8ed34024ef..ab07a37c183e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -1,5 +1,6 @@
 config PARISC
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_OPROFILE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 809c468edab1..78f269b9db7e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -133,6 +133,7 @@ config PPC
 	#
 	# Please keep this list sorted alphabetically.
 	#
+	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 507d63181389..0a9484bbddf5 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -2,6 +2,7 @@ menu "Machine selection"
 
 config SCORE
        def_bool y
+       select ARCH_32BIT_OFF_T
        select GENERIC_IRQ_SHOW
        select GENERIC_IOMAP
        select GENERIC_ATOMIC64
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 640a85925060..2ee30af2e866 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -57,6 +57,7 @@ config SUPERH
 
 config SUPERH32
 	def_bool ARCH = "sh"
+	select ARCH_32BIT_OFF_T
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0be3828752e5..09e02b616367 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -48,6 +48,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 4583c0320059..845dcbd8235e 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -3,6 +3,7 @@
 
 config TILE
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 0a3bfd1fefcd..9629fd827d6b 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -1,5 +1,6 @@
 config UNICORE32
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fb8790a5932..06455fde2afb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -43,6 +43,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
+	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index ed56a1c4ae73..8436bcd9beba 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -21,6 +21,7 @@ config 64BIT
 config X86_32
 	def_bool !64BIT
 	select HAVE_AOUT
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7ad6d77b2f22..aa39c680ce75 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 1b48d9c9a561..297993c92490 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -11,7 +11,7 @@
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
 #ifndef force_o_largefile
-#define force_o_largefile() (BITS_PER_LONG != 32)
+#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
 
 #if BITS_PER_LONG == 32
-- 
2.11.0
