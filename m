From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 03/22] signal/c6x: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:37:52 -0500
Message-ID: <20180420143811.9994-3-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-c6x-dev@linux-c6x.org
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

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/c6x/kernel/traps.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index c5feee4542b0..5c60aea3b75a 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -244,9 +244,7 @@ static struct exception_info eexcept_table[128] = {
 static void do_trap(struct exception_info *except_info, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
-	siginfo_t info;
 
-	clear_siginfo(&info);
 	if (except_info->code != TRAP_BRKPT)
 		pr_err("TRAP: %s PC[0x%lx] signo[%d] code[%d]\n",
 		       except_info->kernel_str, regs->pc,
@@ -254,12 +252,8 @@ static void do_trap(struct exception_info *except_info, struct pt_regs *regs)
 
 	die_if_kernel(except_info->kernel_str, regs, addr);
 
-	info.si_signo = except_info->signo;
-	info.si_errno = 0;
-	info.si_code  = except_info->code;
-	info.si_addr  = (void __user *)addr;
-
-	force_sig_info(except_info->signo, &info, current);
+	force_sig_fault(except_info->signo, except_info->code,
+			(void __user *)addr, current);
 }
 
 /*
-- 
2.14.1
