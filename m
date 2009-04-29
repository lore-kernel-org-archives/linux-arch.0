From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Fwd: arch/ && tracehook_report_syscall_xxx()
Date: Wed, 29 Apr 2009 21:30:36 +0200
Message-ID: <20090429193036.GB14652@elte.hu>
References: <20090427180455.GA32509@redhat.com> <20090427182919.B923DFC3BF@magilla.sf.frob.com> <20090427183218.GA31596@lst.de> <20090429190852.GA14515@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:44162 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637AbZD2Tbm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Apr 2009 15:31:42 -0400
Content-Disposition: inline
In-Reply-To: <20090429190852.GA14515@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, chris@zankel.net, cooloney@kernel.org, deller@gmx.de, geert@linux-m68k.org, gerg@uclinux.org, hskinnemoen@atmel.com, jdike@addtoit.com, jesper.nilsson@axis.com, kyle@mcmartin.ca, linux@arm.linux.org.uk, ralf@linux-mips.org, rth@twiddle.net, starvik@axis.com, takata@linux-m32r.org, ysato@users.sourceforge.jp, zippel@linux-m68k.org, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/27, Christoph Hellwig wrote:
> >
> > I've poked a few arch maintainers in the past to separate the enter/exit
> > path and usually got the desired changes :)
> 
> I'd like to try your method!
> 
> So. Dear maintainers of
> 
> 	alpha
> 	arm
> 	avr32
> 	blackfin
> 	cris
> 	h8300
> 	m32r
> 	m68k
> 	m68knommu
> 	mips
> 	parisc
> 	um
> 	xtensa
> 
> . Could you please convert your syscall trace code to use
> tracehook_report_syscall_entry/tracehook_report_syscall_exit ?
> 
> 
> For example, let's look at more or less typical arch/alpha/kernel/ptrace.c,
> 
> 	asmlinkage void
> 	syscall_trace(void)
> 	{
> 		if (!test_thread_flag(TIF_SYSCALL_TRACE))
> 			return;
> 		if (!(current->ptrace & PT_PTRACED))
> 			return;
> 		/* The 0x80 provides a way for the tracing parent to distinguish
> 		   between a syscall stop and SIGTRAP delivery */
> 		ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
> 					 ? 0x80 : 0));
> 
> 		/*
> 		 * This isn't the same as continuing with a signal, but it will do
> 		 * for normal use.  strace only continues with a signal if the
> 		 * stopping signal is not SIGTRAP.  -brl
> 		 */
> 		if (current->exit_code) {
> 			send_sig(current->exit_code, current, 1);
> 			current->exit_code = 0;
> 		}
> 	}
> 
> it would be really nice to turn it into something like
> 
> 	asmlinkage void
> 	syscall_trace(int entryexit)
> 	{
> 		if (!test_thread_flag(TIF_SYSCALL_TRACE))
> 			return;
> 
> 		if (entryexit)
> 			tracehook_report_syscall_entry(task_pt_regs(current));
> 		else
> 			tracehook_report_syscall_exit(task_pt_regs(current), stepping);
> 	}
> 
> Also, tracehook_report_syscall_entry() might want to abort this system
> call (please see the comment above this helper), it would be great to
> take the returned value into account.
> 
> arch/* play with ptrace internals which should be changed soon, not good.

And there's upstream examples in:

 arch/ia64/kernel/ptrace.c
 arch/powerpc/kernel/ptrace.c
 arch/s390/kernel/ptrace.c
 arch/sh/kernel/ptrace_32.c
 arch/sh/kernel/ptrace_64.c
 arch/sparc/kernel/ptrace_32.c
 arch/sparc/kernel/ptrace_64.c
 arch/x86/kernel/ptrace.c

as well, for tracehook usage. Chances are that your architecture's 
syscall entry/exit ptrace hooks look quite similar to one of the 
architectures above!

	Ingo
