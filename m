Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38130 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756875AbYAPEtA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jan 2008 23:49:00 -0500
Date: Tue, 15 Jan 2008 20:48:42 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080116043728.GA7684@wotan.suse.de>
Message-ID: <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
 <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <20080116033800.GA8890@wotan.suse.de> <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org> <20080116043728.GA7684@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org



On Wed, 16 Jan 2008, Nick Piggin wrote:
> 
> Right, that's what I had hoped as well. But when I say pte_special
> *usable* by all architectures, I mean it is usable by all that can
> spare a bit in the pte. Apparently ARM can't because some some bug
> in an Xscale CPU or something (the thread is on linux-arch).

Hmm. Can you give a pointer to some browsable archive? I guess I should 
subscribe, but there's too much email, too little time. linux-arch is one 
of the lists that I probably should look at.

That said: especially for PFNMAP and friends, it may be possible to simply 
re-use an existign hardware bit, like (for example) a "cacheable" bit.

That doesn't mean that such an architecture would have a free bit for any 
*arbitrary* software use, but the "no <struct page> backing" is really a 
pretty special feature, and may well map fairly well 1:1 with something 
like a "cache disable" bit (which I do think ARM has).

It's not like we necessarily would want /dev/mem to be mapped cacheable 
*anyway*, much less on some architecture with stupid virtual caches. 

> I remember that too. I guess some wires got crossed somewhere. s390
> evidently does have free bits in their pte_present-type ptes.

I think they had two types of PTE's - 32-bit and 64-bit. Maybe it's just 
the 32-bit one that was all used up (but see above - maybe cacheable bits 
are doable?)

I do have to say, one of the reasons I enjoyed PFNMAP was that so far 
we've basially been able to live without any SW-specified bits at all. 
Yeah, we use "software bits" on architectures to emulate dirty/accessed, 
but we have never really needed any "kernel internal bits". And I do think 
that's generally a good idea. 

So in that sense, I'd actually prefer the current setup if it's not a huge 
pain. I saw your 5% number, but I really wonder about that one. Was that 
perhaps with the much more expensive non-linear NUMA "pfn_to_page()"? THAT 
expense would drown out any vma->vm_flags costs.

		Linus
