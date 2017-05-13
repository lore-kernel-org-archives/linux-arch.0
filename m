From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 20:11:42 +0100
Message-ID: <20170513191142.GB390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
 <20170513182656.GA390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41942 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbdEMTLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 15:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20170513182656.GA390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 07:26:56PM +0100, Al Viro wrote:
> BTW, even in arch/* they tend to nest.  E.g. arch/alpha has 133 callers
> total.  Distribution by files:
>      35 arch/alpha/kernel/osf_sys.c
>      92 arch/alpha/kernel/signal.c
>       1 arch/alpha/kernel/traps.c
>       4 arch/alpha/lib/csum_partial_copy.c
>       1 arch/alpha/mm/fault.c

Another large pile is on sparc (208 callers).  Except that on sparc64
access_ok() is constant 1, which reduces it to 42 callers.
        3 arch/sparc/kernel/ptrace_32.c (all in arch_ptrace())
       31 arch/sparc/kernel/signal_32.c (5 in do_sigreturn(),
					 6 in do_rt_sigreturn(),
					 8 in setup_frame(),
					 11 in setup_rt_frame(),
					 1 in do_sys_sigstack())
	7 arch/sparc/kernel/sigutil_32.c (2 in save_fpu_state(),
					  2 in restore_fpu_state(),
					  2 in save_rwin_state(),
					  1 in restore_rwin_state()
	1 arch/sparc/mm/fault_32.c (in compute_si_addr())

The last one ignores -EFAULT, BTW - not sure what should it have done
in that case, though.  It's calculation of ->si_addr on SIGSEGV and SIGBUS
in case of data access SIGSEGV or SIGBUS; it wants to peek into insn to
figure out the effective address.  arch_ptrace() one is zeroing several
fields in userland struct fps for PTRACE_GETFPREGS.  Could've been
put_user() (or clear_user(), for that matter); we'd just done
copy_regset_to_user() on adjacent addresses, so the lack of access_ok() is not
a security hole there).  Everything else is in sigframe handling...

Other large piles are on mips, ppc and itanic.  parisc is next, but there
access_ok() is constant 1 as well.  Same for s390 and m68k.  nios2 and
unicore32 are a bit under 80 callers each and the next are tile (~60),
sh (~50) and then it drops off fast.

It's not impossible to review; the problem is in figuring out which codepaths
are hot enough to worry about them.  And I'm even more convinced that
bulk search-and-replace is the right approach here; we probably _can_ get
rid of that shit this cycle (or, at least, reduce its use to very few places
in arch/*), but that'll require some cooperation from architecture maintainers.
