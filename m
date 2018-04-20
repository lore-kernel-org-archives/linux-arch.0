From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 10/22] signal/nios2: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:37:59 -0500
Message-ID: <20180420143811.9994-10-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
List-Id: linux-arch.vger.kernel.org

Filling in struct siginfo before calling force_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper force_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls force_sig_info.

In short about a 5 line reduction in code for every time force_sig_info
is called, which makes the calling function clearer.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nios2/kernel/traps.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index a69861d3e1a3..3bc3cd22b750 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -26,14 +26,7 @@ static DEFINE_SPINLOCK(die_lock);
 
 static void _send_sig(int signo, int code, unsigned long addr)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = signo;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signo, &info, current);
+	force_sig_fault(signo, code, (void __user *) addr, current);
 }
 
 void die(const char *str, struct pt_regs *regs, long err)
-- 
2.14.1
