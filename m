Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C78DC433F5
	for <linux-arch@archiver.kernel.org>; Fri,  6 May 2022 14:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442147AbiEFOTa (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 6 May 2022 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbiEFOTW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:22 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6024BDB;
        Fri,  6 May 2022 07:15:39 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33946)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmyk5-001V1f-P3; Fri, 06 May 2022 08:15:38 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmyk4-007Cxx-KB; Fri, 06 May 2022 08:15:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-arch@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  6 May 2022 09:15:08 -0500
Message-Id: <20220506141512.516114-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmyk4-007Cxx-KB;;;mid=<20220506141512.516114-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/mDmv+ns3fcb9e/GMSp2NnY4KNRo/+Yic=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/7] fork: Explicity test for idle tasks in copy_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The architectures ia64 and parisc have special handling for the idle
thread in copy_process.  Add a flag named idle to kernel_clone_args
and use it to explicity test if an idle process is being created.

Fullfill the expectations of the rest of the copy_thread
implemetations and pass a function pointer in .stack from fork_idle().
This makes what is happening in copy_thread better defined, and is
useful to make idle threads less special.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c | 2 +-
 include/linux/sched/task.h   | 1 +
 kernel/fork.c                | 9 +++++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 10d41ded05a5..8f010ae818bc 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -342,7 +342,7 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
 	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
-		if (unlikely(!user_stack_base)) {
+		if (unlikely(args->idle)) {
 			/* fork_idle() called us */
 			return 0;
 		}
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 129c17de45ba..30a5874ca845 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -224,7 +224,7 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
-		if (!usp) /* idle thread */
+		if (args->idle) /* idle thread */
 			return 0;
 		/* Must exit via ret_from_kernel_thread in order
 		 * to call schedule_tail()
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index fcdcba231aac..3d6b99ce5408 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -33,6 +33,7 @@ struct kernel_clone_args {
 	int cgroup;
 	int io_thread;
 	int kthread;
+	int idle;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index d39a248a8d8d..93d77ee921ff 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2544,12 +2544,21 @@ static inline void init_idle_pids(struct task_struct *idle)
 	}
 }
 
+static int idle_dummy(void *dummy)
+{
+	/* This function is never called */
+	return 0;
+}
+
 struct task_struct * __init fork_idle(int cpu)
 {
 	struct task_struct *task;
 	struct kernel_clone_args args = {
 		.flags		= CLONE_VM,
+		.stack		= (unsigned long)&idle_dummy,
+		.stack_size	= (unsigned long)NULL,
 		.kthread	= 1,
+		.idle		= 1,
 	};
 
 	task = copy_process(&init_struct_pid, 0, cpu_to_node(cpu), &args);
-- 
2.35.3

