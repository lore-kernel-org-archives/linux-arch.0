Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44001 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752855AbYAMDlc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 Jan 2008 22:41:32 -0500
Date: Sat, 12 Jan 2008 19:41:16 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080113031013.GD22285@wotan.suse.de>
Message-ID: <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org



On Sun, 13 Jan 2008, Nick Piggin wrote:
> 
> mm: introduce pte_special pte bit

What's the point of this?

>  23 files changed, 147 insertions(+), 37 deletions(-)

That's lots of new (ugly) code, and two totally different paths, that 
aren't even cleanly abstracted, so now there's two separate things that 
are just arbitrarily selected by an #ifdef.

You seem to claim that this is a performance issue, with vm_normal_page() 
eating up to 5% of time on some loads, but it would appear that the main 
thing you did that will speed up vm_normal_page() is the fact that you 
replaced the current

        if (unlikely(!pfn_valid(pfn))) {
                print_bad_pte(vma, pte, addr);
                return NULL;
        }

with a

	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));

which is basically compiled away in the normal case.

From what I can tell, your vm_normal_page() is no less expensive than the 
current one is: the cost is always going to be that multiply by the size 
of the "struct page" implicit in

	pte_page(pte)

(which in the current one is just written out as

	pfn = pte_pfn(pte)
	pfn_page(pfn)

rather than hidden in a macro).

Does the code generation really change that radically that this makes any 
real difference?

		Linus
