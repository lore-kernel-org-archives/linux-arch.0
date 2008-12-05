From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/3] performance counters: core code
Date: Fri, 5 Dec 2008 21:55:18 +1100
Message-ID: <18745.2198.389098.296393@cargo.ozlabs.ibm.com>
References: <20081204225345.654705757@linutronix.de>
	<20081204230228.470613892@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38437 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbYLEKzZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Dec 2008 05:55:25 -0500
In-Reply-To: <20081204230228.470613892@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

Thomas Gleixner writes:

> +static void
> +perf_install_in_context(struct perf_counter_context *ctx,
> +			struct perf_counter *counter,
> +			int cpu)
> +{
> +	struct task_struct *task = ctx->task;
> +

[...]

> +	if (task) {
> +		task_oncpu_function_call(task, __perf_install_in_context,
> +					 counter);
> +	} else {
> +		smp_call_function_single(cpu, __perf_install_in_context,
> +					 counter, 1);
> +	}

What happens if we send an IPI to the cpu where the task is running,
but by the time the IPI arrives, the task has been migrated to another
cpu and is now running there?  Do you chase after it and send another
IPI to its new cpu, or is there some reason why it can't migrate?
If it's the former, where is that code?  I haven't seen it so far (at
least, task_oncpu_function_call doesn't seem to do it).

Paul.
