Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55304 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeHBBDK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 21:03:10 -0400
Date: Wed, 1 Aug 2018 19:02:05 -0400
From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-ID: <20180801230205.GI1392@brightrain.aerifal.cx>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <20180801112019.GA2666@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801112019.GA2666@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Rob Landley <rob@landley.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Aug 01, 2018 at 04:20:19AM -0700, Matthew Wilcox wrote:
> On Wed, Aug 01, 2018 at 09:42:02AM +0200, Geert Uytterhoeven wrote:
> > Hi Sato-san,
> > 
> > CC Rob , Willy, linux-arch
> 
> Thanks!
> 
> > > -void pgd_ctor(void *x)
> > > -{
> > > -       pgd_t *pgd = x;
> > > -
> > > -       memcpy(pgd + USER_PTRS_PER_PGD,
> > > -              swapper_pg_dir + USER_PTRS_PER_PGD,
> > > -              (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> > > -}
> > > -
> > >  void pgtable_cache_init(void)
> > >  {
> > >         pgd_cachep = kmem_cache_create("pgd_cache",
> > >                                        PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
> > > -                                      PAGE_SIZE, SLAB_PANIC, pgd_ctor);
> > > +                                      PAGE_SIZE, SLAB_PANIC, NULL);
> > >  #if PAGETABLE_LEVELS > 2
> > >         pmd_cachep = kmem_cache_create("pmd_cache",
> > >                                        PTRS_PER_PMD * (1<<PTE_MAGNITUDE),
> > 
> > While I can confirm your patch fixes the
> > 
> >     WARNING: CPU: 0 PID: 1 at mm/slub.c:2412
> > ___slab_alloc.constprop.34+0x196/0x288
> > 
> > seen since commit 128227e7fe4087b6 ("slab: __GFP_ZERO is incompatible
> > with a constructor"), I'm not 100% sure this is the correct fix.
> > 
> > swapper_pg_dir[] does have two non-zero entries (768 and 895), which were
> > copied by the constructor.  Perhaps SH does have a need for these two
> > entries, and thus for the constructor?
> 
> __GFP_ZERO overrode the constructor.  That is, before 128227e7fe40,
> if you specified both a constructor and __GFP_ZERO, first the slab
> code would invoke the constructor, then it would zero the allocation.
> So this patch is preserving the existing behaviour.  Whether the existing
> behaviour is correct or not, I cannot say.

Then I think we should really try to figure out whether this is a
buried bug before deleting the evidence of it...

Rich
