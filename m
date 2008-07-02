Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.235]:24547 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763316AbYGAWlt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 18:41:49 -0400
Received: by hu-out-0506.google.com with SMTP id 28so820912hub.21
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 15:41:47 -0700 (PDT)
From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 20/23] make section names compatible with -ffunction-sections -fdata-sections: um
Date: Wed, 2 Jul 2008 02:41:58 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <200807020241.58201.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
Message-ID: <20080702004158.eEczLdQ8X87HIMCsFVmjiuVAo1sEhbsGd-PetiSoWcU@z>

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes User Mode Linux.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/um/kernel/dyn.lds.S	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/um/kernel/dyn.lds.S	Wed Jul  2 00:45:57 2008
@@ -97,9 +97,9 @@
   .fini_array     : { *(.fini_array) }
   .data           : {
     . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
+    *(.init_task.data)
     . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data.init_irqstack)
+    *(.init_irqstack.data)
     DATA_DATA
     *(.data.* .gnu.linkonce.d.*)
     SORT(CONSTRUCTORS)
--- 0.org/arch/um/kernel/init_task.c	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/um/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -35,9 +35,9 @@
  */
 
 union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
 union thread_union cpu0_irqstack
-	__attribute__((__section__(".data.init_irqstack"))) =
+	__attribute__((__section__(".init_irqstack.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
--- 0.org/arch/um/kernel/uml.lds.S	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/um/kernel/uml.lds.S	Wed Jul  2 00:45:57 2008
@@ -53,9 +53,9 @@
   .data    :
   {
     . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
+    *(.init_task.data)
     . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data.init_irqstack)
+    *(.init_irqstack.data)
     DATA_DATA
     *(.gnu.linkonce.d*)
     CONSTRUCTORS
--- 0.org/include/asm-um/common.lds.S	Wed Jul  2 00:40:51 2008
+++ 1.fixname/include/asm-um/common.lds.S	Wed Jul  2 00:45:39 2008
@@ -49,9 +49,9 @@
   }
 
   . = ALIGN(32);
-  .data.percpu : {
+  .percpu.data : {
 	__per_cpu_start = . ;
-	*(.data.percpu)
+	*(.percpu.data)
 	__per_cpu_end = . ;
   }
 	
