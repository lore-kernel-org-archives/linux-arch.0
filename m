Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:56946 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDXPcl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2018 11:32:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-14-ebiederm@xmission.com>
        <20180421072550.GA6973@infradead.org>
Date: Tue, 24 Apr 2018 10:31:15 -0500
In-Reply-To: <20180421072550.GA6973@infradead.org> (Christoph Hellwig's
        message of "Sat, 21 Apr 2018 00:25:50 -0700")
Message-ID: <87lgdcei4c.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 23/22] signal/riscv: Replace do_trap_siginfo with force_sig_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Albert Ou <albert@sifive.com>
Message-ID: <20180424153115.QpJgdgXKwrBxwTuQGCRyinSjhYkxqs-feyDWGXrp_zw@z>


The function force_sig_fault is just the generic version of
do_trap_siginfo with a (void __user *) instead of an unsigned long
parameter for the address.

So just use force_sig_fault to simplify the code.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Cc: linux-riscv@lists.infradead.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/riscv/kernel/traps.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3087940008f4..b99d9dd21fd0 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -63,12 +63,6 @@ void die(struct pt_regs *regs, const char *str)
 		do_exit(SIGSEGV);
 }
 
-static inline void do_trap_siginfo(int signo, int code,
-	unsigned long addr, struct task_struct *tsk)
-{
-	force_sig_fault(signo, code, (void __user *)addr, tsk);
-}
-
 void do_trap(struct pt_regs *regs, int signo, int code,
 	unsigned long addr, struct task_struct *tsk)
 {
@@ -81,7 +75,7 @@ void do_trap(struct pt_regs *regs, int signo, int code,
 		show_regs(regs);
 	}
 
-	do_trap_siginfo(signo, code, addr, tsk);
+	force_sig_fault(signo, code, (void __user *)addr, tsk);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -143,7 +137,7 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 	}
 #endif /* CONFIG_GENERIC_BUG */
 
-	do_trap_siginfo(SIGTRAP, TRAP_BRKPT, regs->sepc, current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc), current);
 	regs->sepc += 0x4;
 }
 
-- 
2.14.1
