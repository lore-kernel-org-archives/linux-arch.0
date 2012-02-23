Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f74.google.com ([209.85.216.74]:33001 "EHLO
	mail-qw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab2BWTn2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2012 14:43:28 -0500
Received: by mail-qw0-f74.google.com with SMTP id b12so213840qad.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2012 11:43:28 -0800 (PST)
Subject: [PATCH v2 05/12] arm/PCI: use pci_flags PCI_PROBE_ONLY instead of
	arm-specific flag
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 12:43:27 -0700
Message-ID: <20120223194327.20708.30508.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <20120223194327.G86TX6P1ZEh7lh458sBFqviC2yyia_ZtWkrV_V0dacw@z>

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

