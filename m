From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC/PATCH] ftrace: Reduce size of function graph entries
Date: Fri, 24 Jun 2016 15:35:44 +0900
Message-ID: <20160624063543.GA1607@sejong>
References: <1463930775-12214-1-git-send-email-namhyung@kernel.org>
 <20160623093740.638579af@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:43722 "EHLO
	lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcFXGfr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2016 02:35:47 -0400
In-Reply-To: <20160623093740.638579af@gandalf.local.home>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Steve,

On Thu, Jun 23, 2016 at 09:37:40AM -0400, Steven Rostedt wrote:
> On Mon, 23 May 2016 00:26:15 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Currently ftrace_graph_ent{,_entry} and ftrace_graph_ret{,_entry} struct
> > can have padding bytes at the end due to alignment in 64-bit data type.
> > As these data are recorded so frequently, those paddings waste
> > non-negligible space.  As some archs can have efficient unaligned
> > accesses, reducing the alignment can save ~10% of data size:
> > 
> >   ftrace_graph_ent_entry:  24 -> 20
> >   ftrace_graph_ret_entry:  48 -> 44
> > 
> > Also I moved the 'overrun' field in struct ftrace_graph_ret to minimize
> > the padding.  Tested on x86_64 only.
> 
> I'd like to see this tested on other archs too.
> 
> [ Added linux-arch so maybe other arch maintainers may know about this ]

Thanks, it'd be great if anyone could try this.

I think it doesn't affect most of (64-bit) archs since only x86_64,
arm64 and powerpc define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS (and
it turns off CONFIG_HAVE_64BIT_ALIGNED_ACCESS).  So other archs still
have (same) 8-byte alignment requirement.

Do 32-bit archs really require 64-bit alignment for unsigned long
long?  IOW is it an alignment violation putting it in 32-bit boundary?


> 
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  include/linux/ftrace.h       | 16 ++++++++++++----
> >  kernel/trace/trace.h         | 11 +++++++++++
> >  kernel/trace/trace_entries.h |  4 ++--
> >  3 files changed, 25 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index dea12a6e413b..35c523ba5c59 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -751,25 +751,33 @@ extern void ftrace_init(void);
> >  static inline void ftrace_init(void) { }
> >  #endif
> >  
> > +#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> > +# define FTRACE_ALIGNMENT	4
> > +#else
> > +# define FTRACE_ALIGNMENT	8
> > +#endif
> 
> Swap the above. Having the #ifndef is more confusing to understand than
> to have a #ifdef.

Will do.

> 
> > +
> > +#define FTRACE_ALIGN_DATA	__attribute__((packed, aligned(FTRACE_ALIGNMENT)))
> 
> Do we really need to pack it? I mean, just get rid of the hole (like
> you did with the movement of the overrun) and shouldn't the array be
> aligned normally without holes, if the arch can support it? Doesn't gcc
> take care of that?

I'm not sure I understood you correctly.  AFAIK the size of struct is
a multiple of alignment unit and gcc manual says the aligment
attribute only can be increased unless the 'packed' is used as well..

Thanks,
Namhyung


> 
> -- Steve
> 
> > +
> >  /*
> >   * Structure that defines an entry function trace.
> >   */
> >  struct ftrace_graph_ent {
> >  	unsigned long func; /* Current function */
> >  	int depth;
> > -};
> > +} FTRACE_ALIGN_DATA;
> >  
> >  /*
> >   * Structure that defines a return function trace.
> >   */
> >  struct ftrace_graph_ret {
> >  	unsigned long func; /* Current function */
> > -	unsigned long long calltime;
> > -	unsigned long long rettime;
> >  	/* Number of functions that overran the depth limit for current task */
> >  	unsigned long overrun;
> > +	unsigned long long calltime;
> > +	unsigned long long rettime;
> >  	int depth;
> > -};
> > +} FTRACE_ALIGN_DATA;
> >  
> >  /* Type of the callback handlers for tracing function graph*/
> >  typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *); /* return */
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 5167c366d6b7..d2dd49ca55ee 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -80,6 +80,12 @@ enum trace_type {
> >  	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
> >  		     filter)
> >  
> > +#undef FTRACE_ENTRY_PACKED
> > +#define FTRACE_ENTRY_PACKED(name, struct_name, id, tstruct, print,	\
> > +			    filter)					\
> > +	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
> > +		     filter) FTRACE_ALIGN_DATA
> > +
> >  #include "trace_entries.h"
> >  
> >  /*
> > @@ -1600,6 +1606,11 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
> >  #define FTRACE_ENTRY_DUP(call, struct_name, id, tstruct, print, filter)	\
> >  	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
> >  		     filter)
> > +#undef FTRACE_ENTRY_PACKED
> > +#define FTRACE_ENTRY_PACKED(call, struct_name, id, tstruct, print, filter) \
> > +	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
> > +		     filter)
> > +
> >  #include "trace_entries.h"
> >  
> >  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_FUNCTION_TRACER)
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > index ee7b94a4810a..5c30efcda5e6 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -72,7 +72,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
> >  );
> >  
> >  /* Function call entry */
> > -FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
> > +FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> >  
> >  	TRACE_GRAPH_ENT,
> >  
> > @@ -88,7 +88,7 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
> >  );
> >  
> >  /* Function return entry */
> > -FTRACE_ENTRY(funcgraph_exit, ftrace_graph_ret_entry,
> > +FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
> >  
> >  	TRACE_GRAPH_RET,
> >  
> 
