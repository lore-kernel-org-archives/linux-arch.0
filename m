From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] tracing: add support for tracing MMIO helpers
Date: Fri, 29 Apr 2016 23:29:50 +0200
Message-ID: <20160429212950.GA3846@debian>
References: <1461697482-32406-1-git-send-email-rabin@rab.in>
 <6253918.VUpbMrMy7R@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6253918.VUpbMrMy7R@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 26, 2016 at 09:14:47PM +0200, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 21:04:42 Rabin Vincent wrote:
> > The support is added via <asm-generic/io.h> and as such is only
> > available on the archs which use that header.
> 
> Why that limitation? I think only few architectures use it. Maybe
> at least enable it for x86 as well?

Seems to work to on x86 (and presumably other archs as well, not tested
yet) to insert the include into linux/io.h instead of asm-generic/io.h.

> 
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index e45db6b0d878..feca834436c5 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -372,6 +372,22 @@ config STACK_TRACER
> >  
> >  	  Say N if unsure.
> >  
> > +config TRACE_MMIO_HELPERS
> > +       bool "Support for tracing MMIO helpers"
> > +       select GENERIC_TRACER
> 
> How about putting a whitelist of architectures here that are including
> the necessary definitions? Or better, a HAVE_TRACE_MMIO_HELPERS
> symbol that gets selected by architectures and that this depends on?

If it works with linux/io.h we won't need to restrict it to specific
archs, otherwise I'll add a symbol as you suggest.

> > +#define DEFINE_MMIO_RW_TRACE(c, type)					\
> > +type read ## c ## _trace(const volatile void __iomem *addr,		\
> > +		    const char *addrexp, bool relaxed,			\
> > +		    unsigned long caller)				\
> > +{									\
> > +	type value;							\
> > +									\
> > +	if (relaxed)							\
> > +		value = read ## c ## _relaxed_notrace(addr);		\
> > +	else								\
> > +		value = read ## c ## _notrace(addr);			\
> > +									\
> > +	trace_mmio_read(addr, addrexp, value,				\
> > +			sizeof(value), relaxed, caller);		\
> > +									\
> > +	return value;							\
> > +}									\
> > +									\
> 
> We have a number of other accessors that are commonly used:
> 
> {ioread,iowrite}{8,16,32,64}{,_be}

I'll make the code handle these.

> {in,out}{b,w,l,q}

These are port-mapped IO accesors, aren't they?  They don't even take
pointer arguments so mmio:* tracepoints don't seem appropriate for them?

> {hi_lo_,lo_hi_}{read,write}q

There's only a single definition of these and that is in terms of
writel()/readl() so they should be coverd by the readl/writel case.
