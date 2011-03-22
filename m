From: Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: [PATCH] arm: handle ptrace requests to change PC during interrupted system calls
Date: Tue, 22 Mar 2011 16:01:25 +0100
Message-ID: <201103221601.25616.arnd.bergmann@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64785 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab1CVPBj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2011 11:01:39 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linaro-dev@lists.linaro.org, Ulrich Weigand <ulrich.weigand@linaro.org>, linux-arch@vger.kernel.org, patches@linaro.org

From: Ulrich Weigand <ulrich.weigand@linaro.org>

GDB's interrupt.exp test cases currenly fail on ARM.  The problem is how do_signal
handled restarting interrupted system calls:

The entry.S assembler code determines that we come from a system call; and that
information is passed as "syscall" parameter to do_signal.  That routine then
calls get_signal_to_deliver [*] and if a signal is to be delivered, calls into
handle_signal.  If a system call is to be restarted either after the signal
handler returns, or if no handler is to be called in the first place, the PC
is updated after the get_signal_to_deliver call, either in handle_signal (if
we have a handler) or at the end of do_signal (otherwise).

Now the problem is that during [*], the call to get_signal_to_deliver, a ptrace
intercept may happen.  During this intercept, the debugger may change registers,
including the PC.  This is done by GDB if it wants to execute an "inferior call",
i.e. the execution of some code in the debugged program triggered by GDB.

To this purpose, GDB will save all registers, allocate a stack frame, set up
PC and arguments as appropriate for the call, and point the link register to
a dummy breakpoint instruction.  Once the process is restarted, it will execute
the call and then trap back to the debugger, at which point GDB will restore
all registers and continue original execution.

This generally works fine.  However, now consider what happens when GDB attempts
to do exactly that while the process was interrupted during execution of a to-be-
restarted system call:  do_signal is called with the syscall flag set; it calls
get_signal_to_deliver, at which point the debugger takes over and changes the PC
to point to a completely different place.  Now get_signal_to_deliver returns
without a signal to deliver; but now do_signal decides it should be restarting
a system call, and decrements the PC by 2 or 4 -- so it now points to 2 or 4
bytes before the function GDB wants to call -- which leads to a subsequent crash.

To fix this problem, two things need to be supported:
- do_signal must be able to recognize that get_signal_to_deliver changed the PC
  to a different location, and skip the restart-syscall sequence
- once the debugger has restored all registers at the end of the inferior call
  sequence, do_signal must recognize that *now* it needs to restart the pending
  system call, even though it was now entered from a breakpoint instead of an
  actual svc instruction


This set of issues is solved on other platforms, usually by one of two
mechanisms:

- The status information "do_signal is handling a system call that may need
  restarting" is itself carried in some register that can be accessed via
  ptrace.  This is e.g. on Intel the "orig_eax" register; on Sparc the kernel
  defines a magic extra bit in the flags register for this purpose.
  This allows GDB to manage that state: reset it when doing an inferior call,
  and restore it after the call is finished.

- On s390, do_signal transparently handles this problem without requiring
  GDB interaction, by performing system call restarting in the following
  way: first, adjust the PC as necessary for restarting the call.  Then,
  call get_signal_to_deliver; and finally just continue execution at the
  PC.  This way, if GDB does not change the PC, everything is as before.
  If GDB *does* change the PC, execution will simply continue there --
  and once GDB restores the PC it saved at that point, it will automatically
  point to the *restarted* system call.  (There is the minor twist how to
  handle system calls that do *not* need restarting -- do_signal will undo
  the PC change in this case, after get_signal_to_deliver has returned, and
  only if ptrace did not change the PC during that call.)


Because there does not appear to be any obvious register to carry the
syscall-restart information on ARM, we'd either have to introduce a new
artificial ptrace register just for that purpose, or else handle the issue
transparently like on s390.  The patch below implements the second option;
using this patch makes the interrupt.exp test cases pass on ARM, with no
regression in the GDB test suite otherwise.

Signed-off-by: Ulrich Weigand <ulrich.weigand@linaro.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: patches@linaro.org

--- 

 arch/arm/kernel/signal.c |   90 +++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index cb83983..8242197 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -597,19 +597,13 @@ setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
 	return err;
 }
 
-static inline void setup_syscall_restart(struct pt_regs *regs)
-{
-	regs->ARM_r0 = regs->ARM_ORIG_r0;
-	regs->ARM_pc -= thumb_mode(regs) ? 2 : 4;
-}
-
 /*
  * OK, we're invoking a handler
  */	
 static int
 handle_signal(unsigned long sig, struct k_sigaction *ka,
 	      siginfo_t *info, sigset_t *oldset,
-	      struct pt_regs * regs, int syscall)
+	      struct pt_regs * regs)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = current;
@@ -617,26 +611,6 @@ handle_signal(unsigned long sig, struct k_sigaction *ka,
 	int ret;
 
 	/*
-	 * If we were from a system call, check for system call restarting...
-	 */
-	if (syscall) {
-		switch (regs->ARM_r0) {
-		case -ERESTART_RESTARTBLOCK:
-		case -ERESTARTNOHAND:
-			regs->ARM_r0 = -EINTR;
-			break;
-		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
-				regs->ARM_r0 = -EINTR;
-				break;
-			}
-			/* fallthrough */
-		case -ERESTARTNOINTR:
-			setup_syscall_restart(regs);
-		}
-	}
-
-	/*
 	 * translate the signal
 	 */
 	if (usig < 32 && thread->exec_domain && thread->exec_domain->signal_invmap)
@@ -685,6 +659,7 @@ handle_signal(unsigned long sig, struct k_sigaction *ka,
  */
 static void do_signal(struct pt_regs *regs, int syscall)
 {
+	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
 	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
@@ -698,18 +673,61 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	if (!user_mode(regs))
 		return;
 
+	/*
+	 * If we were from a system call, check for system call restarting...
+	 */
+	if (syscall) {
+		continue_addr = regs->ARM_pc;
+		restart_addr = continue_addr - (thumb_mode(regs) ? 2 : 4);
+		retval = regs->ARM_r0;
+
+		/*
+		 * Prepare for system call restart.  We do this here so that a
+		 * debugger will see the already changed PSW.
+		 */
+		switch (retval) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			regs->ARM_r0 = regs->ARM_ORIG_r0;
+			regs->ARM_pc = restart_addr;
+			break;
+		case -ERESTART_RESTARTBLOCK:
+			regs->ARM_r0 = -EINTR;
+			break;
+		}
+	}
+
 	if (try_to_freeze())
 		goto no_signal;
 
+	/*
+	 * Get the signal to deliver.  When running under ptrace, at this
+	 * point the debugger may change all our registers ...
+	 */
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		sigset_t *oldset;
 
+		/*
+		 * Depending on the signal settings we may need to revert the
+		 * decision to restart the system call.  But skip this if a
+		 * debugger has chosen to restart at a different PC.
+		 */
+		if (regs->ARM_pc == restart_addr) {
+			if (retval == -ERESTARTNOHAND
+			    || (retval == -ERESTARTSYS
+				&& !(ka.sa.sa_flags & SA_RESTART))) {
+				regs->ARM_r0 = -EINTR;
+				regs->ARM_pc = continue_addr;
+			}
+		}
+
 		if (test_thread_flag(TIF_RESTORE_SIGMASK))
 			oldset = &current->saved_sigmask;
 		else
 			oldset = &current->blocked;
-		if (handle_signal(signr, &ka, &info, oldset, regs, syscall) == 0) {
+		if (handle_signal(signr, &ka, &info, oldset, regs) == 0) {
 			/*
 			 * A signal was successfully delivered; the saved
 			 * sigmask will have been stored in the signal frame,
@@ -723,11 +741,14 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	}
 
  no_signal:
-	/*
-	 * No signal to deliver to the process - restart the syscall.
-	 */
 	if (syscall) {
-		if (regs->ARM_r0 == -ERESTART_RESTARTBLOCK) {
+		/*
+		 * Handle restarting a different system call.  As above,
+		 * if a debugger has chosen to restart at a different PC,
+		 * ignore the restart.
+		 */
+		if (retval == -ERESTART_RESTARTBLOCK
+		    && regs->ARM_pc == continue_addr) {
 			if (thumb_mode(regs)) {
 				regs->ARM_r7 = __NR_restart_syscall - __NR_SYSCALL_BASE;
 				regs->ARM_pc -= 2;
@@ -750,11 +771,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 #endif
 			}
 		}
-		if (regs->ARM_r0 == -ERESTARTNOHAND ||
-		    regs->ARM_r0 == -ERESTARTSYS ||
-		    regs->ARM_r0 == -ERESTARTNOINTR) {
-			setup_syscall_restart(regs);
-		}
 
 		/* If there's no signal to deliver, we just put the saved sigmask
 		 * back.
