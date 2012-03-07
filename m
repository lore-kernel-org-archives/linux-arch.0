Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:39105 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2CGWjS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:39:18 -0500
Received: by faaa19 with SMTP id a19so250676faa.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:39:17 -0800 (PST)
Subject: [PATCH v3 12/34] unicore32/PCI: use pci_flags PCI_PROBE_ONLY instead
	of arm-specific flag
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 15:33:05 -0700
Message-ID: <20120307223305.25669.46919.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20120307223305.spAAOCgHTzfABQfQXfCIbGRHHtk4ZL98P5OdbhuX4Sk@z>

CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/unicore32/include/asm/pci.h |    1 +
 arch/unicore32/kernel/pci.c      |    5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index dd38677..f5e108f 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -14,6 +14,7 @@
 
 #ifdef __KERNEL__
 #include <asm-generic/pci-dma-compat.h>
+#include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci.h>
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index a8f07fe..2fc2b1b 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 
 static int debug_pci;
-static int use_firmware;
 
 #define CONFIG_CMD(bus, devfn, where)	\
 	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
@@ -276,7 +275,7 @@ static int __init pci_common_init(void)
 
 	pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
 
-	if (!use_firmware) {
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		/*
 		 * Size the bridge windows.
 		 */
@@ -303,7 +302,7 @@ char * __devinit pcibios_setup(char *str)
 		debug_pci = 1;
 		return NULL;
 	} else if (!strcmp(str, "firmware")) {
-		use_firmware = 1;
+		pci_add_flags(PCI_PROBE_ONLY);
 		return NULL;
 	}
 	return str;

