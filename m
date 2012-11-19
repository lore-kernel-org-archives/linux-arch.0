From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 291/493] asm-generic: remove use of __devinit
Date: Mon, 19 Nov 2012 13:24:00 -0500
Message-ID: <1353349642-3677-291-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41461 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab2KSSeS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2012 13:34:18 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Arnd Bergmann <arnd@arndb.de> 
Cc: linux-arch@vger.kernel.org 
---
 include/asm-generic/parport.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/parport.h b/include/asm-generic/parport.h
index 40528cb..2c9f9d4 100644
--- a/include/asm-generic/parport.h
+++ b/include/asm-generic/parport.h
@@ -10,8 +10,8 @@
  * to devices on the PCI bus.
  */
 
-static int __devinit parport_pc_find_isa_ports(int autoirq, int autodma);
-static int __devinit parport_pc_find_nonpci_ports(int autoirq, int autodma)
+static int parport_pc_find_isa_ports(int autoirq, int autodma);
+static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
 {
 #ifdef CONFIG_ISA
 	return parport_pc_find_isa_ports(autoirq, autodma);
-- 
1.8.0
