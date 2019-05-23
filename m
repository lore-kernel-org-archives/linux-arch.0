Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:51341 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWBGr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:06:47 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:03 -0500
Message-ID: <20190523003916.20726-14-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 13/26] signal/sh: Remove tsk parameter from force_sig_info_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003903.3bHa_9D3XwRJxzT3lKal5Jwmo55ni9EijY-9MgUfaGs@z>

The force_sig_info_fault function is always called with tsk == current.
Make that explicit by removing the tsk parameter.

This also makes it clear that the sh force_sig_info_fault passes
current into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/mm/fault.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 6defd2c6d9b1..851a3cbb2b9c 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -39,10 +39,9 @@ static inline int notify_page_fault(struct pt_regs *regs, int trap)
 }
 
 static void
-force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk)
+force_sig_info_fault(int si_signo, int si_code, unsigned long address)
 {
-	force_sig_fault(si_signo, si_code, (void __user *)address, tsk);
+	force_sig_fault(si_signo, si_code, (void __user *)address, current);
 }
 
 /*
@@ -244,8 +243,6 @@ static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, int si_code)
 {
-	struct task_struct *tsk = current;
-
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		/*
@@ -253,7 +250,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		 */
 		local_irq_enable();
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk);
+		force_sig_info_fault(SIGSEGV, si_code, address);
 
 		return;
 	}
@@ -308,7 +305,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 	if (!user_mode(regs))
 		no_context(regs, error_code, address);
 
-	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address);
 }
 
 static noinline int
-- 
2.21.0
