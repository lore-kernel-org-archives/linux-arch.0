From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH 21/23] make section names compatible with -ffunction-sections -fdata-sections: v850
Date: Wed, 2 Jul 2008 02:42:21 +0200
Message-ID: <200807020242.21960.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.225]:23110 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760518AbYGAWmQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 18:42:16 -0400
Received: by qb-out-0506.google.com with SMTP id d8so941576qbc.37
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 15:42:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>

The purpose of this patch is to make kernel buildable
with "gcc -ffunction-sections -fdata-sections".
This patch fixes v850 architecture.

Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
--
vda


--- 0.org/arch/v850/kernel/init_task.c	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/v850/kernel/init_task.c	Wed Jul  2 00:45:57 2008
@@ -44,5 +44,5 @@
  * "init_task" linker map entry.
  */
 union thread_union init_thread_union 
-	__attribute__((__section__(".data.init_task"))) =
+	__attribute__((__section__(".init_task.data"))) =
 		{ INIT_THREAD_INFO(init_task) };
--- 0.org/arch/v850/kernel/vmlinux.lds.S	Wed Jul  2 00:40:42 2008
+++ 1.fixname/arch/v850/kernel/vmlinux.lds.S	Wed Jul  2 00:46:26 2008
@@ -95,8 +95,8 @@
 		TEXT_TEXT						      \
 		SCHED_TEXT						      \
 			*(.exit.text)	/* 2.5 convention */		      \
-			*(.text.exit)	/* 2.4 convention */		      \
-			*(.text.lock)					      \
+			*(.exit.text)	/* 2.4 convention */		      \
+			*(.lock.text)					      \
 			*(.exitcall.exit)				      \
 		__real_etext = . ;	/* There may be data after here.  */  \
 		RODATA_CONTENTS						      \
@@ -115,11 +115,11 @@
 		__sdata = . ;						      \
 		DATA_DATA						      \
 			EXIT_DATA	/* 2.5 convention */		      \
-			*(.data.exit)	/* 2.4 convention */		      \
+			*(.exit.data)	/* 2.4 convention */		      \
 		. = ALIGN (16) ;					      \
-		*(.data.cacheline_aligned)				      \
+		*(.cacheline_aligned.data)				      \
 		. = ALIGN (0x2000) ;					      \
-        	*(.data.init_task)					      \
+        	*(.init_task.data)					      \
 		. = ALIGN (0x2000) ;					      \
 		__edata = . ;
 
@@ -160,8 +160,8 @@
 			INIT_TEXT	/* 2.5 convention */		      \
 			__einittext = .;				      \
 			INIT_DATA					      \
-			*(.text.init)	/* 2.4 convention */		      \
-			*(.data.init)					      \
+			*(.init.text)	/* 2.4 convention */		      \
+			*(.init.data)					      \
 		INITCALL_CONTENTS					      \
 		INITRAMFS_CONTENTS
 
@@ -171,7 +171,7 @@
 		. = ALIGN (4096) ;					      \
 		__init_start = . ;					      \
 			INIT_DATA	/* 2.5 convention */		      \
-			*(.data.init)	/* 2.4 convention */		      \
+			*(.init.data)	/* 2.4 convention */		      \
 		__init_end = . ;					      \
 		. = ALIGN (4096) ;
 
@@ -181,7 +181,7 @@
 			_sinittext = .;					      \
 			INIT_TEXT	/* 2.5 convention */		      \
 			_einittext = .;					      \
-			*(.text.init)	/* 2.4 convention */		      \
+			*(.init.text)	/* 2.4 convention */		      \
 		INITCALL_CONTENTS					      \
 		INITRAMFS_CONTENTS
 
