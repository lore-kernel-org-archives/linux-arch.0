Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBEg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2018 00:36:56 -0400
Date: Wed, 1 Aug 2018 19:47:59 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-ID: <20180802024759.GB25338@bombadil.infradead.org>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <20180801112019.GA2666@bombadil.infradead.org>
 <20180801230205.GI1392@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801230205.GI1392@brightrain.aerifal.cx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Rob Landley <rob@landley.net>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>

On Wed, Aug 01, 2018 at 07:02:05PM -0400, Rich Felker wrote:
> On Wed, Aug 01, 2018 at 04:20:19AM -0700, Matthew Wilcox wrote:
> > __GFP_ZERO overrode the constructor.  That is, before 128227e7fe40,
> > if you specified both a constructor and __GFP_ZERO, first the slab
> > code would invoke the constructor, then it would zero the allocation.
> > So this patch is preserving the existing behaviour.  Whether the existing
> > behaviour is correct or not, I cannot say.
> 
> Then I think we should really try to figure out whether this is a
> buried bug before deleting the evidence of it...

Archaeology suggests the bug was introduced in commit 2a5eacca85d3 ("sh:
Move page table allocation out of line") in 2009.  Previous code:

-       pgd = kzalloc(sizeof(*pgd) * PTRS_PER_PGD, GFP_KERNEL | __GFP_REPEAT);
-
-       for (i = USER_PTRS_PER_PGD; i < PTRS_PER_PGD; i++)
-               pgd[i] = swapper_pg_dir[i];

Replacement code:

+#define PGALLOC_GFP GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO

+void pgd_ctor(void *x)
+{
+       pgd_t *pgd = x;
+
+       memcpy(pgd + USER_PTRS_PER_PGD,
+              swapper_pg_dir + USER_PTRS_PER_PGD,
+              (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+}

+       pgd_cachep = kmem_cache_create("pgd_cache",
+                                      PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
+                                      PAGE_SIZE, SLAB_PANIC, pgd_ctor);

+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+       return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);

It clearly doesn't cause any bugs to zero the PGD entries (... or somebody
would have noticed since 2009?), but I suspect it causes various PMD
entries to not be shared.

I'm really happy we decided to introduce this check.  It caught a really
old and completely unrelated bug!
