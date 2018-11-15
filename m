From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/9] pcmcia: allow PCMCIA support independent of the architecture
Date: Thu, 15 Nov 2018 20:05:35 +0100
Message-ID: <20181115190538.17016-8-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

There is nothing architecture specific in the PCMCIA core, so allow
building it everywhere.  The actual host controllers will depend on ISA,
PCI or a specific SOC.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/alpha/Kconfig     |  2 --
 arch/arm/Kconfig       |  2 --
 arch/ia64/Kconfig      | 10 ----------
 arch/m68k/Kconfig.bus  |  2 --
 arch/mips/Kconfig      |  2 --
 arch/powerpc/Kconfig   |  2 --
 arch/sh/Kconfig        |  2 --
 arch/sparc/Kconfig     |  2 --
 arch/unicore32/Kconfig |  6 ------
 arch/x86/Kconfig       |  2 --
 arch/xtensa/Kconfig    |  2 --
 drivers/Kconfig        |  1 +
 drivers/parisc/Kconfig |  2 --
 drivers/pcmcia/Kconfig |  1 +
 14 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 1f679508bc34..0ff180ab2a42 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -669,8 +669,6 @@ config HZ
 
 source "drivers/eisa/Kconfig"
 
-source "drivers/pcmcia/Kconfig"
-
 config SRM_ENV
 	tristate "SRM environment through procfs"
 	depends on PROC_FS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73d0f5e9feb7..7b1dfaec030e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1225,8 +1225,6 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8f18d90c933d..887e7bfd7055 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -542,16 +542,6 @@ endif
 
 endmenu
 
-if !IA64_HP_SIM
-
-menu "Bus options (PCI, PCMCIA)"
-
-source "drivers/pcmcia/Kconfig"
-
-endmenu
-
-endif
-
 source "arch/ia64/hp/sim/Kconfig"
 
 config MSPEC
diff --git a/arch/m68k/Kconfig.bus b/arch/m68k/Kconfig.bus
index 8cb0604b195b..9d0a3a23d50e 100644
--- a/arch/m68k/Kconfig.bus
+++ b/arch/m68k/Kconfig.bus
@@ -68,6 +68,4 @@ if !MMU
 config ISA_DMA_API
         def_bool !M5272
 
-source "drivers/pcmcia/Kconfig"
-
 endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 151a4aaf0610..3912250ff813 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3107,8 +3107,6 @@ config ZONE_DMA
 config ZONE_DMA32
 	bool
 
-source "drivers/pcmcia/Kconfig"
-
 config HAS_RAPIDIO
 	bool
 	default n
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cbdcd1c0b1e0..cc8435d87949 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -939,8 +939,6 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-source "drivers/pcmcia/Kconfig"
-
 config HAS_RAPIDIO
 	bool
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 8a3c292ae906..44a45a37a3c4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -855,8 +855,6 @@ config MAPLE
 	 Dreamcast with a serial line terminal or a remote network
 	 connection.
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 menu "Power management options (EXPERIMENTAL)"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 20417b8b12a5..daee2c73b6c5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -503,8 +503,6 @@ config SPARC_GRPCI2
 	help
 	  Say Y here to include the GRPCI2 Host Bridge Driver.
 
-source "drivers/pcmcia/Kconfig"
-
 config SUN_OPENPROMFS
 	tristate "Openprom tree appears in /proc/openprom"
 	help
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 4658859c6aee..96ac6cc6ab2a 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -117,12 +117,6 @@ config UNICORE_FPU_F64
 
 endmenu
 
-menu "Bus support"
-
-source "drivers/pcmcia/Kconfig"
-
-endmenu
-
 menu "Kernel Features"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 953db09165c2..659d59d7f033 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2811,8 +2811,6 @@ config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
-source "drivers/pcmcia/Kconfig"
-
 config RAPIDIO
 	tristate "RapidIO support"
 	depends on PCI
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2865a556163a..322b7391de89 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -512,8 +512,6 @@ config FORCE_MAX_ZONEORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 11 means that the largest free memory block is 2^10 pages.
 
-source "drivers/pcmcia/Kconfig"
-
 config PLATFORM_WANT_DEFAULT_MEM
 	def_bool n
 
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 059573823387..58ee88c36cf5 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -5,6 +5,7 @@ menu "Device Drivers"
 
 source "drivers/amba/Kconfig"
 source "drivers/pci/Kconfig"
+source "drivers/pcmcia/Kconfig"
 
 
 source "drivers/base/Kconfig"
diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
index 5bbfea1a019c..1a55763d1245 100644
--- a/drivers/parisc/Kconfig
+++ b/drivers/parisc/Kconfig
@@ -92,8 +92,6 @@ config IOMMU_SBA
 	depends on PCI_LBA
 	default PCI_LBA
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 menu "PA-RISC specific drivers"
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index cbbe4a285b48..c9bdbb463a7e 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
+	depends on !UML
 	---help---
 	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
 	  computer.  These are credit-card size devices such as network cards,
-- 
2.19.1
