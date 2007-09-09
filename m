Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:47620 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbXIISFA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 14:05:00 -0400
Date: Sun, 9 Sep 2007 20:06:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/4] ia64: fix sn to add include files using EXTRA_CFLAGS
Message-ID: <20070909180623.GD20086@uranus.ravnborg.org>
References: <20070909180254.GA20086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070909180254.GA20086@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>

Changing the global CPPFLAGS is not the recommended way
to add additional include dirs.
Changed to use EXTRA_CFLAGS.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/ia64/sn/kernel/Makefile     |    2 +-
 arch/ia64/sn/kernel/sn2/Makefile |    2 +-
 arch/ia64/sn/pci/Makefile        |    2 +-
 arch/ia64/sn/pci/pcibr/Makefile  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/sn/kernel/Makefile b/arch/ia64/sn/kernel/Makefile
index 0a59371..688a3c2 100644
--- a/arch/ia64/sn/kernel/Makefile
+++ b/arch/ia64/sn/kernel/Makefile
@@ -7,7 +7,7 @@
 # Copyright (C) 1999,2001-2006 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
-CPPFLAGS += -I$(srctree)/arch/ia64/sn/include
+EXTRA_CFLAGS += -Iarch/ia64/sn/include
 
 obj-y				+= setup.o bte.o bte_error.o irq.o mca.o idle.o \
 				   huberror.o io_acpi_init.o io_common.o \
diff --git a/arch/ia64/sn/kernel/sn2/Makefile b/arch/ia64/sn/kernel/sn2/Makefile
index 99e1776..08e6565 100644
--- a/arch/ia64/sn/kernel/sn2/Makefile
+++ b/arch/ia64/sn/kernel/sn2/Makefile
@@ -9,7 +9,7 @@
 # sn2 specific kernel files
 #
 
-CPPFLAGS += -I$(srctree)/arch/ia64/sn/include
+EXTRA_CFLAGS += -Iarch/ia64/sn/include
 
 obj-y += cache.o io.o ptc_deadlock.o sn2_smp.o sn_proc_fs.o \
 	 prominfo_proc.o timer.o timer_interrupt.o sn_hwperf.o
diff --git a/arch/ia64/sn/pci/Makefile b/arch/ia64/sn/pci/Makefile
index c694678..ad4ef34 100644
--- a/arch/ia64/sn/pci/Makefile
+++ b/arch/ia64/sn/pci/Makefile
@@ -7,6 +7,6 @@
 #
 # Makefile for the sn pci general routines.
 
-CPPFLAGS += -I$(srctree)/arch/ia64/sn/include
+EXTRA_CFLAGS += -Iarch/ia64/sn/include
 
 obj-y := pci_dma.o tioca_provider.o tioce_provider.o pcibr/
diff --git a/arch/ia64/sn/pci/pcibr/Makefile b/arch/ia64/sn/pci/pcibr/Makefile
index 3b403ea..01192d3 100644
--- a/arch/ia64/sn/pci/pcibr/Makefile
+++ b/arch/ia64/sn/pci/pcibr/Makefile
@@ -7,7 +7,7 @@
 #
 # Makefile for the sn2 io routines.
 
-CPPFLAGS += -I$(srctree)/arch/ia64/sn/include
+EXTRA_CFLAGS += -Iarch/ia64/sn/include
 
 obj-y				+=  pcibr_dma.o pcibr_reg.o \
 				    pcibr_ate.o pcibr_provider.o
-- 
1.5.1.rc3.2928.g8e573-dirty

