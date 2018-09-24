From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 3/3] signal/unicore32: Use force_sig_fault where appropriate
Date: Mon, 24 Sep 2018 17:25:37 +0200
Message-ID: <20180924152537.19515-3-ebiederm@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/mm/fault.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index a942776110a0..b9a3a50644c1 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -120,17 +120,10 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		unsigned int fsr, unsigned int sig, int code,
 		struct pt_regs *regs)
 {
-	struct siginfo si;
-
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	clear_siginfo(&si);
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	force_sig_info(sig, &si, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, tsk);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-- 
2.17.1
