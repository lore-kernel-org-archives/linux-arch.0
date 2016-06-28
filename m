From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH v2] ftrace: Reduce size of function graph entries
Date: Tue, 28 Jun 2016 19:32:00 -0400
Message-ID: <20160628193200.71629fc5@gandalf.local.home>
References: <1467091840-4625-1-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467091840-4625-1-git-send-email-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 28 Jun 2016 14:30:40 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Currently ftrace_graph_ent{,_entry} and ftrace_graph_ret{,_entry} struct
> can have padding bytes at the end due to alignment in 64-bit data type.
> As these data are recorded so frequently, those paddings waste
> non-negligible space.  As some archs can have efficient unaligned
> accesses, reducing the alignment can save ~10% of data size:
> 
>   ftrace_graph_ent_entry:  24 -> 20
>   ftrace_graph_ret_entry:  48 -> 44
> 
> Also I moved the 'overrun' field in struct ftrace_graph_ret to minimize
> the padding.  I think the FTRACE_ALIGNMENT still needs to have proper
> alignment (even if ring buffer handles the alignment after all) since
> the ftrace_graph_ent/ret struct is located on stack before copying to
> the ring buffer.

I don't know. I mean it doesn't hurt to keep the alignment, but I'm
still thinking that it's overkill. All elements will start on their
proper alignment anyway.

Think about it, we have:

For 32bit:

  struct ftrace_graph_ret {
  	unsigned long func; /* Current function */

is at 0-3

  	/* Number of functions that overran the depth limit for current task */
  	unsigned long overrun;

is at 4-7

	unsigned long long calltime;

is at 8-15

	unsigned long long rettime;
is at 16-23

  	int depth;

is at 24-28

And for 64bit:

  struct ftrace_graph_ret {
  	unsigned long func; /* Current function */

is at 0-7

  	/* Number of functions that overran the depth limit for current task */
  	unsigned long overrun;

is at 8-15

	unsigned long long calltime;

is at 16-23

	unsigned long long rettime;

is at 24-31

  	int depth;

is at 32-37

For a total of 38 bytes. I'm betting that without the packed, the 4
extra bytes will always be at the end.

If the compiler places it incorrectly without any attribute, it will
fail to read the long long if the arch requires 64 bits to be 8 bytes
aligned. The alignment is meaningless here. All we need is "packed" and
be done with it. It's only going to truncate the 4 bytes at the end of
the structure if that.


-- Steve

> 
> Tested on x86_64 only.
> 
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/ftrace.h       | 16 ++++++++++++----
>  kernel/trace/trace.h         | 11 +++++++++++
>  kernel/trace/trace_entries.h |  4 ++--
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index dea12a6e413b..a86cdf167419 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -751,25 +751,33 @@ extern void ftrace_init(void);
>  static inline void ftrace_init(void) { }
>  #endif
>  
> +#ifdef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> +# define FTRACE_ALIGNMENT	8
> +#else
> +# define FTRACE_ALIGNMENT	4
> +#endif
> +
> +#define FTRACE_ALIGN_DATA	__attribute__((packed, aligned(FTRACE_ALIGNMENT)))
> +
>  /*
>   * Structure that defines an entry function trace.
>   */
>  struct ftrace_graph_ent {
>  	unsigned long func; /* Current function */
>  	int depth;
> -};
> +} FTRACE_ALIGN_DATA;
>  
>  /*
>   * Structure that defines a return function trace.
>   */
>  struct ftrace_graph_ret {
>  	unsigned long func; /* Current function */
> -	unsigned long long calltime;
> -	unsigned long long rettime;
>  	/* Number of functions that overran the depth limit for current task */
>  	unsigned long overrun;
> +	unsigned long long calltime;
> +	unsigned long long rettime;
>  	int depth;
> -};
> +} FTRACE_ALIGN_DATA;
>  
>  /* Type of the callback handlers for tracing function graph*/
>  typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *); /* return */
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5167c366d6b7..d2dd49ca55ee 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -80,6 +80,12 @@ enum trace_type {
>  	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
>  		     filter)
>  
> +#undef FTRACE_ENTRY_PACKED
> +#define FTRACE_ENTRY_PACKED(name, struct_name, id, tstruct, print,	\
> +			    filter)					\
> +	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
> +		     filter) FTRACE_ALIGN_DATA
> +
>  #include "trace_entries.h"
>  
>  /*
> @@ -1600,6 +1606,11 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
>  #define FTRACE_ENTRY_DUP(call, struct_name, id, tstruct, print, filter)	\
>  	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
>  		     filter)
> +#undef FTRACE_ENTRY_PACKED
> +#define FTRACE_ENTRY_PACKED(call, struct_name, id, tstruct, print, filter) \
> +	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
> +		     filter)
> +
>  #include "trace_entries.h"
>  
>  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_FUNCTION_TRACER)
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index ee7b94a4810a..5c30efcda5e6 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -72,7 +72,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>  );
>  
>  /* Function call entry */
> -FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
> +FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>  
>  	TRACE_GRAPH_ENT,
>  
> @@ -88,7 +88,7 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
>  );
>  
>  /* Function return entry */
> -FTRACE_ENTRY(funcgraph_exit, ftrace_graph_ret_entry,
> +FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  
>  	TRACE_GRAPH_RET,
>  
