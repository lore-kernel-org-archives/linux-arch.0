Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20050322091331.7b2967a1.davem@davemloft.net>
References: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk>
	 <20050321150619.2ea75257.davem@davemloft.net>
	 <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com>
	 <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
	 <20050322160324.GA4980@krispykreme> <11333.1111510094@redhat.com>
	 <20050322091331.7b2967a1.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 11:44:23 -0600
Message-Id: <1111513463.5520.53.camel@mulgrave>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>, matthew@wil.cx, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-03-22 at 09:13 -0800, David S. Miller wrote:
> On Tue, 22 Mar 2005 16:48:14 +0000
> David Howells <dhowells@redhat.com> wrote:
> 
> > Matthew Wilcox <matthew@wil.cx> wrote:
> > 
> > >  - io_*mb() are equivalent, for io memory.
> > 
> > I don't think these actually exist at the moment. My suggestion was that we
> > rename {r,w,}mb() to io_{r,w,}mb().
> 
> This is the first time I've seen that ?mb() should order I/O
> accesses.  My sparc64 versions certainly don't handle that
> correctly.  :-)  That being said, I think we're all being
> educated to so me extent in this thread.

Actually, by and large, they shouldn't the I/O domain is usually
completely separate from the processor and memory one.

There is one exception for the altix and that's the mmiowb()
instruction.  You can read about it in the linux-arch archives (if you
keep them) under the subject:

[PATCH] I/O space write barrier

which is, I think where this is coming from.

As a summary: the altix has a method of imposing write ordering on the
PCI domain, which is what mmiowb does.  They prefer it in certain
circumstances to a read that does a flush of posted writes because it's
a lot cheaper on their hardware.  The only drivers (at least in SCSI)
that I've seen modified to use it are the ones that get plugged into the
altix.

As an aside, the main ordering problem it prevents is the SMP one where
two CPUs do writes into the PCI domain that they order with spinlocks.
Even though, temporally, the writes are sequenced leaving the CPUs, the
altix PCI domain can still re-order them if the mmiowb() isn't present
(so it sounds like it's really a smp_mmiowb()...)

James
