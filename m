Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:56068 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbYAPFSB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2008 00:18:01 -0500
Date: Wed, 16 Jan 2008 06:17:59 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080116051759.GA14049@wotan.suse.de>
References: <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org> <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <20080116033800.GA8890@wotan.suse.de> <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org> <20080116043728.GA7684@wotan.suse.de> <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com

On Tue, Jan 15, 2008 at 08:48:42PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 16 Jan 2008, Nick Piggin wrote:
> > 
> > Right, that's what I had hoped as well. But when I say pte_special
> > *usable* by all architectures, I mean it is usable by all that can
> > spare a bit in the pte. Apparently ARM can't because some some bug
> > in an Xscale CPU or something (the thread is on linux-arch).
> 
> Hmm. Can you give a pointer to some browsable archive? I guess I should 
> subscribe, but there's too much email, too little time. linux-arch is one 
> of the lists that I probably should look at.

http://marc.info/?t=119968107900003&r=2&w=2

I've also cc'ed Russell and Catalin, who were involved in that one.


> That said: especially for PFNMAP and friends, it may be possible to simply 
> re-use an existign hardware bit, like (for example) a "cacheable" bit.
> 
> That doesn't mean that such an architecture would have a free bit for any 
> *arbitrary* software use, but the "no <struct page> backing" is really a 
> pretty special feature, and may well map fairly well 1:1 with something 
> like a "cache disable" bit (which I do think ARM has).
> 
> It's not like we necessarily would want /dev/mem to be mapped cacheable 
> *anyway*, much less on some architecture with stupid virtual caches. 
> 
> > I remember that too. I guess some wires got crossed somewhere. s390
> > evidently does have free bits in their pte_present-type ptes.
> 
> I think they had two types of PTE's - 32-bit and 64-bit. Maybe it's just 
> the 32-bit one that was all used up (but see above - maybe cacheable bits 
> are doable?)

Not sure, I'll let the s390 people chime in here. We'd still need a
pte_special bit for 32 and 64 bit ptes (if they are different)...

 
> I do have to say, one of the reasons I enjoyed PFNMAP was that so far 
> we've basially been able to live without any SW-specified bits at all. 
> Yeah, we use "software bits" on architectures to emulate dirty/accessed, 
> but we have never really needed any "kernel internal bits". And I do think 
> that's generally a good idea. 

I agree in a way (on one hand it would be nice to simplify the whole
PFNMAP logic, on the other hand it isn't actually a problem to keep it,
and it is a nice way of avoiding the use of a pte bit, which might be
important in future even if not today...) 


> So in that sense, I'd actually prefer the current setup if it's not a huge 
> pain. 

Well that is why I wanted to go the ifdef route (or rather, tidy it up to
be an if (CONSTANT) { } else { } or something).

We could go and hide the pte-check in s390 specific code just in the
VM_MIXEDMAP case, but again I think that is actually just making things
less clear (than having the 2 distinct cases in core code).


> I saw your 5% number, but I really wonder about that one. Was that 
> perhaps with the much more expensive non-linear NUMA "pfn_to_page()"? THAT 
> expense would drown out any vma->vm_flags costs.

The 5% case yes that was with SPARSEMEM. And yes we should get rid of
that pfn_valid test IMO (or put it under CONFIG_DEBUG_VM). I'm not aware
of it ever triggering, so I think it should go away (I think Hugh nacked
my attempt at this last time -- Hugh, what do you think?).

However, minor performance issues aside, I'd still hope to find a good
way to get the pte_special path in.

---

vm_normal_page has been seen to take nearly 5% kernel time in profiles, and
regularly appears in the top 10 or so functions in a profile. It is called
at every page fault, and for every pte in bulk copy or unmaps.

pfn_valid in particular can be quite expensive in some memory models.

Place that code under CONFIG_DEBUG_VM. I'm not aware of it catching any
problems.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -392,16 +392,13 @@ struct page *vm_normal_page(struct vm_ar
 			return NULL;
 	}
 
-	/*
-	 * Add some anal sanity checks for now. Eventually,
-	 * we should just do "return pfn_to_page(pfn)", but
-	 * in the meantime we check that we get a valid pfn,
-	 * and that the resulting page looks ok.
-	 */
+#ifdef CONFIG_DEBUG_VM
+	/* Check that we get a valid pfn. */
 	if (unlikely(!pfn_valid(pfn))) {
 		print_bad_pte(vma, pte, addr);
 		return NULL;
 	}
+#endif
 
 	/*
 	 * NOTE! We still have PageReserved() pages in the page 
