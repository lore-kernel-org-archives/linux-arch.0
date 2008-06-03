From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 14:16:17 +1000
Message-ID: <200806031416.18195.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org> <20080602072403.GA20222@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754110AbYFCEQm@vger.kernel.org>
In-Reply-To: <20080602072403.GA20222@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com
List-Id: linux-arch.vger.kernel.org

On Monday 02 June 2008 17:24, Russell King wrote:
> On Tue, May 27, 2008 at 02:55:56PM -0700, Linus Torvalds wrote:
> > On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> > > A problem with __raw_ though is that they -also- don't do byteswap,
> >
> > Well, that's why there is __readl() and __raw_readl(), no?
> >
> > Neither does ordering, and __raw_readl() doesn't do byte-swap.
>
> This is where the lack of documentation causes arch maintainers a big
> problem.  None of the semantics of __raw_readl vs __readl vs readl are
> documented _anywhere_.  If you look at x86 as a template, there's no
> comments there about what the different variants are supposed to do
> or not do.
>
> So it's left up to arch maintainers to literally guess what should be
> done.  That's precisely what I did when I implemented ARMs __raw_readl
> and friends.  I guessed.
>
> And it was only after I read a few mails on lkml which suggested that
> readl and friends should always be LE that ARMs readl implementation
> started to use le32_to_cpu()... before that it had always been native
> endian.  Again, lack of documentation...
>
> So, can the semantics of what's expected from these IO accessor
> functions be documented somewhere.  Please?  Before this thread gets
> lost in the depths of time?

This whole thread also ties in with my posts about mmiowb (which IMO
should go away).

readl/writel:  strongly ordered wrt one another and other stores
               to cacheable RAM, byteswapping
__readl/__writel:  not ordered (needs mb/rmb/wmb to order with
                   other readl/writel and cacheable operations, or
                   io_*mb to order with one another)
raw_readl/raw_writel:  strongly ordered, no byteswapping
__raw_readl/__raw_writel:  not ordered, no byteswapping

then get rid of *relaxed* variants.

Linus: on x86, memory operations to wc and wc+ memory are not ordered
with one another, or operations to other memory types (ie. load/load
and store/store reordering is allowed). Also, as you know, store/load
reordering is explicitly allowed as well, which covers all memory
types. So perhaps it is not quite true to say readl/writel is strongly
ordered by default even on x86. You would have to put in some
mfence instructions in them to make it so.

So, what *exact* definition are you going to mandate for readl/writel?
Anything less than strict ordering then we also need to ensure drivers
use the correct barriers (to implement strict ordering, we could either
put mfence instructions in, or explicitly disallow readl/writel to be
used on wc/wc+ memory).

The other way we can go is just say that they have x86 semantics,
although that would be a bit sad IMO: we should have strong ops, in
which case driver writers never need to use a single barrier provided
they have locking right, and weak ops, in which case they should match
up with the weak Linux memory ordering model for system RAM.
