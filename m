Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51288 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbYAPEhb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jan 2008 23:37:31 -0500
Date: Wed, 16 Jan 2008 05:37:28 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080116043728.GA7684@wotan.suse.de>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org> <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <20080116033800.GA8890@wotan.suse.de> <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

On Tue, Jan 15, 2008 at 08:04:19PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 16 Jan 2008, Nick Piggin wrote:
> > 
> > My biggest concen is that s390 basically are thinking about doing
> > something like this:
> > 
> >        if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> >                 if (vma->vm_flags & VM_MIXEDMAP) {
> > #ifdef s390
> > 			if (pte_special(pte))
> > 				return NULL;
> > #else
> >                         if (!pfn_valid(pfn))
> >                                 return NULL;
> > #endif
> 
> Ok. So now that I actually know what the reason for the insanity was.
> 
> > Basically what I want to do is make the pte_special part usable by
> > all architectures, and bring it out of the vma tests.
> 
> But if it's always there, then there is no reason for *any* of this. The 
> right thing is to just always do
> 
> 	return pte_special(pte) ? NULL : pte_page(pte);
> 
> and I'd be happy with that too. I'm just not happy with the mixing, and 
> with the #ifdef inside code.

Right, that's what I had hoped as well. But when I say pte_special
*usable* by all architectures, I mean it is usable by all that can
spare a bit in the pte. Apparently ARM can't because some some bug
in an Xscale CPU or something (the thread is on linux-arch).


> All the other code only makes sense if there isn't a special bit in the 
> pte, but I was literally told that the only architecture that does *not* 
> have any free bits for that is S390. So now you use S390 as an excuse to 
> do that "pte_special()", which is what I think EVERYBODY ELSE wanted to do 
> in the first place!

I remember that too. I guess some wires got crossed somewhere. s390
evidently does have free bits in their pte_present-type ptes.

 
> Can you see why I'm not so enamoured with the patch? Either it makes 
> sense, and *everybody* should just use that simple one-liner, or it 
> doesn't make sense, and *nobody* should do it.
> 
> It's the "both cases" that just drives me wild. It doesn't make sense.

I can see what you mean, but if we have one architecture (arm) that
cannot support pte_special, then the conclusion is that we should
only support vma-based scheme and be done with it.

But in that case will still end up with the s390 specific code in
the VM_MIXEDMAP case, because they cannot support VM_MIXEDMAP with
pfn_valid (because of their memory model). So once they have that
special case there, I'd much rather make it an explicit core VM
concept rather than hiding it away in s390 code.

The argument to allow other architectures to use it is a very minor
one, just that there is no reason *not* to allow them to use it if
it generates even slightly better code (especially not if they want
to use a pte_special bit for other reasons anyway eg. lockless GUP).

Actually it is useful even just to involve the core VM people in the
logic rather than hiding it in s390 stuff (which scares people away).
And also makes the pte-based scheme testable on non-s390...

