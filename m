From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 18:19:05 +1000
Message-ID: <200806031819.06559.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <200806031433.12460.nickpiggin@yahoo.com.au> <20080603081552.GC117059@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp116.mail.mud.yahoo.com ([209.191.84.165]:37135 "HELO
	smtp116.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751228AbYFCITU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jun 2008 04:19:20 -0400
In-Reply-To: <20080603081552.GC117059@sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jes Sorensen <jes@sgi.com>, Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

On Tuesday 03 June 2008 18:15, Jeremy Higdon wrote:
> On Tue, Jun 03, 2008 at 02:33:11PM +1000, Nick Piggin wrote:
> > On Monday 02 June 2008 19:56, Jes Sorensen wrote:

> > > Would we be able to use Ben's trick of setting a per cpu flag in
> > > writel() then and checking that in spin unlock issuing the mmiowb()
> > > there if needed?
> >
> > Yes you could, but your writels would still not be strongly ordered
> > within (or outside) spinlock regions, which is what Linus wants (and
> > I kind of agree with).
>
> Yes they would be.  Writes from the same CPU are always ordered.  Writes
> from different CPUs are not, but that's only a concern if you protect

They are not strongly ordered WRT writes to cacheable memory. If they
were, then they would not leak out of spinlocks.
