Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBA2F7F14
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089104; cv=none; b=VEcTpAcjo1DTAnJXj+W1heJ/WtIVv4CqoRqNqujPcEeKyQGZc7UyW/B/CxwajCsgzDAK4SRPyuwUjJ9c3ruxcYvSZvjN655klsH9MzVKl1FqLvLtshUu3tKRTQW4IuKXb4EdAlkstaXJlDdOmn84CsW/X35eWmB+P/pIeby9q+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089104; c=relaxed/simple;
	bh=7ikM4P9momayK00KEIzRtImf+mubKwpeAzO9jtPF4uA=;
	h=Subject:References:To:From:Content-Type:Cc:Date:In-Reply-To:
	 Message-Id:Mime-Version; b=JbaZst++9+yNt+5e0gYj8pN2b7lIQX+VqQ3d/vx0LVmSiDSHBQKdR6+UfV/3GLL4kJmr2Umqj0kbJQSKixuwri88jwEg8KJz4EHzbYlsNdq7j1zUFB6QWYgudqpaGcaT2/agzFePjUzqyYqXHix+HW/mTne03ynBLnInyuJ0Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y/wf9sZg; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y/wf9sZg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784089097; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YlZq5VNM9IveAQcVqRzB2FJ/yvLP/3pgRLHZ2gLJdL4=;
 b=Y/wf9sZghBaYe/3v6+fzD7g3VqPtISh6wWAFyypbQaCiND2PkaqVMakErbc7af6sLX3cqZ
 kctbl65fkP3q6XmcQmbXHp2ui0/LGpf4Jt3bXsBYsz52Kf5tv04kquFPyJZkozEmOmm1NG
 CMPKfmKDSDxf0NlG3ARnEAFZZtAEF1YMR0IF+VpUgJ4IRcYmKd8G8Zgs5veqDAFrmC7hL1
 +cldkj5ZNk3tR6IOWK+iltoanUxVWbGq3EFOKwo31Juk47rTlm00akeZMtQyQyJpZg091T
 BVz0oUycp2RURuZR96XtE2R8nZnwxY8+3iW9lT1T1DyVuF3XRR5UOdDh7vlmUw==
Subject: Re: [PATCH v6 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-3-lizhe.67@bytedance.com> <ff75fd32-6aef-4712-8a4c-4deaeb5c3269@nvidia.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: "Balbir Singh" <balbirs@nvidia.com>, <akpm@linux-foundation.org>, 
	<apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a570a07+cef936+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>
Date: Wed, 15 Jul 2026 12:17:54 +0800
User-Agent: Mozilla Thunderbird
In-Reply-To: <ff75fd32-6aef-4712-8a4c-4deaeb5c3269@nvidia.com>
Message-Id: <f9c4a3cd-7872-48a6-bb87-7358ad824fd1@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On 7/14/26 7:35 PM, Balbir Singh wrote:
> On 7/9/26 9:25 PM, Li Zhe wrote:
>> memmap_init_zone_device() currently mixes refcount policy and core
>> ZONE_DEVICE page setup in a single helper.
>>
>> Factor the refcount-reset predicate into pagemap_resets_refcount(), move
>> the common page initialization into __zone_device_page_init(), and wrap
>> the existing slow path in zone_device_page_init_slow().
>>
>> This keeps the slow-path behaviour unchanged and gives later patches
>> reusable helper boundaries.
>>
>> No functional change intended.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>>   mm/mm_init.c | 56 ++++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 95808ab5cfdb..5fccfbacf855 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>>   }
>>   
>>   #ifdef CONFIG_ZONE_DEVICE
>> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>> +/*
>> + * Return true when the free path for this pagemap type restores the page
>> + * refcount to 1, so memmap_init_zone_device() can keep the count set by
>> + * __init_single_page(). Otherwise initialize the refcount to 0 and leave
>> + * it to the allocator or pgmap callbacks to raise it when the page is
>> + * handed out again.
>> + */
>> +static inline bool pagemap_resets_refcount(const struct dev_pagemap *pgmap)
>> +{
> resets_refcount reads like it resets it to 0, but it could be just me. How does
> pagemap_requires_refcount_reset() sound, with the value returned being toggled


Agreed. pagemap_requires_refcount_reset() is clearer here, especially at
the call site as well. I will rename the helper and flip the return
value in the next version.


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
>> +		return false;
>> +	case MEMORY_DEVICE_GENERIC:
>> +		return true;
>> +	}
>> +
>> +	return true;
> Shouldn't the default be a VM_WARN_ON()?

I would prefer not to add a default case here. As David pointed out
earlier in the discussion, keeping the switch exhaustive without a
default preserves compiler checking when new enum memory_type values are
added.

Thanks,
Zhe

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
>> +	if (!pagemap_resets_refcount(pgmap))
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
>>   
>>   		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>>   			cond_resched();
> Balbir
