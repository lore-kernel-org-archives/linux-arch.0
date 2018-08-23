Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbeHWL7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Aug 2018 07:59:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 161/217] ARC: Improve cmpxchg syscall implementation
Date: Thu, 23 Aug 2018 09:54:34 +0200
Message-ID: <20180823075512.824910753@linuxfoundation.org>
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <vgupta@synopsys.com>, Sasha Levin <alexander.levin@microsoft.com>
Message-ID: <20180823075434.rpxnt5jnNfhY5xtGS_EFPeL-oIXhxeA62hWvVlD77vU@z>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit e8708786d4fe21c043d38d760f768949a3d71185 ]

This is used in configs lacking hardware atomics to emulate atomic r-m-w
for user space, implemented by disabling preemption in kernel.

However there are issues in current implementation:

1. Process not terminated if invalid user pointer passed:
   i.e. __get_user() failed.

2. The reason for this patch was __put_user() failure not being handled
   either, specifically for the COW break scenario.
   The zero page is initially wired up and read from __get_user()
   succeeds. A subsequent write by __put_user() induces a
   Protection Violation, but COW can't finish as Linux page fault
   handler is disabled due to preempt disable.
   And what's worse is we silently return the stale value to user space.
   Fix this specific case by re-enabling preemption and explicitly
   fixing up the fault and retrying the whole sequence over.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: rewrote the changelog]
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/kernel/process.c |   47 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -47,7 +47,8 @@ SYSCALL_DEFINE0(arc_gettls)
 SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 {
 	struct pt_regs *regs = current_pt_regs();
-	int uval = -EFAULT;
+	u32 uval;
+	int ret;
 
 	/*
 	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
@@ -60,23 +61,47 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *,
 	/* Z indicates to userspace if operation succeded */
 	regs->status32 &= ~STATUS_Z_MASK;
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
+	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
+	if (!ret)
+		 goto fail;
 
+again:
 	preempt_disable();
 
-	if (__get_user(uval, uaddr))
-		goto done;
+	ret = __get_user(uval, uaddr);
+	if (ret)
+		 goto fault;
 
-	if (uval == expected) {
-		if (!__put_user(new, uaddr))
-			regs->status32 |= STATUS_Z_MASK;
-	}
+	if (uval != expected)
+		 goto out;
 
-done:
-	preempt_enable();
+	ret = __put_user(new, uaddr);
+	if (ret)
+		 goto fault;
+
+	regs->status32 |= STATUS_Z_MASK;
 
+out:
+	preempt_enable();
 	return uval;
+
+fault:
+	preempt_enable();
+
+	if (unlikely(ret != -EFAULT))
+		 goto fail;
+
+	down_read(&current->mm->mmap_sem);
+	ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
+			       FAULT_FLAG_WRITE, NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (likely(!ret))
+		 goto again;
+
+fail:
+	force_sig(SIGSEGV, current);
+	return ret;
 }
 
 #ifdef CONFIG_ISA_ARCV2
