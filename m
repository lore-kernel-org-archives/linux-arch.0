From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/9] PCI: consolidate the PCI_DOMAINS and PCI_DOMAINS_GENERIC config options
Date: Thu, 15 Nov 2018 20:05:33 +0100
Message-ID: <20181115190538.17016-6-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Move the definitions to drivers/pci and let the architectures select
them.  Two small differences to before: PCI_DOMAINS_GENERIC now selects
PCI_DOMAINS, cutting down the churn for modern architectures.  As the
only architectured arm did previously also offer PCI_DOMAINS as a user
visible choice in addition to selecting it from the relevant configs,
this is gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig            |  5 +----
 arch/arm/Kconfig              | 15 +--------------
 arch/arm/mach-bcm/Kconfig     |  2 +-
 arch/arm/mach-socfpga/Kconfig |  2 +-
 arch/arm64/Kconfig            |  7 +------
 arch/ia64/Kconfig             |  4 +---
 arch/microblaze/Kconfig       |  7 +------
 arch/mips/Kconfig             | 10 ++--------
 arch/powerpc/Kconfig          |  4 +---
 arch/riscv/Kconfig            |  7 +------
 arch/s390/Kconfig             |  4 +---
 arch/sh/Kconfig               |  3 ---
 arch/sparc/Kconfig            |  4 +---
 arch/x86/Kconfig              |  5 +----
 drivers/pci/Kconfig           |  9 +++++++++
 15 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index ef6ea8171994..2bf98e581684 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_NO_PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select FORCE_PCI if !ALPHA_JENSEN
+	select PCI_DOMAINS if PCI
 	select HAVE_AOUT
 	select HAVE_IDE
 	select HAVE_OPROFILE
@@ -321,10 +322,6 @@ config ISA_DMA_API
 	bool
 	default y
 
-config PCI_DOMAINS
-	bool
-	default y
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eb82c5cb0ad5..5eab9f943723 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -316,7 +316,7 @@ config ARCH_MULTIPLATFORM
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_MULTI_HANDLER
 	select HAVE_PCI
-	select PCI_DOMAINS if PCI
+	select PCI_DOMAINS_GENERIC if PCI
 	select SPARSE_IRQ
 	select USE_OF
 
@@ -1212,19 +1212,6 @@ config ISA_DMA
 config ISA_DMA_API
 	bool
 
-config PCI_DOMAINS
-	bool "Support for multiple PCI domains"
-	depends on PCI
-	help
-	  Enable PCI domains kernel management. Say Y if your machine
-	  has a PCI bus hierarchy that requires more than one PCI
-	  domain (aka segment) to be correctly managed. Say N otherwise.
-
-	  If you don't know what to do here, say N.
-
-config PCI_DOMAINS_GENERIC
-	def_bool PCI_DOMAINS
-
 config PCI_NANOENGINE
 	bool "BSE nanoEngine PCI support"
 	depends on SA1100_NANOENGINE
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 25aac6ee2ab1..a3f375af673d 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -20,7 +20,7 @@ config ARCH_BCM_IPROC
 	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
-	select PCI_DOMAINS if PCI
+	select PCI_DOMAINS_GENERIC if PCI
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 4adb901dd5eb..d43798defdba 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -10,7 +10,7 @@ menuconfig ARCH_SOCFPGA
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
-	select PCI_DOMAINS if PCI
+	select PCI_DOMAINS_GENERIC if PCI
 
 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index feffc52c823f..0eba26143350 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -164,6 +164,7 @@ config ARM64
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
+	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if ACPI
 	select POWER_RESET
 	select POWER_SUPPLY
@@ -288,12 +289,6 @@ config ARCH_PROC_KCORE_TEXT
 
 source "arch/arm64/Kconfig.platforms"
 
-config PCI_DOMAINS
-	def_bool PCI
-
-config PCI_DOMAINS_GENERIC
-	def_bool PCI
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 4dec7457feed..7cf4b8bd779f 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -15,6 +15,7 @@ config IA64
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select FORCE_PCI if (!IA64_HP_SIM)
+	select PCI_DOMAINS if PCI
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_EXIT_THREAD
 	select HAVE_IDE
@@ -544,9 +545,6 @@ if !IA64_HP_SIM
 
 menu "Bus options (PCI, PCMCIA)"
 
-config PCI_DOMAINS
-	def_bool PCI
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index cee1fc849d97..551252d5c561 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -36,6 +36,7 @@ config MICROBLAZE
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
+	select PCI_DOMAINS_GENERIC if PCI
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
@@ -267,12 +268,6 @@ endmenu
 
 menu "Bus Options"
 
-config PCI_DOMAINS
-	def_bool PCI
-
-config PCI_DOMAINS_GENERIC
-	def_bool PCI_DOMAINS
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 01be35aeffad..151a4aaf0610 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -73,7 +73,6 @@ config MIPS
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select MODULES_USE_ELF_REL if MODULES
-	select PCI_DOMAINS if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
@@ -3028,19 +3027,14 @@ menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
 config HW_HAS_EISA
 	bool
 
-config PCI_DOMAINS
-	bool
-
-config PCI_DOMAINS_GENERIC
-	bool
-
 config PCI_DRIVERS_GENERIC
-	select PCI_DOMAINS_GENERIC if PCI_DOMAINS
+	select PCI_DOMAINS_GENERIC if PCI
 	bool
 
 config PCI_DRIVERS_LEGACY
 	def_bool !PCI_DRIVERS_GENERIC
 	select NO_GENERIC_PCI_IOPORT_MAP
+	select PCI_DOMAINS if PCI
 
 #
 # ISA support is now enabled via select.  Too many systems still have the one
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8eba699e8ea3..edd3686eec28 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -236,6 +236,7 @@ config PPC
 	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
+	select PCI_DOMAINS			if PCI
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
@@ -931,9 +932,6 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
-config PCI_DOMAINS
-	def_bool PCI
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f17a39fe9408..5c659165b618 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -41,6 +41,7 @@ config RISCV
 	select HAVE_PCI
 	select MODULES_USE_ELF_RELA if MODULES
 	select THREAD_INFO_IN_TASK
+	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
@@ -265,12 +266,6 @@ config CMDLINE_FORCE
 
 endmenu
 
-config PCI_DOMAINS
-	def_bool PCI
-
-config PCI_DOMAINS_GENERIC
-	def_bool PCI
-
 menu "Power management options"
 
 source kernel/power/Kconfig
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9f05625d75b9..22a0c364b31d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -181,6 +181,7 @@ config S390
 	select NEED_SG_DMA_LENGTH	if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
+	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
@@ -724,9 +725,6 @@ config PCI_NR_FUNCTIONS
 
 endif	# PCI
 
-config PCI_DOMAINS
-	def_bool PCI
-
 config HAS_IOMEM
 	def_bool PCI
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 479566c76562..8a3c292ae906 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -855,9 +855,6 @@ config MAPLE
 	 Dreamcast with a serial line terminal or a remote network
 	 connection.
 
-config PCI_DOMAINS
-	bool
-
 source "drivers/pcmcia/Kconfig"
 
 endmenu
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5a4d5264822b..d2b760b4d2d2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -90,6 +90,7 @@ config SPARC64
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
+	select PCI_DOMAINS if PCI
 
 config ARCH_DEFCONFIG
 	string
@@ -473,9 +474,6 @@ config SUN_LDOMS
 	  Say Y here is you want to support virtual devices via
 	  Logical Domains.
 
-config PCI_DOMAINS
-	def_bool PCI if SPARC64
-
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a8da60284822..953db09165c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -197,6 +197,7 @@ config X86
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
+	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG
 	select PERF_EVENTS
 	select RTC_LIB
@@ -2634,10 +2635,6 @@ config PCI_XEN
 	depends on PCI && XEN
 	select SWIOTLB_XEN
 
-config PCI_DOMAINS
-	def_bool y
-	depends on PCI
-
 config MMCONF_FAM10H
 	def_bool y
 	depends on X86_64 && PCI_MMCONFIG && ACPI
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a8128a1946a2..95812fc4958c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -21,6 +21,15 @@ menuconfig PCI
 	  support for PCI-X and the foundations for PCI Express support.
 	  Say 'Y' here unless you know what you are doing.
 
+config PCI_DOMAINS
+	depends on PCI
+	bool
+
+config PCI_DOMAINS_GENERIC
+	depends on PCI
+	select PCI_DOMAINS
+	bool
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
-- 
2.19.1
