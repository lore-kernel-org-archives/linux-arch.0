From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC/PATCH] ftrace: Reduce size of function graph entries
Date: Sat, 25 Jun 2016 01:15:34 +0900
Message-ID: <20160624161534.GA29064@danjae.aot.lge.com>
References: <1463930775-12214-1-git-send-email-namhyung@kernel.org>
 <20160623093740.638579af@gandalf.local.home>
 <20160624063543.GA1607@sejong>
 <20160624120440.3961bb05@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34599 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcFXQQS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2016 12:16:18 -0400
Content-Disposition: inline
In-Reply-To: <20160624120440.3961bb05@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, Jun 24, 2016 at 12:04:40PM -0400, Steven Rostedt wrote:
> On Fri, 24 Jun 2016 15:35:44 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> 
> > > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > > index dea12a6e413b..35c523ba5c59 100644
> > > > --- a/include/linux/ftrace.h
> > > > +++ b/include/linux/ftrace.h
> > > > @@ -751,25 +751,33 @@ extern void ftrace_init(void);
> > > >  static inline void ftrace_init(void) { }
> > > >  #endif
> > > >  
> > > > +#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> > > > +# define FTRACE_ALIGNMENT	4
> > > > +#else
> > > > +# define FTRACE_ALIGNMENT	8
> > > > +#endif  
> > > 
> > > Swap the above. Having the #ifndef is more confusing to understand than
> > > to have a #ifdef.  
> > 
> > Will do.
> > 
> > >   
> > > > +
> > > > +#define FTRACE_ALIGN_DATA	__attribute__((packed, aligned(FTRACE_ALIGNMENT)))  
> > > 
> > > Do we really need to pack it? I mean, just get rid of the hole (like
> > > you did with the movement of the overrun) and shouldn't the array be
> > > aligned normally without holes, if the arch can support it? Doesn't gcc
> > > take care of that?  
> > 
> > I'm not sure I understood you correctly.  AFAIK the size of struct is
> > a multiple of alignment unit and gcc manual says the aligment
> > attribute only can be increased unless the 'packed' is used as well..
> 
> Ah, I see you are trying to get the recorded size in the array down to
> a 4 byte alignment (due to the "int depth"), instead of adding the 4
> bytes to the buffer.
> 
> Hmm, I wondering if we need the ifdef above, as the ring buffer itself
> will force the 8 byte alignment of structures added to the buffer.

As far as I can see, the ring buffer has following code in ring_buffer.c:

  #define RB_ALIGNMENT		4U
  #define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
  #define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */

  #ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
  # define RB_FORCE_8BYTE_ALIGNMENT	0
  # define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
  #else
  # define RB_FORCE_8BYTE_ALIGNMENT	1
  # define RB_ARCH_ALIGNMENT		8U
  #endif

  #define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)


Thanks,
Namhyung
