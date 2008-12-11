From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 14:10:31 +0100
Message-ID: <200812111410.31837.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <cover.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54725 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569AbYLKNKr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 08:10:47 -0500
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>, Jeff Dike <jdike@addtoit.com>
Cc: linux-arch@vger.kernel.org

Leave arch/x86/kernel/init_task.c hanging around with the cpu0_irqstack
definition in it, a later patch can move it to an appropriate place and
nuke the file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
On Thursday 11 December 2008, Kyle McMartin wrote:

> Unconverted architectures so far are m68k (because it doesn't use an explicit
> init_task.c), ia64 (because it faffs about with init_thread_union), and
> sparc{,64} (which appear to rely on some magic.)

Apparently, you also forget arch/um. It is similar to the x86 version.

--- a/arch/um/kernel/init_task.c
+++ b/arch/um/kernel/init_task.c
@@ -10,34 +10,10 @@
 #include "linux/mqueue.h"
 #include "asm/uaccess.h"
 
-static struct fs_struct init_fs = INIT_FS;
-struct mm_struct init_mm = INIT_MM(init_mm);
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-EXPORT_SYMBOL(init_mm);
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_task);
-
 /*
- * Initial thread structure.
- *
- * We need to make sure that this is aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry..
+ * This definition is left over from the move to kernel/init_task.c
  */
 
-union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
-
 union thread_union cpu0_irqstack
 	__attribute__((__section__(".data.init_irqstack"))) =
 		{ INIT_THREAD_INFO(init_task) };
