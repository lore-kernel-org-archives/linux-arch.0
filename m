From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 07/22] signal/microblaze: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:37:56 -0500
Message-ID: <20180420143811.9994-7-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Michal Simek <monstr@monstr.eu>
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

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/microblaze/kernel/exceptions.c | 9 +--------
 arch/microblaze/mm/fault.c          | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/microblaze/kernel/exceptions.c b/arch/microblaze/kernel/exceptions.c
index 443ec1feacb4..eafff21fcb0e 100644
--- a/arch/microblaze/kernel/exceptions.c
+++ b/arch/microblaze/kernel/exceptions.c
@@ -60,17 +60,10 @@ asmlinkage void sw_exception(struct pt_regs *regs)
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
-	siginfo_t info;
-
 	if (kernel_mode(regs))
 		die("Exception in kernel mode", regs, signr);
 
-	clear_siginfo(&info);
-	info.si_signo = signr;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signr, &info, current);
+	force_sig_fault(signr, code, (void __user *)addr, current);
 }
 
 asmlinkage void full_exception(struct pt_regs *regs, unsigned int type,
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 1251d380df47..af607447c683 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -289,14 +289,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 do_sigbus:
 	up_read(&mm->mmap_sem);
 	if (user_mode(regs)) {
-		siginfo_t info;
-
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 		return;
 	}
 	bad_page_fault(regs, address, SIGBUS);
-- 
2.14.1
