Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9C377AB9
	for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787021808; cv=none; b=poxDZXJPUNEaPpd1IjUSZxXAYjxHg03nWgXZKOAMmlkQH4i7cTpCQsGOOwqxQexra7J0rrTQ1fCFU9hwGf/vBJut41Lx0YooiCRh0U5vu3AZGAO7GuEifoE6Ikhrn9Et+YKY7yalllWCmS4KHpJvxy5yGk9aaLCplddj2YYzcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787021808; c=relaxed/simple;
	bh=Zuuyx425jd0Ev1tCIi7y/sh8sfTufvyG0prBkgLQF9E=;
	h=From:Date:Content-Type:References:Subject:Mime-Version:
	 In-Reply-To:To:Cc:Message-Id; b=EEFiYc3c4+Q8MGxjH8U0WIy2rW2dWSkMf+fxrAGKshhUXM3BwHYArOvR+UFLvmOSaDTDI7LnDXi1CboE/P1GNeZCMPJEu7nosgFkyecBJYRb7LVUQUKyK9XqJ6H41EuUGWQAThrNJhZz38gUrJ9czpra7qRDmsMOo7bPCb+zh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G6t8z4aO; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G6t8z4aO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787021794; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Mmzy2KRppiE9A8Y8ELPAoQZxfCoaZ+1Mf41Owvy1ldo=;
 b=G6t8z4aOiaCzjzAN2kz662NjpkK/owVRzHLTQhAZXx54Yi1Sg/N02PJ+48Rg9zDruutufI
 J6WcnvsV5ly2B+1/Eii501RlXt3ImOEXcUw/PbsT15f4+6F6nZ8nRCh5pmKC/k8iM5ITkh
 71rQw74bCPphV3R6fxGOk7j5foh8qUZ4sTI3T7V/uJHDYYHro0ZbQ1jqifb8RCd7CtqM9L
 FzoKg1JMMqvpE0LF7hn3zorSAdJWVP3aCiD4yFjMtXqedwFgrSRlrT8pxlDqqf1T17rKgk
 PryGbnxPFVBVe8kAL0nRUk7lkKQICKoKzBbFUp1YojXUmxBYxDDjyx+Sbvyv5w==
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Tue, 18 Aug 2026 10:56:10 +0800
Content-Type: text/plain; charset=UTF-8
References: <20260810122057.30447-1-lizhe.67@bytedance.com> <20260810122057.30447-3-lizhe.67@bytedance.com> <178688187038.2799959.7900723270155108493.b4-review@b4> <050c317f-111e-4293-aee5-ac8e154ebc7e@bytedance.com> <aoLtbbv5euE4H1xO@kernel.org>
Subject: Re: [PATCH v10 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <aoLtbbv5euE4H1xO@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a83c9e0+236816+vger.kernel.org+lizhe.67@bytedance.com>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Message-Id: <6a066922-4528-4c4d-9bb5-bbdb2b6cd56f@bytedance.com>

On 8/17/26 7:15 PM, Mike Rapoport wrote:
> On Mon, Aug 17, 2026 at 03:11:56PM +0800, Li Zhe wrote:
>> On 8/16/26 8:04 PM, Mike Rapoport wrote:
>>> Hi,
>>>
>>>> memmap_init_zone_device() currently mixes refcount policy and core
>>>> ZONE_DEVICE page setup in a single helper.
>>>>
>>>> Factor the refcount-reset predicate into pagemap_requires_refcount_reset(),
>>>> move the common page initialization into __zone_device_page_init(), and
>>>> wrap the existing slow path in zone_device_page_init_slow().
>>>>
>>>> This keeps the slow-path behaviour unchanged and gives later patches
>>>> reusable helper boundaries.
>>>>
>>>> No functional change intended.
>>>>
>>>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>>
>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>> index 95808ab5cfdb..a70acb7431a6 100644
>>>> --- a/mm/mm_init.c
>>>> +++ b/mm/mm_init.c
>>>> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>>>>    }
>>>>    
>>>>    #ifdef CONFIG_ZONE_DEVICE
>>>> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>>>> +/*
>>>> + * Return true when memmap_init_zone_device() must initialize the page
>>>> + * refcount to 0. MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in
>>>> + * the free path, while the remaining ZONE_DEVICE types start from 0 here
>>>> + * and raise the count again when the allocator or driver hands the page
>>>> + * out.
>>>> + */
>>>> +static inline bool pagemap_requires_refcount_reset(const struct dev_pagemap *pgmap)
>>>> +{
>>>> +	/*
>>>> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
>>>> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
>>>> +	 * the count again when the allocator or driver hands the page out.
>>>> +	 */
>>>> +	switch (pgmap->type) {
>>>> +	case MEMORY_DEVICE_FS_DAX:
>>>> +	case MEMORY_DEVICE_PRIVATE:
>>>> +	case MEMORY_DEVICE_COHERENT:
>>>> +	case MEMORY_DEVICE_PCI_P2PDMA:
>>>> +		return true;
>>>> +	case MEMORY_DEVICE_GENERIC:
>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
>>>>    					  unsigned long zone_idx, int nid,
>>>>    					  struct dev_pagemap *pgmap)
>>>>    {
>>>> -
>>>>    	__init_single_page(page, pfn, zone_idx, nid);
>>>>    
>>>>    	/*
>>>> @@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>>>>    	 */
>>>>    	page_folio(page)->pgmap = pgmap;
>>>>    	page->zone_device_data = NULL;
>>>> +}
>>>>    
>>>> -	/*
>>>> -	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
>>>> -	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
>>>> -	 * the count again when the allocator or driver hands the page out.
>>>> -	 */
>>>> -	switch (pgmap->type) {
>>>> -	case MEMORY_DEVICE_FS_DAX:
>>>> -	case MEMORY_DEVICE_PRIVATE:
>>>> -	case MEMORY_DEVICE_COHERENT:
>>>> -	case MEMORY_DEVICE_PCI_P2PDMA:
>>>> +static void __ref zone_device_page_init_slow(struct page *page,
>>>> +		unsigned long pfn, unsigned long zone_idx, int nid,
>>>> +		struct dev_pagemap *pgmap)
>>>> +{
>>>> +	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
>>>> +	if (pagemap_requires_refcount_reset(pgmap))
>>>>    		set_page_count(page, 0);
>>>> -		break;
>>>> -
>>>> -	case MEMORY_DEVICE_GENERIC:
>>>> -		break;
>>>> -	}
>>>>    }
>>>>    
>>>>    /*
>>>> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
>>>>    	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
>>>>    		struct page *page = pfn_to_page(pfn);
>>>>    
>>>> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>>> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>>>>    		prep_compound_tail(page, head, order);
>>>>    		set_page_count(page, 0);
>>>>    	}
>>>> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>>>    	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>>>>    		struct page *page = pfn_to_page(pfn);
>>>>    
>>>> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>>> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>>> It looks like all callers of __init_zone_device_page() are now calling
>>> zone_device_page_init_slow() that with series evolution became a thin
>>> wrapper for __zone_device_page_init().
>>>
>>> Maybe we can just rename __init_zone_device_page() to
>>> __zone_device_page_init() and replace the open coded setting of the page
>>> count with the call to pagemap_requires_refcount_reset() an be done
>>> here?
>>
>> Yes, that would make patch 2 simpler.
>>
>> The reason I kept the refcount policy outside __zone_device_page_init()
>> is the compound-tail initialization added later in patch 5. Tail pages
>> still need the same basic ZONE_DEVICE struct page initialization as head
>> pages, including __init_single_page(), PageReserved, pgmap and
>> zone_device_data setup. After that, the tail-page path calls
>> prep_compound_tail() and sets the tail refcount to 0 unconditionally.
>>
>> Folding pagemap_requires_refcount_reset() into __zone_device_page_init()
>> would make that helper include the head-page refcount policy even for
>> callers that will immediately apply the tail-page refcount rule
>> afterwards.
> But you still call zone_device_page_init_slow() from
> zone_device_tail_page_init() so it's anyway there.


Thanks for pointing this out. I was mistaken about the current split.

>
> I'd suggest combining this and the next patch into one, keeping
> __init_zone_device_page() name without renaming it at all and open-coding
> the initialization of the first head and the first tail page to properly
> set refcount and call other prep methods.
>
> I'd also pull the initialization of the first page in both cases out of the
> loop and make the loop only use the _template version.


Thanks for the suggestion. This is indeed clearer. I will fix this in v11.

Thanks,
Zhe

>   
>> That preserves the final state, but I was trying to keep the common
>> ZONE_DEVICE page setup separate from the head-page refcount policy for
>> this reason.
>>
>> Would you still prefer the simpler renamed helper here, or should I keep
>> the common ZONE_DEVICE page setup separate from the refcount policy and
>> make the naming clearer in v11?
>>
>> Thanks,
>> Zhe
>>
