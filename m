From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/2] x86/mm/pkeys: Fix fill_sig_info_pkey
Date: Fri, 12 Jan 2018 14:31:35 -0600
Message-ID: <20180112203135.4669-2-ebiederm@xmission.com>
References: <87vag6zupo.fsf@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:36092 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbeALUcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 15:32:55 -0500
In-Reply-To: <87vag6zupo.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

SEGV_PKUERR is a signal specific si_code which happens to have the
same numeric value as several others: BUS_MCEERR_AR, ILL_ILLTRP,
FPE_FLTOVF, TRAP_HWBKPT, CLD_TRAPPED, POLL_ERR, SEGV_THREAD_ID,
as such it is not safe to just test the si_code the signal number
must also be tested to prevent a false positive in fill_sig_info_pkey.

I found this error by inspection, and BUS_MCEERR_AR appears to
be a real candidate for confusion.  So pass in si_signo and fix it.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Fixes: 019132ff3daf ("x86/mm/pkeys: Fill in pkey field in siginfo")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 06fe3d51d385..b3e40773dce0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -172,14 +172,15 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
  * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
  *	     faulted on a pte with its pkey=4.
  */
-static void fill_sig_info_pkey(int si_code, siginfo_t *info, u32 *pkey)
+static void fill_sig_info_pkey(int si_signo, int si_code, siginfo_t *info,
+		u32 *pkey)
 {
 	/* This is effectively an #ifdef */
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
 		return;
 
 	/* Fault not from Protection Keys: nothing to do */
-	if (si_code != SEGV_PKUERR)
+	if ((si_code != SEGV_PKUERR) || (si_signo != SIGSEGV))
 		return;
 	/*
 	 * force_sig_info_fault() is called from a number of
@@ -218,7 +219,7 @@ force_sig_info_fault(int si_signo, int si_code, unsigned long address,
 		lsb = PAGE_SHIFT;
 	info.si_addr_lsb = lsb;
 
-	fill_sig_info_pkey(si_code, &info, pkey);
+	fill_sig_info_pkey(si_signo, si_code, &info, pkey);
 
 	force_sig_info(si_signo, &info, tsk);
 }
-- 
2.14.1
