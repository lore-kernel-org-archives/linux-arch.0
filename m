From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 14:33:11 +1000
Message-ID: <200806031433.12460.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <20080531075242.GC108600@sgi.com> <4843C3D7.7000609@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp119.mail.mud.yahoo.com ([209.191.84.76]:48301 "HELO
	smtp119.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751658AbYFCEd0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jun 2008 00:33:26 -0400
In-Reply-To: <4843C3D7.7000609@sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

On Monday 02 June 2008 19:56, Jes Sorensen wrote:
> Jeremy Higdon wrote:
> > We don't actually have that problem on the Altix.  All writes issued
> > by CPU X will be ordered with respect to each other.  But writes by
> > CPU X and CPU Y will not be, unless an mmiowb() is done by the
> > original CPU before the second CPU writes.  I.e.
> >
> > 	CPU X	writel
> > 	CPU X	writel
> > 	CPU X	mmiowb
> >
> > 	CPU Y	writel
> > 	...
> >
> > Note that this implies some sort of locking.  Also note that if in
> > the above, CPU Y did the mmiowb, that would not work.
>
> Hmmm,
>
> Then it's less bad than I thought - my apologies for the confusion.
>
> Would we be able to use Ben's trick of setting a per cpu flag in
> writel() then and checking that in spin unlock issuing the mmiowb()
> there if needed?

Yes you could, but your writels would still not be strongly ordered
within (or outside) spinlock regions, which is what Linus wants (and
I kind of agree with).

This comes back to my posting about mmiowb and io_*mb barriers etc.

Despite what you say, what you've done really _does_ change the semantics
of wmb() for all drivers. It is a really sad situation we've got ourselves
into somehow, AFAIKS in the hope of trying to save ourselves a tiny bit
of work upfront :( (this is not just the sgi folk with mmiowb I'm talking
about, but the whole random undefinedness of ordering and io barriers).

The right way to make any change is never to weaken the postcondition of
an existing interface *unless* you are willing to audit the entire tree
and fix it. Impossible for drivers, so the correct thing to do is introduce
a new interface, and move things over at an easier pace. Not rocket science.

The argument that "Altix only uses a few drivers so this way we can just
fix these up rather than make big modifications to large numbers of drivers"
is bogus. It is far worse even for Altix if you make incompatible changes,
because you first *break* every driver on your platform, then you have to
audit and fix them. If you make compatible changes, then you have to do
exactly the same audits to move them over to the new API, but you go from
slower->faster rather than broken->non broken. As a bonus, you haven't
got random broken stuff all over the tree that you forgot to audit.

I don't know how there is still so much debate about this :(

I have a proposal: I am a neutral party here, not being an arch maintainer,
so I'll take input and write up a backward compatible API specification
and force everybody to conform to it ;)
