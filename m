Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8E3B47E3
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950754; cv=none; b=OZtMslX8+3DmZnqXtvXydEX6ZpoYyTxvEXj6aOx4JlmrHOy8rj6p1TPhvTevwsSrQx3+BPygCNiKUt716Gnrgl3U80l1seRV6Pwy9/pracjWHkGSjX76iP9CJfp0GSTNKQlS/ob0C6y4m/3peweHr684KwPYID/HyxU/2PrEdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950754; c=relaxed/simple;
	bh=+oXPAAva5kvvjai0iPcqJOZa+kqlPBgXMgSAYtrukhw=;
	h=Message-Id:Mime-Version:From:Date:Cc:References:Content-Type:
	 Subject:In-Reply-To:To; b=QFR65x0g4Xo8iPKD3SUmfLX/ON5gGuaTiRwZBWuJwfhez2XzsyoaZFcn9sk7JEIX3lv4e6Dsx0mLsO5ANASZJjibvFCn4UcW041KsOP4UapnTu5RUnLiRhTlZUfyLY6YF6/Q5x2u6SA1mdwEpEQUp4K0aMHMn8+DZTnSfh8mccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RTog4FrE; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RTog4FrE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786950741; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zEmC/EhsOQJ52Eiw8IEgOG+hTiA5mRLWdEfIjaGYqew=;
 b=RTog4FrEdFqXQN4hf79GJWgPqw+l52P3rPXcGGKIGLGuSurl2iiePNSZKSjgiV2JmrMOJN
 vYyCw635BkqbabmR76hXeHDRnXwWRVXdkPH4Yp9lXSXlRnlhKYqAFLJLrM8+Lo515MxNOB
 oSBetItuasYL2QqXxUuA87xabBsKOnH2tIEtSm8BszM8w88czHkniU7w9aRBIfHnQFZmML
 5zYhboPmWTS7iU3tsWiNfX/f2r8cVTzOAoTByI63fcCHdzZtdtUTcGRZybo3g6Q06uLz7M
 bjwvi7vVDN20QqlmYxcJFOeeQD+6oGrk0I3eQGrW1Xt+Xg2FcAF/K5va956j3w==
Message-Id: <050c317f-111e-4293-aee5-ac8e154ebc7e@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a82b453+a0bc5e+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 17 Aug 2026 15:11:56 +0800
User-Agent: Mozilla Thunderbird
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Content-Transfer-Encoding: 7bit
References: <20260810122057.30447-1-lizhe.67@bytedance.com> <20260810122057.30447-3-lizhe.67@bytedance.com> <178688187038.2799959.7900723270155108493.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v10 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
In-Reply-To: <178688187038.2799959.7900723270155108493.b4-review@b4>
To: "Mike Rapoport" <rppt@kernel.org>

On 8/16/26 8:04 PM, Mike Rapoport wrote:
> Hi,
>
>> memmap_init_zone_device() currently mixes refcount policy and core
>> ZONE_DEVICE page setup in a single helper.
>>
>> Factor the refcount-reset predicate into pagemap_requires_refcount_reset(),
>> move the common page initialization into __zone_device_page_init(), and
>> wrap the existing slow path in zone_device_page_init_slow().
>>
>> This keeps the slow-path behaviour unchanged and gives later patches
>> reusable helper boundaries.
>>
>> No functional change intended.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 95808ab5cfdb..a70acb7431a6 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>>   }
>>   
>>   #ifdef CONFIG_ZONE_DEVICE
>> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>> +/*
>> + * Return true when memmap_init_zone_device() must initialize the page
>> + * refcount to 0. MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in
>> + * the free path, while the remaining ZONE_DEVICE types start from 0 here
>> + * and raise the count again when the allocator or driver hands the page
>> + * out.
>> + */
>> +static inline bool pagemap_requires_refcount_reset(const struct dev_pagemap *pgmap)
>> +{
>> +	/*
>> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
>> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
>> +	 * the count again when the allocator or driver hands the page out.
>> +	 */
>> +	switch (pgmap->type) {
>> +	case MEMORY_DEVICE_FS_DAX:
>> +	case MEMORY_DEVICE_PRIVATE:
>> +	case MEMORY_DEVICE_COHERENT:
>> +	case MEMORY_DEVICE_PCI_P2PDMA:
>> +		return true;
>> +	case MEMORY_DEVICE_GENERIC:
>> +		return false;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
>>   					  unsigned long zone_idx, int nid,
>>   					  struct dev_pagemap *pgmap)
>>   {
>> -
>>   	__init_single_page(page, pfn, zone_idx, nid);
>>   
>>   	/*
>> @@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>>   	 */
>>   	page_folio(page)->pgmap = pgmap;
>>   	page->zone_device_data = NULL;
>> +}
>>   
>> -	/*
>> -	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
>> -	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
>> -	 * the count again when the allocator or driver hands the page out.
>> -	 */
>> -	switch (pgmap->type) {
>> -	case MEMORY_DEVICE_FS_DAX:
>> -	case MEMORY_DEVICE_PRIVATE:
>> -	case MEMORY_DEVICE_COHERENT:
>> -	case MEMORY_DEVICE_PCI_P2PDMA:
>> +static void __ref zone_device_page_init_slow(struct page *page,
>> +		unsigned long pfn, unsigned long zone_idx, int nid,
>> +		struct dev_pagemap *pgmap)
>> +{
>> +	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
>> +	if (pagemap_requires_refcount_reset(pgmap))
>>   		set_page_count(page, 0);
>> -		break;
>> -
>> -	case MEMORY_DEVICE_GENERIC:
>> -		break;
>> -	}
>>   }
>>   
>>   /*
>> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
>>   	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>>   		prep_compound_tail(page, head, order);
>>   		set_page_count(page, 0);
>>   	}
>> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>   	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> It looks like all callers of __init_zone_device_page() are now calling
> zone_device_page_init_slow() that with series evolution became a thin
> wrapper for __zone_device_page_init().
>
> Maybe we can just rename __init_zone_device_page() to
> __zone_device_page_init() and replace the open coded setting of the page
> count with the call to pagemap_requires_refcount_reset() an be done
> here?


Yes, that would make patch 2 simpler.

The reason I kept the refcount policy outside __zone_device_page_init()
is the compound-tail initialization added later in patch 5. Tail pages
still need the same basic ZONE_DEVICE struct page initialization as head
pages, including __init_single_page(), PageReserved, pgmap and
zone_device_data setup. After that, the tail-page path calls
prep_compound_tail() and sets the tail refcount to 0 unconditionally.

Folding pagemap_requires_refcount_reset() into __zone_device_page_init()
would make that helper include the head-page refcount policy even for
callers that will immediately apply the tail-page refcount rule
afterwards.

That preserves the final state, but I was trying to keep the common
ZONE_DEVICE page setup separate from the head-page refcount policy for
this reason.

Would you still prefer the simpler renamed helper here, or should I keep
the common ZONE_DEVICE page setup separate from the refcount policy and
make the naming clearer in v11?

Thanks,
Zhe

