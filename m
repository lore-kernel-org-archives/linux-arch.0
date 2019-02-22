Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfBVRij (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 12:38:39 -0500
Date: Fri, 22 Feb 2019 17:38:34 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190222173834.GC32113@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
 <20190218165007.GC16713@fuggles.cambridge.arm.com>
 <20190219161334.GA28803@fuggles.cambridge.arm.com>
 <87k1htwtis.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1htwtis.fsf@concordia.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, paulus@samba.org
Message-ID: <20190222173834.LZQc4Qa0UVseAAWVxpqwF3Q76rS7KZhAN9I_OQH6-rE@z>

On Thu, Feb 21, 2019 at 05:22:03PM +1100, Michael Ellerman wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > [+more ppc folks]
> >
> > On Mon, Feb 18, 2019 at 04:50:12PM +0000, Will Deacon wrote:
> >> On Wed, Feb 13, 2019 at 10:27:09AM -0800, Linus Torvalds wrote:
> >> > Note that even if mmiowb() is expensive (and I don't think that's
> >> > actually even the case on ia64), you can - and probably should - do
> >> > what PowerPC does.
> >> > 
> >> > Doing an IO barrier on PowerPC is insanely expensive, but they solve
> >> > that simply track the whole "have I done any IO" manually. It's not
> >> > even that expensive, it just uses a percpu flag.
> >> > 
> >> > (Admittedly, PowerPC makes it less obvious that it's a percpu variable
> >> > because it's actually in the special "paca" region that is like a
> >> > hyper-local percpu area).
> >
> > [...]
> >
> >> > But we *could* first just do the mmiowb() unconditionally in the ia64
> >> > unlocking code, and then see if anybody notices?
> >> 
> >> I'll hack this up as a starting point. We can always try to be clever later
> >> on if it's deemed necessary.
> >
> > Ok, so I started hacking this up in core code with the percpu flag (since
> > riscv apparently needs it), but I've now realised that I don't understand
> > how the PowerPC trick works after all. Consider the following:
> >
> > 	spin_lock(&foo);	// io_sync = 0
> > 	outb(42, port);		// io_sync = 1
> > 	spin_lock(&bar);	// io_sync = 0
> > 	...
> > 	spin_unlock(&bar);
> > 	spin_unlock(&foo);
> >
> > The inner lock could even happen in an irq afaict, but we'll end up skipping
> > the mmiowb()/sync because the io_sync flag is unconditionally cleared by
> > spin_lock(). Fixing this is complicated by the fact that I/O writes can be
> > performed in preemptible context with no locks held, so we can end up
> > spuriously setting the io_sync flag for arbitrary CPUs, hence the desire
> > to clear it in spin_lock().
> >
> > If the paca entry was more than a byte, we could probably track that a
> > spinlock is held and then avoid clearing the flag prematurely, but I have
> > a feeling that I'm missing something. Anybody know how this is supposed to
> > work?
> 
> I don't think you're missing anything :/

Ok, well that's slightly reasurring for me :)

> Having two flags like you suggest could work. Or you could just make the
> flag into a nesting counter.

My work-in-progress asm-generic version uses a counter, but I can't squeese
that into your u8 paca entry. I'll cc you when I post the patches, so
perhaps you can hack up the ppc side.

> Or do you just remove the clearing from spin_lock()? 
> 
> That gets you:
> 
>  	spin_lock(&foo);
>  	outb(42, port);		// io_sync = 1
>  	spin_lock(&bar);
>  	...
>  	spin_unlock(&bar);	// mb(); io_sync = 0
>  	spin_unlock(&foo);
> 
> 
> And I/O outside of the lock case:
> 
>  	outb(42, port);		// io_sync = 1
> 
>  	spin_lock(&bar);
>  	...
>  	spin_unlock(&bar);	// mb(); io_sync = 0
> 
> 
> Extra barriers are not ideal, but the odd spurious mb() might be
> preferable to doing another compare and branch or increment in every
> spin_lock()?

Up to you. I'm working on the assumption that these barriers are insanely
expensive, otherwise we'd just upgrade spin_unlock() and work on things
that are more fun instead ;)

Will
