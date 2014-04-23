Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51221 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbaDWDKW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 23:10:22 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so296396pbc.23
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2014 20:10:21 -0700 (PDT)
Date: Tue, 22 Apr 2014 20:08:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
Subject: Re: Dirty/Access bits vs. page content
In-Reply-To: <CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
References: <1398032742.19682.11.camel@pasglop> <CA+55aFz1sK+PF96LYYZY7OB7PBpxZu-uNLWLvPiRz-tJsBqX3w@mail.gmail.com> <1398054064.19682.32.camel@pasglop> <1398057630.19682.38.camel@pasglop> <CA+55aFwWHBtihC3w9E4+j4pz+6w7iTnYhTf4N3ie15BM9thxLQ@mail.gmail.com>
 <53558507.9050703@zytor.com> <CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com> <53559F48.8040808@intel.com> <CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com> <CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
 <20140422075459.GD11182@twins.programming.kicks-ass.net> <CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140423030859.5zVtP3IcrCYKkhpzft7EbQL9D5zzZ4_fcLIWYUczMo8@z>

On Tue, 22 Apr 2014, Linus Torvalds wrote:
> On Tue, Apr 22, 2014 at 12:54 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> That said, Dave Hansen did report a BUG_ON() in
> mpage_prepare_extent_to_map(). His line number was odd, but I assume
> it's this one:
> 
>         BUG_ON(PageWriteback(page));
> 
> which may be indicative of some oddity here wrt the dirty bit.

Whereas later mail from Dave showed it to be the
	BUG_ON(!PagePrivate(page));
in page_buffers() from fs/ext4/inode.c mpage_prepare_extent_to_map().
But still presumably some kind of fallout from your patches.

Once upon a time there was a page_has_buffers() check in there,
but Honza decided that's nowadays unnecessary in f8bec37037ac
"ext4: dirty page has always buffers attached".  Cc'ed,
he may very well have some good ideas.

Reading that commit reminded me of how we actually don't expect that
set_page_dirty() in zap_pte_range() to do anything at all on the usual
mapping_cap_account_dirty()/page_mkwrite() filesystems, do we?  Or do we?
 
> So I'm a bit worried.  I'm starting to think that we need to do
> "set_page_dirty_lock()". It *used* to be the case that because we held
> the page table lock and the page used to be mapped (even if we then
> unmapped it), page_mapping() could not go away from under us because
> truncate would see it in the rmap list and then get serialized on that
> page table lock. But moving the set_page_dirty() later - and to
> outside the page table lock - means that we probably need to use that
> version that takes the page lock.
> 
> Which might kind of suck from a performance angle. But it might
> explain DaveH's BUG_ON() when testing those patches?
> 
> I wonder if we could hold on to the page mapping some other way than
> taking that page lock, because taking that page lock sounds
> potentially damn expensive.

At first I thought you were right, and set_page_dirty_lock() needed;
but now I think not.  We only(?) need set_page_dirty_lock() when
there's a danger that the struct address_space itself might be
evicted beneath us.

But here (even without relying on Al's delayed_fput) the fput()
is done by remove_vma() called _after_ the tlb_finish_mmu().
So I see no danger of struct address_space being freed:
set_page_dirty_lock() is for, say, people who did get_user_pages(),
and cannot be sure that the original range is still mapped when
they come to do the final set_page_dirtys and put_pages.

page->mapping might be truncated to NULL at any moment without page
lock and without mapping->tree_lock (and without page table lock
helping to serialize page_mapped against unmap_mapping_range); but
__set_page_dirty_nobuffers() (admittedly not the only set_page_dirty)
is careful about that, and it's just not the problem Dave is seeing.

However... Virginia and I get rather giddy when it comes to the
clear_page_dirty_for_io() page_mkclean() dance: we trust you and
Peter and Jan on that, and page lock there has some part to play.

My suspicion, not backed up at all, is that by leaving the
set_page_dirty() until after the page has been unmapped (and page
table lock dropped), that dance has been disturbed in such a way
that ext4 can be tricked into freeing page buffers before it will
need them again for a final dirty writeout.

Kind words deleted :) Your 2 patches below for easier reference.

Hugh

From 21819f790e3d206ad77cd20d6e7cae86311fc87d Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2014 15:29:49 -0700
Subject: [PATCH 1/2] mm: move page table dirty state into TLB gather operation

When tearing down a memory mapping, we have long delayed the actual
freeing of the pages until after the (batched) TLB flush, since only
after the TLB entries have been flushed from all CPU's do we know that
none of the pages will be accessed any more.

HOWEVER.

Ben Herrenschmidt points out that we need to do the same thing for
marking a shared mapped page dirty.  Because if we mark the underlying
page dirty before we have flushed the TLB's, other CPU's may happily
continue to write to the page (using their stale TLB contents) after
we've marked the page dirty, and they can thus race with any cleaning
operation.

Now, in practice, any page cleaning operations will take much longer to
start the IO on the page than it will have taken us to get to the TLB
flush, so this is going to be hard to trigger in real life.  In fact, so
far nobody has even come up with a reasonable test-case for this to show
it happening.

But what we do now (set_page_dirty() before flushing the TLB) really is
wrong.  And this commit does not fix it, but by moving the dirty
handling into the TLB gather operation at least the internal interfaces
now support the notion of those TLB gather interfaces doing the rigth
thing.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm/include/asm/tlb.h  |  6 ++++--
 arch/ia64/include/asm/tlb.h |  6 ++++--
 arch/s390/include/asm/tlb.h |  4 +++-
 arch/sh/include/asm/tlb.h   |  6 ++++--
 arch/um/include/asm/tlb.h   |  6 ++++--
 include/asm-generic/tlb.h   |  4 ++--
 mm/hugetlb.c                |  4 +---
 mm/memory.c                 | 15 +++++++++------
 8 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 0baf7f0d9394..ac9c16af8e63 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -165,8 +165,10 @@ tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 		tlb_flush(tlb);
 }
 
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty)
 {
+	if (dirty)
+		set_page_dirty(page);
 	tlb->pages[tlb->nr++] = page;
 	VM_BUG_ON(tlb->nr > tlb->max);
 	return tlb->max - tlb->nr;
@@ -174,7 +176,7 @@ static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	if (!__tlb_remove_page(tlb, page))
+	if (!__tlb_remove_page(tlb, page, 0))
 		tlb_flush_mmu(tlb);
 }
 
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index bc5efc7c3f3f..9049a7d6427d 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -193,8 +193,10 @@ tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
  * must be delayed until after the TLB has been flushed (see comments at the beginning of
  * this file).
  */
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty)
 {
+	if (dirty)
+		set_page_dirty(page);
 	tlb->need_flush = 1;
 
 	if (!tlb->nr && tlb->pages == tlb->local)
@@ -213,7 +215,7 @@ static inline void tlb_flush_mmu(struct mmu_gather *tlb)
 
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	if (!__tlb_remove_page(tlb, page))
+	if (!__tlb_remove_page(tlb, page, 0))
 		tlb_flush_mmu(tlb);
 }
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index c544b6f05d95..8107a8c53985 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -76,8 +76,10 @@ static inline void tlb_finish_mmu(struct mmu_gather *tlb,
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
  * has already been freed, so just do free_page_and_swap_cache.
  */
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty)
 {
+	if (dirty)
+		set_page_dirty(page);
 	free_page_and_swap_cache(page);
 	return 1; /* avoid calling tlb_flush_mmu */
 }
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 362192ed12fe..428de7858d27 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -90,15 +90,17 @@ static inline void tlb_flush_mmu(struct mmu_gather *tlb)
 {
 }
 
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, int dirty)
 {
+	if (dirty)
+		set_page_dirty(page);
 	free_page_and_swap_cache(page);
 	return 1; /* avoid calling tlb_flush_mmu */
 }
 
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	__tlb_remove_page(tlb, page);
+	__tlb_remove_page(tlb, page, 0);
 }
 
 #define pte_free_tlb(tlb, ptep, addr)	pte_free((tlb)->mm, ptep)
diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
index 29b0301c18aa..df557f987819 100644
--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -86,8 +86,10 @@ tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
  *	while handling the additional races in SMP caused by other CPUs
  *	caching valid mappings in their TLBs.
  */
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty)
 {
+	if (dirty)
+		set_page_dirty(page);
 	tlb->need_flush = 1;
 	free_page_and_swap_cache(page);
 	return 1; /* avoid calling tlb_flush_mmu */
@@ -95,7 +97,7 @@ static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	__tlb_remove_page(tlb, page);
+	__tlb_remove_page(tlb, page, 0);
 }
 
 /**
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 5672d7ea1fa0..541c563f0ff9 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -116,7 +116,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm, unsigned long
 void tlb_flush_mmu(struct mmu_gather *tlb);
 void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start,
 							unsigned long end);
-int __tlb_remove_page(struct mmu_gather *tlb, struct page *page);
+int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty);
 
 /* tlb_remove_page
  *	Similar to __tlb_remove_page but will call tlb_flush_mmu() itself when
@@ -124,7 +124,7 @@ int __tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	if (!__tlb_remove_page(tlb, page))
+	if (!__tlb_remove_page(tlb, page, 0))
 		tlb_flush_mmu(tlb);
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 246192929a2d..dfbe23c0c200 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2516,11 +2516,9 @@ again:
 
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
 		tlb_remove_tlb_entry(tlb, ptep, address);
-		if (huge_pte_dirty(pte))
-			set_page_dirty(page);
 
 		page_remove_rmap(page);
-		force_flush = !__tlb_remove_page(tlb, page);
+		force_flush = !__tlb_remove_page(tlb, page, huge_pte_dirty(pte));
 		if (force_flush) {
 			spin_unlock(ptl);
 			break;
diff --git a/mm/memory.c b/mm/memory.c
index d0f0bef3be48..62fdcd1995f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -277,12 +277,15 @@ void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long e
  *	mappings in their TLBs. Returns the number of free page slots left.
  *	When out of page slots we must call tlb_flush_mmu().
  */
-int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty)
 {
 	struct mmu_gather_batch *batch;
 
 	VM_BUG_ON(!tlb->need_flush);
 
+	/* FIXME! This needs to be batched too */
+	if (dirty)
+		set_page_dirty(page);
 	batch = tlb->active;
 	batch->pages[batch->nr++] = page;
 	if (batch->nr == batch->max) {
@@ -1124,11 +1127,11 @@ again:
 					pte_file_mksoft_dirty(ptfile);
 				set_pte_at(mm, addr, pte, ptfile);
 			}
-			if (PageAnon(page))
+			if (PageAnon(page)) {
+				/* We don't bother saving dirty state for anonymous pages */
+				ptent = pte_mkclean(ptent);
 				rss[MM_ANONPAGES]--;
-			else {
-				if (pte_dirty(ptent))
-					set_page_dirty(page);
+			} else {
 				if (pte_young(ptent) &&
 				    likely(!(vma->vm_flags & VM_SEQ_READ)))
 					mark_page_accessed(page);
@@ -1137,7 +1140,7 @@ again:
 			page_remove_rmap(page);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
-			force_flush = !__tlb_remove_page(tlb, page);
+			force_flush = !__tlb_remove_page(tlb, page, pte_dirty(ptent));
 			if (force_flush)
 				break;
 			continue;
-- 
1.9.1.377.g96e67c8.dirty

From d26515fe19d5850aa69881ee6ae193e068f22ba1 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2014 17:35:35 -0700
Subject: [PATCH 2/2] mm: make the generic TLB flush batching correctly dirty
 the page at the end

When unmapping dirty shared mappings, the page should be dirtied after
doing the TLB flush.  This does that by hiding the dirty bit in the low
bit of the "struct page" pointer in the TLB gather batching array, and
teaching free_pages_and_swap_cache() to mark the pages dirty at the end.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 mm/memory.c     |  5 +----
 mm/swap.c       |  8 +++++++-
 mm/swap_state.c | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 62fdcd1995f4..174542ab2b90 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -283,11 +283,8 @@ int __tlb_remove_page(struct mmu_gather *tlb, struct page *page, bool dirty)
 
 	VM_BUG_ON(!tlb->need_flush);
 
-	/* FIXME! This needs to be batched too */
-	if (dirty)
-		set_page_dirty(page);
 	batch = tlb->active;
-	batch->pages[batch->nr++] = page;
+	batch->pages[batch->nr++] = (void *) (dirty + (unsigned long)page);
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return 0;
diff --git a/mm/swap.c b/mm/swap.c
index 9ce43ba4498b..1a58c58c7f41 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -821,8 +821,14 @@ void release_pages(struct page **pages, int nr, int cold)
 	struct lruvec *lruvec;
 	unsigned long uninitialized_var(flags);
 
+	/*
+	 * NOTE! The low bit of the struct page pointer in
+	 * the "pages[]" array is used as a dirty bit, so
+	 * we ignore it
+	 */
 	for (i = 0; i < nr; i++) {
-		struct page *page = pages[i];
+		unsigned long pageval = (unsigned long)pages[i];
+		struct page *page = (void *)(~1ul & pageval);
 
 		if (unlikely(PageCompound(page))) {
 			if (zone) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e76ace30d436..bb0b2d675a82 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -258,6 +258,11 @@ void free_page_and_swap_cache(struct page *page)
 /*
  * Passed an array of pages, drop them all from swapcache and then release
  * them.  They are removed from the LRU and freed if this is their last use.
+ *
+ * NOTE! The low bit of the "struct page" pointers passed in is a dirty
+ * indicator, saying that the page needs to be marked dirty before freeing.
+ *
+ * release_pages() itself ignores that bit.
  */
 void free_pages_and_swap_cache(struct page **pages, int nr)
 {
@@ -268,8 +273,13 @@ void free_pages_and_swap_cache(struct page **pages, int nr)
 		int todo = min(nr, PAGEVEC_SIZE);
 		int i;
 
-		for (i = 0; i < todo; i++)
-			free_swap_cache(pagep[i]);
+		for (i = 0; i < todo; i++) {
+			unsigned long pageval = (unsigned long) pagep[i];
+			struct page *page = (void *)(~1ul & pageval);
+			if (pageval & 1)
+				set_page_dirty(page);
+			free_swap_cache(page);
+		}
 		release_pages(pagep, todo, 0);
 		pagep += todo;
 		nr -= todo;
-- 
1.9.1.377.g96e67c8.dirty
