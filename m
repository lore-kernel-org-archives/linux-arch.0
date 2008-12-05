From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 1/3] performance counters: core code
Date: Fri, 5 Dec 2008 12:20:52 +0100
Message-ID: <20081205112052.GA7219@elte.hu>
References: <20081204225345.654705757@linutronix.de> <20081204230228.470613892@linutronix.de> <18745.2198.389098.296393@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:34670 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbYLELVT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Dec 2008 06:21:19 -0500
Content-Disposition: inline
In-Reply-To: <18745.2198.389098.296393@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>


* Paul Mackerras <paulus@samba.org> wrote:

> Thomas Gleixner writes:
> 
> > +static void
> > +perf_install_in_context(struct perf_counter_context *ctx,
> > +			struct perf_counter *counter,
> > +			int cpu)
> > +{
> > +	struct task_struct *task = ctx->task;
> > +
> 
> [...]
> 
> > +	if (task) {
> > +		task_oncpu_function_call(task, __perf_install_in_context,
> > +					 counter);
> > +	} else {
> > +		smp_call_function_single(cpu, __perf_install_in_context,
> > +					 counter, 1);
> > +	}
> 
> What happens if we send an IPI to the cpu where the task is running, 
> but by the time the IPI arrives, the task has been migrated to another 
> cpu and is now running there?  Do you chase after it and send another 
> IPI to its new cpu, or is there some reason why it can't migrate? If 
> it's the former, where is that code?  I haven't seen it so far (at 
> least, task_oncpu_function_call doesn't seem to do it).

in that case the schedule-in method will install the perf counter 
automatically. No need to chase after it. The smp call is only for the 
case where the task does not schedule at all.

	Ingo
