Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:56232 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751337AbcFXR3I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2016 13:29:08 -0400
Date: Fri, 24 Jun 2016 13:29:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH] ftrace: Reduce size of function graph entries
Message-ID: <20160624132904.1a94c0fc@gandalf.local.home>
In-Reply-To: <20160624161534.GA29064@danjae.aot.lge.com>
References: <1463930775-12214-1-git-send-email-namhyung@kernel.org>
	<20160623093740.638579af@gandalf.local.home>
	<20160624063543.GA1607@sejong>
	<20160624120440.3961bb05@gandalf.local.home>
	<20160624161534.GA29064@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160624172904.sIglTMa9QMIJxlGXXoavddBEcxsWKIglFfnau4JEw7U@z>

On Sat, 25 Jun 2016 01:15:34 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Fri, Jun 24, 2016 at 12:04:40PM -0400, Steven Rostedt wrote:
> > On Fri, 24 Jun 2016 15:35:44 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> >   
> > > > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > > > index dea12a6e413b..35c523ba5c59 100644
> > > > > --- a/include/linux/ftrace.h
> > > > > +++ b/include/linux/ftrace.h
> > > > > @@ -751,25 +751,33 @@ extern void ftrace_init(void);
> > > > >  static inline void ftrace_init(void) { }
> > > > >  #endif
> > > > >  
> > > > > +#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> > > > > +# define FTRACE_ALIGNMENT	4
> > > > > +#else
> > > > > +# define FTRACE_ALIGNMENT	8
> > > > > +#endif    
> > > > 
> 
> As far as I can see, the ring buffer has following code in ring_buffer.c:
> 
>   #define RB_ALIGNMENT		4U
>   #define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
>   #define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
> 
>   #ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
>   # define RB_FORCE_8BYTE_ALIGNMENT	0
>   # define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
>   #else
>   # define RB_FORCE_8BYTE_ALIGNMENT	1
>   # define RB_ARCH_ALIGNMENT		8U
>   #endif
> 
>   #define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
> 

Right, what I meant was that we should just define FTRACE_ALIGNMENT
unconditionally to 4. If CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set,
it will add the buffered space regardless.

You already moved "overrun", I don't see anything that would be out of
alignment if the structure itself is aligned.

-- Steve
