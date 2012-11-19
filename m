Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41653 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab2KSSiP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2012 13:38:15 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 022/493] ARM: remove CONFIG_HOTPLUG ifdefs
Date: Mon, 19 Nov 2012 13:19:31 -0500
Message-ID: <1353349642-3677-22-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Message-ID: <20121119181931.A1KVqHe3442f0bGiJM3vXrGROwsVXPO3kMZGtPmz4kE@z>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Arnd Bergmann <arnd@arndb.de> 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-arch@vger.kernel.org 
---
 arch/arm/kernel/bios32.c          | 4 ++--
 arch/arm/kernel/vmlinux.lds.S     | 2 --
 include/asm-generic/vmlinux.lds.h | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 9b72261..f136307 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -361,9 +361,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
 		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
 }
-#ifdef CONFIG_HOTPLUG
+
 EXPORT_SYMBOL(pcibios_fixup_bus);
-#endif
+
 
 /*
  * Swizzle the device pin each time we cross a bridge.  If a platform does
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b9f38e3..38279fe 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -66,10 +66,8 @@ SECTIONS
 		ARM_EXIT_DISCARD(EXIT_TEXT)
 		ARM_EXIT_DISCARD(EXIT_DATA)
 		EXIT_CALL
-#ifndef CONFIG_HOTPLUG
 		*(.ARM.exidx.devexit.text)
 		*(.ARM.extab.devexit.text)
-#endif
 #ifndef CONFIG_MMU
 		*(.fixup)
 		*(__ex_table)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1ea7ce..856b58d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -74,13 +74,8 @@
  * are handled as text/data or they can be discarded (which
  * often happens at runtime)
  */
-#ifdef CONFIG_HOTPLUG
 #define DEV_KEEP(sec)    *(.dev##sec)
 #define DEV_DISCARD(sec)
-#else
-#define DEV_KEEP(sec)
-#define DEV_DISCARD(sec) *(.dev##sec)
-#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define CPU_KEEP(sec)    *(.cpu##sec)
-- 
1.8.0

