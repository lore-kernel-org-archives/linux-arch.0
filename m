Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39311 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932534AbWACVHl
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
Subject: [PATCH 33/50] arm: end_of_stack()
Message-Id: <E1EttNa-0008RI-Tf@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm/kernel/process.c |    2 +-
 arch/arm/kernel/traps.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

886253feedc3c113e137755e8d9c9052eaea6376
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 6c82d6b..8c62909 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -460,7 +460,7 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_start = (unsigned long)(p->thread_info + 1);
+	stack_start = (unsigned long)end_of_stack(p);
 	stack_end = ((unsigned long)p->thread_info) + THREAD_SIZE;
 
 	fp = thread_saved_fp(p);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 45e9ea6..f7e733c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -165,7 +165,7 @@ static void dump_backtrace(struct pt_reg
 	} else if (verify_stack(fp)) {
 		printk("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)(tsk->thread_info + 1))
+	} else if (fp < (unsigned long)end_of_stack(tsk))
 		printk("frame pointer underflow");
 	printk("\n");
 
-- 
0.99.9.GIT

