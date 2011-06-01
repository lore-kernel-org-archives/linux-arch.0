Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59128 "EHLO duck.linux-mips.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759626Ab1FATre (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jun 2011 15:47:34 -0400
Message-ID: <20110601180611.061710714@duck.linux-mips.net>
Date: Wed, 01 Jun 2011 19:05:10 +0100
From: ralf@linux-mips.org
Subject: [patch 14/14] PCSPKR: MIPS: Make config dependencies finer grained.
References: <20110601180456.801265664@duck.linux-mips.net>
Content-Disposition: inline; filename=i8253-make-mips-pcspkr-config-finer-grained.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Message-ID: <20110601180510.YGvVBueJM2L4sfiPJWfysFKrTLJrgEPSra8N5Ap-J2c@z>

Only the Siemens-Nixdorf RM series workstations and the Jazz family
workstations have PC speakers built in; Malta can connect one via the
infamous AMR connector with an AMR sound card or a little creativity.
So we don't want to offer the PC speaker driver on all MIPS systems.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org

 arch/mips/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-mips/arch/mips/Kconfig
===================================================================
--- linux-mips.orig/arch/mips/Kconfig
+++ linux-mips/arch/mips/Kconfig
@@ -5,7 +5,6 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_IRQ_WORK
-	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
@@ -186,6 +185,7 @@ config MACH_JAZZ
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select GENERIC_ISA_DMA
+	select HAVE_PCSPKR_PLATFORM
 	select IRQ_CPU
 	select I8253
 	select I8259
@@ -267,6 +267,7 @@ config MIPS_MALTA
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
+	select HAVE_PCSPKR_PLATFORM
 	select IRQ_CPU
 	select IRQ_GIC
 	select HW_HAS_PCI
@@ -641,6 +642,7 @@ config SNI_RM
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
+	select HAVE_PCSPKR_PLATFORM
 	select HW_HAS_EISA
 	select HW_HAS_PCI
 	select IRQ_CPU


