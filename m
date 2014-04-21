From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: Dirty/Access bits vs. page content
Date: Mon, 21 Apr 2014 15:44:24 -0700
Message-ID: <53559F48.8040808@intel.com>
References: <1398032742.19682.11.camel@pasglop>	<CA+55aFz1sK+PF96LYYZY7OB7PBpxZu-uNLWLvPiRz-tJsBqX3w@mail.gmail.com>	<1398054064.19682.32.camel@pasglop>	<1398057630.19682.38.camel@pasglop>	<CA+55aFwWHBtihC3w9E4+j4pz+6w7iTnYhTf4N3ie15BM9thxLQ@mail.gmail.com>	<53558507.9050703@zytor.com> <CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050208060308010306080202"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46184 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493AbaDUWo0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Apr 2014 18:44:26 -0400
In-Reply-To: <CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050208060308010306080202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 04/21/2014 03:29 PM, Linus Torvalds wrote:
> Actually moving the dirty bit information into the batching is
> somewhat painful, because free_pages_and_swap_cache() really wants an
> array of 'struct page *', rather than some array of "page and dirty
> info". And that in turn is mainly because it then passes it down to
> release_pages(), rather than anything else. But it looks doable.

I came up with something pretty similar to what you've got.  I used some
local variables for the dirty state rather than using the pte, but
otherwise looks pretty similar.  It actually boots, runs, and
superficially looks to be doing the right thing.

I fixed free_pages_and_swap_cache() but just making a first pass through
the array and clearing the bits.

We probably need to make sure none of the other architectures have funky
uses calling tlb_remove_page() where they would need something other
than dirty=0.

--------------050208060308010306080202
Content-Type: text/x-patch;
 name="defer-setting-page-dirty-until-after-tlb-flush.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="defer-setting-page-dirty-until-after-tlb-flush.patch"



---

 b/include/asm-generic/tlb.h |   11 ++++++--
 b/mm/hugetlb.c              |    5 ++-
 b/mm/memory.c               |   57 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 10 deletions(-)

diff -puN mm/memory.c~defer-setting-page-dirty-until-after-tlb-flush mm/memory.c
--- a/mm/memory.c~defer-setting-page-dirty-until-after-tlb-flush	2014-04-21 14:28:17.892798969 -0700
+++ b/mm/memory.c	2014-04-21 15:24:17.596775818 -0700
@@ -232,6 +232,39 @@ void tlb_gather_mmu(struct mmu_gather *t
 #endif
 }
 
+/*
+ * When we cleared the dirty bit out of the pte, we collected it
+ * in the low bit of the __pages[] pointers.  Here, after we have
+ * cleared the TLB, we can safely set_page_dirty() knowing that
+ * any new writers will have had to re-set the dirty bit in the
+ * new pte.
+ */
+struct page **mmu_batch_shift_dirty(struct mmu_gather_batch *batch)
+{
+	int i;
+	for (i = 0; i < batch->nr; i++) {
+		struct page *page;
+		unsigned long __page = batch->__pages[i];
+		int dirty = __page & 0x1;
+		if (dirty) {
+			/*
+			 * clear the bit in the 'struct page'
+			 * pointer so we can use it again
+			 */
+			batch->__pages[i] = __page;
+			__page &= ~0x1;
+			page = (struct page *)__page;
+			set_page_dirty(page);
+		}
+	}
+	/*
+	 * Now that we have cleared the dirty bits out of the
+	 * pointers, we can act like it is just a normal array
+	 * of 'struct page' pointers.
+	 */
+	return (struct page **)&batch->__pages;
+}
+
 void tlb_flush_mmu(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
@@ -245,7 +278,8 @@ void tlb_flush_mmu(struct mmu_gather *tl
 #endif
 
 	for (batch = &tlb->local; batch; batch = batch->next) {
-		free_pages_and_swap_cache(batch->pages, batch->nr);
+		struct page **pages = mmu_batch_shift_dirty(batch);
+		free_pages_and_swap_cache(pages, batch->nr);
 		batch->nr = 0;
 	}
 	tlb->active = &tlb->local;
@@ -277,14 +311,25 @@ void tlb_finish_mmu(struct mmu_gather *t
  *	mappings in their TLBs. Returns the number of free page slots left.
  *	When out of page slots we must call tlb_flush_mmu().
  */
-int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+int __tlb_remove_page(struct mmu_gather *tlb, struct page *page,
+			int need_mark_page_dirty)
 {
 	struct mmu_gather_batch *batch;
+	unsigned long __page;
 
 	VM_BUG_ON(!tlb->need_flush);
 
 	batch = tlb->active;
-	batch->pages[batch->nr++] = page;
+	__page = (unsigned long)page;
+	VM_BUG_ON(__page & 0x1);
+	/*
+	 * Stash the information about the page's dirty status
+	 * in a low bit and keep it until after we actually
+	 * flush the TLB.
+	 */
+	if (need_mark_page_dirty)
+		__page |= 0x1;
+	batch->__pages[batch->nr++] = __page;
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return 0;
@@ -1091,6 +1136,7 @@ again:
 
 		if (pte_present(ptent)) {
 			struct page *page;
+			int need_mark_page_dirty = 0;
 
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(details) && page) {
@@ -1128,7 +1174,7 @@ again:
 				rss[MM_ANONPAGES]--;
 			else {
 				if (pte_dirty(ptent))
-					set_page_dirty(page);
+					need_mark_page_dirty = 1;
 				if (pte_young(ptent) &&
 				    likely(!(vma->vm_flags & VM_SEQ_READ)))
 					mark_page_accessed(page);
@@ -1137,7 +1183,8 @@ again:
 			page_remove_rmap(page);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
-			force_flush = !__tlb_remove_page(tlb, page);
+			force_flush = !__tlb_remove_page(tlb, page,
+						need_mark_page_dirty);
 			if (force_flush)
 				break;
 			continue;
diff -puN mm/hugetlb.c~defer-setting-page-dirty-until-after-tlb-flush mm/hugetlb.c
--- a/mm/hugetlb.c~defer-setting-page-dirty-until-after-tlb-flush	2014-04-21 14:29:50.764012322 -0700
+++ b/mm/hugetlb.c	2014-04-21 15:02:59.666200259 -0700
@@ -2476,6 +2476,7 @@ void __unmap_hugepage_range(struct mmu_g
 	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
 again:
 	for (address = start; address < end; address += sz) {
+		int pte_was_dirty = 0;
 		ptep = huge_pte_offset(mm, address);
 		if (!ptep)
 			continue;
@@ -2517,10 +2518,10 @@ again:
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
 		tlb_remove_tlb_entry(tlb, ptep, address);
 		if (huge_pte_dirty(pte))
-			set_page_dirty(page);
+			pte_was_dirty = 1;
 
 		page_remove_rmap(page);
-		force_flush = !__tlb_remove_page(tlb, page);
+		force_flush = !__tlb_remove_page(tlb, page, pte_was_dirty);
 		if (force_flush) {
 			spin_unlock(ptl);
 			break;
diff -puN include/asm-generic/tlb.h~defer-setting-page-dirty-until-after-tlb-flush include/asm-generic/tlb.h
--- a/include/asm-generic/tlb.h~defer-setting-page-dirty-until-after-tlb-flush	2014-04-21 14:30:14.423086322 -0700
+++ b/include/asm-generic/tlb.h	2014-04-21 15:00:48.965275609 -0700
@@ -72,7 +72,11 @@ struct mmu_gather_batch {
 	struct mmu_gather_batch	*next;
 	unsigned int		nr;
 	unsigned int		max;
-	struct page		*pages[0];
+	/*
+	 * a 'struct page *' array, but with the low bit
+	 * representing the dirty state of the page
+	 */
+	unsigned long		__pages[0];
 };
 
 #define MAX_GATHER_BATCH	\
@@ -116,7 +120,8 @@ void tlb_gather_mmu(struct mmu_gather *t
 void tlb_flush_mmu(struct mmu_gather *tlb);
 void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start,
 							unsigned long end);
-int __tlb_remove_page(struct mmu_gather *tlb, struct page *page);
+int __tlb_remove_page(struct mmu_gather *tlb, struct page *page,
+			int need_set_page_dirty);
 
 /* tlb_remove_page
  *	Similar to __tlb_remove_page but will call tlb_flush_mmu() itself when
@@ -124,7 +129,7 @@ int __tlb_remove_page(struct mmu_gather
  */
 static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	if (!__tlb_remove_page(tlb, page))
+	if (!__tlb_remove_page(tlb, page, 0))
 		tlb_flush_mmu(tlb);
 }
 
_

--------------050208060308010306080202--
