Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfBSNU1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 08:20:27 -0500
Date: Tue, 19 Feb 2019 13:20:21 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190219132021.GJ8501@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com>
 <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
 <20190218175625.GD16713@fuggles.cambridge.arm.com>
 <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
 <20190219112747.7db95e58@windsurf.home>
 <CAK8P3a3n2meqogz7MeMUA48LBOEV9_AYQPxU3+V8A=Fn_63v4A@mail.gmail.com>
 <20190219113609.GC4027@fuggles.cambridge.arm.com>
 <CAK8P3a0iM17ABoaFn9+KymZ-JkjM9hmBNDMyn6-A=s06p1fvnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0iM17ABoaFn9+KymZ-JkjM9hmBNDMyn6-A=s06p1fvnQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Message-ID: <20190219132021.G5ww1liLqhOqG_CuK3l1a_o1GskqP6DYS9I3yLG4-Xw@z>

On Tue, Feb 19, 2019 at 02:01:50PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 19, 2019 at 12:36 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Feb 19, 2019 at 12:31:50PM +0100, Arnd Bergmann wrote:
> > > On Tue, Feb 19, 2019 at 11:27 AM Thomas Petazzoni
> > > <thomas.petazzoni@bootlin.com> wrote:
> > >
> > > I think an example of this would be a driver using outb() to disable
> > > an interrupt, and then relying on the the interrupt no longer happening
> > > after the outb().
> >
> > Isn't that racy already? i.e. the interrupt could fire just before you
> > disabled it, but not get delivered by the irq controller until after you'd
> > disabled it at the device?
> 
> Probably, I had a hard enough time trying to come up with any example ;-)

You and me both!

> One reference to non-posted transaction in a comment is in
> drivers/net/ethernet/dec/tulip/de4x5.c:
> 
> /*
> ** The DE4X5 interrupt handler.
> **
> ** I/O Read/Writes through intermediate PCI bridges are never 'posted',
> ** so that the asserted interrupt always has some real data to work with -
> ** if these I/O accesses are ever changed to memory accesses, ensure the
> ** STS write is read immediately to complete the transaction if the adapter
> ** is not on bus 0. Lost interrupts can still occur when the PCI bus load
> ** is high and descriptor status bits cannot be set before the associated
> ** interrupt is asserted and this routine entered.
> */

Thankfully, that driver is both old and non-portable:

  depends on VIRT_TO_BUS || ALPHA || PPC || SPARC

so I'm not especially concerned about it. Judging by the comment, we'd
need to add something like:


diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 66535d1653f6..c85089f65b0e 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -1556,6 +1556,10 @@ de4x5_interrupt(int irq, void *dev_id)
 	sts = inl(DE4X5_STS);            /* Read IRQ status */
 	outl(sts, DE4X5_STS);            /* Reset the board interrupts */
 
+	/* Beware of PCI posted writes */
+	if (IS_ENABLED(CONFIG_ARM64) && lp->bus_num)
+		inl(DE4X5_STS);
+
 	if (!(sts & lp->irq_mask)) break;/* All done */
 	handled = 1;
 


if we wanted to get this working reliably on arm64. However, I'll be honest
and say we haven't had much demand for supporting DEC PCI devices yet :)

> I found another comment in the via-rhine driver:
> 
> /* Beware of PCI posted writes */
> #define IOSYNC  do { ioread8(ioaddr + StationAddr); } while (0)
> 
> this one is used in the chip reset function, and in the transmit
> path.

Since this is doing a read-back, I take this comment as saying "posted
writes are a thing, so perform a read-back to force the prior write to
complete", which is fine.

Will
