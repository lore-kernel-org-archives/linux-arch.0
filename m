Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 23 Mar 2005 03:03:24 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Message-ID: <20050322160324.GA4980@krispykreme>
References: <20050321150619.2ea75257.davem@davemloft.net> <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com> <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> > Would it be worth renaming the mb/rmb/wmb to io_mb/io_rmb/io_wmb?
> > After all, I believe they should only be used to flush I/O memory
> > accesses. This would, I think, make the distinction between memory
> > barriers for I/O and memory barriers for SMP more obvious.
> 
> Are you joking or genuinely confused?

To be fair there are a lot of confused people out there. A few examples:

1. My original patch showed there are a number of places we use memory
barriers on UP when not required. Getting rid of mb/rmb/wmb would help
this, people are unlikely to sprinkle io_mb in the scheduler code :)

2. drivers/net/typhoon.c

                INIT_COMMAND_NO_RESPONSE(cmd, TYPHOON_CMD_HELLO_RESP);
                smp_wmb();
                writel(ring->lastWrite, tp->ioaddr + TYPHOON_REG_CMD_READY);

it looks a lot like smp_wmb is being used to order IO.

3. On ppc64 we recently had to upgrade our barriers to make sure
mb/wmb/rmb ordered IO. This is because drivers do this (example taken
from e1000):

        tx_desc->lower.data |= cpu_to_le32(adapter->txd_cmd);

        /* Force memory writes to complete before letting h/w
         * know there are new descriptors to fetch.  (Only
         * applicable for weak-ordered memory model archs,
         * such as IA-64). */
        wmb();

        tx_ring->next_to_use = i;
        E1000_WRITE_REG(&adapter->hw, TDT, i);

Renaming mb/wmb/rmb to io_mb/io_wmb/io_rmb would fit in well here.

4. Its not clear other architectures are insuring wmb/rmb/mb are
ordering IO. Checking ia64:

 * Note: "mb()" and its variants cannot be used as a fence to order
 * accesses to memory mapped I/O registers.  For that, mf.a needs to
 * be used.  However, we don't want to always use mf.a because (a)
 * it's (presumably) much slower than mf and (b) mf.a is supported for
 * sequential memory pages only.

Anton
