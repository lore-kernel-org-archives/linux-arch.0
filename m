From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 05/11] arm/PCI: use pci_flags PCI_PROBE_ONLY instead of
	arm-specific flag
Date: Wed, 22 Feb 2012 11:19:27 -0700
Message-ID: <20120222181927.27513.36301.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:56042 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab2BVST2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2012 13:19:28 -0500
Received: by yenm1 with SMTP id m1so39414yen.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2012 10:19:28 -0800 (PST)
In-Reply-To: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index f3fd52b..8d7c22d 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -16,7 +16,6 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
-static int use_firmware;
 
 /*
  * We can't use pci_find_device() here since we are
@@ -537,7 +536,7 @@ void __init pci_common_init(struct hw_pci *hw)
 	list_for_each_entry(sys, &hw->buses, node) {
 		struct pci_bus *bus = sys->bus;
 
-		if (!use_firmware) {
+		if (!pci_has_flag(PCI_PROBE_ONLY)) {
 			/*
 			 * Size the bridge windows.
 			 */
@@ -575,7 +574,7 @@ char * __init pcibios_setup(char *str)
 		debug_pci = 1;
 		return NULL;
 	} else if (!strcmp(str, "firmware")) {
-		use_firmware = 1;
+		pci_add_flags(PCI_PROBE_ONLY);
 		return NULL;
 	}
 	return str;
