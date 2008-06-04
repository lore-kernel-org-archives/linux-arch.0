From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:19:27 +1000
Message-ID: <200806041219.28099.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <200806031416.18195.nickpiggin@yahoo.com.au> <alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp111.mail.mud.yahoo.com ([209.191.84.64]:46118 "HELO
	smtp111.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751311AbYFDCTp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jun 2008 22:19:45 -0400
In-Reply-To: <alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Wednesday 04 June 2008 00:47, Linus Torvalds wrote:
> On Tue, 3 Jun 2008, Nick Piggin wrote:
> > Linus: on x86, memory operations to wc and wc+ memory are not ordered
> > with one another, or operations to other memory types (ie. load/load
> > and store/store reordering is allowed). Also, as you know, store/load
> > reordering is explicitly allowed as well, which covers all memory
> > types. So perhaps it is not quite true to say readl/writel is strongly
> > ordered by default even on x86. You would have to put in some
> > mfence instructions in them to make it so.
>
> Well, you have to ask for WC/WC+ anyway, so it's immaterial. A driver that
> does that needs to be aware of it. IOW, it's a non-issue, imnsho.

Ah, yes UC is strongly ordered WRT all others *except* WC/WC+.

But WC memory is not an x86 specific thing right, so do we need
some accessors for WC memory? Or can we just throw that in the
weakly ordered pile, and ensure mb/rmb/wmb does the right thing
for them.

And you want readl/writel to be strongly ordered like x86 on all
architectures, no exceptions? This will slow some things down,
but if we then also provide explicitly weakly ordered instructions
(and add io_mb/io_rmb/io_wmb) then at least it gives the framework
for drivers to be written to run on those architectures.

The other thing we could do is mandate only that readl/writel will
be ordered WRT one another, *and* with spinlocks, but otherwise not
with cacheable RAM...
