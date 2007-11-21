Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbXKUBxQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2007 20:53:16 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20071121003053.GA11881@wotan.suse.de>
References: <20071121003053.GA11881@wotan.suse.de> <20071120160220.GA22196@wotan.suse.de> <4680.1195577182@redhat.com>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Date: Wed, 21 Nov 2007 01:53:09 +0000
Message-ID: <21121.1195609989@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <npiggin@suse.de> wrote:

> Yeah ... the name isn't ideal. _mb is a nice one, but I don't want to use it
> unless it is guaranteed to be a full barrier (rather than lock/unlock
> barriers). barrier similarly has an existing meaning.

How about _iobarrier?

Or how about calling them begin_io_section() and end_io_section()?

> > Does having 'CACHEABLE' imply that 'FULL' ones are or that they aren't?
> 
> Are or aren't what?

Hmmm...  Nevermind.  I'm not sure what I was thinking of applies anyway.
Perhaps you should state that a FULL barrier implies a CACHEABLE barrier and
it implies an I/O barrier and it also orders ordinary memory accesses with
respect to I/O accesses.

Also, I object to 'CACHEABLE' because memory barriers may still be required
even if there aren't any caches.

> The problem with just calling them mandatory or SMP conditional is that it
> doesn't suggest the important *what* is being ordered.

Well, it is called 'memory-barriers.txt':-)

But I know what you mean, you've expanded the whole scope of the document in a
way.

> Pretty verbose, isn't it ;) Not only does a CPU appear self consistent, it
> is.  And not only will overlapping accesses be ordered correctly, so will
> completely out of order ones.

Sometimes it's a good idea to explicitly state your assumptions, just so that
people know.

> > > +[!] Note that CACHEABLE or FULL memory barriers must be used to control the
> > > +ordering of references to shared memory on SMP systems, though the use of
> > > +locking instead is sufficient.
> > 
> > So a spin_lock() or a down() will do the trick?
> 
> I hope so. I didn't write this (just changed slightly).

I think this paragraph implies that use of a spin lock render I/O barriers
redundant for that particular situation.  However your io_lock() implies
otherwise.

> > > Do not get smart.
> > 
> > I'd very much recommend against saying that.
> 
> Really? What if you grep drivers/*, do you still recommend against? ;(

Bad practice elsewhere doesn't condone it here.  In fact, you're even more
constrained in formal documentation.

> I just figure it is vague, unneccesary, hardware specific. Can take it out.

You still have to say why.  You should check this with Paul McKenney.  I think
he added the statement you've removed.

> > > +XXX: get rid of this, and just prefer io_lock()/io_unlock() ?
> > 
> > What do you mean?
> 
> I mean that although the readl can obviate the need for mmiowb on PCI,
> will it be a problem just to encourage the use of the IO locks instead.
> Just for simplicity and clarity.

So if I have a hardware device with a register that I want to make three reads
of, and I expect each read to have side effects, I can just do:

	io_lock()
	readl()
	readl()
	readl()
	io_unlock()

One thing I'm not entirely clear on.  Do you expect two I/O accesses from one
CPU remain ordered wrt to each other?  Or is the following required:

	io_lock()
	readl()
	io_rmb()
	readl()
	io_rmb()
	readl()
	io_unlock()

when talking to a device?

David
