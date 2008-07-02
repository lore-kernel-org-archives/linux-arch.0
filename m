From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 2/23] make section names compatible with -ffunction-sections -fdata-sections: alpha
Date: Wed, 2 Jul 2008 02:34:09 +0200
Message-ID: <200807020234.09577.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes alpha architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/alpha/kernel/head.S	Wed Jul  2 00:40:39 2008
+++ 1.fixname/arch/alpha/kernel/head.S	Wed Jul  2 00:44:22 2008
@@ -10,7 +10,7 @@
 #include <asm/system.h>
 #include <asm/asm-offsets.h>
 
-.section .text.head, "ax"
+.section .head.text, "ax"
 .globl swapper_pg_dir
 .globl _stext
 swapper_pg_dir=SWAPPER_PGD
--- 0.org/arch/alpha/kernel/init_task.c	Wed Jul  2 00:40:39 2008
+++ 1.fixname/arch/alpha/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -18,5 +18,5 @@
 EXPORT_SYMBOL(init_task);
 
 union thread_union init_thread_union
-	__attribute__((section(".data.init_thread")))
+	__attribute__((section(".init_thread.data")))
 	= { INIT_THREAD_INFO(init_task) };
--- 0.org/arch/alpha/kernel/vmlinux.lds.S	Wed Jul  2 00:40:39 2008
+++ 1.fixname/arch/alpha/kernel/vmlinux.lds.S	Wed Jul  2 00:46:09 2008
@@ -16,7 +16,7 @@
 
 	_text = .;	/* Text and read-only data */
 	.text : {
-	*(.text.head)
+	*(.head.text)
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -93,18 +93,18 @@
 	/* Freed after init ends here */
 
 	/* Note 2 page alignment above.  */
-	.data.init_thread : {
-		*(.data.init_thread)
+	.init_thread.data : {
+		*(.init_thread.data)
 	}
 
 	. = ALIGN(PAGE_SIZE);
-	.data.page_aligned : {
-		*(.data.page_aligned)
+	.page_aligned.data : {
+		*(.page_aligned.data)
 	}
 
 	. = ALIGN(64);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
+	.cacheline_aligned.data : {
+		*(.cacheline_aligned.data)
 	}
 
 	_data = .;
