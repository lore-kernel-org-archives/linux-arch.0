From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Software prefetching considered harmful
Date: Fri, 20 May 2011 11:42:49 +1000
Message-ID: <1305855769.7481.114.camel@pasglop>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
	 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47634 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934716Ab1ETBnV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2011 21:43:21 -0400
In-Reply-To: <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>

On Thu, 2011-05-19 at 12:05 -0700, Linus Torvalds wrote:
> On Thu, May 19, 2011 at 10:12 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Now, notice that right now I'm *only* talking about removing it for
> > the "hlist" cases (patch attached). I suspect we should do the same
> > thing for all the list helpers.
> 
> Actually, it's the "rcu" versions of the hlist helpers that need this
> most, since those are the performance-critical ones and the ones used
> in avc traversal. So the previous patch did nothing.
> 
> So here's the actual patch I think I should commit.
> 
> Added davem, benh and rmk explicitly - I think you're on linux-arch,
> but still..  You may have machines that like prefetch more, although I
> think the "pollute the L1 cache" issue means that even if  you don't
> have the NULL pointer microtrap issue you'll still find this actually
> performs better..

Asked our local performance god:

Anton Blanchard: yeah we found this 5 years ago, i thought intel were filtering null prefetches
Anton Blanchard: turns out they werent. funny

:-)

Cheers,
Ben.
