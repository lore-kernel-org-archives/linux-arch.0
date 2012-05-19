From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: hexagon: signal bugs
Date: Sat, 19 May 2012 22:09:11 +0100
Message-ID: <20120519210911.GB11775@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38454 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757477Ab2ESVJN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2012 17:09:13 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

	1) spot the braino:
void do_trap0(struct pt_regs *regs)
...
        unsigned long syscallret = 0;
	...
                if ((unsigned long) regs->syscall_nr >= __NR_syscalls) {
                        regs->r00 = -1;
                } else {
                        syscall = (syscall_fn)
                                  (sys_call_table[regs->syscall_nr]);
                        syscallret = syscall(regs->r00, regs->r01,
                                   regs->r02, regs->r03,
                                   regs->r04, regs->r05);
                }

                if (regs->syscall_nr != __NR_rt_sigreturn)
                        regs->r00 = syscallret;
IOW, the last if () should've been inside the "syscall_nr is not too high"
branch of the if () just above...

	2) you do _not_ want syscall restarts to happen on sigreturn().
Whatever adjustment needed to be done had already been done back before
we'd saved the registers into sigcontext.  So doing
        regs->syscall_nr = __NR_rt_sigreturn;
in sys_rt_sigreturn() is exactly the wrong thing - for syscall restart
purposes you want it to look like a non-syscall (i.e. it should be
regs->syscall_nr = -1 to make your check in handle_signal() work).
Incidentally, I would suggest just having that thing return regs->r00;
then you can avoid all special-casing for "do we want to put the
return value of sys_...() into regs->r00?" in do_trap0().

	3) if you have multiple pending signals, you need to handle all
of them before returning to userland.  And you need to make sure that
syscall restart logics does not trigger on anything past the first time
around.

	4) checking for !user_mode(regs) needs to be done in the loop (created
while fixing #3) in vm_entry.S where you are calling do_notify_resume();
you need to leave the loop if it's true (if you can get there on return
to kernel in the first place).
