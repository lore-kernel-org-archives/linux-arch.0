From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 01/18] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Wed, 17 Aug 2016 14:46:26 +0300
Message-ID: <1471434403-25291-2-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-72559-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
List-Id: linux-arch.vger.kernel.org

All new 32-bit architectures should have 64-bit off_t type, but existing
architectures has 32-bit ones.

To handle it, new config option is added to arch/Kconfig that defaults
ARCH_32BIT_OFF_T to be disabled for 64-bit and new 32-bit architectures.
All existing 32-bit architectures enable it explicitly here.

New option affects force_o_largefile() behaviour. Namely, if off_t is
64-bits long, we have no reason to reject user to open big files.

For syscalls sys_openat() and sys_open_by_handle_at() force_o_largefile()
is called, to set O_LARGEFILE flag, and this is the only difference
comparing to compat versions. So for now we can drop compat version of
that syscalls in standard unistd, as ARCH_32BIT_OFF_T controls the
behaviour explicitly.

Note that even if architectures has only 64-bit off_t in the kernel
(arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
a libc may use 32-bit off_t, and therefore want to limit the file size
to 4GB unless specified differently in the open flags.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/Kconfig                      | 4 ++++
 arch/arc/Kconfig                  | 1 +
 arch/arm/Kconfig                  | 1 +
 arch/blackfin/Kconfig             | 1 +
 arch/cris/Kconfig                 | 1 +
 arch/frv/Kconfig                  | 1 +
 arch/h8300/Kconfig                | 1 +
 arch/hexagon/Kconfig              | 1 +
 arch/m32r/Kconfig                 | 1 +
 arch/m68k/Kconfig                 | 1 +
 arch/metag/Kconfig                | 1 +
 arch/microblaze/Kconfig           | 1 +
 arch/mips/Kconfig                 | 1 +
 arch/mn10300/Kconfig              | 1 +
 arch/nios2/Kconfig                | 1 +
 arch/openrisc/Kconfig             | 1 +
 arch/parisc/Kconfig               | 1 +
 arch/powerpc/Kconfig              | 1 +
 arch/score/Kconfig                | 1 +
 arch/sh/Kconfig                   | 1 +
 arch/sparc/Kconfig                | 1 +
 arch/tile/Kconfig                 | 1 +
 arch/unicore32/Kconfig            | 1 +
 arch/x86/Kconfig                  | 1 +
 arch/x86/um/Kconfig               | 1 +
 arch/xtensa/Kconfig               | 1 +
 include/linux/fcntl.h             | 2 +-
 include/uapi/asm-generic/unistd.h | 5 ++---
 28 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e9c9334..eaf657c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -234,6 +234,10 @@ config ARCH_THREAD_STACK_ALLOCATOR
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
 
+config ARCH_32BIT_OFF_T
+	bool
+	depends on !64BIT
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 0d3e59f..d5ca749 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,6 +9,7 @@
 config ARC
 	def_bool y
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
+	select ARCH_32BIT_OFF_T
 	select BUILDTIME_EXTABLE_SORT
 	select CLKSRC_OF
 	select CLONE_BACKWARDS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48..888b067 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 28c63fe..097e7a5 100644
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
index deba266..b1376a9 100644
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
index eefd9a4..2f14904 100644
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
index 3ae8525..29bbcb1 100644
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
index 1941e4b..bbcea8c 100644
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
index 3cc8498..efa10d3 100644
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
index 498b567..e9897e4 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -1,6 +1,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 5b7a45d..c337192 100644
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
index 86f6572..3a6146b 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2638856..4552f76 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1,6 +1,7 @@
 config MIPS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 38e3494..c44c699 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -1,6 +1,7 @@
 config MN10300
 	def_bool y
 	select HAVE_EXIT_THREAD
+	select ARCH_32BIT_OFF_T
 	select HAVE_OPROFILE
 	select HAVE_UID16
 	select GENERIC_IRQ_SHOW
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 51a56c8..f9273c9 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,5 +1,6 @@
 config NIOS2
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select CLKSRC_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 489e7f9..c4c96c9 100644
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
index cd87781..8630385 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -1,5 +1,6 @@
 config PARISC
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab..c28fece 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -85,6 +85,7 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 507d631..0a9484b 100644
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
index ee08695..1f99eb3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -56,6 +56,7 @@ config SUPERH
 
 config SUPERH32
 	def_bool ARCH = "sh"
+	select ARCH_32BIT_OFF_T
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 59b0960..e1a1ad3 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -47,6 +47,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 4820a02..79434be 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -4,6 +4,7 @@
 config TILE
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 0769066..cc642f9 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -1,6 +1,7 @@
 config UNICORE32
 	def_bool y
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_32BIT_OFF_T
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_MEMBLOCK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c580d8c..5789877 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -20,6 +20,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
+	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index ed56a1c..8436bcd 100644
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
index 64336f6..1eeca06 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 76ce329..46960a1 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -5,7 +5,7 @@
 
 
 #ifndef force_o_largefile
-#define force_o_largefile() (BITS_PER_LONG != 32)
+#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
 
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a26415b..4dcc38d 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -178,7 +178,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -676,8 +676,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 #define __NR_clock_adjtime 266
 __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
 #define __NR_syncfs 267
-- 
2.7.4
