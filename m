From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH] ftrace: Reduce size of function graph entries
Date: Fri, 24 Jun 2016 12:04:40 -0400
Message-ID: <20160624120440.3961bb05@gandalf.local.home>
References: <1463930775-12214-1-git-send-email-namhyung@kernel.org>
	<20160623093740.638579af@gandalf.local.home>
	<20160624063543.GA1607@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:44669 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751185AbcFXQEo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2016 12:04:44 -0400
In-Reply-To: <20160624063543.GA1607@sejong>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, 24 Jun 2016 15:35:44 +0900
Namhyung Kim <namhyung@kernel.org> wrote:


> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index dea12a6e413b..35c523ba5c59 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -751,25 +751,33 @@ extern void ftrace_init(void);
> > >  static inline void ftrace_init(void) { }
> > >  #endif
> > >  
> > > +#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> > > +# define FTRACE_ALIGNMENT	4
> > > +#else
> > > +# define FTRACE_ALIGNMENT	8
> > > +#endif  
> > 
> > Swap the above. Having the #ifndef is more confusing to understand than
> > to have a #ifdef.  
> 
> Will do.
> 
> >   
> > > +
> > > +#define FTRACE_ALIGN_DATA	__attribute__((packed, aligned(FTRACE_ALIGNMENT)))  
> > 
> > Do we really need to pack it? I mean, just get rid of the hole (like
> > you did with the movement of the overrun) and shouldn't the array be
> > aligned normally without holes, if the arch can support it? Doesn't gcc
> > take care of that?  
> 
> I'm not sure I understood you correctly.  AFAIK the size of struct is
> a multiple of alignment unit and gcc manual says the aligment
> attribute only can be increased unless the 'packed' is used as well..

Ah, I see you are trying to get the recorded size in the array down to
a 4 byte alignment (due to the "int depth"), instead of adding the 4
bytes to the buffer.

Hmm, I wondering if we need the ifdef above, as the ring buffer itself
will force the 8 byte alignment of structures added to the buffer.

-- Steve
