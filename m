From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 23/23] make section names compatible with -ffunction-sections -fdata-sections: xtensa
Date: Wed, 2 Jul 2008 02:43:10 +0200
Message-ID: <200807020243.10579.vda.linux@googlemail.com>
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
This patch fixes xtensa architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/xtensa/kernel/head.S	Wed Jul  2 00:40:43 2008
+++ 1.fixname/arch/xtensa/kernel/head.S	Wed Jul  2 00:47:00 2008
@@ -234,7 +234,7 @@
  * BSS section
  */
 	
-.section ".bss.page_aligned", "w"
+.section ".bss.k.page_aligned", "w"
 ENTRY(swapper_pg_dir)
 	.fill	PAGE_SIZE, 1, 0
 ENTRY(empty_zero_page)
--- 0.org/arch/xtensa/kernel/init_task.c	Wed Jul  2 00:40:43 2008
+++ 1.fixname/arch/xtensa/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -29,7 +29,7 @@
 EXPORT_SYMBOL(init_mm);
 
 union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 { INIT_THREAD_INFO(init_task) };
 
 struct task_struct init_task = INIT_TASK(init_task);
--- 0.org/arch/xtensa/kernel/vmlinux.lds.S	Wed Jul  2 00:40:43 2008
+++ 1.fixname/arch/xtensa/kernel/vmlinux.lds.S	Wed Jul  2 00:47:00 2008
@@ -121,14 +121,14 @@
     DATA_DATA
     CONSTRUCTORS
     . = ALIGN(XCHAL_ICACHE_LINESIZE);
-    *(.data.cacheline_aligned)
+    *(.cacheline_aligned.data)
   }
 
   _edata = .;
 
   /* The initial task */
   . = ALIGN(8192);
-  .data.init_task : { *(.data.init_task) }
+  .init_task.data : { *(.init_task.data) }
 
   /* Initialization code and data: */
 
@@ -259,7 +259,7 @@
 
   /* BSS section */
   _bss_start = .;
-  .bss : { *(.bss.page_aligned) *(.bss) }
+  .bss : { *(.bss.k.page_aligned) *(.bss) }
   _bss_end = .;
 
   _end = .;
--- 0.org/include/asm-frv/init.h	Wed Jul  2 00:40:50 2008
+++ 1.fixname/include/asm-frv/init.h	Wed Jul  2 00:45:57 2008
@@ -1,12 +1,12 @@
 #ifndef _ASM_INIT_H
 #define _ASM_INIT_H
 
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 /* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
+#define __INIT		.section	".init.text",#alloc,#execinstr
 #define __FINIT		.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
+#define __INITDATA	.section	".init.data",#alloc,#write
 
 #endif
 
