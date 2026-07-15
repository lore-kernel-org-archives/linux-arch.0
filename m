Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482431197C
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098207; cv=none; b=gtm5xL6EZMWrbmAVrZwZdnJK0PXnRLa1R07wyRqIE2FlDnFv8xxVoIL6TRHibDwayvnZ8x+qQTgwzcwpBI8ajR2nqwLDU45kZ8sUeFwNOKuF1okT4d6k/vaPK7XD2aGCz1b7/1m4p45KegqidQVip9uC1+cqsBXWk618Gu8aIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098207; c=relaxed/simple;
	bh=wY7nFfvNggnUV0oyqH/ROfQsrMha0bxghTRn3NDWX88=;
	h=To:References:From:Content-Type:Cc:Message-Id:Mime-Version:
	 Subject:Date:In-Reply-To; b=qzo5ldFExdn2WlrO+qCEGZ4yY+T7v6xu8QvTH2tLbY46Y41HYmCqWsTsn93+moX+MzhpNFqLOKI2jFzsC6GP2nenmILb7gy9/VEPu8IPH56k4EyrvzvS80iVP19FpxTqffOQm2VbDNsJipHrAh+J2m1CefEsepleCa9Q039mRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XV4IsHPJ; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XV4IsHPJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784098194; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=FzWaBi5nhk3zsziR24NjLg3C2/DMb81RzLM+luUQZKs=;
 b=XV4IsHPJXYJIfno/uxlgtr4Ag3Jy2ObFn+A4IfcLTywAY6RwvY2+K9o1e7fYnu3hx0/Ycu
 GMnzax5gTwe5wrA7B0phe07Dikr0XwjNq1co9Piiw9d3JodtiC0dxurZ5nvrTKsQbZrIeV
 ITlPchkjTIBZRXPE0Rtl82vi8GEDpwuP/+HaiO7F/SgGZiHaycX0nSuZ/HLEkbCe0/swIu
 pAM8bZNZQxJ5UyIaopdRFbelCTdnMWj+dhOsBqRQZTM4Ykt9QV4itTclOCLV5R5KTnf5MY
 HcE8ND/eNKgga3QxYqA/L1SdrmWb3t1OyxmK/1mp7wncL+XkklvxhDD7YQ+ICQ==
To: "Balbir Singh" <balbirs@nvidia.com>, <akpm@linux-foundation.org>, 
	<apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>
X-Lms-Return-Path: <lba+26a572d90+c578f2+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-5-lizhe.67@bytedance.com> <b5af990e-4d88-47cd-bc44-9612e30270ff@nvidia.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>
Message-Id: <89f29fc2-e1f4-437c-9851-404420e8929e@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] mm: add a template-based fast path for zone-device page init
Date: Wed, 15 Jul 2026 14:49:31 +0800
In-Reply-To: <b5af990e-4d88-47cd-bc44-9612e30270ff@nvidia.com>

On 7/15/26 1:21 PM, Balbir Singh wrote:
> On 7/9/26 9:25 PM, Li Zhe wrote:
>> memmap_init_zone_device() repeats nearly identical head-page
>> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
>> template through the existing slow path, refresh the PFN-dependent
>> fields in that template before each copy, and memcpy it into each
>> destination page.
>>
>> The optimized path assigns _refcount through the copied template, so
>> keep it disabled when the page_ref_set tracepoint is enabled.
>>
>> This patch accelerates head-page initialization. The pfns_per_compound
>> == 1 case gets the full benefit here, compound tails are handled in the
>> next patch.
>>
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
>> path (pfns_per_compound == 1).
>>
>> Test procedure:
>> Rebind the nd_pmem driver 30 times and collect the memmap initialization
>> time from the pr_debug() output of memmap_init_zone_device().
>>
>> Base(v7.2-rc1):
>>    First binding: 1456 ms
>>    Average of subsequent rebinds: 244.28 ms
>>
>> With this patch and its prerequisites applied:
>>    First binding: 1440 ms
>>    Average of subsequent rebinds: 217.19 ms
>>
>> This reduces the average rebind time from 244.28 ms to 217.19 ms, or
>> about 11%.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> ---
>>   mm/mm_init.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 5fccfbacf855..170021e182e0 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1065,6 +1065,44 @@ static void __ref zone_device_page_init_slow(struct page *page,
>>   		set_page_count(page, 0);
>>   }
>>   
>> +static inline bool zone_device_page_init_optimization_enabled(void)
>> +{
>> +	/*
>> +	 * The template fast path copies a preinitialized struct page image.
>> +	 * Skip it when the page_ref_set tracepoint is enabled.
>> +	 */
>> +	return !page_ref_tracepoint_active(page_ref_set);
>> +}
>> +
>> +/*
>> + * 'template' is a reusable page prototype rather than a strictly immutable
>> + * object. Most ZONE_DEVICE fields stay constant across the pages covered by
>> + * the current template, but section bits and page->virtual may still depend
>> + * on the PFN. Refresh those PFN-dependent fields in the template before
>> + * copying it into @page.
>> + */
>> +static inline void zone_device_page_update_template(struct page *template,
>> +		unsigned long pfn)
>> +{
>> +	set_page_section_from_pfn(template, pfn);
>> +#ifdef WANT_PAGE_VIRTUAL
>> +	if (!is_highmem_idx(ZONE_DEVICE))
>> +		set_page_address(template, __va(pfn << PAGE_SHIFT));
>> +#endif
>> +}
>> +
>> +static void zone_device_page_init_from_template(struct page *page,
>> +		unsigned long pfn, struct page *template)
>> +{
>> +	/*
>> +	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
>> +	 * page. Update the PFN-dependent fields in place before copying it
>> +	 * to the destination page.
>> +	 */
>> +	zone_device_page_update_template(template, pfn);
>> +	memcpy(page, template, sizeof(*page));
> I wonder why the code updates the pfn in the template and then memcpy's page as
> opposed to have a read-only template, copy that to the page and update the pfn
> in the page?


The main reason is to keep the destination page on a single copy path.

The PFN-dependent fields here are only the section bits and, under
WANT_PAGE_VIRTUAL, page->virtual. Updating those in the stack-resident
template first is cheap, while updating them in the destination page
after memcpy() would add extra per-page stores on the memmap itself.

This patch is trying to reduce writes on the destination struct page, so
refreshing the stack template first and then copying it keeps the
destination side to a single bulk copy.

It also keeps the later memcpy_nt() conversion straightforward, because
the destination still receives one copy stream rather than a copy plus
follow-up cached stores.

Thanks,
Zhe

>
>> +}
>> +
>>   /*
>>    * With compound page geometry and when struct pages are stored in ram most
>>    * tail pages are reused. Consequently, the amount of unique struct pages to
>> @@ -1120,6 +1158,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>   				   unsigned long nr_pages,
>>   				   struct dev_pagemap *pgmap)
>>   {
>> +	bool use_template = zone_device_page_init_optimization_enabled();
>>   	unsigned long pfn, end_pfn = start_pfn + nr_pages;
>>   	struct pglist_data *pgdat = zone->zone_pgdat;
>>   	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
>> @@ -1127,6 +1166,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>   	unsigned long zone_idx = zone_idx(zone);
>>   	unsigned long start = jiffies;
>>   	int nid = pgdat->node_id;
>> +	struct page template;
>>   
>>   	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>>   		return;
>> @@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>   	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>> +		if (!use_template) {
>> +			zone_device_page_init_slow(page, pfn, zone_idx,
>> +						   nid, pgmap);
>> +		} else if (pfn == start_pfn) {
>> +			/*
>> +			 * Seed the reusable head-page template from the
>> +			 * first real struct page, because the existing
>> +			 * page-init and pageblock helpers expect a real
>> +			 * memmap entry rather than a stack object.
>> +			 */
>> +			zone_device_page_init_slow(page, pfn, zone_idx,
>> +						   nid, pgmap);
>> +			/* init template page */
>> +			memcpy(&template, page, sizeof(*page));
>> +		} else {
>> +			zone_device_page_init_from_template(page, pfn,
>> +							    &template);
>> +		}
>>   
>>   		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>>   			cond_resched();
> Balbir
