From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 17/23] make section names compatible with -ffunction-sections -fdata-sections: s390
Date: Wed, 2 Jul 2008 02:40:33 +0200
Message-ID: <200807020240.33271.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.228]:18988 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762223AbYGAWkj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 18:40:39 -0400
Received: by qb-out-0506.google.com with SMTP id d8so939914qbc.37
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 15:40:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes s390 architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/s390/kernel/head.S	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/s390/kernel/head.S	Wed Jul  2 00:44:22 2008
@@ -35,7 +35,7 @@
 #define ARCH_OFFSET	0
 #endif
 
-.section ".text.head","ax"
+.section ".head.text","ax"
 #ifndef CONFIG_IPL
 	.org   0
 	.long  0x00080000,0x80000000+startup	# Just a restart PSW
--- 0.org/arch/s390/kernel/init_task.c	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/s390/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -31,7 +31,7 @@
  * "init_task" linker map entry..
  */
 union thread_union init_thread_union 
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
 
 /*
--- 0.org/arch/s390/kernel/vmlinux.lds.S	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/s390/kernel/vmlinux.lds.S	Wed Jul  2 00:46:32 2008
@@ -28,7 +28,7 @@
 	. = 0x00000000;
 	.text : {
 	_text = .;		/* Text and read-only data */
-		*(.text.head)
+		*(.head.text)
 	TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -66,30 +66,30 @@
 	. = ALIGN(PAGE_SIZE);
 	.data_nosave : {
 	__nosave_begin = .;
-		*(.data.nosave)
+		*(.nosave.data)
 	}
 	. = ALIGN(PAGE_SIZE);
 	__nosave_end = .;
 
 	. = ALIGN(PAGE_SIZE);
-	.data.page_aligned : {
-		*(.data.idt)
+	.page_aligned.data : {
+		*(.idt.data)
 	}
 
 	. = ALIGN(0x100);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
+	.cacheline_aligned.data : {
+		*(.cacheline_aligned.data)
 	}
 
 	. = ALIGN(0x100);
-	.data.read_mostly : {
-		*(.data.read_mostly)
+	.read_mostly.data : {
+		*(.read_mostly.data)
 	}
 	_edata = .;		/* End of data section */
 
 	. = ALIGN(2 * PAGE_SIZE);	/* init_task */
-	.data.init_task : {
-		*(.data.init_task)
+	.init_task.data : {
+		*(.init_task.data)
 	}
 
 	/* will be freed after init */
--- 0.org/include/asm-s390/cache.h	Wed Jul  2 00:40:50 2008
+++ 1.fixname/include/asm-s390/cache.h	Wed Jul  2 00:45:45 2008
@@ -14,6 +14,6 @@
 #define L1_CACHE_BYTES     256
 #define L1_CACHE_SHIFT     8
 
-#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+#define __read_mostly __attribute__((__section__(".read_mostly.data")))
 
 #endif
