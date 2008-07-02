From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 8/23] make section names compatible with -ffunction-sections -fdata-sections: h8300
Date: Wed, 2 Jul 2008 02:36:22 +0200
Message-ID: <200807020236.22585.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.228]:5514 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762176AbYGAWgV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 18:36:21 -0400
Received: by qb-out-0506.google.com with SMTP id d8so934895qbc.37
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 15:36:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes h8300 architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/h8300/boot/compressed/head.S	Wed Jul  2 00:40:40 2008
+++ 1.fixname/arch/h8300/boot/compressed/head.S	Wed Jul  2 00:44:34 2008
@@ -9,7 +9,7 @@
 
 #define SRAM_START 0xff4000
 
-	.section	.text.startup
+	.section	.startup.text
 	.global	startup
 startup:
 	mov.l	#SRAM_START+0x8000, sp
--- 0.org/arch/h8300/boot/compressed/vmlinux.lds	Wed Jul  2 00:40:40 2008
+++ 1.fixname/arch/h8300/boot/compressed/vmlinux.lds	Wed Jul  2 00:44:34 2008
@@ -4,7 +4,7 @@
         {
         __stext = . ;
 	__text = .;
-	       *(.text.startup)
+	       *(.startup.text)
 	       *(.text)
         __etext = . ;
         }
--- 0.org/arch/h8300/kernel/init_task.c	Wed Jul  2 00:40:40 2008
+++ 1.fixname/arch/h8300/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -37,6 +37,6 @@
  * "init_task" linker map entry..
  */
 union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
--- 0.org/arch/h8300/kernel/vmlinux.lds.S	Wed Jul  2 00:40:40 2008
+++ 1.fixname/arch/h8300/kernel/vmlinux.lds.S	Wed Jul  2 00:45:57 2008
@@ -101,7 +101,7 @@
 	___data_start = . ;
 
 	. = ALIGN(0x2000) ;
-		*(.data.init_task)
+		*(.init_task.data)
 	. = ALIGN(0x4) ;
 		DATA_DATA
 	. = ALIGN(0x4) ;
