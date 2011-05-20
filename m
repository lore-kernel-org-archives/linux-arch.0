From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Software prefetching considered harmful
Date: Fri, 20 May 2011 10:34:42 +0200
Message-ID: <20110520083442.GB22802@elte.hu>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
 <1305855769.7481.114.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38818 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934960Ab1ETIey (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 May 2011 04:34:54 -0400
Content-Disposition: inline
In-Reply-To: <1305855769.7481.114.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2011-05-19 at 12:05 -0700, Linus Torvalds wrote:
> > On Thu, May 19, 2011 at 10:12 AM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Now, notice that right now I'm *only* talking about removing it for
> > > the "hlist" cases (patch attached). I suspect we should do the same
> > > thing for all the list helpers.
> > 
> > Actually, it's the "rcu" versions of the hlist helpers that need this
> > most, since those are the performance-critical ones and the ones used
> > in avc traversal. So the previous patch did nothing.
> > 
> > So here's the actual patch I think I should commit.
> > 
> > Added davem, benh and rmk explicitly - I think you're on linux-arch,
> > but still..  You may have machines that like prefetch more, although I
> > think the "pollute the L1 cache" issue means that even if  you don't
> > have the NULL pointer microtrap issue you'll still find this actually
> > performs better..
> 
> Asked our local performance god:
> 
> Anton Blanchard: yeah we found this 5 years ago, i thought intel were filtering null prefetches
> Anton Blanchard: turns out they werent. funny
> 
> :-)

Yeah, over the past 10 years we have been suffering from an increasing level of 
blindness in the area of x86 performance analysis. Our old tools gradually 
deteriorated, the hardware got smarter and more parallel and it was harder and 
harder to see what happens. The 32-bit/64-bit split did not help us stay 
focused either. I think i warned about this 4-5 years ago at a KS.

This has improved meanwhile, we now have better tools (*wink* :) and have a 
good performance monitoring model (*wink* :) and people are again looking at 
the fine details and i think we now have a good chance to speed up the kernel 
again and keep it fast - and not just on PowerPC which has its envied Olympus 
of performance gods! :-)

Watching out for performance is a fundamentally critical mass thing: for a long 
time it seems a Sisyphean task with little progress, then it just happens very 
quickly.

Thanks,

	Ingo
