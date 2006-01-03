Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48271 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932543AbWACVHl
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
Subject: [PATCH 43/50] cris: task_thread_info()
Message-Id: <E1EttNb-0008Rq-B0@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/cris/arch-v32/kernel/process.c |    2 +-
 arch/cris/arch-v32/kernel/smp.c     |    4 ++--
 arch/cris/arch-v32/mm/tlb.c         |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

5608c115f07982afc48d4c13fb30faf80e490249
diff --git a/arch/cris/arch-v32/kernel/process.c b/arch/cris/arch-v32/kernel/process.c
index e88b13b..8435131 100644
--- a/arch/cris/arch-v32/kernel/process.c
+++ b/arch/cris/arch-v32/kernel/process.c
@@ -157,7 +157,7 @@ copy_thread(int nr, unsigned long clone_
 	 * The TLS is in $mof beacuse it is the 5th argument to sys_clone.
 	 */
 	if (p->mm && (clone_flags & CLONE_SETTLS)) {
-		p->thread_info->tls = regs->mof;
+		task_thread_info(p)->tls = regs->mof;
 	}
 
 	/* Put the switch stack right below the pt_regs. */
diff --git a/arch/cris/arch-v32/kernel/smp.c b/arch/cris/arch-v32/kernel/smp.c
index 13867f4..da40d19 100644
--- a/arch/cris/arch-v32/kernel/smp.c
+++ b/arch/cris/arch-v32/kernel/smp.c
@@ -113,10 +113,10 @@ smp_boot_one_cpu(int cpuid)
 	if (IS_ERR(idle))
 		panic("SMP: fork failed for CPU:%d", cpuid);
 
-	idle->thread_info->cpu = cpuid;
+	task_thread_info(idle)->cpu = cpuid;
 
 	/* Information to the CPU that is about to boot */
-	smp_init_current_idle_thread = idle->thread_info;
+	smp_init_current_idle_thread = task_thread_info(idle);
 	cpu_now_booting = cpuid;
 
 	/* Wait for CPU to come online */
diff --git a/arch/cris/arch-v32/mm/tlb.c b/arch/cris/arch-v32/mm/tlb.c
index b08a28b..9d75d76 100644
--- a/arch/cris/arch-v32/mm/tlb.c
+++ b/arch/cris/arch-v32/mm/tlb.c
@@ -198,9 +198,9 @@ switch_mm(struct mm_struct *prev, struct
 	per_cpu(current_pgd, cpu) = next->pgd;
 
 	/* Switch context in the MMU. */
-        if (tsk && tsk->thread_info)
+        if (tsk && task_thread_info(tsk))
         {
-          SPEC_REG_WR(SPEC_REG_PID, next->context.page_id | tsk->thread_info->tls);
+          SPEC_REG_WR(SPEC_REG_PID, next->context.page_id | task_thread_info(tsk)->tls);
         }
         else
         {
-- 
0.99.9.GIT

