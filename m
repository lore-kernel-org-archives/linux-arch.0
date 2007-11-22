Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:39858 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbXKVIXa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Nov 2007 03:23:30 -0500
Date: Thu, 22 Nov 2007 09:23:29 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Message-ID: <20071122082329.GB31932@wotan.suse.de>
References: <20071121003053.GA11881@wotan.suse.de> <20071120160220.GA22196@wotan.suse.de> <4680.1195577182@redhat.com> <21121.1195609989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21121.1195609989@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 21, 2007 at 01:53:09AM +0000, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > Yeah ... the name isn't ideal. _mb is a nice one, but I don't want to use it
> > unless it is guaranteed to be a full barrier (rather than lock/unlock
> > barriers). barrier similarly has an existing meaning.
> 
> How about _iobarrier?
> 
> Or how about calling them begin_io_section() and end_io_section()?

Well it's lock semantics. If we decide to use any name without lock/unlock
in it, it will have acquire/release. begin_io_lock/end_io_lock, maybe...


> Also, I object to 'CACHEABLE' because memory barriers may still be required
> even if there aren't any caches.

OK. RAM?

 
> > The problem with just calling them mandatory or SMP conditional is that it
> > doesn't suggest the important *what* is being ordered.
> 
> Well, it is called 'memory-barriers.txt':-)
> 
> But I know what you mean, you've expanded the whole scope of the document in a
> way.

Yeah, I mean the type of memory being ordered.

 
> > > > +[!] Note that CACHEABLE or FULL memory barriers must be used to control the
> > > > +ordering of references to shared memory on SMP systems, though the use of
> > > > +locking instead is sufficient.
> > > 
> > > So a spin_lock() or a down() will do the trick?
> > 
> > I hope so. I didn't write this (just changed slightly).
> 
> I think this paragraph implies that use of a spin lock render I/O barriers
> redundant for that particular situation.  However your io_lock() implies
> otherwise.

Oh, perhaps. Yes, locks won't work for IO. By shared memory, I was thinking
about regular shared ram, but it could be talking about shared access to IO
memory too. So it needs clarification.


> > > > Do not get smart.
> > > 
> > > I'd very much recommend against saying that.
> > 
> > Really? What if you grep drivers/*, do you still recommend against? ;(
> 
> Bad practice elsewhere doesn't condone it here.  In fact, you're even more
> constrained in formal documentation.

OK, just to please you  ;)
 

> > > > +XXX: get rid of this, and just prefer io_lock()/io_unlock() ?
> > > 
> > > What do you mean?
> > 
> > I mean that although the readl can obviate the need for mmiowb on PCI,
> > will it be a problem just to encourage the use of the IO locks instead.
> > Just for simplicity and clarity.
> 
> So if I have a hardware device with a register that I want to make three reads
> of, and I expect each read to have side effects, I can just do:
> 
> 	io_lock()
> 	readl()
> 	readl()
> 	readl()
> 	io_unlock()

Well, presumably they will somehow be excluding other CPUs from accessing,
in which case I guess they would take a lock. And we would encourage them to
do the io_lock / io_unlock just after/before taking and releasing the lock.


> One thing I'm not entirely clear on.  Do you expect two I/O accesses from one
> CPU remain ordered wrt to each other?  Or is the following required:
> 
> 	io_lock()
> 	readl()
> 	io_rmb()
> 	readl()
> 	io_rmb()
> 	readl()
> 	io_unlock()
> 
> when talking to a device?

Good question. I'm not an expert on that.

sn2 implements readl_relaxed() differently to readl. powerpc implements their
readls with sync and isync, so presumably they can go out of order too. I do
think all architectures should make read*/write* as completely ordered WRT
one another (if not ordered with RAM), and then we should consistenly
implement _relaxed postfixes if performance matters.



