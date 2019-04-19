Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfDSS3Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Date: Fri, 19 Apr 2019 09:28:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch V2 22/29] tracing: Make ftrace_trace_userstack() static
 and conditional
Message-ID: <20190419092823.094a6061@gandalf.local.home>
In-Reply-To: <20190418084255.088813838@linutronix.de>
References: <20190418084119.056416939@linutronix.de>
        <20190418084255.088813838@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190419132823.ZS9XHJ8TffhLKm4qOyyeNxxBEiCkb7BRYlqNuJYJ8vg@z>

On Thu, 18 Apr 2019 10:41:41 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> It's only used in trace.c and there is absolutely no point in compiling it
> in when user space stack traces are not supported.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Funny, these were moved out to global functions along with the
ftrace_trace_stack() but I guess they were never used.

This basically just does a partial revert of:

 c0a0d0d3f6528 ("tracing/core: Make the stack entry helpers global")


> ---
>  kernel/trace/trace.c |   14 ++++++++------
>  kernel/trace/trace.h |    8 --------
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -159,6 +159,8 @@ static union trace_eval_map_item *trace_
>  #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
>  
>  static int tracing_set_tracer(struct trace_array *tr, const char *buf);
> +static void ftrace_trace_userstack(struct ring_buffer *buffer,
> +				   unsigned long flags, int pc);
>  
>  #define MAX_TRACER_SIZE		100
>  static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
> @@ -2905,9 +2907,10 @@ void trace_dump_stack(int skip)
>  }
>  EXPORT_SYMBOL_GPL(trace_dump_stack);
>  
> +#ifdef CONFIG_USER_STACKTRACE_SUPPORT
>  static DEFINE_PER_CPU(int, user_stack_count);
>  
> -void
> +static void
>  ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
>  {
>  	struct trace_event_call *call = &event_user_stack;
> @@ -2958,13 +2961,12 @@ ftrace_trace_userstack(struct ring_buffe
>   out:
>  	preempt_enable();
>  }
> -
> -#ifdef UNUSED

Strange, I never knew about this ifdef. I would have nuked it when I
saw it.

Anyway,

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> -static void __trace_userstack(struct trace_array *tr, unsigned long flags)
> +#else /* CONFIG_USER_STACKTRACE_SUPPORT */
> +static void ftrace_trace_userstack(struct ring_buffer *buffer,
> +				   unsigned long flags, int pc)
>  {
> -	ftrace_trace_userstack(tr, flags, preempt_count());
>  }
> -#endif /* UNUSED */
> +#endif /* !CONFIG_USER_STACKTRACE_SUPPORT */
>  
>  #endif /* CONFIG_STACKTRACE */
>  
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -782,17 +782,9 @@ void update_max_tr_single(struct trace_a
>  #endif /* CONFIG_TRACER_MAX_TRACE */
>  
>  #ifdef CONFIG_STACKTRACE
> -void ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags,
> -			    int pc);
> -
>  void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
>  		   int pc);
>  #else
> -static inline void ftrace_trace_userstack(struct ring_buffer *buffer,
> -					  unsigned long flags, int pc)
> -{
> -}
> -
>  static inline void __trace_stack(struct trace_array *tr, unsigned long flags,
>  				 int skip, int pc)
>  {
> 
