From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 17:18:42 +1000
Message-ID: <200806031718.43393.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <200806031611.13817.nickpiggin@yahoo.com.au> <18500.60032.989380.864674@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754797AbYFCHTO@vger.kernel.org>
In-Reply-To: <18500.60032.989380.864674@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, Russell King <rmk+lkml@arm.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com
List-Id: linux-arch.vger.kernel.org

On Tuesday 03 June 2008 16:53, Paul Mackerras wrote:
> Nick Piggin writes:
> > So your readl can pass an earlier cacheable store or earlier writel?
>
> No.  It's quite gross at the moment, it has a sync before the access
> (i.e. a full mb()) and a twi; isync sequence after the access that
> stalls execution until the data comes back.

OK.


> > > We don't provide meaningless ones like writel + cacheable store for
> > > example. (PCI posting would defeat it anyway).
> >
> > What do you mean by meaningless? Ordering of writel followed by a
> > cacheable store  is meaningful eg. for retaining io operations within
> > locks. OK, you explicitly have some extra code for spin_unlock, but
> > not for bit locks, mutexes, etc. It would make sense to have the
> > default operations _very_ strongly ordered IMO, and then move drivers
> > to be more relaxed when they are verified.
>
> It's meaningless in the sense that nothing guarantees that the writel
> has actually hit the device, even if we put a full mb() barrier in
> between the writel and the cacheable write.  That would guarantee that
> the writel had got to the PCI host bridge, and couldn't be reordered
> with other accesses to the device, but not that the device had
> actually seen it.

OK, but I think fits OK with our SMP ordering model for cacheable
stores: no amount of barriers on CPU0 will guarantee that CPU1 has
seen the store, you actually have to observe a causual effect
of the store before you can say that.


> I don't mind adding code to the mutex unlock to do the same as
> spin_unlock, but I really don't want to have *two* sync instructions
> for every MMIO write.  One is bad enough.

So you can't provide iostore/store ordering without another sync
after the writel store?

I guess the problem with providing exceptions is that it makes it
hard for people who absolutely don't know or care about ordering.
I don't like having to think about it "hmm, we can allow this type
of reordering... oh, unless some silly device does X...".

If we come up with a sane set of weakly ordered accessors
(including io_*mb()), it will make it easier to go through the
important drivers and improve them. We don't have to enforce the
the new semantics strictly until then if they'll slow you down
too much in the meantime.
