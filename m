From: Masami Hiramatsu <mhiramat@redhat.com>
Subject: Re: [PATCH 1/2] perf: Introduce new perf_save_regs() for hot regs
 snapshot
Date: Fri, 05 Mar 2010 10:08:07 -0500
Message-ID: <4B911E57.60004@redhat.com>
References: <1267605529.25158.75.camel@laptop> <1267758486-30499-2-git-send-regression-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab0CEPIr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Mar 2010 10:08:47 -0500
In-Reply-To: <1267758486-30499-2-git-send-regression-fweisbec@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jason Baron <jbaron@redhat.com>, Archs <linux-arch@vger.kernel.org>

Frederic Weisbecker wrote:
> Events that trigger overflows by interrupting a context can
> use get_irq_regs() or task_pt_regs() to retrieve the state
> when the event triggered. But this is not the case for some
> other class of events like trace events as tracepoints are
> executed in the same context than the code that triggered
> the event.
> 
> It means we need a different api to capture the regs there,
> namely we need a hot snapshot to get the most important
> informations for perf: the instruction pointer to get the
> event origin, the frame pointer for the callchain, the code
> segment for user_mode() tests (we always use __KERNEL_CS as
> trace events always occur from the kernel) and the eflags
> for further purposes.
> 
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@redhat.com>
> Cc: Jason Baron <jbaron@redhat.com>
> Cc: Archs <linux-arch@vger.kernel.org>
> ---
>  arch/x86/kernel/cpu/perf_event.c |   12 ++++++++++
>  arch/x86/kernel/dumpstack.h      |   15 +++++++++++++
>  include/linux/perf_event.h       |   42 +++++++++++++++++++++++++++++++++++++-
>  kernel/perf_event.c              |    5 ++++
>  4 files changed, 73 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
> index 641ccb9..274d0cd 100644
> --- a/arch/x86/kernel/cpu/perf_event.c
> +++ b/arch/x86/kernel/cpu/perf_event.c
> @@ -1662,6 +1662,18 @@ struct perf_callchain_entry *perf_callchain(struct pt_regs *regs)
>  	return entry;
>  }
>  
> +void perf_arch_save_regs(struct pt_regs *regs, unsigned long ip, int skip)

Hmm, why would you call it 'save_regs' ?
It seems that this function is just for fixing registers 
instead of saving it into somewhere...

Thank you,


-- 
Masami Hiramatsu
e-mail: mhiramat@redhat.com
