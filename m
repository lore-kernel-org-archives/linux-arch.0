Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50911 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965576Ab2ERR6f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 13:58:35 -0400
Date: Fri, 18 May 2012 18:58:33 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [parisc] double restarts on multiple signal arrivals
Message-ID: <20120518175833.GQ22082@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-parisc@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20120518175833.TWL5BdwuXNEbEY-gnqTjiD_uL6FB_wLC9-q-u6iwu_Q@z>

	Since "[PATCH] PA-RISC assembler cleanups and fixes" back in 2005,
(commit b6181a0a1999c7d4dd937d7f5234fb62eca68e89 in historical tree),
we do loop until all pending signals are dealt with.  Which is fine,
except that now we need to deal with syscall restart logics in all of
them.

	What happens if we have r28 containing e.g. -ERESTARTNOINTR
when we do a syscall?  Note that x86 analog of the code in parisc
syscall_restart() differs in one respect - the same register is used
for return value and syscall number.  So once we'd copied ->orig_ax
to ->ax, that's it - it *can't* be a restart-worthy value anymore,
since then we would've been in a syscall with negative syscall number
and ->ax before the assignment would've been -ENOSYS.  I.e. not a
restart-worthy value, so we wouldn't have hit that regs->ax = regs->orig_ax
in the first place.

	On parisc the counterpart of the above doesn't work; AFAICS,
we might have whatever we bloody please in r28 when we make a syscall.
Syscall number goes in r20, arguments are apparently in r26..r21.
Return value goes into r28.  Incidentally, why do we bother restoring
r28 on syscall restart at all?  Except for that mess with multiple
pending signals, the value we have in r28 on syscall entry doesn't
seem to affect the syscall behaviour...  Some HPUX compat fun?  But
AFAICS there calling conventions are also such that r28 on entry
doesn't affect anything...[1]

	Another fun question: what prevents syscall restarts on
rt_sigreturn()?  If original signal had been taken in syscall handler
we go through syscall_exit and that'll pass 1 as in_syscall to do_signal().
Are we relying on r28 in saved sigcontext never being restart-worthy,
seeing that we'd done syscall_restart()?  But that again relies on
->orig_r28 never containing such values; if it *did* contain one,
we are really screwed since on the path from rt_sigreturn() we'll have
->orig_r28 equal to r28 at the end of signal handler (not to mention
having moved back by twice the required amount - one time when we took
the original signal, another - now).

[1] FWIW, on other architectures the situation with restoring registers on
restarts looks so:
alpha		r0 (syscall number), r19 (arg4)
arm		r0 (arg1)
avr32		r12 (arg1)
bfin		p0 (syscall number), r0 (arg1)
c6x		a4 (arg1)
cris		r10 (arg1)
frv		gr8 (arg1)
h8300		er0 (syscall number)
hexagon		r06 (syscall number), r00 (arg1)
ia64		nothing
m32r		r0 (arg1)
m68k		d0 (syscall number)
microblaze	nothing
mips		r2 (syscall number), r7 (arg1)
mn10300		d0 (syscall number)
openrisc	r11 (syscall number)
parisc		r28
ppc		r3 (arg1)
s390		r2 (arg1)
score		r4 (syscall number), r7 (arg1)
sh		r0 or r9, depending on whether it's sh32 or sh4
sparc		i0 (arg1)
tile		r0 (arg1)
unicore32	r00 (arg1)
x86		[er]ax (syscall number)
xtensa		a2 (syscall number)
