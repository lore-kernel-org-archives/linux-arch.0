Received: from outbound.ms.icloud.com (p-west3-cluster6-host4-snip4-10.eps.apple.com [57.103.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4B344044
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777614991; cv=none; b=Py9u9utN4gQpbnaeeTJoHFKdPHEunosOkuZrbjd5xYx8RM7rEqplMyr0JL2YonTXdbs5QN6qoO4dhkR6+LS9g9wfTfBdBQ6HTZzEcJFPruBtIJD++TMy4WrXUfBIrSreEypn9ScGJscCUp18uu/NdJT3e9I3WNqnCj5oQe9aHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777614991; c=relaxed/simple;
	bh=bQLkhy/GMOtgXMDL30CjqTGiS0lt2sy/G/NQIeeXbwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHuBB+H3Fj40b6p9U+koyYwO7KVpfr3H7nffazWAMwtdv1WSQXuffzB4t7PF1g/iTi3u8RJR7NTkc/AxDdSgGhNqncM/zplY7yE0b3g/m8+cVCHeNJ4pe8UvUuDWC/ksvd3rdr/hcAJRFz+73JKGBwDReWUb5dVrwSFd8pl+lLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rYMz/l11; arc=none smtp.client-ip=57.103.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rYMz/l11"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPS id 2C8B71800400;
	Fri, 01 May 2026 05:56:25 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPXwdZBEAMSAJAQwNCL1oXREBBWh9FFEgDWARcBUQBSwReDytGFVcbVgNDRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777614989; x=1780206989; bh=7N+z8NTKNzTfnk4CNz4j1nHwx7t72Y+uiy3ixa6NunI=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=rYMz/l11sQIIMMiwoXLPBByVSm5dpjYPWZRJSvWpAIgolZazq6euFxPI+Jy6cZGj3YTX09Yj8Y+tGNUnIv4zGRR/mtHIw1VW5zRqwkKgK8reqJCqQRX1l5UreyKBT1KrekXN/KYn4/xDT4BdwVL43ajxYaqplk61mh+j7z/5JkarfUV+f+Tc+FTArQfIJ6WtMlMgbdJlobgyEz2yCdJaMs0QZBCxyGCWoxWwOk9ivTWwxyQZFMzrRM3bmy1BbW18Kf3C1i4eCdelH6Szz4SHaeSGfv7o2NvahqSexmAj1olEXz/ZPIhQGA5mXoQng5gkwjhB5ZGNpx9x7qwD0I0Cag==
Received: from [127.0.0.1] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPSA id 576791800401;
	Fri, 01 May 2026 05:56:19 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Fri, 01 May 2026 13:55:46 +0800
Subject: [PATCH 5/5] mm: support choosing to do THP COW for anonymous pmd
 entry.
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-thp_cow-v1-5-005377483738@tencent.com>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
In-Reply-To: <20260501-thp_cow-v1-0-005377483738@tencent.com>
To: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777614950; l=7099;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=PFGHhjK+TnZW9Z6ghtvzoKwlLu7cEjIWo9wxf6XDzvc=;
 b=t+G004ry0cf1bDvr6aUyhg1633TW+1DsSigwn6pJTC2qqMq4foBJlk0IbzzyT6hS4AnxrRphz
 X3f1dK9FyNIBzqzvDm8d74YSHMcxPBEcSGypXJBywwXXV2qBONCbLTI
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA1NCBTYWx0ZWRfX0akgOBOh0fYa
 Q+E2GaHK68Txx9IL647qqsmdwS/up6JF9dDw2h1c4yqw0OEEwue545bPA67GdZ9svbu0bDB/emT
 rbXu4+/7p0yCRh/QRYJw26RwRrN9POINQnnACAhfqv6SGeKqavTwQpI5e7UfHhY31Vt9hqZnWqt
 xzQKwEbSe4JXtnOvH+v4FmHc84tPsSQSSiNmswPSwuddoyPGc//cJUcD77cT8sFl6yYe7rgTz1K
 Tq/9iJQXV66RLvaeYK12FWDNKL9WNQY1WveOXcsiA8ii9vv1TRMHTANtUU8+jrKPMRIlHYvih5A
 CB30DllqzbyAkv9dzL3GQukV5w6KCcgQpacjqX0YYY2eRecBbJgkejRJs3/wtI=
X-Authority-Info-Out: v=2.4 cv=F9Bat6hN c=1 sm=1 tr=0 ts=69f4408b
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=bJ5UqtxypIKHvNYtotEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KfOtRRhL_HN1WoZjM0WIgLjaKfm-9Rka
X-Proofpoint-GUID: KfOtRRhL_HN1WoZjM0WIgLjaKfm-9Rka

From: Luka Bai <lukabai@tencent.com>

For pmd mapped anonymous folios, we currently do not do COW for the
whole vma region, because we don't want to copy and unshare the full
PMD range on the first write fault.

That proposal holds for the most workloads, however, that also makes
the pmd entry split into 512 4K ptes in the child process after we
write on a part of the folio.

For example, if process A and B share a pmd sized folio, if B does
writing on a small region, its pmd mapping will be split into 511
4K ptes which still point to the original pmd sized folio, and 1 4K
pte pointing to the new 4K page.

This is quite good for memory utilization, but it also make the tlb gain
caused by pmd entry suddenly "vanish" after a simple write, which
causes a observable performance decrease in some workloads. And also,
it adds some "uncertainty" to the THP since it does splitting
transparently in the COW scenorio which sometimes can cause trouble
to ones that need stable hugepages.

This patch adds support for pmd sized COW of anonymous page with
switch controlling. The reason we add switch is that for some scenorio,
the performance matters more, but for other workloads maybe the memory
waste is more unbearable. So we can use the THP setup to control this
configuration, either on the vma level or the global level.

The patch is relatively simple, we add function wp_huge_pmd_page_copy
to do the hugepage copy on write part, and do the allocation, accouting
and cache flushing just like in 4K path. We use the newly reconstructed
map_anon_folio_pmd_pf to do the mapping since it can properly support
FAULT_FLAG_UNSHARE right now.

We remove the ref checking in do_huge_pmd_wp_page, since we have
supported copying the pmd folio right now, we'll check the refcount
in the following folio_ref_count to make sure if the folio can be
exclusively used. If not, we can always do copy on write for this
folio just like in do_wp_page when THP COW is enabled.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 mm/huge_memory.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e661b411b2e..a05a4456e5a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -40,6 +40,7 @@
 #include <linux/pgalloc.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/pagewalk.h>
+#include <linux/delayacct.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -2196,6 +2197,94 @@ static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf)
 	return ret;
 }
 
+static vm_fault_t wp_huge_pmd_page_copy(struct vm_fault *vmf, struct folio *old_folio)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	struct folio *new_folio = NULL;
+	struct page *new_page, *old_page;
+	unsigned long pmd_address = vmf->address & HPAGE_PMD_MASK;
+	struct mmu_notifier_range range;
+	vm_fault_t ret = 0;
+	int i;
+
+	delayacct_wpcopy_start();
+
+	old_page = folio_page(old_folio, 0);
+	ret = vmf_anon_prepare(vmf);
+	if (unlikely(ret)) {
+		if (ret != VM_FAULT_RETRY)
+			ret = VM_FAULT_FALLBACK;
+		goto out;
+	}
+
+	new_folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
+	if (unlikely(!new_folio)) {
+		ret = VM_FAULT_FALLBACK;
+		goto out;
+	}
+
+	if (copy_user_large_folio(new_folio, old_folio,
+		pmd_address, vma)) {
+		ret = VM_FAULT_HWPOISON;
+		goto out;
+	}
+
+	new_page = folio_page(new_folio, 0);
+	for (i = 0; i < HPAGE_PMD_NR; i++)
+		kmsan_copy_page_meta(new_page + i, old_page + i);
+
+	__folio_mark_uptodate(new_folio);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				pmd_address, pmd_address + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	spin_lock(vmf->ptl);
+	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
+		update_mmu_cache_pmd(vma, pmd_address, vmf->pmd);
+		ret = 0;
+		goto out_unlock;
+	}
+
+	flush_cache_range(vma, pmd_address, pmd_address + HPAGE_PMD_SIZE);
+	/*
+	 * Clear the pmd entry and flush it first, before updating the
+	 * pmd with the new entry, to keep TLBs on different CPUs in
+	 * sync.
+	 */
+	(void)pmdp_huge_clear_flush(vma, pmd_address, vmf->pmd);
+	/*
+	 * We just temporarily decrement the mm_counter here, and it will be added back in
+	 * map_anon_folio_pmd_pf below.
+	 */
+	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	map_anon_folio_pmd_pf(new_folio, vmf, true);
+	folio_remove_rmap_pmd(old_folio, old_page, vma);
+
+	spin_unlock(vmf->ptl);
+
+	mmu_notifier_invalidate_range_end(&range);
+	/* This put is for the folio_get() in the caller */
+	folio_put(old_folio);
+	free_swap_cache(old_folio);
+
+	/* This put is for decrementing refcount after we switch page table mapping */
+	folio_put(old_folio);
+
+	delayacct_wpcopy_end();
+	return 0;
+out_unlock:
+	spin_unlock(vmf->ptl);
+	mmu_notifier_invalidate_range_end(&range);
+out:
+	folio_put(old_folio);
+	if (new_folio)
+		folio_put(new_folio);
+
+	delayacct_wpcopy_end();
+	return ret;
+}
+
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
@@ -2204,12 +2293,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t orig_pmd = vmf->orig_pmd;
+	vm_fault_t ret;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
 	if (is_huge_zero_pmd(orig_pmd)) {
-		vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
+		ret = do_huge_zero_wp_pmd(vmf);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -2253,14 +2343,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		goto reuse;
 	}
 
-	/*
-	 * See do_wp_page(): we can only reuse the folio exclusively if
-	 * there are no additional references. Note that we always drain
-	 * the LRU cache immediately after adding a THP.
-	 */
-	if (folio_ref_count(folio) >
-			1 + folio_test_swapcache(folio) * folio_nr_pages(folio))
-		goto unlock_fallback;
 	if (folio_test_swapcache(folio))
 		folio_free_swap(folio);
 	if (folio_ref_count(folio) == 1) {
@@ -2282,6 +2364,31 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		return 0;
 	}
 
+	/*
+	 * Only do hugepage copy on write if the parameter setup supports it.
+	 */
+	if (!hugepage_cow_enabled(vma))
+		goto unlock_fallback;
+
+	/*
+	 * For vma without a vm_ops(anonymous vma), there should not be VM_SHARED or
+	 * VM_MAYSHARE types.
+	 */
+	VM_WARN_ON_ONCE_VMA(vma->vm_flags & (VM_SHARED | VM_MAYSHARE), vma);
+
+	folio_unlock(folio);
+	/*
+	 * Copy on write branch here.
+	 * We are about to unlock the ptl here, so we need to get folio before that
+	 * in case the folio gets freed in the meantime.
+	 */
+	folio_get(folio);
+	spin_unlock(vmf->ptl);
+	ret = wp_huge_pmd_page_copy(vmf, folio);
+	if (ret & VM_FAULT_FALLBACK)
+		goto fallback;
+	return ret;
+
 unlock_fallback:
 	folio_unlock(folio);
 	spin_unlock(vmf->ptl);

-- 
2.52.0

