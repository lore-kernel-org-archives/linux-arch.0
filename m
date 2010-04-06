From: Nick Piggin <npiggin@suse.de>
Subject: Re: SMP barriers semantics
Date: Wed, 7 Apr 2010 02:04:06 +1000
Message-ID: <20100406160406.GG5288@laptop>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
 <20100303005529.GA3879@brick.ozlabs.ibm.com>
 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
 <20100312123105.GB4400@linux-mips.org>
 <1268792716.2335.170.camel@pasglop>
 <20100317134243.GA15235@shareable.org>
 <20100322120203.GL17637@laptop>
 <1269339847.29545.42.camel@e102109-lin.cambridge.arm.com>
 <20100406142054.GE5288@laptop>
 <20100406154321.GC29236@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52183 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab0DFQEP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Apr 2010 12:04:15 -0400
Content-Disposition: inline
In-Reply-To: <20100406154321.GC29236@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Tue, Apr 06, 2010 at 04:43:21PM +0100, Jamie Lokier wrote:
> Nick Piggin wrote:
> > On Tue, Mar 23, 2010 at 10:24:07AM +0000, Catalin Marinas wrote:
> > 
> > But hmm, I don't know if we even need acquire/release IO barriers at
> > all. Might be better to just fix up wmb(), get rid of mmiowb(),
> > strengthen IO accessors, and then just add special case barriers as
> > the need arises.
> 
> I must admit I don't understand what wmb() means at this point,
> generically from the point of view of arch-independent drivers!  It's
> not an inter-CPU ordering (smb_wmb is sufficient), and it doesn't
> order all memory and I/O writes (otherwise why mmiowb?).  I suspect a
> few people have been unsure, resulting in a bit of confusion about
> what goes into different arch implementations of wmb().

No, it has forever been defined to order *everything* (and this
includes ordering as-seen from IO devices, not as-sent from CPU,
otherwise it is absolutely useless on its own).

The problem is that it was weakened and made more complex by one
particular arch, and something else added to make up for it. This simply
doesn't work because it is impossible to audit all drivers (or get
driver writers to understand new semantics).

So, wmb() really should mean what it has always meant. sn2 should be
fixed up. Relaxed schemes should be added as required.

 
> For strengthening I/O accessors, do you mean the equivalent of putting
> "dmb;dsb" before _and_ after the I/O write inside every call to
> writel()?  (That's using ARM as an example: "dmb" means barrier, and
> "dsb" means flush write buffers I think, and some ARMs need other,
> rather heavier instructions such as a coprocessor instruction or even
> an instruction to the L2 cache.)
> 
> Because I'm not sure if that's as light as we'd like it to be on
> slower CPUs, and __raw_writel or something will get used instead by
> some driver writer...

writel_relaxed, I guess. It will get used, but it should be in a small
portion of driver code, that is carefully checked.


> leading back to needing to be very clear about
> the meaning of wmb/mmiowb.
