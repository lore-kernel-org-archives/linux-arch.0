From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 5/8] m68k: calculate thread_info offset with asm offset
Date: Sat, 29 Aug 2009 12:21:20 +0200
Message-ID: <20090829102156.858204262@de.ibm.com>
References: <20090829102115.638224800@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.17.161]:48409 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbZH2KWA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2009 06:22:00 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7TALwTT003301
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 10:21:58 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com [9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7TALwDi1654788
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 12:21:58 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7TALv3s018989
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 12:21:58 +0200
Content-Disposition: inline; filename=m68k.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

m68k has the thread_info structure embedded in its task struct. Therefore
its not possible to implement current_thread_info() by looking at the stack
pointer and do some simple calculations like most other architectures do it.

To return the thread_info pointer for a task two defines are used. This works
until the spinlock function bodies get moved into an own header file and
CONFIG_SPINLOCK_DEBUG is turned on. That results into this compile error:

In file included from include/linux/spinlock.h:378,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/m68k/kernel/asm-offsets.c:12:
include/linux/spinlock_api_smp.h: In function '__spin_unlock_irq':
include/linux/spinlock_api_smp.h:371: error: 'current' undeclared (first use in this function)
include/linux/spinlock_api_smp.h:371: error: (Each undeclared identifier is reported only once
include/linux/spinlock_api_smp.h:371: error: for each function it appears in.)

Including asm/current.h to asm-offsets.c wouldn't help since the definition
of struct task is needed. So we end up with ugly header file include
dependencies.

To solve this calculate the offset of the thread_info structure into the
task struct in asm-offsets.h and use the offset in task_thread_info().
This works just like it does for IA64 as well.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/m68k/include/asm/thread_info_mm.h |   11 ++++++++++-
 arch/m68k/kernel/asm-offsets.c         |    5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/m68k/include/asm/thread_info_mm.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/thread_info_mm.h
+++ linux-2.6/arch/m68k/include/asm/thread_info_mm.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_M68K_THREAD_INFO_H
 #define _ASM_M68K_THREAD_INFO_H
 
+#ifndef ASM_OFFSETS_C
+#include <asm/asm-offsets.h>
+#endif
+#include <asm/current.h>
 #include <asm/types.h>
 #include <asm/page.h>
 
@@ -31,7 +35,12 @@ struct thread_info {
 #define init_thread_info	(init_task.thread.info)
 #define init_stack		(init_thread_union.stack)
 
-#define task_thread_info(tsk)	(&(tsk)->thread.info)
+#ifdef ASM_OFFSETS_C
+#define task_thread_info(tsk)	((struct thread_info *) NULL)
+#else
+#define task_thread_info(tsk)	((struct thread_info *)((char *)tsk+TASK_TINFO))
+#endif
+
 #define task_stack_page(tsk)	((tsk)->stack)
 #define current_thread_info()	task_thread_info(current)
 
Index: linux-2.6/arch/m68k/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/asm-offsets.c
+++ linux-2.6/arch/m68k/kernel/asm-offsets.c
@@ -8,6 +8,8 @@
  * #defines from the assembly-language output.
  */
 
+#define ASM_OFFSETS_C
+
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
@@ -27,6 +29,9 @@ int main(void)
 	DEFINE(TASK_INFO, offsetof(struct task_struct, thread.info));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
 	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
+#ifdef CONFIG_MMU
+	DEFINE(TASK_TINFO, offsetof(struct task_struct, thread.info));
+#endif
 
 	/* offsets into the thread struct */
 	DEFINE(THREAD_KSP, offsetof(struct thread_struct, ksp));

-- 
