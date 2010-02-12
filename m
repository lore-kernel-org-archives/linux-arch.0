From: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] Blackfin: initial tracehook
	support
Date: Fri, 12 Feb 2010 12:44:27 -0800 (PST)
Message-ID: <20100212204427.5F75CA18@magilla.sf.frob.com>
References: <20100202185907.GE3630@lst.de>
	<1265881389-26925-2-git-send-email-vapier@gentoo.org>
	<20100211204653.34BB3900@magilla.sf.frob.com>
	<8bd0f97a1002111554ib69bd48rc3c5f4af65058281@mail.gmail.com>
	<20100212032406.BE645C81B@magilla.sf.frob.com>
	<8bd0f97a1002112033m5805d4eco3add4d5625e71e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: Mike Frysinger's message of  Thursday,
	11 February 2010 23:33:20 -0500
	<8bd0f97a1002112033m5805d4eco3add4d5625e71e9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

> cant say we've had anything to do with this ;).  nor does Blackfin
> support coredumps on FDPIC ELF (and FLAT has never supported
> coredumps), and i'm pretty sure we havent looked at anything in gdb
> along these lines.  no one has ever asked, so we've never looked.

Ok.

> i dont have a problem with implementing user_regsets ... my point was
> more that if there's no code using these interfaces, then i could slap
> together a whole lot of crap and never know if it's correct since i
> cant test it.  Blackfin doesnt currently implement
> PTRACE_{G,S}ETREGSET, so even with that patch i dont think i have any
> (straight forward) test vectors.

The point of PTRACE_{G,S}ETREGSET is that no arch code implements them.
The generic ptrace code does.  The patch for that is in tip/master (I think).

Moreover, the usual cleanup is to make your arch_ptrace() use
copy_regset_from_user() and copy_regset_to_user() to implement existing
calls ike PTRACE_GETREGS.  That way, existing ptrace users (strace, gdb)
become tests of the user_regset paths (some of them).

> i missed the passing of TIF_SINGLESTEP in as the second arg.  i
> thought you were taking issue with the if(...) portions.

I was trying to explain how you apply your arch knowledge to decide what is
exactly right for your arch code.

> the way we do it on Blackfin atm is that syscall_trace_{enter,leave}
> are only called when TIF_SYSCALL_TRACE is set (in the low level
> assembly), so any checking of thread_flags here is pointless.  i guess
> the low level code needs updating to check a mask so that we can add
> TIF_SYSCALL_TRACEPOINT easier.

What happens today when PTRACE_SINGLESTEP is used with the PC sitting at a
syscall instruction?  If that gets a single-step report (SIGTRAP) after the
syscall is done, with the PC sitting at the instruction immediately
following the syscall instruction, then you are already doing the right
thing.  On some other machines, making that happen involves arch assembly
code making sure it gets to its syscall_trace_leave() for this case.

> so tracehook_report_syscall_exit() checking TIF_SINGLESTEP only makes
> sense when the arch doesnt support hardware single stepping in user
> mode ?  the Blackfin processor does support hardware single stepping
> (and we utilize it in Linux).

No, that is not what I said at all.  It is necessary if and only if the way
that the hardware single-step interacts with the syscall entry/exit paths
on your machine means that the completion of the user-mode syscall
instruction does not result in a single-step trap like any other single
user-mode instruction would.  This is the case on machines such as x86 and
powerpc (I don't know others in detail).  There, the hardware single-step
feature works such that the real hardware trap either comes in kernel mode
right at syscall entry, or doesn't come at all.  Hence, the arch code has
to notice when single-step was enabled at syscall entry time and simulate
the hardware trap before returning to user mode.

> also, in reading the kerneldocs for tracehook_report_syscall_exit(),
> it says "an attempted system call".  should system calls greater than
> NR_syscall (-ENOSYS) also get traced ?  we dont currently do this on
> the Blackfin port, but going by `strace` differences between my
> desktop and the board, i guess the answer is "the Blackfin code is
> currently broken".

Yes.  It's any syscall attempt.  Inside tracehook_report_syscall_entry(),
all the registers can be changed (via user_regset, i.e. ptrace) so that
what starts as an entry with a bogus syscall number becomes an entry with a
different syscall number and/or arguments.  So you can't decide before
tracehook_report_syscall_entry() whether it is "real" or not.  For every
tracehook_report_syscall_entry() call, there must be a corresponding
tracehook_report_syscall_exit() call (unless TIF_SYSCALL_TRACE was cleared
in the interim).  At that exit point, the registers can again be changed.

For example, an "expected" use (that some things do today via ptrace) is to
catch the entry, abort the syscall by changing the syscall number register
to something bogus like -1, resume so it diagnoses -ENOSYS and gets to
syscall exit, then catch the exit and reset the return value registers to
pretend some particular syscall results happened.


Thanks,
Roland
