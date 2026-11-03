Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675321;
	b=40P2XjDS9r/A4LUl4R+YVwdjbb0jI69rdwCiN2v9Uj9mDSxokma/QOJq0SjGka9yQTzI
	 s2/PYTgW3hH0c0bOT/IACqCGef3R/l76lF8PH38KU8WduqMRgJDeK+hTWOepmzG49+JQt
	 6aYD+l91K4N5k9E637RlnAah6dfu3s8BUYB1pXNs/+PO4iL1ryRL4qCjCQvd5IQzzzBxy
	 l96s1X8l1LEyUsvOK9/10L2qivai00VPhFrkfj0TPn1g6+QSZjaZ3tJG43QT/75jYZPb8
	 YGbHmVBkwWAY7yaZ9jUOLjqSW0qJS7ZptTA2k/9NZjfEzKE/7ZZlm+VqdzFCYJbxNxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675321;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TcMB+7TMi2bLazC/QSSJVb+dN6unmraBocObaaHDrh4=;
	b=hC5B85klbJPVpOdR+fe6UiW6A4RGHAxLNHRQ3mR49dm/ckTUpzMZaf9jciK2W5dmFc/N
	 qiBRnVWwS0Fs+kzK1ja2hCAD2vo1O9rctAyKoclmidBWb92P0TKmuHukVr9TWpC+kekIl
	 2gLEEeV5XG0Ssbp4yfDJxa3tT4F6ycHue5ztpkHKaS1khfxrs1/nC4ffU/RuFts4AtKb+
	 CH4/vtyDh78bKQZW74yJRsDiQDSPkwBq26qIsGg7tgoZNbc2+WtcLthEYQzUR6p0S638+
	 NluuR5AtBG2hNZJldqY6NL81ARwLNHJMcbCxi45ChIwgPDLizg3khZbGMCdCEocDaVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y2iwApll;
	arc=none smtp.remote-ip=95.215.58.102
Received: from mta1.migadu.com (out-102.mta1.migadu.com [95.215.58.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BE606A329
	for <linux-arch@vger.kernel.org>; Tue,  3 Nov 2026 03:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8BE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y2iwApll
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9TIi4e+jhWvSVLJqdtmuDmhXX3FHNuF+HLGG6Up3ljY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793675312; v=1; x=1794280112;
 b=Y2iwAplloUzu5bm58twpXtkXG9/CIrmyyFjmR4r0iZ7mcki0wVTD3/AcJHdq+jFn4PndzStX
 io6vtdlQDs6nSNxk8e+ryodh7MtiPa/Xh/QOKBFWs0SWrKpNhZ4OClnOc5QavHY8x0cvltw7H2d
 27+v3+F5MDZwhvhc2vc48Ozo=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59608abf10f0d8e0;
	Tue, 03 Nov 2026 03:08:32 +0000
X-Mizu-Trace-ID: 59608abf10f0d8e0
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 32/47] mm/mremap: fix moving PUD leaves
Date: Tue,  3 Nov 2026 11:08:26 +0800
Message-ID: <20261103030826.79600-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-32-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-32-d6437171ecc3@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:40:01AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>pud_none_or_clear_bad() only really works on page tables. PUD leaves
>confuse the check and make us clear the page table entry and print a
>warning.
>
>Since commit aed877c2b4257 ("device/dax: properly refcount device dax pages
>when mapping"), this also leaks device-DAX folio references, mapcounts
>and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.
>
>Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
>whole or the move fails, split it. This unmaps it with proper accounting
>instead of treating the leaf entry as a PMD table.
>
>Keep using pud_trans_huge() for now, in the future this code should be
>cleaned up to just check for PUD leaves.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: fallthrough after splitting ]
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/mremap.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index 91f0865f6aeea..1237718848f5c 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -87,7 +87,7 @@ static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> 		return NULL;
> 
> 	pud = pud_offset(p4d, addr);
>-	if (pud_none_or_clear_bad(pud))
>+	if (!pud_trans_huge(*pud) && pud_none_or_clear_bad(pud))
> 		return NULL;
> 
> 	return pud;
>@@ -847,11 +847,10 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
> 		if (!new_pud)
> 			break;
> 		if (pud_trans_huge(*old_pud)) {
>-			if (extent == HPAGE_PUD_SIZE) {
>-				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
>-				/* We ignore and continue on error? */
>+			if (extent == HPAGE_PUD_SIZE &&
>+			    move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud))
> 				continue;
>-			}
>+			split_huge_pud(pmc->old, old_pud, pmc->old_addr);

Right, copy_vma() already sets up the file and offset at the new address,
so we can let subsequent faults rebuild the mapping.

No need to build a PMD table just for the move ;)

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
> 			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
> 				continue;
>
>-- 
>2.43.0
>
>
