Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBSQNn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 11:13:43 -0500
Date: Tue, 19 Feb 2019 16:13:34 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190219161334.GA28803@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
 <20190218165007.GC16713@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218165007.GC16713@fuggles.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, mpe@ellerman.id.au, paulus@samba.org
Message-ID: <20190219161334.UORLU6RhOq9EM08Jsln2I0-zIFd4ggJr4TjfJLBAjCk@z>

[+more ppc folks]

On Mon, Feb 18, 2019 at 04:50:12PM +0000, Will Deacon wrote:
> On Wed, Feb 13, 2019 at 10:27:09AM -0800, Linus Torvalds wrote:
> > Note that even if mmiowb() is expensive (and I don't think that's
> > actually even the case on ia64), you can - and probably should - do
> > what PowerPC does.
> > 
> > Doing an IO barrier on PowerPC is insanely expensive, but they solve
> > that simply track the whole "have I done any IO" manually. It's not
> > even that expensive, it just uses a percpu flag.
> > 
> > (Admittedly, PowerPC makes it less obvious that it's a percpu variable
> > because it's actually in the special "paca" region that is like a
> > hyper-local percpu area).

[...]

> > But we *could* first just do the mmiowb() unconditionally in the ia64
> > unlocking code, and then see if anybody notices?
> 
> I'll hack this up as a starting point. We can always try to be clever later
> on if it's deemed necessary.

Ok, so I started hacking this up in core code with the percpu flag (since
riscv apparently needs it), but I've now realised that I don't understand
how the PowerPC trick works after all. Consider the following:

	spin_lock(&foo);	// io_sync = 0
	outb(42, port);		// io_sync = 1
	spin_lock(&bar);	// io_sync = 0
	...
	spin_unlock(&bar);
	spin_unlock(&foo);

The inner lock could even happen in an irq afaict, but we'll end up skipping
the mmiowb()/sync because the io_sync flag is unconditionally cleared by
spin_lock(). Fixing this is complicated by the fact that I/O writes can be
performed in preemptible context with no locks held, so we can end up
spuriously setting the io_sync flag for arbitrary CPUs, hence the desire
to clear it in spin_lock().

If the paca entry was more than a byte, we could probably track that a
spinlock is held and then avoid clearing the flag prematurely, but I have
a feeling that I'm missing something. Anybody know how this is supposed to
work?

Will
