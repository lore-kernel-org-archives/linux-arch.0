From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] PCI: consolidate the PCI_SYSCALL symbol
Date: Thu, 15 Nov 2018 20:05:34 +0100
Message-ID: <20181115190538.17016-7-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Let architectures select the syscall support instead of duplicating the
kconfig entry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig      | 4 +---
 arch/arc/Kconfig        | 4 +---
 arch/arm/Kconfig        | 4 +---
 arch/arm64/Kconfig      | 4 +---
 arch/ia64/Kconfig       | 4 +---
 arch/microblaze/Kconfig | 4 +---
 arch/powerpc/Kconfig    | 4 +---
 arch/sparc/Kconfig      | 4 +---
 drivers/pci/Kconfig     | 3 +++
 9 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 2bf98e581684..1f679508bc34 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -8,6 +8,7 @@ config ALPHA
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select FORCE_PCI if !ALPHA_JENSEN
 	select PCI_DOMAINS if PCI
+	select PCI_SYSCALL if PCI
 	select HAVE_AOUT
 	select HAVE_IDE
 	select HAVE_OPROFILE
@@ -322,9 +323,6 @@ config ISA_DMA_API
 	bool
 	default y
 
-config PCI_SYSCALL
-	def_bool PCI
-
 config ALPHA_NONAME
 	bool
 	depends on ALPHA_BOOK1 || ALPHA_NONAME_CH
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5d2dde4b04cd..54d618960a14 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -46,6 +46,7 @@ config ARC
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
+	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 
 config ARCH_HAS_CACHE_LINE_SIZE
@@ -550,7 +551,4 @@ config FORCE_MAX_ZONEORDER
 	default "12" if ARC_HUGEPAGE_16M
 	default "11"
 
-config PCI_SYSCALL
-	def_bool PCI
-
 source "kernel/power/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5eab9f943723..73d0f5e9feb7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -103,6 +103,7 @@ config ARM
 	select OF_RESERVED_MEM if OF
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
+	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select REFCOUNT_FULL
 	select RTC_LIB
@@ -1218,9 +1219,6 @@ config PCI_NANOENGINE
 	help
 	  Enable PCI on the BSE nanoEngine board.
 
-config PCI_SYSCALL
-	def_bool PCI
-
 config PCI_HOST_ITE8152
 	bool
 	depends on PCI && MACH_ARMCORE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0eba26143350..8db186f8442b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -166,6 +166,7 @@ config ARM64
 	select OF_RESERVED_MEM
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if ACPI
+	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
@@ -289,9 +290,6 @@ config ARCH_PROC_KCORE_TEXT
 
 source "arch/arm64/Kconfig.platforms"
 
-config PCI_SYSCALL
-	def_bool PCI
-
 menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 7cf4b8bd779f..8f18d90c933d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -16,6 +16,7 @@ config IA64
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select FORCE_PCI if (!IA64_HP_SIM)
 	select PCI_DOMAINS if PCI
+	select PCI_SYSCALL if PCI
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_EXIT_THREAD
 	select HAVE_IDE
@@ -545,9 +546,6 @@ if !IA64_HP_SIM
 
 menu "Bus options (PCI, PCMCIA)"
 
-config PCI_SYSCALL
-	def_bool PCI
-
 source "drivers/pcmcia/Kconfig"
 
 endmenu
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 551252d5c561..b3012bb4e2b2 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -37,6 +37,7 @@ config MICROBLAZE
 	select OF
 	select OF_EARLY_FLATTREE
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_SYSCALL if PCI
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
@@ -268,9 +269,6 @@ endmenu
 
 menu "Bus Options"
 
-config PCI_SYSCALL
-	def_bool PCI
-
 config PCI_XILINX
 	bool "Xilinx PCI host bridge support"
 	depends on PCI
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index edd3686eec28..cbdcd1c0b1e0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
+	select PCI_SYSCALL			if PCI
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
@@ -932,9 +933,6 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
-config PCI_SYSCALL
-	def_bool PCI
-
 config PCI_8260
 	bool
 	depends on PCI && 8260
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d2b760b4d2d2..20417b8b12a5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -39,6 +39,7 @@ config SPARC
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
+	select PCI_SYSCALL if PCI
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select ARCH_HAS_SG_CHAIN
@@ -474,9 +475,6 @@ config SUN_LDOMS
 	  Say Y here is you want to support virtual devices via
 	  Logical Domains.
 
-config PCI_SYSCALL
-	def_bool PCI
-
 config PCIC_PCI
 	bool
 	depends on PCI && SPARC32 && !SPARC_LEON
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 95812fc4958c..904847d173de 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -30,6 +30,9 @@ config PCI_DOMAINS_GENERIC
 	select PCI_DOMAINS
 	bool
 
+config PCI_SYSCALL
+	bool
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
-- 
2.19.1
