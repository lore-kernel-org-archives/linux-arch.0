Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607661;
	b=ECxqrApmqPDn7u6OJBV8EMTk901MxtHgqg5GqOv8JM2QBjbQVAFNEepc5Ww+KokzBfQ9
	 Mis0E71yXsmtYfUDO4f/SdVQaQei+5JR3F6tA0Ms9kvWFgcIG63xV6fCmdM7WDKEL+pBR
	 AP2Sri8prXYBxNnAkoZ8wWZcWWAIk1f7HtMADpB2Vb43vN5UhPmQ52OSwOfKyxo3wvDzl
	 HRBviC524CLKC5bnaFnpqerPq+sIP0RIogYwOIdhfjdjVbiia9Jw7AhbeLamhr0LY9Lby
	 tYF0C19g0v3boe9JyfwcDwtE3kxyFOfmWh+2GhDL2pBaO8TdDfk6SOBelYoQzCcG8GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607661;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uBfJJilvsrye3sZPINSFwLYLhpZUOxlraaYo4APzklo=;
	b=hDSZTjlzKtW+rhicdd7T8KKEZWHnrYO41e4XrmAYiU3//nSEsBKKYBrrg5bvwHS1Oq3y
	 DEt/RP0Rq/xyQ0y1rJjlsBQ1NUnTCTmlpb6YaXu1l3DCwW1FC5Yphn7xHg5dtK1gWVDMb
	 lGbafeCzwBQVfzDwgDAJWA3K4A4Z2K0TWvIzOC7hMiRoF+198miJVsG+eKJV/bKMAMZoT
	 FZvdo/Cjb1q2FGpq35faX2VlwlC5JzA0JqRjF+c+Qya8M26wuthFTqJIVyBDTj/u98LCF
	 LdZ6lcjBE92/8UfFrijgxbhSElIvp1HA34/8+B3QswYiDXp8nMNTtZp7SucpscVBPvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="Cv/ZBqya";
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69331606A329;
	Mon,  2 Nov 2026 08:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69331606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Cv/ZBqya
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793607654; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uBfJJilvsrye3sZPINSFwLYLhpZUOxlraaYo4APzklo=;
	b=Cv/ZBqyauKvpIiJsJbve1p37lt8DylOPEhkkaGir9F1MTv6bCr/eHTIDxKR+sEqsF6Cn+1n+FH+8RJREwX1PgRCbK+TnwQ8Lz1QisKs847CGaBtygoMIWG6dRL2gyLz5I/LVvgpbEe4PFLJGISKxPFwNJonBdcFusDNrFDvunjU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=64;SR=0;TI=SMTPD_---0XDw-lN._1793607648;
Received: from 30.74.144.167(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDw-lN._1793607648 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 16:20:50 +0800
Message-ID: <62268831-f6f3-4666-a32f-a77546b95432@linux.alibaba.com>
Date: Mon, 2 Nov 2026 16:20:47 +0800
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/47] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@arm.com>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/26 5:39 PM, David Hildenbrand (Arm) wrote:
> The existing code is rather horrible and already resulted in bugs in the
> past: we special-case UFFD inserting anonymous folios by grabbing the PMD
> lock early, but ignore any other markers (guard, poison through uffd) that
> could have been inserted into the page table in the meantime, effectively
> dropping them.
> 
> Let's just unify and simplify the locking: try to grab the PMD table
> lock and if that fails, flush the TLB, drop the PTE lock, take PT locks in
> the right order and check if the page table is still empty.
> 
> We still perform the heavy lifting (zapping the folio ptes) under PTE table
> lock only.
> 
> Include <linux/hugetlb.h> for now, as x86's flush_tlb_range() macro
> depends on hugetlb helpers. This dependency needs a separate cleanup.
> 
> Both issues this fixes are rather corner cases. Let's not CC stable for
> now.
> 
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>   mm/khugepaged.c | 64 ++++++++++++++++++++++++++++-----------------------------
>   1 file changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ce794d9760a87..ad07c8caa3bd9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -10,6 +10,7 @@
>   #include <linux/mm_inline.h>
>   #include <linux/kthread.h>
>   #include <linux/khugepaged.h>
> +#include <linux/hugetlb.h>
>   #include <linux/freezer.h>
>   #include <linux/mman.h>
>   #include <linux/hashtable.h>
> @@ -1832,6 +1833,17 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
>   	return SCAN_SUCCEED;
>   }
>   
> +static bool pte_table_empty(pte_t *pte)
> +{
> +	int i;
> +
> +	for (i = 0; i < HPAGE_PMD_NR; i++, pte++) {

Using PTRS_PER_PTE to iterate PTEs seems more straightforward? Otherwise 
LGTM.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
