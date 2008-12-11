From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 08/19] blackfin: convert to generic init_task.c
Date: Thu, 11 Dec 2008 03:52:46 +0000
Message-ID: <03f8f28b93a00552becc1acff88cda27b158c9ee.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
 <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
 <58c9a7705b8b9bf574b9ec8b3aab04d5fd1b3dc3.1228966585.git.kyle@mcmartin.ca>
 <d8bf2b2ba6404dccafe2d50698fd13899bcd8a95.1228966585.git.kyle@mcmartin.ca>
 <088318acd2a7993a8334254f2a5f6a57c22a442d.1228966585.git.kyle@mcmartin.ca>
 <ebb6a4d1c4dccd59884bfca0b42f8ffa9dbb849c.1228966585.git.kyle@mcmartin.ca>
 <f484338a15e1ccd69743b39cf1df7d778644b9ed.1228966585.git.kyle@mcmartin.ca>
 <9a5b7775c30315d101d24b7979d43e8018d83bfd.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57701 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbYLKDxf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:35 -0500
In-Reply-To: <9a5b7775c30315d101d24b7979d43e8018d83bfd.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, cooloney@kernel.org, Kyle McMartin <kyle@redhat.com>

Cc: cooloney@kernel.org
Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/blackfin/Kconfig            |    1 -
 arch/blackfin/kernel/Makefile    |    2 +-
 arch/blackfin/kernel/init_task.c |   60 --------------------------------------
 3 files changed, 1 insertions(+), 62 deletions(-)
 delete mode 100644 arch/blackfin/kernel/init_task.c

diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index e25d145..29e71ed 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -26,7 +26,6 @@ config BLACKFIN
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
-	select HAVE_ARCH_INIT_TASK
 
 config ZONE_DMA
 	bool
diff --git a/arch/blackfin/kernel/Makefile b/arch/blackfin/kernel/Makefile
index 606adc7..fbe5ab3 100644
--- a/arch/blackfin/kernel/Makefile
+++ b/arch/blackfin/kernel/Makefile
@@ -2,7 +2,7 @@
 # arch/blackfin/kernel/Makefile
 #
 
-extra-y := init_task.o vmlinux.lds
+extra-y := vmlinux.lds
 
 obj-y := \
 	entry.o process.o bfin_ksyms.o ptrace.o setup.o signal.o \
diff --git a/arch/blackfin/kernel/init_task.c b/arch/blackfin/kernel/init_task.c
deleted file mode 100644
index 6bdba7b..0000000
--- a/arch/blackfin/kernel/init_task.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * File:         arch/blackfin/kernel/init_task.c
- * Based on:
- * Author:
- *
- * Created:
- * Description:  This file contains the simple DMA Implementation for Blackfin
- *
- * Modified:
- *               Copyright 2004-2006 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/init_task.h>
-#include <linux/mqueue.h>
-#include <linux/fs.h>
-
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-
-struct mm_struct init_mm = INIT_MM(init_mm);
-EXPORT_SYMBOL(init_mm);
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-struct task_struct init_task = INIT_TASK(init_task);
-EXPORT_SYMBOL(init_task);
-
-/*
- * Initial thread structure.
- *
- * We need to make sure that this is 8192-byte aligned due to the
- * way process stacks are handled. This is done by having a special
- * "init_task" linker map entry.
- */
-union thread_union init_thread_union
-    __attribute__ ((__section__(".init_task.data"))) = {
-INIT_THREAD_INFO(init_task)};
-- 
1.6.0.4
