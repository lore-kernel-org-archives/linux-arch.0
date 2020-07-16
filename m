From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 06/13] x86/entry: Consolidate 32/64 bit syscall entry
Date: Thu, 16 Jul 2020 20:22:14 +0200
Message-ID: <20200716185424.550204929@linutronix.de>
References: <20200716182208.180916541@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGPTuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:51 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

64bit and 32bit entry code have the same open coded syscall entry handling
after the bitwidth specific bits.

Move it to a helper function and share the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   93 +++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 52 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -366,8 +366,7 @@ static void __syscall_return_slowpath(st
 	exit_to_user_mode();
 }
 
-#ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+static noinstr long syscall_enter(struct pt_regs *regs, unsigned long nr)
 {
 	struct thread_info *ti;
 
@@ -379,6 +378,16 @@ static void __syscall_return_slowpath(st
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
+	instrumentation_end();
+	return nr;
+}
+
+#ifdef CONFIG_X86_64
+__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+{
+	nr = syscall_enter(regs, nr);
+
+	instrumentation_begin();
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](regs);
@@ -390,64 +399,53 @@ static void __syscall_return_slowpath(st
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
 	}
-	__syscall_return_slowpath(regs);
-
 	instrumentation_end();
-	exit_to_user_mode();
+	syscall_return_slowpath(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		current_thread_info()->status |= TS_COMPAT;
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * or may not be necessary, but it matches the old asm behavior.
+	 */
+	return syscall_enter(regs, (unsigned int)regs->orig_ax);
+}
+
 /*
- * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
- * all entry and exit work and returns with IRQs off.  This function is
- * extremely hot in workloads that use it, and it's usually called from
- * do_fast_syscall_32, so forcibly inline it to improve performance.
+ * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
-static void do_syscall_32_irqs_on(struct pt_regs *regs)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
+						  unsigned int nr)
 {
-	struct thread_info *ti = current_thread_info();
-	unsigned int nr = (unsigned int)regs->orig_ax;
-
-#ifdef CONFIG_IA32_EMULATION
-	ti->status |= TS_COMPAT;
-#endif
-
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
-		/*
-		 * Subtlety here: if ptrace pokes something larger than
-		 * 2^32-1 into orig_ax, this truncates it.  This may or
-		 * may not be necessary, but it matches the old asm
-		 * behavior.
-		 */
-		nr = syscall_trace_enter(regs);
-	}
-
 	if (likely(nr < IA32_NR_syscalls)) {
+		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+		instrumentation_end();
 	}
-
-	__syscall_return_slowpath(regs);
 }
 
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
-	do_syscall_32_irqs_on(regs);
+	unsigned int nr = syscall_32_enter(regs);
 
-	instrumentation_end();
-	exit_to_user_mode();
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_return_slowpath(regs);
 }
 
-static bool __do_fast_syscall_32(struct pt_regs *regs)
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned int nr	= syscall_32_enter(regs);
 	int res;
 
+	instrumentation_begin();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
@@ -460,17 +458,18 @@ static bool __do_fast_syscall_32(struct
 		res = get_user(*(u32 *)&regs->bp,
 		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
 	}
+	instrumentation_end();
 
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
-		local_irq_disable();
-		__prepare_exit_to_usermode(regs);
+		syscall_return_slowpath(regs);
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs);
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_return_slowpath(regs);
 	return true;
 }
 
@@ -483,7 +482,6 @@ static bool __do_fast_syscall_32(struct
 	 */
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 					vdso_image_32.sym_int80_landing_pad;
-	bool success;
 
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
@@ -492,17 +490,8 @@ static bool __do_fast_syscall_32(struct
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
-	success = __do_fast_syscall_32(regs);
-
-	instrumentation_end();
-	exit_to_user_mode();
-
-	/* If it failed, keep it simple: use IRET. */
-	if (!success)
+	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
+	if (!__do_fast_syscall_32(regs))
 		return 0;
 
 #ifdef CONFIG_X86_64
