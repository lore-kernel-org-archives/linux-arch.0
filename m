From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 13/23] make section names compatible with -ffunction-sections -fdata-sections: mn10300
Date: Wed, 2 Jul 2008 02:38:45 +0200
Message-ID: <200807020238.45086.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762229AbYGAWjB@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes mn10300 architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/mn10300/kernel/head.S	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/mn10300/kernel/head.S	Wed Jul  2 00:44:22 2008
@@ -19,7 +19,7 @@
 #include <asm/param.h>
 #include <asm/unit/serial.h>
 
-	.section .text.head,"ax"
+	.section .head.text,"ax"
 
 ###############################################################################
 #
--- 0.org/arch/mn10300/kernel/init_task.c	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/mn10300/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -32,7 +32,7 @@
  * "init_task" linker map entry..
  */
 union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
 /*
--- 0.org/arch/mn10300/kernel/vmlinux.lds.S	Wed Jul  2 00:40:41 2008
+++ 1.fixname/arch/mn10300/kernel/vmlinux.lds.S	Wed Jul  2 00:47:00 2008
@@ -27,7 +27,7 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(
-	.text.head
+	.head.text
 	.text
 	)
 	TEXT_TEXT
@@ -57,25 +57,25 @@
 
   . = ALIGN(4096);
   __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
+  .data_nosave : { *(.nosave.data) }
   . = ALIGN(4096);
   __nosave_end = .;
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
+  .page_aligned.data : { *(.idt.data) }
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   /* rarely changed data like cpu maps */
   . = ALIGN(32);
-  .data.read_mostly : AT(ADDR(.data.read_mostly)) {
-	*(.data.read_mostly)
+  .read_mostly.data : AT(ADDR(.read_mostly.data)) {
+	*(.read_mostly.data)
 	_edata = .;		/* End of data section */
   }
 
   . = ALIGN(THREAD_SIZE);	/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .init_task.data : { *(.init_task.data) }
 
   /* might get freed after init */
   . = ALIGN(4096);
@@ -128,7 +128,7 @@
 
   . = ALIGN(32);
   __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
+  .percpu.data  : { *(.percpu.data) }
   __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
@@ -136,7 +136,7 @@
 
   __bss_start = .;		/* BSS */
   .bss : {
-	*(.bss.page_aligned)
+	*(.bss.k.page_aligned)
 	*(.bss)
   }
   . = ALIGN(4);
