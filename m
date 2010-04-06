From: Jamie Lokier <jamie@shareable.org>
Subject: Re: SMP barriers semantics
Date: Tue, 6 Apr 2010 16:43:21 +0100
Message-ID: <20100406154321.GC29236@shareable.org>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com> <20100303005529.GA3879@brick.ozlabs.ibm.com> <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com> <20100312123105.GB4400@linux-mips.org> <1268792716.2335.170.camel@pasglop> <20100317134243.GA15235@shareable.org> <20100322120203.GL17637@laptop> <1269339847.29545.42.camel@e102109-lin.cambridge.arm.com> <20100406142054.GE5288@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:56320 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab0DFPn5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 11:43:57 -0400
Content-Disposition: inline
In-Reply-To: <20100406142054.GE5288@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

Nick Piggin wrote:
> On Tue, Mar 23, 2010 at 10:24:07AM +0000, Catalin Marinas wrote:
> 
> But hmm, I don't know if we even need acquire/release IO barriers at
> all. Might be better to just fix up wmb(), get rid of mmiowb(),
> strengthen IO accessors, and then just add special case barriers as
> the need arises.

I must admit I don't understand what wmb() means at this point,
generically from the point of view of arch-independent drivers!  It's
not an inter-CPU ordering (smb_wmb is sufficient), and it doesn't
order all memory and I/O writes (otherwise why mmiowb?).  I suspect a
few people have been unsure, resulting in a bit of confusion about
what goes into different arch implementations of wmb().

For strengthening I/O accessors, do you mean the equivalent of putting
"dmb;dsb" before _and_ after the I/O write inside every call to
writel()?  (That's using ARM as an example: "dmb" means barrier, and
"dsb" means flush write buffers I think, and some ARMs need other,
rather heavier instructions such as a coprocessor instruction or even
an instruction to the L2 cache.)

Because I'm not sure if that's as light as we'd like it to be on
slower CPUs, and __raw_writel or something will get used instead by
some driver writer... leading back to needing to be very clear about
the meaning of wmb/mmiowb.

-- Jamie
