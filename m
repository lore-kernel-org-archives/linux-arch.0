From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] arch: switch the default on ARCH_HAS_SG_CHAIN
Date: Fri,  9 Nov 2018 10:00:08 +0100
Message-ID: <20181109090008.24150-3-hch@lst.de>
References: <20181109090008.24150-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109090008.24150-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

These days architectures are mostly out of the business of dealing with
struct scatterlist at all, unless they have architecture specific iommu
drivers.  Replace the ARCH_HAS_SG_CHAIN symbol with a ARCH_NO_SG_CHAIN
one only enabled for architectures with horrible legacy iommu drivers
like alpha and parisc, and conditionally for arm which wants to keep it
disable for legacy platforms.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../features/io/sg-chain/arch-support.txt     | 33 -------------------
 arch/alpha/Kconfig                            |  1 +
 arch/arc/Kconfig                              |  1 -
 arch/arm/Kconfig                              |  2 +-
 arch/arm64/Kconfig                            |  1 -
 arch/ia64/Kconfig                             |  1 -
 arch/parisc/Kconfig                           |  1 +
 arch/powerpc/Kconfig                          |  1 -
 arch/s390/Kconfig                             |  1 -
 arch/sparc/Kconfig                            |  1 -
 arch/x86/Kconfig                              |  1 -
 arch/xtensa/Kconfig                           |  1 -
 include/linux/scatterlist.h                   |  6 ++--
 lib/Kconfig                                   |  2 +-
 lib/scatterlist.c                             |  2 +-
 15 files changed, 8 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/features/io/sg-chain/arch-support.txt

diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
deleted file mode 100644
index 6554f0372c3f..000000000000
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Feature name:          sg-chain
-#         Kconfig:       ARCH_HAS_SG_CHAIN
-#         description:   arch supports chained scatter-gather lists
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: |  ok  |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: |  ok  |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: | TODO |
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |       riscv: | TODO |
-    |        s390: |  ok  |
-    |          sh: | TODO |
-    |       sparc: |  ok  |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: | TODO |
-    -----------------------
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5b4f88363453..a7e748a46c18 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -5,6 +5,7 @@ config ALPHA
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_NO_PREEMPT
+	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_AOUT
 	select HAVE_IDE
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index c9e2a1323536..fd48d698da29 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -13,7 +13,6 @@ config ARC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_SG_CHAIN
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..199eb62230b0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -19,6 +19,7 @@ config ARM
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_NO_SG_CHAIN if !ARM_HAS_SG_CHAIN
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
@@ -118,7 +119,6 @@ config ARM
 	  <http://www.arm.linux.org.uk/>.
 
 config ARM_HAS_SG_CHAIN
-	select ARCH_HAS_SG_CHAIN
 	bool
 
 config ARM_DMA_USE_IOMMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..4c851b3a7b7c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,7 +23,6 @@ config ARM64
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 36773def6920..d6f203658994 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -29,7 +29,6 @@ config IA64
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_DMA_MARK_CLEAN
-	select ARCH_HAS_SG_CHAIN
 	select VIRT_TO_BUS
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_IRQ_PROBE
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 92a339ee28b3..428ee50fc3db 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -11,6 +11,7 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select RTC_CLASS
 	select RTC_DRV_GENERIC
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8be31261aec8..4bc8edd83cee 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -138,7 +138,6 @@ config PPC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
-	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5173366af8f3..5624e8607054 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -73,7 +73,6 @@ config S390
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 490b2c95c212..8853b6ceae17 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -40,7 +40,6 @@ config SPARC
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
-	select ARCH_HAS_SG_CHAIN
 	select CPU_NO_EFFICIENT_FFS
 	select LOCKDEP_SMALL if LOCKDEP
 	select NEED_DMA_MAP_STATE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e3464ee92..6faab6f9b57e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -66,7 +66,6 @@ config X86
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
 	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d29b7365da8d..e3387919eb22 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config XTENSA
 	def_bool y
-	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 093aa57120b0..b96f0d0b5b8f 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -324,10 +324,10 @@ size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
  * Like SG_CHUNK_SIZE, but for archs that have sg chaining. This limit
  * is totally arbitrary, a setting of 2048 will get you at least 8mb ios.
  */
-#ifdef CONFIG_ARCH_HAS_SG_CHAIN
-#define SG_MAX_SEGMENTS	2048
-#else
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define SG_MAX_SEGMENTS	SG_CHUNK_SIZE
+#else
+#define SG_MAX_SEGMENTS	2048
 #endif
 
 #ifdef CONFIG_SG_POOL
diff --git a/lib/Kconfig b/lib/Kconfig
index a9965f4af4dd..d5a5e2ebf286 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -577,7 +577,7 @@ config SG_POOL
 # sg chaining option
 #
 
-config ARCH_HAS_SG_CHAIN
+config ARCH_NO_SG_CHAIN
 	def_bool n
 
 config ARCH_HAS_PMEM_API
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7c6096a71704..9ba349e775ef 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -271,7 +271,7 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 
 	if (nents == 0)
 		return -EINVAL;
-#ifndef CONFIG_ARCH_HAS_SG_CHAIN
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
 	if (WARN_ON_ONCE(nents > max_ents))
 		return -EINVAL;
 #endif
-- 
2.19.1
