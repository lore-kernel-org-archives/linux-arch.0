Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk> 
References: <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>  <20050321150619.2ea75257.davem@davemloft.net> <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com> 
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion 
Date: Tue, 22 Mar 2005 14:27:04 +0000
Message-ID: <30642.1111501624@redhat.com>
Sender: dhowells@redhat.com
To: Matthew Wilcox <matthew@wil.cx>
Cc: "David S. Miller" <davem@davemloft.net>, Anton Blanchard <anton@samba.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox <matthew@wil.cx> wrote:

> > > If I remember correctly, the ?mb() routines _were_ the original
> > > SMP memory barriers.
> > 
> > Would it be worth renaming the mb/rmb/wmb to io_mb/io_rmb/io_wmb? After
> > all, I believe they should only be used to flush I/O memory accesses. This
> > would, I think, make the distinction between memory barriers for I/O and
> > memory barriers for SMP more obvious.
> 
> Are you joking or genuinely confused?

Must be the latter.

As far as I know memory barriers are only used for I/O and SMP. I don't see
where else they should be required.

Of course, the tiny bit of documentation in the kernel sources isn't much
help; it doesn't even mention the smp_*mb() functions.

David
