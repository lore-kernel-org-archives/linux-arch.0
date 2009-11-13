From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 3/5] ptrace: change tracehook_report_syscall_exit()
	to handle stepping
Date: Fri, 13 Nov 2009 20:58:58 +0100
Message-ID: <20091113195858.GA12049@redhat.com>
References: <20091112173853.GA12279@redhat.com> <20091113112530.c10a3743.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392AbZKMUEN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Nov 2009 15:04:13 -0500
Content-Disposition: inline
In-Reply-To: <20091113112530.c10a3743.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Roland McGrath <roland@redhat.com>, Srinivasa Ds <srinivasa@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/13, Andrew Morton wrote:
>
> On Thu, 12 Nov 2009 18:38:53 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Change tracehook_report_syscall_exit() to look at step flag and send
> > the trap signal if needed.
> >
> > This change affects ia64, microblaze, parisc, powerpc, sh.  They pass
> > nonzero "step" argument to tracehook but since it was ignored the tracee
> > reports via ptrace_notify(), this is not right and not consistent.
>
> This patch conflicts with utrace-core.patch a bit:

Ah, indeed, sorry...

>   static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
>   {
>         if (step) {
>                 siginfo_t info;
>                 user_single_step_siginfo(current, regs, &info);
>                 force_sig_info(SIGTRAP, &info, current);
>                 return;
>         }
>
> +       if (task_utrace_flags(current) & UTRACE_EVENT(SYSCALL_EXIT))
> +               utrace_report_syscall_exit(regs);
>         ptrace_report_syscall(regs);
>   }
>
>
> utrace-core.patch is getting rather old.  What is its status?

Roland, given that you are going to send the updated utrace patch,
perhaps it makes sense to drop this old utrace-core.patch from -mm?

Oleg.
