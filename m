Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:42743 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbYAMEjZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 Jan 2008 23:39:25 -0500
Date: Sun, 13 Jan 2008 05:39:22 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080113043922.GA22345@wotan.suse.de>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

On Sat, Jan 12, 2008 at 07:41:16PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 13 Jan 2008, Nick Piggin wrote:
> > 
> > mm: introduce pte_special pte bit
> 
> What's the point of this?

Well, it's written in the changelog. I'm not asking for it to be merged
or anything just now because obviously it isn't in a patchset with anything
that needs it, just want some comments on the idea.

Myself, I would like such a bit to implement lockless get_user_pages on
x86. The x390 guys want to implement pfn mapped xip with the same bit in
their pagetables.


> >  23 files changed, 147 insertions(+), 37 deletions(-)
> 
> That's lots of new (ugly) code, and two totally different paths, that 
> aren't even cleanly abstracted, so now there's two separate things that 
> are just arbitrarily selected by an #ifdef.

How should it be cleanly abstracted?

 
> You seem to claim that this is a performance issue, with vm_normal_page() 

Hmm, the performance observation was an aside. I'd love to be able to
fix up the existing vm_normal_page as well. Sorry if that wasn't clear.


> eating up to 5% of time on some loads, but it would appear that the main 
> thing you did that will speed up vm_normal_page() is the fact that you 
> replaced the current
> 
>         if (unlikely(!pfn_valid(pfn))) {
>                 print_bad_pte(vma, pte, addr);
>                 return NULL;
>         }

FWIW I have wanted to put this under DEBUG_VM too, but there were
objections.

> Does the code generation really change that radically that this makes any 
> real difference?

It's mainly for semantics. Basically: if we have architectures with such
a bit in their ptes anyway for other reasons, I'm hoping we can use it in
vm_normal_page too, because it's just a nicer. (and it is fundamentally
faster for MIXEDMAP mappings, but that's probably not a big issue at this
point)
