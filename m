Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jul 2018 09:19:59 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/10] kconfig: include kernel/Kconfig.preempt from init/Kconfig
Date: Tue, 31 Jul 2018 13:39:32 +0200
Message-ID: <20180731113935.6105-8-hch@lst.de>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180731113932.dz_okJvqwrynZQtWFllqpSrD_lyJ-dIpbQBavOWPD80@z>

Almost all architectures include it.  Add a ARCH_NO_PREEMPT symbol to
disable preempt support for alpha, hexagon, non-coldfire m68k and
user mode Linux.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig            | 3 +++
 arch/alpha/Kconfig      | 1 +
 arch/arc/Kconfig        | 2 --
 arch/arm/Kconfig        | 2 --
 arch/arm64/Kconfig      | 1 -
 arch/c6x/Kconfig        | 2 --
 arch/h8300/Kconfig      | 6 ------
 arch/hexagon/Kconfig    | 1 +
 arch/ia64/Kconfig       | 2 --
 arch/m68k/Kconfig       | 5 +----
 arch/microblaze/Kconfig | 2 --
 arch/mips/Kconfig       | 2 --
 arch/nds32/Kconfig      | 1 -
 arch/nios2/Kconfig      | 2 --
 arch/openrisc/Kconfig   | 1 -
 arch/parisc/Kconfig     | 1 -
 arch/powerpc/Kconfig    | 1 -
 arch/riscv/Kconfig      | 2 --
 arch/s390/Kconfig       | 2 --
 arch/sh/Kconfig         | 2 --
 arch/sparc/Kconfig      | 2 --
 arch/um/Kconfig         | 1 +
 arch/unicore32/Kconfig  | 2 --
 arch/x86/Kconfig        | 2 --
 arch/xtensa/Kconfig     | 2 --
 init/Kconfig            | 1 +
 kernel/Kconfig.preempt  | 2 ++
 lib/Kconfig.debug       | 1 +
 28 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 09a561a70168..cddd0faae4cb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -881,6 +881,9 @@ config COMPAT_32BIT_TIME
 config ARCH_NO_COHERENT_DMA_MMAP
 	bool
 
+config ARCH_NO_PREEMPT
+	bool
+
 config CPU_NO_EFFICIENT_FFS
 	def_bool n
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index e4334f017f8e..5b4f88363453 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -4,6 +4,7 @@ config ALPHA
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_NO_PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_AOUT
 	select HAVE_IDE
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 85b56dee4efa..24bf1408ae59 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -545,8 +545,6 @@ config ARC_BUILTIN_DTB_NAME
 	  Set the name of the DTB to embed in the vmlinux binary
 	  Leaving it blank selects the minimal "skeleton" dtb
 
-source "kernel/Kconfig.preempt"
-
 endmenu	 # "ARC Architecture Configuration"
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9aaa23c25374..1b1c21519039 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1481,8 +1481,6 @@ config ARCH_NR_GPIO
 
 	  If unsure, leave the default value.
 
-source kernel/Kconfig.preempt
-
 config HZ_FIXED
 	int
 	default 200 if ARCH_EBSA110
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d457ec417a..daf59d363dd3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -752,7 +752,6 @@ config HOLES_IN_ZONE
 	def_bool y
 	depends on NUMA
 
-source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 904b3375331e..a641b0bf1611 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -110,8 +110,6 @@ config KERNEL_RAM_BASE_ADDRESS
 	default 0xe0000000 if SOC_TMS320C6472
 	default 0x80000000
 
-source "kernel/Kconfig.preempt"
-
 source "kernel/Kconfig.hz"
 
 endmenu
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index c16e7cf732f7..5e89d40be8cd 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -49,9 +49,3 @@ config NR_CPUS
 	default 1
 
 source "arch/h8300/Kconfig.cpu"
-
-menu "Kernel Features"
-
-source "kernel/Kconfig.preempt"
-
-endmenu
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index fcdb6d9fcecc..89a4b22f34d9 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -4,6 +4,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_NO_PREEMPT
 	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 34a8d24cffea..86bd377bc7c0 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -364,8 +364,6 @@ config FORCE_CPEI_RETARGET
 	This option it useful to enable this feature on older BIOS's as well.
 	You can also enable this by using boot command line option force_cpei=1.
 
-source "kernel/Kconfig.preempt"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index cf41ad45513f..3e47f8df6504 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
+	select ARCH_NO_PREEMPT if !COLDFIRE
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
 	select HAVE_DEBUG_BUGVERBOSE
@@ -129,10 +130,6 @@ endmenu
 
 menu "Kernel Features"
 
-if COLDFIRE
-source "kernel/Kconfig.preempt"
-endif
-
 endmenu
 
 if !MMU
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index f4492e9478fe..6163a39ddeb6 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -87,8 +87,6 @@ source "arch/microblaze/Kconfig.platform"
 
 menu "Processor type and features"
 
-source "kernel/Kconfig.preempt"
-
 source "kernel/Kconfig.hz"
 
 config MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ab02824c3976..06a633eb9777 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2818,8 +2818,6 @@ config HZ
 config SCHED_HRTICK
 	def_bool HIGH_RES_TIMERS
 
-source "kernel/Kconfig.preempt"
-
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index d834061ba0ec..1d4248fa55e9 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -88,6 +88,5 @@ config NDS32_BUILTIN_DTB
 endmenu
 
 menu "Kernel Features"
-source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 endmenu
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 22d19febcc92..cbe1844b0657 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -47,8 +47,6 @@ config TRACE_IRQFLAGS_SUPPORT
 
 menu "Kernel features"
 
-source "kernel/Kconfig.preempt"
-
 source "kernel/Kconfig.hz"
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index c52cecd94d62..42e3a0f2afab 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -143,7 +143,6 @@ config SMP
 	  If you don't know what to do here, say N.
 
 source kernel/Kconfig.hz
-source kernel/Kconfig.preempt
 
 config OPENRISC_NO_SPR_SR_DSX
 	bool "use SPR_SR_DSX software emulation" if OR1K_1200
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index d1dd56ea297b..89496aa318da 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -323,7 +323,6 @@ config NODES_SHIFT
 	default "3"
 	depends on NEED_MULTIPLE_NODES
 
-source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 
 config COMPAT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c55e61302d57..1c10ff0406f2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -393,7 +393,6 @@ config HIGHMEM
 	depends on PPC32
 
 source kernel/Kconfig.hz
-source kernel/Kconfig.preempt
 
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 73c0e16793fa..a344980287a5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -212,8 +212,6 @@ endmenu
 
 menu "Kernel type"
 
-source "kernel/Kconfig.preempt"
-
 source "kernel/Kconfig.hz"
 
 endmenu
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 10685536fa90..abfc8e625370 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -511,8 +511,6 @@ config SCHED_TOPOLOGY
 	  making when dealing with machines that have multi-threading,
 	  multiple cores or multiple books.
 
-source kernel/Kconfig.preempt
-
 source kernel/Kconfig.hz
 
 config KEXEC
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index c8460330eff7..993f61a5961d 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -709,8 +709,6 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
-source "kernel/Kconfig.preempt"
-
 config GUSA
 	def_bool y
 	depends on !SMP && SUPERH32
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 622695e8fa44..2d58c26bff9a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -349,8 +349,6 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
-source "kernel/Kconfig.preempt"
-
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
 	depends on SPARC64
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 3022d1bf9bf9..6b9938919f0b 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_HAS_KCOV
+	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_UID16
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 6bfaa4a910e1..60eae744d8fd 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -135,8 +135,6 @@ endmenu
 
 menu "Kernel Features"
 
-source "kernel/Kconfig.preempt"
-
 source "kernel/Kconfig.hz"
 
 config LEDS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fd3a4c77b028..41dbcff3074f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1039,8 +1039,6 @@ config SCHED_MC_PRIO
 
 	  If unsure say Y here.
 
-source "kernel/Kconfig.preempt"
-
 config UP_LATE_INIT
        def_bool y
        depends on !SMP && X86_LOCAL_APIC
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index aae0e1800be7..801491e98890 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -173,8 +173,6 @@ config XTENSA_UNALIGNED_USER
 
 	  Say Y here to enable unaligned memory access in user space.
 
-source "kernel/Kconfig.preempt"
-
 config HAVE_SMP
 	bool "System Supports SMP (MX)"
 	depends on XTENSA_VARIANT_CUSTOM
diff --git a/init/Kconfig b/init/Kconfig
index 283f6bc796b1..29bbad9338d6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -326,6 +326,7 @@ config AUDIT_TREE
 
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
+source "kernel/Kconfig.preempt"
 
 menu "CPU/Task time and stats accounting"
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 3f9c97419f02..cd1655122ec0 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -18,6 +18,7 @@ config PREEMPT_NONE
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
+	depends on !ARCH_NO_PREEMPT
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -35,6 +36,7 @@ config PREEMPT_VOLUNTARY
 
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
+	depends on !ARCH_NO_PREEMPT
 	select PREEMPT_COUNT
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 26d3ff7e3cf4..373ce9fecd7e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1195,6 +1195,7 @@ config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
+	depends on !ARCH_NO_PREEMPT
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called inside atomic sections: when a spinlock is
-- 
2.18.0
