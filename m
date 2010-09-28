From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/5] mips: syscall number in in R2, not R0...
Date: Tue, 28 Sep 2010 18:50:27 +0100
Message-ID: <E1P0eJv-0006iz-4d__27374.7451407418$1287052954$gmane$org@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Resent-Message-ID: <20101014104146.GB28911@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


as it is, audit_syscall_entry() and secure_computing() get the
bogus value (0, in fact)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/ptrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c51b95f..c877733 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -536,7 +536,7 @@ asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	/* do the secure computing check first */
 	if (!entryexit)
-		secure_computing(regs->regs[0]);
+		secure_computing(regs->regs[2]);
 
 	if (unlikely(current->audit_context) && entryexit)
 		audit_syscall_exit(AUDITSC_RESULT(regs->regs[2]),
@@ -565,7 +565,7 @@ asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 
 out:
 	if (unlikely(current->audit_context) && !entryexit)
-		audit_syscall_entry(audit_arch(), regs->regs[0],
+		audit_syscall_entry(audit_arch(), regs->regs[2],
 				    regs->regs[4], regs->regs[5],
 				    regs->regs[6], regs->regs[7]);
 }
-- 
1.5.6.5
