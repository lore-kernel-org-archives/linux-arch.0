From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 11 Jun 2008 13:29:35 +1000
Message-ID: <200806111329.35894.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <adaskvl3yb0.fsf@cisco.com> <200806101219.34995.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp118.mail.mud.yahoo.com ([209.191.84.167]:22829 "HELO
	smtp118.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754759AbYFKD3r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jun 2008 23:29:47 -0400
In-Reply-To: <200806101219.34995.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Roland Dreier <rdreier@cisco.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org

On Wednesday 11 June 2008 05:19, Jesse Barnes wrote:
> On Tuesday, June 10, 2008 12:05 pm Roland Dreier wrote:
> >  > me too.  That's the whole basis for readX_relaxed() and its cohorts:
> >  > we make our weirdest machines (like altix) conform to the x86 norm. 
> >  > Then where it really kills us we introduce additional semantics to
> >  > selected drivers that enable us to recover I/O speed on the abnormal
> >  > platforms.
> >
> > Except as I pointed out before, Altix doesn't conform to the norm and
> > many (most?) drivers are missing mmiowb()s that are needed for Altix.
> > Just no one has plugged most devices into an Altix (or haven't stressed
> > the driver in a way that exposes problems of IO ordering between CPUs).
> >
> > It would be a great thing to use the powerpc trick of setting a flag
> > that is tested by spin_unlock()/mutex_unlock() and automatically doing
> > the mmiowb() if needed, and then killing off mmiowb() entirely.
>
> Yeah I think that's what Nick's guidelines would guarantee.  And Jes is
> already working on the spin_unlock change you mentioned, so mmiowb() should
> be history soon (in name only, assuming Nick also introduces the I/O
> barriers he talked about for ordering the looser accessors it would still
> be there but would be called io_wmb or something).

Exactly, yes. I guess everybody has had good intentions here, but
as noticed, what is lacking is coordination and documentation.

You mention strong ordering WRT spin_unlock, which suggests that
you would prefer to take option #2 (the current powerpc one): io/io
is ordered and io is contained inside spinlocks, but io/cacheable
in general is not ordered.

I *would* prefer that io/cacheable actually is strongly ordered with
the default accessors. Because if you have that, then the driver
writer never has to care about memory ordering, provided they use
correct locking for SMP issues. Same as x86. With option 2, there
are still windows where you could possibly have issues.

For any high performance drivers that are well maintained (ie. the
ones where slowdown might be noticed), everyone should have a pretty
good handle on memory ordering requirements, so it shouldn't take
long to go through and convert them to relaxed accessors.
