Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62A175A93
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095928; cv=none; b=jYoyikJRDV/JLR77Q4x7Gvr4lBcJp7vbIYEUskkmhNSS4vP6BPcKImiPU+3V85/n4fbgrbt8S5u0xKG9tuKJHzGy3fbF9QmE5RfmnCMJ2VTtwSw9U6B4wPmRQ/KQoba8i2gIu/5DoQR2I5t+oN2Rd6FEK/zjNdI+8l0aLoLTLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095928; c=relaxed/simple;
	bh=j+gJA7tqEZMJUaymDan0oLSAsVsiMfSlVhTnTUzhvlQ=;
	h=In-Reply-To:Cc:From:References:Date:Content-Type:Message-Id:
	 Mime-Version:To:Subject; b=kso8S1ODw1xdaTQuLmA3cgACqHo7k5u7VA36BH9jt0uJCsRxS8u9pkL+vK7hZevdwkj6vR+kczYhhZbPtfDnDPGHreD1+INae4LcVt4i/9rbsSMNHH35BInroScasOSEICT0fxoiOJ5KPjrhLgdvAUP+qcmcJp9pr+W1L5Bn+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hw0x9EZ1; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hw0x9EZ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784095920; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=j+gJA7tqEZMJUaymDan0oLSAsVsiMfSlVhTnTUzhvlQ=;
 b=Hw0x9EZ16f1lejpQSPimnI40mvy5Rt2aUouHz9c28RDxEp6WcbQg2W+R4FW8p3isU20ST1
 wJwxJ8lnor1/MY8GhGspTAUa9Z17QOymMWyfSqXWtDy58IVIBreNuOJxVU5Hatgx5qvoBy
 TIr1ml3LcSWaRCCerjid354Z9c+3d7GpxkldCnyzPJnhb1Rq/AQGQpRjzOxhwx/Ftinofi
 NFksaJN5x3SFmYtWBdPsln3Wup/GAxn18jHnJbrO/JcMzmTF08QEY38/kvVyOgepem7yHc
 ytdAh4f9IBQgq5B2BHlPl3Va3xbZQpQQ5qwhyTCaHLZdou4PY5CmjUiprNALZQ==
In-Reply-To: <08d40cad-8f61-4aba-9556-5a84067c6494@linux.dev>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: quoted-printable
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-5-lizhe.67@bytedance.com> <08d40cad-8f61-4aba-9556-5a84067c6494@linux.dev>
User-Agent: Mozilla Thunderbird
Date: Wed, 15 Jul 2026 14:11:36 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Message-Id: <b4308d88-3486-4e4d-ae81-6c7ae66956a1@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a5724ae+cca19f+vger.kernel.org+lizhe.67@bytedance.com>
To: "Muchun Song" <muchun.song@linux.dev>
Subject: Re: [PATCH v6 4/8] mm: add a template-based fast path for zone-device page init

On 7/14/26 4:38 PM, Muchun Song wrote:
>
>
> On 2026/7/9 19:25, Li Zhe wrote:
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
>> =3D=3D 1 case gets the full benefit here, compound tails are handled in =
the
>> next patch.
>>
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=3Ddev on Intel Ice Lake server. This test exercises the nd_pmem rebi=
nd
>> path (pfns_per_compound =3D=3D 1).
>>
>> Test procedure:
>> Rebind the nd_pmem driver 30 times and collect the memmap initialization
>> time from the pr_debug() output of memmap_init_zone_device().
>>
>> Base(v7.2-rc1):
>> =C2=A0=C2=A0 First binding: 1456 ms
>> =C2=A0=C2=A0 Average of subsequent rebinds: 244.28 ms
>>
>> With this patch and its prerequisites applied:
>> =C2=A0=C2=A0 First binding: 1440 ms
>> =C2=A0=C2=A0 Average of subsequent rebinds: 217.19 ms
>>
>> This reduces the average rebind time from 244.28 ms to 217.19 ms, or
>> about 11%.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> ---
>> =C2=A0 mm/mm_init.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>> =C2=A0 1 file changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 5fccfbacf855..170021e182e0 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1065,6 +1065,44 @@ static void __ref=20
>> zone_device_page_init_slow(struct page *page,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_count(pa=
ge, 0);
>> =C2=A0 }
>> =C2=A0 +static inline bool zone_device_page_init_optimization_enabled(vo=
id)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The template fast path copies a preinitializ=
ed struct page=20
>> image.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Skip it when the page_ref_set tracepoint is =
enabled.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 return !page_ref_tracepoint_active(page_ref_set);
>
> I'm not sure why we need to make this. I think we can go ahead and
> perform this optimization unconditionally.
>
> If we look at why the tracepoint was added in the first place, it's
> clear that its primary purpose is for debugging, particularly regarding
> why CMA memory pages cannot be allocated (see commit 95813b8faa0). But
> at this stage, the struct page hasn't even been initialized yet; we
> are currently in the middle of initialization. From the perspective of
> the page being initialized, the user doesn't need to care at all about
> how the reference count is changing. Therefore, I don't think we need to
> include these checks. It would only increase the complexity of the code.
>
> I suggest deleting this section of code to keep things simple.
>
> Thanks.

I would prefer to keep this check.

When page_ref_set debugging is enabled, preserving the existing per-page
set_page_count() behavior is still useful, including during
initialization, because it keeps the debug trace complete and unchanged.

In the normal case, page_ref_set is off by default, so this only affects
an explicit debugging configuration and leaves the production fast path
unchanged. The extra logic here is also fairly small and stays local to
this optimization path.

Thanks,
Zhe

>> +}
>> +
>> +/*
>> + * 'template' is a reusable page prototype rather than a strictly=20
>> immutable
>> + * object. Most ZONE_DEVICE fields stay constant across the pages=20
>> covered by
>> + * the current template, but section bits and page->virtual may=20
>> still depend
>> + * on the PFN. Refresh those PFN-dependent fields in the template=20
>> before
>> + * copying it into @page.
>> + */
>> +static inline void zone_device_page_update_template(struct page=20
>> *template,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn)
>> +{
>> +=C2=A0=C2=A0=C2=A0 set_page_section_from_pfn(template, pfn);
>> +#ifdef WANT_PAGE_VIRTUAL
>> +=C2=A0=C2=A0=C2=A0 if (!is_highmem_idx(ZONE_DEVICE))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_address(template, _=
_va(pfn << PAGE_SHIFT));
>> +#endif
>> +}
>> +
>> +static void zone_device_page_init_from_template(struct page *page,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, struct pa=
ge *template)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * 'template' carries the invariant portion of =
a ZONE_DEVICE struct
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * page. Update the PFN-dependent fields in pla=
ce before copying it
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to the destination page.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 zone_device_page_update_template(template, pfn);
>> +=C2=A0=C2=A0=C2=A0 memcpy(page, template, sizeof(*page));
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * With compound page geometry and when struct pages are sto=
red in=20
>> ram most
>> =C2=A0=C2=A0 * tail pages are reused. Consequently, the amount of unique=
 struct=20
>> pages to
>> @@ -1120,6 +1158,7 @@ void __ref memmap_init_zone_device(struct zone=20
>> *zone,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long nr_pages,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dev_pagemap *pgmap)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 bool use_template =3D zone_device_page_init_optimiza=
tion_enabled();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, end_pfn =3D start_pfn =
+ nr_pages;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pglist_data *pgdat =3D zone->zone_=
pgdat;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vmem_altmap *altmap =3D pgmap_altm=
ap(pgmap);
>> @@ -1127,6 +1166,7 @@ void __ref memmap_init_zone_device(struct zone=20
>> *zone,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long zone_idx =3D zone_idx(zone)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long start =3D jiffies;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nid =3D pgdat->node_id;
>> +=C2=A0=C2=A0=C2=A0 struct page template;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pgmap || zone_idx !=3D =
ZONE_DEVICE))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> @@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone=20
>> *zone,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (pfn =3D start_pfn; pfn < end_pfn; pf=
n +=3D pfns_per_compound) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page=
 =3D pfn_to_page(pfn);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone_device_page_init_slow(p=
age, pfn, zone_idx, nid, pgmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!use_template) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone=
_device_page_init_slow(page, pfn, zone_idx,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nid, pgmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (pfn =3D=3D start_=
pfn) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Seed the reusable head-page template from the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * first real struct page, because the existing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * page-init and pageblock helpers expect a real
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * memmap entry rather than a stack object.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone=
_device_page_init_slow(page, pfn, zone_idx,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nid, pgmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* i=
nit template page */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memc=
py(&template, page, sizeof(*page));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone=
_device_page_init_from_template(page, pfn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &template);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ALIGNED(pf=
n, PAGES_PER_SECTION))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cond_resched();
>> --=20
>> 2.20.1
>>
>
