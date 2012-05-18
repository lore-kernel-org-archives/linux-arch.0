From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Fri, 18 May 2012 23:24:22 +0100
Message-ID: <20120518222422.GX22082@ZenIV.linux.org.uk>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
 <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
 <20120518195610.GV22082@ZenIV.linux.org.uk>
 <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
 <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46246 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab2ERWY2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 18:24:28 -0400
Content-Disposition: inline
In-Reply-To: <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Grant Grundler <grantgrundler@gmail.com>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, May 18, 2012 at 04:15:42PM -0400, Carlos O'Donell wrote:

> I've hit "Mark as unread" twice on this thread now because I *am*
> interested in this conversation.
> 
> However, I must confess that the original email reads like a rant
> without a clear explanation of exactly what you think is wrong.
> 
> I'm familiar with the PARISC signal code because I worked on the
> 32/64-bit compat support for the frame layout, I also helped Randolph
> work on the syscall restart logic.
> 
> What I don't understand is what's wrong with it now, and your subject
> begins to hint at the problem.
> 
> Can you describe in more detail exactly what problem we need to solve?

Sure.  Have e.g. read(2) on a pipe called when you happen to have -512 in
r28 and have two signals arrive at once while inside that read().  Both
with user handlers.  Both with SA_RESTART.

When we enter the kernel, we have pt_regs created on kernel stack and
filled with the values we had in registers.  Among other things, the
value of r28 is stored in regs->orig_r28.  Note that arguments and the
syscall number are all passed through other registers, so setting the
arguments for syscall did not overwrite the value we used to have in
r28.  It's still -512.

We find which C function to call (sys_read) and go there, with return
address set to syscall_exit.

sys_read() ends up calling pipe_read(), which finds pipe empty and goes
to sleep.  The signals arrive and pipe_read() is woken up.  It sees that
	* signal_pending() is true
	* nothing has been read yet
so it return -ERESTARSYS.  sys_read() returns what it got from pipe_read().

Now we are at syscall_exit.  We set r1 to pt_regs created on stack when
we entered the syscall.  Return value of sys_read() is taken from r28 and
stored into regs->gr[28].  We check TIF_NEED_RESCHED and it's not set.
We'd reached syscall_check_sig and check TIF_SIGPENDING, which is set.
We go through syscall_do_signal and reach the call of
do_notify_resume(regs, 1), which calls do_signal(regs, 1).

There we call get_signal_to_deliver() and get one of those two signals
dequeued and returned.  Note that TIF_SIGPENDING is still set - there is
the second signal left.  We got positive signr, so we do not leave the
loop yet.  in_syscall is 1, so we call syscall_restart().

We check regs->gr[28], which is -ERESTARTSYS.  SA_RESTART is set in
sa_flags, so we fall through to the next case, which is
                regs->gr[31] -= 8; /* delayed branching */
                /* Preserve original r28. */
                regs->gr[28] = regs->orig_r28;
Note that ERESTARTSYS is 512, so the second assignment does nothing - we
still have regs->gr[28] equal to -ERESTARTSYS.  We are done with
syscall_restart().

Now we call handle_signal(), which calls setup_rt_frame().  sigframe is
allocated on userland stack and filled accordingly to the contents of *regs.
No errors occured, so we set regs->gr[31] to entry point of signal handler,
regs->gr[2] to address of sigreturn trampoline we'd created in the sigframe,
regs->gr[26..24] to arguments of handler, and regs->gr[30] to new value of
userland stack pointer.

Back in handle_signal(), we adjust the set of blocked signals and return 1.
do_signal() sees that RESTORE_SIGMASK is not set and it's done - we return
to do_notify_resume() and from there back into entry.S.

We reload registers from pt_regs and go to syscall_check_sig again.  There
we reread the thread flags and see that SIGPENDING is still set - we have
another signal to deal with.  We hit do_notify_resume() and do_signal()
again.  And again, in_syscall is 1.

do_signal() gets the remaining pending signal from get_signal_to_deliver().
Again, we call syscall_restart().  And neither regs->gr[28] nor regs->orig_r28
has been changed, so we hit the same case.  Assignment to regs->gr[28] is
a no-op again.  But look what happened to regs->gr[31] - it got decremented
by 8.  So it points 8 bytes before the entry point of the first handler now.

We proceed to set the second sigframe up.  The registers are saved in
sigcontext, adjusted so that they correspond to the call of the second
handler with future return to the second trampoline and we return all the
way out to entry.S.  There we go to syscall_check_sig again, but this
time we have no pending signals left, so we reach syscall_restore and
proceed to userland.

Now we are in the second handler.  It's executed to the end and when it
returns, we go to the address we had in r2.  I.e. the second trampoline.
There we get r25 set to 1, r20 set to __NR_rt_sigreturn and we go to
execute the syscall.  Which restores the registers from sigcontext and,
since its in_syscall argument is 1, sets ->gr[31] to sc->sc_iaoq.  Which
had been set by setup_rt_sigcontext() from regs->gr[31] at the moment it
had been called, i.e. the entry point of the first handler decremented by 8.  
Then we proceed to return to userland.  And arrive there are the right
arguments for the first handler, but instruction pointer is 8 bytes too
early.  Bad things happen, obviously.

The point where the things go wrong is the second call of syscall_restart().
It should've done nothing.  We need to do syscall restarts only when building
the first sigframe.  And usually it does work out that way, simply because
the value you happened to have in r28 is probably not one of the 4 that
make syscall_restart() do things.  So after the first time around it does
nothing.  Very similar logics on x86 does, indeed, work in all cases.
There the register used for return values happens to be the same as we use
to pass syscall number, so you can't arrange a call of syscall_restart()
analog that would trigger restart *and* leave the return value register
unchanged - you'd need %eax to be -ERESTART<something> when you enter the
syscall and that would immediately result in regs->ax set to -ENOSYS.  I.e.
no restarts would be done.  However, on parisc that doesn't work - you can
start with r28 being -ERESTARTSYS and get -ERESTARTSYS from syscall.

And no, I don't have any good suggestions on how to fix it right now.  Depends
on how does gdb on parisc play with pt_regs, among other things...

Sorry if the original posting sounded like a rant - I'd spent the last month
crawling through the assembler glue around signal hanlding all over arch/*
and that probably affected the tone.  Definitely had been affecting the amount
of spoken obscenities lately...
