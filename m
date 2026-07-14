Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F63655F4;
	Tue, 14 Jul 2026 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997125; cv=none; b=u+tLQCn1VLga/NRuQweNC6S/sf/4ZGLuS7I/mseZ2XiPQaEsX6EPVy+hu56lIrA4aEoOK/MCsF0vOC+rJr8uUzGR2NzFQLeAg9HD8p+PrRmcL27euoGjVK7y12m2TaUxoVMUwKsQjtFwYxzgLW3Pi4JtXiSbC86ncL2W8Ule8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997125; c=relaxed/simple;
	bh=5MAFloAc3GTiCVj/jV42l3HY1PvEXBDwzcrBAvGk5LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQs89WYYRT0l5hQ92kltEsJyTQuo0cxG9eDJXp6aSej+0YP/Dg6r/CFVPeISkQYITUhdmgW2SkjqOZKv/9actWMoc4xek+abGuX1UY30PW9HOUM6Dl+6X9zk7NsA0Vic3CMYh6w6hQOKAukOtzpLasQOwISVHKikas5KDh/rWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMJ2w4Zw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMJ2w4Zw"
Message-ID: <993afd58-e503-46aa-acaf-19243b0d147c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783997117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nb7XE0WKxPNCmW2jzzoEfyvfKdOTIP2EGQX42DdHNL8=;
	b=OMJ2w4ZwurgTTryrGfFSYG399nNWFddIFP0IbpfcqzSmC+cengYkbS2Uj3xx2QK/1Pozab
	5yb3IX4IJBBcgNeFk2ad9gLwpxighNPp65I9K7S8C9OjYD3sMQZWQJt/T49WYCKGx5++Qf
	JOHHqjCt1680A1SOSdk8++/jXsNzsRw=
Date: Tue, 14 Jul 2026 10:44:47 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/8] mm: factor zone-device page init helpers out of
 __init_zone_device_page
To: Li Zhe <lizhe.67@bytedance.com>
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
 david@kernel.org, kees@kernel.org, mingo@redhat.com, rppt@kernel.org,
 tglx@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-3-lizhe.67@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-3-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/9 19:25, Li Zhe wrote:
> memmap_init_zone_device() currently mixes refcount policy and core
> ZONE_DEVICE page setup in a single helper.
>
> Factor the refcount-reset predicate into pagemap_resets_refcount(), move
> the common page initialization into __zone_device_page_init(), and wrap
> the existing slow path in zone_device_page_init_slow().

Hi,

Sorry if this has been discussed before, but I'm still curious—what
is the significance of the 'slow' suffix here? I don't think I quite
understand why this is called the 'slow path' here. Is there also a
'fast path' for initializing struct page?

Thanks.

>
> This keeps the slow-path behaviour unchanged and gives later patches
> reusable helper boundaries.
>
> No functional change intended.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   mm/mm_init.c | 56 ++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 95808ab5cfdb..5fccfbacf855 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>   }
>   
>   #ifdef CONFIG_ZONE_DEVICE
> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> +/*
> + * Return true when the free path for this pagemap type restores the page
> + * refcount to 1, so memmap_init_zone_device() can keep the count set by
> + * __init_single_page(). Otherwise initialize the refcount to 0 and leave
> + * it to the allocator or pgmap callbacks to raise it when the page is
> + * handed out again.
> + */
> +static inline bool pagemap_resets_refcount(const struct dev_pagemap *pgmap)
> +{
> +	/*
> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> +	 * the count again when the allocator or driver hands the page out.
> +	 */
> +	switch (pgmap->type) {
> +	case MEMORY_DEVICE_FS_DAX:
> +	case MEMORY_DEVICE_PRIVATE:
> +	case MEMORY_DEVICE_COHERENT:
> +	case MEMORY_DEVICE_PCI_P2PDMA:
> +		return false;
> +	case MEMORY_DEVICE_GENERIC:
> +		return true;
> +	}
> +
> +	return true;
> +}
> +
> +static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
>   					  unsigned long zone_idx, int nid,
>   					  struct dev_pagemap *pgmap)
>   {
> -
>   	__init_single_page(page, pfn, zone_idx, nid);
>
>   	/*
> @@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>   	 */
>   	page_folio(page)->pgmap = pgmap;
>   	page->zone_device_data = NULL;
> +}
>
> -	/*
> -	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> -	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> -	 * the count again when the allocator or driver hands the page out.
> -	 */
> -	switch (pgmap->type) {
> -	case MEMORY_DEVICE_FS_DAX:
> -	case MEMORY_DEVICE_PRIVATE:
> -	case MEMORY_DEVICE_COHERENT:
> -	case MEMORY_DEVICE_PCI_P2PDMA:
> +static void __ref zone_device_page_init_slow(struct page *page,
> +		unsigned long pfn, unsigned long zone_idx, int nid,
> +		struct dev_pagemap *pgmap)
> +{
> +	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
> +	if (!pagemap_resets_refcount(pgmap))
>   		set_page_count(page, 0);
> -		break;
> -
> -	case MEMORY_DEVICE_GENERIC:
> -		break;
> -	}
>   }
>
>   /*
> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
>   	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
>   		struct page *page = pfn_to_page(pfn);
>
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>   		prep_compound_tail(page, head, order);
>   		set_page_count(page, 0);
>   	}
> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>   		struct page *page = pfn_to_page(pfn);
>
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>
>   		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>   			cond_resched();
> --
> 2.20.1

