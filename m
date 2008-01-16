Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51787 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbYAPKxq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2008 05:53:46 -0500
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
From: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20080116051759.GA14049@wotan.suse.de>
References: <20080113031013.GD22285@wotan.suse.de>
	 <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org>
	 <20080113043922.GA22345@wotan.suse.de>
	 <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
	 <20080113050605.GA1340@wotan.suse.de>
	 <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
	 <20080116033800.GA8890@wotan.suse.de>
	 <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org>
	 <20080116043728.GA7684@wotan.suse.de>
	 <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org>
	 <20080116051759.GA14049@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 16 Jan 2008 10:52:29 +0000
Message-Id: <1200480750.19045.33.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk

On Wed, 2008-01-16 at 06:17 +0100, Nick Piggin wrote:
> On Tue, Jan 15, 2008 at 08:48:42PM -0800, Linus Torvalds wrote:
> > On Wed, 16 Jan 2008, Nick Piggin wrote:
> > > Right, that's what I had hoped as well. But when I say pte_special
> > > *usable* by all architectures, I mean it is usable by all that can
> > > spare a bit in the pte. Apparently ARM can't because some some bug
> > > in an Xscale CPU or something (the thread is on linux-arch).
> > 
> > Hmm. Can you give a pointer to some browsable archive? I guess I should 
> > subscribe, but there's too much email, too little time. linux-arch is one 
> > of the lists that I probably should look at.
> 
> http://marc.info/?t=119968107900003&r=2&w=2
> 
> I've also cc'ed Russell and Catalin, who were involved in that one.

In summary, on the ARM side, on architectures ARMv5 and earlier we had
more bits available. Starting with ARMv6, because the memory ordering
model was changed, 3 bits were used for the TEX encoding (Type
EXtension), in addition to the original C and B bits (cacheable and
bufferable, which on ARMv6 and later may have a different meaning, based
on the TEX bits).

However, ARMv6 comes with a new configuration mode, "TEX remapping",
which, if enabled, allows 8 combinations of the TEX, C and B bits to be
encoded in separate registers and only use 3 bits in the PTE (TEX[0], C,
B) rather than 5 (i.e. one more bit compared to ARMv5). Since this mode
isn't backwards compatible, the decision was to not use it and add the
TEX bits to the PTE.

Because of a bug on Xscale3, Russell might use another (the last one)
bit in the PTE but I don't know the details.

There are some solutions (with drawbacks as well):

1. Use the new TEX remapping on ARMv6 (does Xscale3 support it?) and
emulate it on pre-ARMv6 CPUs. On older CPUs, this might add a few cycles
to the set_pte function. While on setting up the page tables these might
be lost in the noise, Russell mentioned the clearing up of the page
tables. Maybe the pte_clear function could use a fast-track
implementation which simply zeros the pte rather than checking the bits.

2. As above but reserve the TEX[0] bit on ARMv5 for compatibility with
ARMv6 and no emulation is needed. In this case, C and B bits have a
totally different meaning on ARMv5 and ARMv6 (as currently on the former
and, on the latter, they are just used as an index in a pre-defined
table stored in configuration registers). I don't think this would be a
problem since we build the PTE bits for various memory types at boot
time based on the CPU architecture.

3. Use TEX remapping on ARMv6 and keep the current implementation for
ARMv5. This would mean 2 separate pte_* implementations, probably
optimal for the corresponding architectures but you cannot build a
kernel supporting both at the same time (though I think even the current
implementation needs some tweaking). If this is needed, we could use
option 1 above but I think the code would be really complicated.

If Xscale3 supports TEX remapping (it's an ARMv6, so it should but I'm
not sure), I think that option 2 above could be feasible to free 2 more
bits in the PTE (leaving us with 3 spare bits). I'm happy to give this
approach a try but it's Russell that has the final word since the patch
would be pretty intrusive (and would need to be discussed on
linux-arm-kernel list first as I'm not sure what wider implications it
might have).

-- 
Catalin

