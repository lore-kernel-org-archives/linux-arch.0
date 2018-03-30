From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/7] x86: don't pointlessly reload the system call number
Date: Fri, 30 Mar 2018 11:37:14 +0200
Message-ID: <20180330093720.6780-2-linux@dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330093720.6780-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

We have it in a register in the low-level asm, just pass it in as an
argument rather than have do_syscall_64() load it back in from the
ptregs pointer.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/common.c   | 12 ++++++------
 arch/x86/entry/entry_64.S |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 74f6eee15179..a8b066dbbf48 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -266,14 +266,13 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_X86_64
-__visible void do_syscall_64(struct pt_regs *regs)
+__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
-	struct thread_info *ti = current_thread_info();
-	unsigned long nr = regs->orig_ax;
+	struct thread_info *ti;
 
 	enter_from_user_mode();
 	local_irq_enable();
-
+	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
@@ -282,8 +281,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	 * table.  The only functional difference is the x32 bit in
 	 * regs->orig_ax, which changes the behavior of some syscalls.
 	 */
-	if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
-		nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
+	nr &= __SYSCALL_MASK;
+	if (likely(nr < NR_syscalls)) {
+		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 805f52703ee3..c843b3d69048 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -233,7 +233,8 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
-	movq	%rsp, %rdi
+	movq	%rax, %rdi
+	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	TRACE_IRQS_IRETQ		/* we're about to change IF */
-- 
2.16.3
