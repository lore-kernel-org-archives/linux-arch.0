From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/2] fix SMP data race in pagetable setup vs walking
Date: Mon, 5 May 2008 17:37:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0805051725140.8230@blonde.site>
References: <20080505112021.GC5018@wotan.suse.de> <20080505121240.GD5018@wotan.suse.de>
 <alpine.LFD.1.10.0805050828120.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:56706 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759042AbYEEQjW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 12:39:22 -0400
Received: from [172.20.24.170]([172.20.24.170]) (2318 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1Jt3gv-0000aVC@megami.veritas.com>
	for <linux-arch@vger.kernel.org>; Mon, 5 May 2008 09:37:29 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
In-Reply-To: <alpine.LFD.1.10.0805050828120.32269@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Paul McKenney <paulmck@us.ibm.com>

On Mon, 5 May 2008, Linus Torvalds wrote:
> On Mon, 5 May 2008, Nick Piggin wrote:
> > 
> > Index: linux-2.6/include/asm-x86/pgtable_32.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-x86/pgtable_32.h
> > +++ linux-2.6/include/asm-x86/pgtable_32.h
> > @@ -133,7 +133,12 @@ extern int pmd_bad(pmd_t pmd);
> >   * pgd_offset() returns a (pgd_t *)
> >   * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
> >   */
> > -#define pgd_offset(mm, address) ((mm)->pgd + pgd_index((address)))
> > +#define pgd_offset(mm, address)						\
> > +({									\
> > +	pgd_t *ret = ((mm)->pgd + pgd_index((address)));		\
> > +	smp_read_barrier_depends(); /* see mm/memory.c:__pte_alloc */	\
> > +	ret;								\
> > +})
> 
> Is there some fundamental reason this needs to be a macro?
> 
> It is really ugly, and it would be much nicer to make this an inline 
> function if at all possible.
> 
> Yeah, maybe it requires some more #include's, but ..

My recollection is that it gets difficult once you reach
pte_offset_map(), which involved kmap_atomic() (now kmap_atomic_pte()),
which gets twisty.  Or perhaps my problems arose from doing
pte_offset_map_lock() in the generic linux/mm.h: harder to
herd that safely through the different arch builds.

Hugh
