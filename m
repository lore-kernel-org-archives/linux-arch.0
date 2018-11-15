From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] rapidio: consolidate RAPIDIO config entry in drivers/rapidio
Date: Thu, 15 Nov 2018 20:05:36 +0100
Message-ID: <20181115190538.17016-9-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

There is no good reason to duplicate the RAPIDIO menu in various
architectures.  Instead provide a selectable HAVE_RAPIDIO symbol
that indicates native availability of RAPIDIO support and the handle
the rest in drivers/pci.  This also means we now provide support
for PCI(e) to Rapidio bridges for every architecture instead of a
limited subset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig                   | 15 +--------------
 arch/powerpc/Kconfig                | 14 +-------------
 arch/powerpc/platforms/85xx/Kconfig |  8 ++++----
 arch/powerpc/platforms/86xx/Kconfig |  4 ++--
 arch/x86/Kconfig                    |  9 ---------
 drivers/Kconfig                     |  1 +
 drivers/rapidio/Kconfig             | 11 +++++++++++
 7 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3912250ff813..67fbd4952ff4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -892,7 +892,7 @@ config CAVIUM_OCTEON_SOC
 	bool "Cavium Networks Octeon SoC based boards"
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -3107,19 +3107,6 @@ config ZONE_DMA
 config ZONE_DMA32
 	bool
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config TRAD_SIGNALS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cc8435d87949..f2f70cc2bd44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -939,26 +939,14 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-config HAS_RAPIDIO
-	bool
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
-	depends on RAPIDIO = y && HAS_RAPIDIO
+	depends on RAPIDIO = y && HAVE_RAPIDIO
 	default "n"
 	---help---
 	  Include support for RapidIO controller on Freescale embedded
 	  processors (MPC8548, MPC8641, etc).
 
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config NONSTATIC_KERNEL
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ba0ea84ce578..d1af0ee2f8c8 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -66,7 +66,7 @@ config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
 	select PPC_I8259
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	help
 	  This option enables support for the MPC85xx CDS board
 
@@ -74,7 +74,7 @@ config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
 	select PHYLIB if NETDEVICES
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx MDS board
@@ -219,7 +219,7 @@ config PPA8548
 	help
 	  This option enables support for the Prodrive PPA8548 board.
 	select DEFAULT_UIMAGE
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 
 config GE_IMP3A
 	bool "GE Intelligent Platforms IMP3A"
@@ -277,7 +277,7 @@ config CORENET_GENERIC
 	select SWIOTLB
 	select GPIOLIB
 	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
 	  This option enables support for the FSL CoreNet based boards.
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index a4fa31a40502..413837a63242 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -15,7 +15,7 @@ config MPC8641_HPCN
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
 	  This option enables support for the MPC8641 HPCN board.
@@ -57,7 +57,7 @@ config GEF_SBC610
 	select MMIO_NVRAM
 	select GPIOLIB
 	select GE_FPGA
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	help
 	  This option enables support for the GE SBC610.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 659d59d7f033..4c8052a7c3f9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2811,15 +2811,6 @@ config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on PCI
-	help
-	  If enabled this option will include drivers and the core
-	  infrastructure code to support RapidIO interconnect devices.
-
-source "drivers/rapidio/Kconfig"
-
 config X86_SYSFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
 	help
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 58ee88c36cf5..065d308fcb00 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -6,6 +6,7 @@ menu "Device Drivers"
 source "drivers/amba/Kconfig"
 source "drivers/pci/Kconfig"
 source "drivers/pcmcia/Kconfig"
+source "drivers/rapidio/Kconfig"
 
 
 source "drivers/base/Kconfig"
diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index d6d2f20c4597..e3d8fe41b50c 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -1,6 +1,17 @@
 #
 # RapidIO configuration
 #
+
+config HAVE_RAPIDIO
+	bool
+
+menuconfig RAPIDIO
+	tristate "RapidIO support"
+	depends on HAVE_RAPIDIO || PCI
+	help
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
 source "drivers/rapidio/devices/Kconfig"
 
 config RAPIDIO_DISC_TIMEOUT
-- 
2.19.1
