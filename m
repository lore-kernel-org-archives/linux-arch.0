Return-Path: <linux-arch-owner@vger.kernel.org>
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Date: Tue, 22 Mar 2005 10:15:57 -0800
References: <20050321150619.2ea75257.davem@davemloft.net> <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk> <20050322160324.GA4980@krispykreme>
In-Reply-To: <20050322160324.GA4980@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221015.57732.jbarnes@engr.sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday, March 22, 2005 8:03 am, Anton Blanchard wrote:
> > > Would it be worth renaming the mb/rmb/wmb to io_mb/io_rmb/io_wmb?
> > > After all, I believe they should only be used to flush I/O memory
> > > accesses. This would, I think, make the distinction between memory
> > > barriers for I/O and memory barriers for SMP more obvious.
> >
> > Are you joking or genuinely confused?
>
> To be fair there are a lot of confused people out there. A few examples:
>
> 1. My original patch showed there are a number of places we use memory
> barriers on UP when not required. Getting rid of mb/rmb/wmb would help
> this, people are unlikely to sprinkle io_mb in the scheduler code :)
>
> 2. drivers/net/typhoon.c
>
>                 INIT_COMMAND_NO_RESPONSE(cmd, TYPHOON_CMD_HELLO_RESP);
>                 smp_wmb();
>                 writel(ring->lastWrite, tp->ioaddr +
> TYPHOON_REG_CMD_READY);

I think this is the same as (3) below, since the first line is writing memory.  
So I'd agree that we need an I/O vs. memory barrier of some sort for 
platforms like ppc64 where they can be reordered independently.

>
> it looks a lot like smp_wmb is being used to order IO.
>
> 3. On ppc64 we recently had to upgrade our barriers to make sure
> mb/wmb/rmb ordered IO. This is because drivers do this (example taken
> from e1000):
>
>         tx_desc->lower.data |= cpu_to_le32(adapter->txd_cmd);
>
>         /* Force memory writes to complete before letting h/w
>          * know there are new descriptors to fetch.  (Only
>          * applicable for weak-ordered memory model archs,
>          * such as IA-64). */
>         wmb();
>
>         tx_ring->next_to_use = i;
>         E1000_WRITE_REG(&adapter->hw, TDT, i);
>
> Renaming mb/wmb/rmb to io_mb/io_wmb/io_rmb would fit in well here.

Yep.

> 4. Its not clear other architectures are insuring wmb/rmb/mb are
> ordering IO. Checking ia64:
>
>  * Note: "mb()" and its variants cannot be used as a fence to order
>  * accesses to memory mapped I/O registers.  For that, mf.a needs to
>  * be used.  However, we don't want to always use mf.a because (a)
>  * it's (presumably) much slower than mf and (b) mf.a is supported for
>  * sequential memory pages only.

Right.  And then there's pure I/O ordering, which as James pointed out can be 
implemented with mmiowb.  So let's see, we have

memory vs. memory writes: smp_wmb()
I/O vs. I/O writes: mmiowb() (and/or io_wmb()?)
memory vs. I/O writes: io_wmb()

right?  And for reads:

memory vs. memory reads: smp_rmb
I/O vs. I/O reads: io_rmb()?
memory vs. I/O reads: io_rmb()

Is that an accurate summary?

Jesse
