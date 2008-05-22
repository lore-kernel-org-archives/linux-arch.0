From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [rfc] add io barriers, remove mmiowb
Date: Thu, 22 May 2008 09:34:07 -0700
Message-ID: <200805220934.07871.jbarnes@virtuousgeek.org>
References: <20080521152855.GE8897@wotan.suse.de> <20080522095121.GA18012@wotan.suse.de> <483566E7.8010703@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-131.bluehost.com ([67.222.39.21]:34845 "HELO
	outbound-mail-131.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754774AbYEVQk6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 May 2008 12:40:58 -0400
In-Reply-To: <483566E7.8010703@sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thursday, May 22, 2008 5:28 am Jes Sorensen wrote:
> Nick Piggin wrote:
> > Right, but probably the large majority of wmb() callers actually
> > just want io_wmb(). This would relieve much of the performance
> > problem, I'd say.
> >
> > Of those that really want a wmb() and cannot be converted to
> > io_wmb(), I don't think it is a good option to actually just weaken
> > wmb() because we deem that doing what the caller asked for is too
> > expensive.
>
> Hi Nick,
>
> I believe there's a fair number of places where wmb() is used for
> memory ordering not related to IO.
>
> > I guess with the ia64_mf(), Altix probably does not reorder PCI
> > stores past earlier cacheable stores, so _some_ wmb()s actually
> > do not require the full mmiowb case (if we only need to order
> > an earlier RAM store with a later PCI store). However, again,
> > weakening wmb() is not a good option because it really requires
> > an audit of the entire tree to do that.
>
> Nope, unfortunately not, ia64_mf() isn't strong enough to prevent the
> reordering, it's done in the PCI controller, so in order to guarantee
> the the reording you have to go all the way out to the PCI controller,
> which is very slow.

And more than that, the local PCI controller has to wait for any outstanding 
writes to arrive at the target host bridge.  That's why the operation is so 
expensive.

> > We _could_ introduce partial barriers like store/iostore iostore/store,
> > but really, I think the io_wmb is a pretty good first step, and I
> > haven't actually seen any numbers indicating it would be a performance
> > problem.
>
> I must admit I am not 100% upto speed on the entire discussion, but I
> think the io_wmb() and friends did go around in the past and got shot
> down.

To be fair to the ia64 guys who pushed this (me), I think the powerpc guys 
were supposed to introduce the other set of barriers they needed at around 
the same time, so we'd have the complete set.  I guess they never got around 
to it.

Given that core kernel code using wmb() usually doesn't care about I/O 
ordering, making it into a heavyweight operation might be a bad idea, 
especially if powerpc wants to weaken its wmb() operations eventually.

Is there really a conflict of definitions except for between ia64 and powerpc 
here?  IIRC they needed more types of barriers to speed things up, but never 
introduced them, and so had to make some of the existing barriers much more 
expensive than they would have liked...

Jesse
