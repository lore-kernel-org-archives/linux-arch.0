From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 05/13] x86/entry: Consolidate check_user_regs()
Date: Thu, 16 Jul 2020 20:22:13 +0200
Message-ID: <20200716185424.442693273@linutronix.de>
References: <20200716182208.180916541@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The user register sanity check is sprinkled all over the place. Move it
into enter_from_user_mode().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -82,10 +82,11 @@ static noinstr void check_user_regs(stru
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
  */
-static noinstr void enter_from_user_mode(void)
+static noinstr void enter_from_user_mode(struct pt_regs *regs)
 {
 	enum ctx_state state = ct_state();
 
+	check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	user_exit_irqoff();
 
@@ -95,8 +96,9 @@ static noinstr void enter_from_user_mode
 	instrumentation_end();
 }
 #else
-static __always_inline void enter_from_user_mode(void)
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 {
+	check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
@@ -369,9 +371,7 @@ static void __syscall_return_slowpath(st
 {
 	struct thread_info *ti;
 
-	check_user_regs(regs);
-
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -434,9 +434,7 @@ static void do_syscall_32_irqs_on(struct
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	check_user_regs(regs);
-
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -487,8 +485,6 @@ static bool __do_fast_syscall_32(struct
 					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
-	check_user_regs(regs);
-
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
@@ -496,7 +492,7 @@ static bool __do_fast_syscall_32(struct
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -599,8 +595,7 @@ idtentry_state_t noinstr idtentry_enter(
 	};
 
 	if (user_mode(regs)) {
-		check_user_regs(regs);
-		enter_from_user_mode();
+		enter_from_user_mode(regs);
 		return ret;
 	}
 
@@ -733,8 +728,7 @@ void noinstr idtentry_exit(struct pt_reg
  */
 void noinstr idtentry_enter_user(struct pt_regs *regs)
 {
-	check_user_regs(regs);
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 }
 
 /**
