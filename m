From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] Blackfin: initial tracehook support
Date: Thu, 11 Feb 2010 18:54:04 -0500
Message-ID: <8bd0f97a1002111554ib69bd48rc3c5f4af65058281@mail.gmail.com>
References: <20100202185907.GE3630@lst.de> <1265881389-26925-2-git-send-email-vapier@gentoo.org>
	<20100211204653.34BB3900@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:36441 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340Ab0BKXyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Feb 2010 18:54:25 -0500
In-Reply-To: <20100211204653.34BB3900@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, oleg@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Thu, Feb 11, 2010 at 15:46, Roland McGrath wrote:
>> =C2=A0config BLACKFIN
>> =C2=A0 =C2=A0 =C2=A0 def_bool y
>> =C2=A0 =C2=A0 =C2=A0 select HAVE_ARCH_KGDB
>> + =C2=A0 =C2=A0 select HAVE_ARCH_TRACEHOOK
>
> Don't define this until you have all its constituents as listed in th=
e
> arch/Kconfig comment. =C2=A0I don't see user_regset support.

where is user_regset actually used ?  i only see it in fs/binfmt_elf.c
and core dumps, neither of which work on nommu systems (or at least on
Blackfin systems).

>> +static inline void
>> +syscall_get_arguments(struct task_struct *task, struct pt_regs *reg=
s,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0unsigned int i, unsigned int n, unsigned long *args)
>> +{
>> + =C2=A0 =C2=A0 /* wtf is "i" ? */
>> + =C2=A0 =C2=A0 BUG_ON(i);
>
> i is the starting number. =C2=A0args[0] gets the i'th argument,
> args[n - 1] gets the i+n-1'th argument.

i dont see anyone calling syscall_get_arguments() with i!=3D0, and a fe=
w
other arches are doing the BUG_ON(i) thing too.

but should be easy to implement this with memory walking code ...

>> +asmlinkage void syscall_trace_leave(struct pt_regs *regs)
>> +{
>> + =C2=A0 =C2=A0 if (test_thread_flag(TIF_SYSCALL_TRACE))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tracehook_report_syscall=
_exit(regs, 0);
>> =C2=A0}
>
> Is it in fact true that single-step reports still come normally after=
 a
> syscall instruction?

this is unchanged from the previous Blackfin behavior, and it's how
most arches behaved in 2.6.32.  but looking in latest mainline, it
seems people are changing to:
if (test_thread_flag(TIF_SINGLESTEP) || test_thread_flag(TIF_SYSCALL_TR=
ACE))
    tracehook_report_syscall_exit(regs, 0);

so changing Blackfin too should be straightforward i guess

>> @@ -213,7 +213,7 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 if (regs->syscfg & TRACE_BITS) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs->syscfg &=3D ~=
TRACE_BITS;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptrace_notify(SIGTRAP);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tracehook_signal_handler=
(sig, info, ka, regs, 1);
>> =C2=A0 =C2=A0 =C2=A0 }
>
> This call should be made unconditionally, and it should be made after=
 the
> signal mask changes have been made (i.e. at the end of handle_signal)=
=2E =C2=A0I
> think it's wrong to clear the single-step flag here. =C2=A0Instead, p=
ass
> (regs->syscfg & TRACE_BITS) as the last argument.
>
> With ptrace, it makes no difference one way or the other because it w=
ill
> always either explicitly clear or explicitly set single-step before i=
t
> resumes. =C2=A0But in future, it will matter.

sounds like this issue is unrelated to tracehook and how we've been
doing signal/ptrace stuff has always been a little broken ...

i'll move it to how most arches seem to do it -- in do_signal after a
successful call to handle_signal and after clearing
TIF_RESTORE_SIGMASK.

thanks for the review
-mike
