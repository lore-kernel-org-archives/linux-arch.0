Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Mar 2005 16:34:28 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Message-ID: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk>
References: <20050321150619.2ea75257.davem@davemloft.net> <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com> <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk> <20050322160324.GA4980@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322160324.GA4980@krispykreme>
Sender: <willy@www.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Mar 23, 2005 at 03:03:24AM +1100, Anton Blanchard wrote:
> 
> > > Would it be worth renaming the mb/rmb/wmb to io_mb/io_rmb/io_wmb?
> > > After all, I believe they should only be used to flush I/O memory
> > > accesses. This would, I think, make the distinction between memory
> > > barriers for I/O and memory barriers for SMP more obvious.
> > 
> > Are you joking or genuinely confused?
> 
> To be fair there are a lot of confused people out there. A few examples:

Yep, and I'm one of them.  Never having worked on the alpha or sparc
ports, i'm pretty barrier-uneducated.  Let me recap my understanding
(and thanks to dhowells for our irc chat earlier) ...

 - barrier() is a *compiler* barrier.  It does not affect how the CPU
   reorders instructions.
 - wmb() ensure that other CPUs and devices doing DMA observe writes 
   to memory before the wmb() before the writes after the wmb()
 - rmb() ensures preceeding reads from memory complete before reads that
   come after the rmb()
 - mb() is the same as wmb(); rmb();
 - io_*mb() are equivalent, for io memory.
 - smp_*mb() no barrier on UP and specified barrier on SMP

> 1. My original patch showed there are a number of places we use memory
> barriers on UP when not required. Getting rid of mb/rmb/wmb would help
> this, people are unlikely to sprinkle io_mb in the scheduler code :)
> 
> 2. drivers/net/typhoon.c
> 
>                 INIT_COMMAND_NO_RESPONSE(cmd, TYPHOON_CMD_HELLO_RESP);
>                 smp_wmb();
>                 writel(ring->lastWrite, tp->ioaddr + TYPHOON_REG_CMD_READY);
> 
> it looks a lot like smp_wmb is being used to order IO.

This is a tricky one because I think we're writing to memory, then
writing the address of memory to IO.  So we need to ensure that memory
writes complete before the next IO write, right?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
