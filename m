From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface
 for RCU changes
Date: Wed, 12 Feb 2020 18:28:30 -0500
Message-ID: <20200212232830.GB170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41901 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgBLX2o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 18:28:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id d11so3881537qko.8
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 15:28:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200212210750.142334759@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, "Steven Rostedt (VMware)" <rosted@goodmis.org>

On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> The tracepoint interface will stop providing regular RCU context; make
> sure we do it ourselves, since perf makes use of regular RCU protected
> data.
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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

The flags are not needed I guess, if you agree on not using in_nmi() in
trace_rcu_enter().

thanks,

 - Joel


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
> 
