From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 19/47] x86/mm/pkeys: Fix fill_sig_info_pkey
Date: Mon, 22 Jan 2018 09:45:30 +0100
Message-ID: <20180122083927.168382996@linuxfoundation.org>
References: <20180122083925.568134913@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180122083925.568134913@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit beacd6f7ed5e2915959442245b3b2480c2e37490 upstream.

SEGV_PKUERR is a signal specific si_code which happens to have the same
numeric value as several others: BUS_MCEERR_AR, ILL_ILLTRP, FPE_FLTOVF,
TRAP_HWBKPT, CLD_TRAPPED, POLL_ERR, SEGV_THREAD_ID, as such it is not safe
to just test the si_code the signal number must also be tested to prevent a
false positive in fill_sig_info_pkey.

This error was by inspection, and BUS_MCEERR_AR appears to be a real
candidate for confusion.  So pass in si_signo and check for SIG_SEGV to
verify that it is actually a SEGV_PKUERR

Fixes: 019132ff3daf ("x86/mm/pkeys: Fill in pkey field in siginfo")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lkml.kernel.org/r/20180112203135.4669-2-ebiederm@xmission.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -191,14 +191,15 @@ is_prefetch(struct pt_regs *regs, unsign
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
@@ -237,7 +238,7 @@ force_sig_info_fault(int si_signo, int s
 		lsb = PAGE_SHIFT;
 	info.si_addr_lsb = lsb;
 
-	fill_sig_info_pkey(si_code, &info, pkey);
+	fill_sig_info_pkey(si_signo, si_code, &info, pkey);
 
 	force_sig_info(si_signo, &info, tsk);
 }
