Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42273E3DBB
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018305; cv=none; b=bDirSB4VTUMgGfbTFbh6yxDAqfnJGhpmzgtVeRqbU+0DxKCxBNs/KvLOVFZGzl5l/0mL21lBx6qdreYiH+ImMC7pGPP0eEWCijvp6Fn3Dj0g8IUw6Ir6/LKSD3szlfiYWPSxfxDtZNwb7VpAynaI4Wx6xhjigyJuV4IM/MbaeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018305; c=relaxed/simple;
	bh=SXoLxpn4jOEWqIFz4I7f0ToHEYGTtT7pNn5RF50R10A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEGZKMG3qjMOfi+IwED94E2eUQF510HrDtEj4zM0AX/qvolwDaKqckxINTJMzkaoFPZq3h2L8SiRzSf8S5+pKkKVwDVUcWQO6/Wii7nRhvz4iCHr9gwRGzFSfgi2es0j+rfUTOL+q4fEI/BN4cwumVOFxPJ3zzK3liGuQj3/Fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mOzRF47s; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mOzRF47s"
Message-ID: <08d40cad-8f61-4aba-9556-5a84067c6494@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784018295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/TOVltIv8GPU47lxpzdPKdqcZK9SsP+TbwAvBawLlM=;
	b=mOzRF47sNowHOJv3Ro+2smpWgvrVnbtSu3znbZPaqdsX6mmf+8GdvZV1Zkf0KgboqBb50T
	7OfeR5BfkHTmCzLsBIuvgr8rSzkNhxNDVXkqb+Hamf+qTxglcbNAHfp7RgdWvsUby3svmk
	Dd5ffzXrKaoxqfVWxQYV3Adw8KX/wZ4=
Date: Tue, 14 Jul 2026 16:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 4/8] mm: add a template-based fast path for zone-device
 page init
To: Li Zhe <lizhe.67@bytedance.com>
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
 david@kernel.org, kees@kernel.org, mingo@redhat.com, rppt@kernel.org,
 tglx@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-5-lizhe.67@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-5-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/9 19:25, Li Zhe wrote:
> memmap_init_zone_device() repeats nearly identical head-page
> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
> template through the existing slow path, refresh the PFN-dependent
> fields in that template before each copy, and memcpy it into each
> destination page.
>
> The optimized path assigns _refcount through the copied template, so
> keep it disabled when the page_ref_set tracepoint is enabled.
>
> This patch accelerates head-page initialization. The pfns_per_compound
> == 1 case gets the full benefit here, compound tails are handled in the
> next patch.
>
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
> path (pfns_per_compound == 1).
>
> Test procedure:
> Rebind the nd_pmem driver 30 times and collect the memmap initialization
> time from the pr_debug() output of memmap_init_zone_device().
>
> Base(v7.2-rc1):
>    First binding: 1456 ms
>    Average of subsequent rebinds: 244.28 ms
>
> With this patch and its prerequisites applied:
>    First binding: 1440 ms
>    Average of subsequent rebinds: 217.19 ms
>
> This reduces the average rebind time from 244.28 ms to 217.19 ms, or
> about 11%.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>   mm/mm_init.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 5fccfbacf855..170021e182e0 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1065,6 +1065,44 @@ static void __ref zone_device_page_init_slow(struct page *page,
>   		set_page_count(page, 0);
>   }
>   
> +static inline bool zone_device_page_init_optimization_enabled(void)
> +{
> +	/*
> +	 * The template fast path copies a preinitialized struct page image.
> +	 * Skip it when the page_ref_set tracepoint is enabled.
> +	 */
> +	return !page_ref_tracepoint_active(page_ref_set);

I'm not sure why we need to make this. I think we can go ahead and
perform this optimization unconditionally.

If we look at why the tracepoint was added in the first place, it's
clear that its primary purpose is for debugging, particularly regarding
why CMA memory pages cannot be allocated (see commit 95813b8faa0). But
at this stage, the struct page hasn't even been initialized yet; we
are currently in the middle of initialization. From the perspective of
the page being initialized, the user doesn't need to care at all about
how the reference count is changing. Therefore, I don't think we need to
include these checks. It would only increase the complexity of the code.

I suggest deleting this section of code to keep things simple.

Thanks.
> +}
> +
> +/*
> + * 'template' is a reusable page prototype rather than a strictly immutable
> + * object. Most ZONE_DEVICE fields stay constant across the pages covered by
> + * the current template, but section bits and page->virtual may still depend
> + * on the PFN. Refresh those PFN-dependent fields in the template before
> + * copying it into @page.
> + */
> +static inline void zone_device_page_update_template(struct page *template,
> +		unsigned long pfn)
> +{
> +	set_page_section_from_pfn(template, pfn);
> +#ifdef WANT_PAGE_VIRTUAL
> +	if (!is_highmem_idx(ZONE_DEVICE))
> +		set_page_address(template, __va(pfn << PAGE_SHIFT));
> +#endif
> +}
> +
> +static void zone_device_page_init_from_template(struct page *page,
> +		unsigned long pfn, struct page *template)
> +{
> +	/*
> +	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
> +	 * page. Update the PFN-dependent fields in place before copying it
> +	 * to the destination page.
> +	 */
> +	zone_device_page_update_template(template, pfn);
> +	memcpy(page, template, sizeof(*page));
> +}
> +
>   /*
>    * With compound page geometry and when struct pages are stored in ram most
>    * tail pages are reused. Consequently, the amount of unique struct pages to
> @@ -1120,6 +1158,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   				   unsigned long nr_pages,
>   				   struct dev_pagemap *pgmap)
>   {
> +	bool use_template = zone_device_page_init_optimization_enabled();
>   	unsigned long pfn, end_pfn = start_pfn + nr_pages;
>   	struct pglist_data *pgdat = zone->zone_pgdat;
>   	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> @@ -1127,6 +1166,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   	unsigned long zone_idx = zone_idx(zone);
>   	unsigned long start = jiffies;
>   	int nid = pgdat->node_id;
> +	struct page template;
>
>   	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>   		return;
> @@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>   		struct page *page = pfn_to_page(pfn);
>
> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> +		if (!use_template) {
> +			zone_device_page_init_slow(page, pfn, zone_idx,
> +						   nid, pgmap);
> +		} else if (pfn == start_pfn) {
> +			/*
> +			 * Seed the reusable head-page template from the
> +			 * first real struct page, because the existing
> +			 * page-init and pageblock helpers expect a real
> +			 * memmap entry rather than a stack object.
> +			 */
> +			zone_device_page_init_slow(page, pfn, zone_idx,
> +						   nid, pgmap);
> +			/* init template page */
> +			memcpy(&template, page, sizeof(*page));
> +		} else {
> +			zone_device_page_init_from_template(page, pfn,
> +							    &template);
> +		}
>
>   		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>   			cond_resched();
> --
> 2.20.1
>

