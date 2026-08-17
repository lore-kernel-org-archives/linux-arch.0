Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC723B811F
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950912; cv=none; b=kx2g2scf80/469NbSr0JIkymoue9yfAzjTnGmds5id0WbJXqK83cXyBPq788FvUhA/feEToDnDZNlTFA1BbM+QKkQKwgdsBNxsSqp/QVmBGXo1yqd8X/fmRr5srA9TmqVSTiEr3XeSgTaBkywa/XIWqfUme8y3aZrBWfodWBh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950912; c=relaxed/simple;
	bh=H0kpBdlqtkCs4mnVIQOsbkWYLGpiS9UuExJ8HPentao=;
	h=References:From:Date:Subject:In-Reply-To:To:Cc:Message-Id:
	 Content-Type:Mime-Version; b=Tia+SA7Zrf77l9626MV+5uykYGxsi7aHeq55rzYTOEVZqNdprlTkR7ieFKmNnusw9iGJ0/cMzxegqnsyeVrwV9SDgKhFRpx/6S5ZHCrw4eTYW6mY7zqF4CC/GNPg1Ufl2kRmZjzAwYYbnVvQMGhDGeKhFu/LwfS1Az7//jascVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X2YMVezb; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X2YMVezb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786950902; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=N1LdzvO8YItiR+BdAiOLPMa7pHh1+EdgmMC0VPZv5PE=;
 b=X2YMVezbEfr6weHo6U4VNjvJJpHkvj0OHP8qA0iUPlLj3qGpr5pr0qyOg9yN67oyz78yxC
 rMCCxDJOT3XGg0yfzgbzhCFKskeqCmlJhQFJjwhx1cK01aXvppLGR0FPD9bXpeDw90b60L
 t7cPj+u/kClDERT/mcGI3u5Jvtc89ZdNveabXOcxmVhzyEHN7G3A0etuabAls0EuFtnatN
 x/8MjrJO9hrT0iMP1J3nmXuaVLzZ893h7vZSENxT06HtP3dxGy3kqhRiDEKxKy0F1WVeng
 jzAZa0/RPhIgO/OFmhZTxav7QBA/ONS6ZK7ZpqrgQUwssRMu99Cxx+elp9d4fQ==
References: <20260810122057.30447-1-lizhe.67@bytedance.com> <20260810122057.30447-5-lizhe.67@bytedance.com> <178688187038.2799959.7142225711373927632.b4-review@b4>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 17 Aug 2026 15:14:38 +0800
Subject: Re: [PATCH v10 4/8] mm: add a template-based fast path for zone-device page init
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <178688187038.2799959.7142225711373927632.b4-review@b4>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Message-Id: <0c23c111-bf5b-43f5-a541-0345f10db25d@bytedance.com>
X-Lms-Return-Path: <lba+26a82b4f4+869ac8+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird

On 8/16/26 8:04 PM, Mike Rapoport wrote:
> Hi,
>
>> memmap_init_zone_device() repeats nearly identical head-page
>> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
>> template through the existing slow path, refresh the PFN-dependent
>> fields in that template before each copy, and memcpy it into each
>> destination page.
>>
>> Use the template path unconditionally. The page_ref_set tracepoint is
>> primarily a debugging aid, while this code is still initializing struct
>> pages before they are handed out. From the perspective of users of those
>> pages, the initialization-time refcount transitions are not part of the
>> observable page lifetime.
>>
>> This means page_ref_set will no longer observe every initialization-time
>> refcount assignment for copied ZONE_DEVICE head pages. The impact is
>> controlled because the final initialized struct page state is unchanged,
>> and keeping a separate non-template path only for this local tracepoint
>> observability would add complexity to the common path.
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
>>    Average of rebinds for nd_pmem driver: 244.28 ms
>>
>> With this patch and its prerequisites applied:
>>    Average of rebinds for nd_pmem driver: 215.55 ms
>>
>> This reduces the average memmap initialization time measured during rebind
>> from 244.28 ms to 215.55 ms, or about 11%.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index a70acb7431a6..56a36a71ba89 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1065,6 +1065,35 @@ static void __ref zone_device_page_init_slow(struct page *page,
>>   		set_page_count(page, 0);
>>   }
>>   
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
> Looks like it's the only user of zone_device_page_update_template().
> I'd just fold it here and drop the comment.


Thanks. I will fold zone_device_page_update_template() into
zone_device_page_init_from_template() and drop the redundant comment.

>
>> +	memcpy(page, template, sizeof(*page));
>> +}
>> +
>>   /*
>>    * With compound page geometry and when struct pages are stored in ram most
>>    * tail pages are reused. Consequently, the amount of unique struct pages to
>> @@ -1127,6 +1156,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>   	unsigned long zone_idx = zone_idx(zone);
>>   	unsigned long start = jiffies;
>>   	int nid = pgdat->node_id;
>> +	struct page template;
>>   
>>   	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>>   		return;
>> @@ -1144,7 +1174,22 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>   	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>> +		if (pfn == start_pfn) {
>> +			/*
>> +			 * Seed the reusable head-page template from the
>> +			 * first real struct page. This initializes the
>> +			 * first page through the existing slow path and
>> +			 * then reuses that final state as the template
>> +			 * for subsequent pages.
>> +			 */
>> +			zone_device_page_init_slow(page, pfn, zone_idx,
>> +						   nid, pgmap);
>> +			/* init template page */
>> +			memcpy(&template, page, sizeof(*page));
>> +		} else {
>> +			zone_device_page_init_from_template(page, pfn,
>> +							    &template);
>> +		}
> Why can't we init the template for the first page being initialized and
> then call zone_device_page_init_from_template() unconditionally?
>
> The same applies to the tail pages initialization.


The concern is that this would initialize a stack-resident struct page
template through the normal page-init and refcount helpers.

An earlier version did initialize the template directly:

https://lore.kernel.org/all/20260527033636.28231-5-lizhe.67@bytedance.com/

but Sashiko pointed out that this is unsafe:

https://sashiko.dev/#/patchset/20260527033636.28231-1-lizhe.67@bytedance.com

For example, set_page_count() may call into the page_ref_set tracepoint
path when the tracepoint is enabled. That path can use helpers such as
page_to_pfn(), which only make sense for real memmap pages. Passing a
stack-resident struct page template there can produce a bogus PFN and may
lead to a kernel panic.

That is why the current version seeds the reusable template from the
first real struct page instead of running the normal page-init helpers on
the stack template.

I also kept the first iteration inside the main loop because Alistair
previously suggested avoiding an unrolled first-page path:

https://lore.kernel.org/all/akxpS3WOP7oUBNKF@nvdebian.thelocal/

The tail-page path follows the same pattern for the same reason.

Thanks,
Zhe
