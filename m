From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/9] MIPS: remove the HT_PCI config option
Date: Thu, 15 Nov 2018 20:05:31 +0100
Message-ID: <20181115190538.17016-4-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

This option is always selected from LOONGSON_MACH3X.  Switch to just
seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
on CONFIG_LOONGSON_MACH3X.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                                | 11 -----------
 arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
 arch/mips/loongson64/Kconfig                     |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..7d28c9dd75d0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3040,17 +3040,6 @@ config PCI
 	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
 	  say Y, otherwise N.
 
-config HT_PCI
-	bool "Support for HT-linked PCI"
-	default y
-	depends on CPU_LOONGSON3
-	select PCI
-	select PCI_DOMAINS
-	help
-	  Loongson family machines use Hyper-Transport bus for inter-core
-	  connection and device connection. The PCI bus is a subordinate
-	  linked at HT. Choose Y for Loongson-3 based machines.
-
 config PCI_DOMAINS
 	bool
 
diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index d0ae5d55413b..b6870fec0f99 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -113,7 +113,7 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCICFG_SIZE	0x00000800	/* 2K */
 #define LOONGSON_PCICFG_TOP	(LOONGSON_PCICFG_BASE+LOONGSON_PCICFG_SIZE-1)
 
-#if defined(CONFIG_HT_PCI)
+#ifdef CONFIG_CPU_LOONGSON3
 #define LOONGSON_PCIIO_BASE	loongson_sysconf.pci_io_base
 #else
 #define LOONGSON_PCIIO_BASE	0x1fd00000
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index c865b4b9b775..781a5156ab21 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -76,7 +76,7 @@ config LOONGSON_MACH3X
 	select CPU_HAS_WB
 	select HW_HAS_PCI
 	select ISA
-	select HT_PCI
+	select PCI
 	select I8259
 	select IRQ_MIPS_CPU
 	select NR_CPUS_DEFAULT_4
-- 
2.19.1
