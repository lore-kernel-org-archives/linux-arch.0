From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 18/20] signal/x86: Replace force_sig_info_fault with force_sig_fault
Date: Tue, 18 Sep 2018 02:05:44 +0200
Message-ID: <20180918000546.12552-18-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Now that the pkey handling has been removed force_sig_info_fault and
force_sig_fault perform identical work.  Just the type of the address
paramter is different.  So replace calls to force_sig_info_fault with
calls to force_sig_fault, and remove force_sig_info_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ccfeed902eee..548396aa03e1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -153,21 +153,6 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 	return prefetch;
 }
 
-static void
-force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk, u32 *pkey)
-{
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo	= si_signo;
-	info.si_errno	= 0;
-	info.si_code	= si_code;
-	info.si_addr	= (void __user *)address;
-
-	force_sig_info(si_signo, &info, tsk);
-}
-
 DEFINE_SPINLOCK(pgd_lock);
 LIST_HEAD(pgd_list);
 
@@ -672,8 +657,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 			tsk->thread.cr2 = address;
 
 			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_info_fault(signal, si_code, address,
-					     tsk, NULL);
+			force_sig_fault(signal, si_code, (void __user *)address,
+					tsk);
 		}
 
 		/*
@@ -835,7 +820,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (si_code == SEGV_PKUERR)
 			force_sig_pkuerr((void __user *)address, *pkey);
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 
 		return;
 	}
@@ -961,7 +946,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		return;
 	}
 #endif
-	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, NULL);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 }
 
 static noinline void
-- 
2.17.1
