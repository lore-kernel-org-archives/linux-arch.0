Return-Path: <linux-arch-owner@vger.kernel.org>
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Date: Tue, 22 Mar 2005 10:24:50 -0800
References: <20050321150619.2ea75257.davem@davemloft.net> <20050322160324.GA4980@krispykreme> <200503221015.57732.jbarnes@engr.sgi.com>
In-Reply-To: <200503221015.57732.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221024.50311.jbarnes@engr.sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday, March 22, 2005 10:15 am, Jesse Barnes wrote:
> > 2. drivers/net/typhoon.c
> >
> >                 INIT_COMMAND_NO_RESPONSE(cmd, TYPHOON_CMD_HELLO_RESP);
> >                 smp_wmb();
> >                 writel(ring->lastWrite, tp->ioaddr +
> > TYPHOON_REG_CMD_READY);
>
> I think this is the same as (3) below, since the first line is writing
> memory. So I'd agree that we need an I/O vs. memory barrier of some sort
> for platforms like ppc64 where they can be reordered independently.

I should clarify this: if both of the stores above are to I/O space and the 
CPU reorders them even coming from the same CPU (since I assume the above is 
in a critical section), you've got a broken CPU, don't you?  I mean, stores 
to I/O space are usually done with 'volatile' semantics, which on ia64 at 
least means that they're ordered wrt one another, so the memory barrier above 
wouldn't be necessary (again, assuming they're both writing to I/O space).

If your platform doesn't do this, I'd expect lots more problems since it seems 
that the majority of driver code assumes strong memory ordering to I/O space.

Jesse
