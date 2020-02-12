Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgBLO06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 09:26:58 -0500
Date: Wed, 12 Feb 2020 09:26:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6/8] perf,tracing: Prepare the perf-trace interface for
 RCU changes
Message-ID: <20200212092655.4ba6cd79@gandalf.local.home>
In-Reply-To: <20200212094107.951346701@infradead.org>
References: <20200212093210.468391728@infradead.org>
        <20200212094107.951346701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200212142655.mZqKmjmy-lZHOudnCOjMyHLKJXxwZTzW0SOg0SCfQp0@z>

On Wed, 12 Feb 2020 10:32:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> The tracepoint interface will stop providing regular RCU context; make
> sure we do it ourselves, since perf makes use of regular RCU protected
> data.
> 

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>

  ;-)

-- Steve

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
>  {
>  	struct perf_sample_data data;
>  	struct perf_event *event;
> +	unsigned long rcu_flags;
>  
>  	struct perf_raw_record raw = {
>  		.frag = {
> @@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
>  	perf_sample_data_init(&data, 0, 0);
>  	data.raw = &raw;
>  
> +	rcu_flags = trace_rcu_enter();
> +
>  	perf_trace_buf_update(record, event_type);
>  
>  	hlist_for_each_entry_rcu(event, head, hlist_entry) {
> @@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
>  	}
>  
>  	perf_swevent_put_recursion_context(rctx);
> +
> +	trace_rcu_exit(rcu_flags);
>  }
>  EXPORT_SYMBOL_GPL(perf_tp_event);
>  
> 
