Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56326 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754222AbYAPEEn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jan 2008 23:04:43 -0500
Date: Tue, 15 Jan 2008 20:04:19 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080116033800.GA8890@wotan.suse.de>
Message-ID: <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
 <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <20080116033800.GA8890@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org



On Wed, 16 Jan 2008, Nick Piggin wrote:
> 
> My biggest concen is that s390 basically are thinking about doing
> something like this:
> 
>        if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
>                 if (vma->vm_flags & VM_MIXEDMAP) {
> #ifdef s390
> 			if (pte_special(pte))
> 				return NULL;
> #else
>                         if (!pfn_valid(pfn))
>                                 return NULL;
> #endif

Ok. So now that I actually know what the reason for the insanity was.

> Basically what I want to do is make the pte_special part usable by
> all architectures, and bring it out of the vma tests.

But if it's always there, then there is no reason for *any* of this. The 
right thing is to just always do

	return pte_special(pte) ? NULL : pte_page(pte);

and I'd be happy with that too. I'm just not happy with the mixing, and 
with the #ifdef inside code.

All the other code only makes sense if there isn't a special bit in the 
pte, but I was literally told that the only architecture that does *not* 
have any free bits for that is S390. So now you use S390 as an excuse to 
do that "pte_special()", which is what I think EVERYBODY ELSE wanted to do 
in the first place!

Can you see why I'm not so enamoured with the patch? Either it makes 
sense, and *everybody* should just use that simple one-liner, or it 
doesn't make sense, and *nobody* should do it.

It's the "both cases" that just drives me wild. It doesn't make sense.

			Linus


