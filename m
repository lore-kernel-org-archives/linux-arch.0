From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cris: convert to generic init_task
Date: Thu, 11 Dec 2008 14:26:24 +0100
Message-ID: <200812111426.24751.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <cover.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51758 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbYLKNbf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 08:31:35 -0500
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, dev-etrax@axis.com
Cc: linux-arch@vger.kernel.org

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

This assumes that the kernel/init_task.c file is already present.

--- a/arch/cris/kernel/process.c
+++ b/arch/cris/kernel/process.c
@@ -31,40 +31,6 @@
 //#define DEBUG
 
 /*
- * Initial task structure. Make this a per-architecture thing,
- * because different architectures tend to have different
- * alignment requirements and potentially different initial
- * setup.
- */
-
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-
-EXPORT_SYMBOL(init_mm);
-
-/*
- * Initial thread structure.
- *
- * We need to make sure that this is 8192-byte aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry..
- */
-union thread_union init_thread_union 
-	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_task);
-
-/*
  * The hlt_counter, disable_hlt and enable_hlt is just here as a hook if
  * there would ever be a halt sequence (for power save when idle) with
  * some largish delay when halting or resuming *and* a driver that can't
