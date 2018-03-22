Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:37728 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeCVJBv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:01:51 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 23/45] sched: add do_sched_yield() helper; remove in-kernel call to sched_yield()
Date: Thu, 22 Mar 2018 10:00:37 +0100
Message-ID: <20180322090059.19361-24-linux@dominikbrodowski.net>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180322090037.fBX5yn7euh-j07JZgJ_HDgiLUSMH2GEc7HmfyOfAprk@z>

Using the sched-internal do_sched_yield() helper allows us to get rid of
the sched-internal call to the sys_sched_yield() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7c535eee0a6..8de4919c889a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4892,7 +4892,7 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
  *
  * Return: 0.
  */
-SYSCALL_DEFINE0(sched_yield)
+static void do_sched_yield(void)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -4913,7 +4913,11 @@ SYSCALL_DEFINE0(sched_yield)
 	sched_preempt_enable_no_resched();
 
 	schedule();
+}
 
+SYSCALL_DEFINE0(sched_yield)
+{
+	do_sched_yield();
 	return 0;
 }
 
@@ -4997,7 +5001,7 @@ EXPORT_SYMBOL(__cond_resched_softirq);
 void __sched yield(void)
 {
 	set_current_state(TASK_RUNNING);
-	sys_sched_yield();
+	do_sched_yield();
 }
 EXPORT_SYMBOL(yield);
 
-- 
2.16.2
