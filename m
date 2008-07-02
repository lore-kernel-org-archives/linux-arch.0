From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 10/23] make section names compatible with -ffunction-sections -fdata-sections: m32r
Date: Wed, 2 Jul 2008 02:37:14 +0200
Message-ID: <200807020237.14092.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.232]:3790 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762044AbYGAWhG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 18:37:06 -0400
Received: by qb-out-0506.google.com with SMTP id d8so934894qbc.37
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 15:37:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes m32r architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/m32r/kernel/init_task.c	Wed Jul  2 00:40:40 2008
+++ 1.fixname/arch/m32r/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -26,7 +26,7 @@
  * "init_task" linker map entry..
  */
 union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
 /*
--- 0.org/arch/m32r/kernel/vmlinux.lds.S	Wed Jul  2 00:40:40 2008
+++ 1.fixname/arch/m32r/kernel/vmlinux.lds.S	Wed Jul  2 00:46:03 2008
@@ -56,17 +56,17 @@
 
   . = ALIGN(4096);
   __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
+  .data_nosave : { *(.nosave.data) }
   . = ALIGN(4096);
   __nosave_end = .;
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   _edata = .;			/* End of data section */
 
   . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .init_task.data : { *(.init_task.data) }
 
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
