Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139913B2D39
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 04:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088814; cv=none; b=gnl1gMr7oNodP8moGUW/Y1s3qBrkYK2IJX5taG+E/pu2T/1DGgEgt7q0amlgvsAhuYlBLWYh1J9YQQmpg7Q1IhXRmR6w1zwBM7Bg60f6sY6gotgAVQq2nG0im1vfxDSgEdODrTMq4eA1JqaVm4Qd/0CttdcsL8DqPqLpEOlJQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088814; c=relaxed/simple;
	bh=iYeoB2Oy/GZpBzjfZl/wRaVKRhISTMx1gSLVXS3r6YQ=;
	h=Content-Type:To:Cc:From:Date:Mime-Version:Subject:References:
	 Message-Id:In-Reply-To; b=KOPFhqy1gVbsEIh+j+RD+o5RVOZQR2oUnBsmwjtMBmupcqHskRUmMzGAxQHU5A7Yh5PP4vT67lVUduuNMbTssWcKM/ni4880OcELLClio5ualujJFKbfsUWbhdSvz1gqMZ4octLNQKXMdQiuQpPJEMDSz61KlWGNtXMwTtgeYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VjO3PUvT; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VjO3PUvT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784088800; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=iYeoB2Oy/GZpBzjfZl/wRaVKRhISTMx1gSLVXS3r6YQ=;
 b=VjO3PUvTDUj3RjNqk8bDBkutYkm4ldUGqiss4dQJVY9POQZM40HbYe9+YncVtM8itsjyjY
 Pf5EthMWJRltFiODPOFTPpNyne/X22AJ4cpV9dPjxMrxIU1K8e0HS3Tgtqqj6kFOYGTFg7
 7S0Hmpa1Q5Zuadsl7/4XgkNYKPjcqakEfTfRj/vOPRBjMIa6WrdODeQmr6HyacSdwAyUnT
 E+suoiQpgO/qwQxEffUb6YAy/d6vlp0ixyQv5KWpB/lWnhgpSVFOrAddrxoQyiK/ray4Ad
 x8JT/bvDJdevYO4+7bTTTNVgp7KbN5Jxt5/3x5MNxkMgI+9Eweo9HDrT6AGjPg==
Content-Type: text/plain; charset=UTF-8
To: "Muchun Song" <muchun.song@linux.dev>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed, 15 Jul 2026 12:12:57 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Subject: Re: [PATCH v6 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
Content-Transfer-Encoding: quoted-printable
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-3-lizhe.67@bytedance.com> <993afd58-e503-46aa-acaf-19243b0d147c@linux.dev>
Message-Id: <0f83a711-5493-45f1-871b-1fade5fa2916@bytedance.com>
X-Lms-Return-Path: <lba+26a5708de+c656cf+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <993afd58-e503-46aa-acaf-19243b0d147c@linux.dev>

On 7/14/26 10:44 AM, Muchun Song wrote:
>
>
> On 2026/7/9 19:25, Li Zhe wrote:
>> memmap_init_zone_device() currently mixes refcount policy and core
>> ZONE_DEVICE page setup in a single helper.
>>
>> Factor the refcount-reset predicate into pagemap_resets_refcount(), move
>> the common page initialization into __zone_device_page_init(), and wrap
>> the existing slow path in zone_device_page_init_slow().
>
> Hi,
>
> Sorry if this has been discussed before, but I'm still curious=E2=80=94wh=
at
> is the significance of the 'slow' suffix here? I don't think I quite
> understand why this is called the 'slow path' here. Is there also a
> 'fast path' for initializing struct page?
>
> Thanks.=20

The "slow" suffix here is relative to the template-copy fast path added
later in patch 4.

Patch 2 factors the existing per-page initialization path into a helper
so that the later patches can reuse it as the fallback path when
template copying is not used. In that sense, this helper is the slow
path, while the fast path is introduced later in the series.

Thanks,
Zhe

>>
>> This keeps the slow-path behaviour unchanged and gives later patches
>> reusable helper boundaries.
>>
>> No functional change intended.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>> =C2=A0 mm/mm_init.c | 56 ++++++++++++++++++++++++++++++++++-------------=
-----
>> =C2=A0 1 file changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 95808ab5cfdb..5fccfbacf855 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>> =C2=A0 }
>> =C2=A0 =C2=A0 #ifdef CONFIG_ZONE_DEVICE
>> -static void __ref __init_zone_device_page(struct page *page,=20
>> unsigned long pfn,
>> +/*
>> + * Return true when the free path for this pagemap type restores the=20
>> page
>> + * refcount to 1, so memmap_init_zone_device() can keep the count=20
>> set by
>> + * __init_single_page(). Otherwise initialize the refcount to 0 and=20
>> leave
>> + * it to the allocator or pgmap callbacks to raise it when the page is
>> + * handed out again.
>> + */
>> +static inline bool pagemap_resets_refcount(const struct dev_pagemap=20
>> *pgmap)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * MEMORY_DEVICE_GENERIC pages regain a refcoun=
t of 1 in the free
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * path. The remaining ZONE_DEVICE types start =
from 0 here and=20
>> raise
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the count again when the allocator or driver=
 hands the page out.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 switch (pgmap->type) {
>> +=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_FS_DAX:
>> +=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_PRIVATE:
>> +=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_COHERENT:
>> +=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_PCI_P2PDMA:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_GENERIC:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> +
>> +static void __ref __zone_device_page_init(struct page *page,=20
>> unsigned long pfn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=
 long zone_idx, int nid,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct d=
ev_pagemap *pgmap)
>> =C2=A0 {
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __init_single_page(page, pfn, zone_idx, n=
id);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -1028,23 +1054,15 @@ static void __ref=20
>> __init_zone_device_page(struct page *page, unsigned long pfn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_folio(page)->pgmap =3D pgmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page->zone_device_data =3D NULL;
>> +}
>>
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * MEMORY_DEVICE_GENERIC pages regain a refcoun=
t of 1 in the free
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * path. The remaining ZONE_DEVICE types start =
from 0 here and=20
>> raise
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * the count again when the allocator or driver=
 hands the page out.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 switch (pgmap->type) {
>> -=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_FS_DAX:
>> -=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_PRIVATE:
>> -=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_COHERENT:
>> -=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_PCI_P2PDMA:
>> +static void __ref zone_device_page_init_slow(struct page *page,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, unsigned =
long zone_idx, int nid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dev_pagemap *pgmap)
>> +{
>> +=C2=A0=C2=A0=C2=A0 __zone_device_page_init(page, pfn, zone_idx, nid, pg=
map);
>> +=C2=A0=C2=A0=C2=A0 if (!pagemap_resets_refcount(pgmap))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_count(pa=
ge, 0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -
>> -=C2=A0=C2=A0=C2=A0 case MEMORY_DEVICE_GENERIC:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 /*
>> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct=20
>> page *head,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (pfn =3D head_pfn + 1; pfn < end_pfn;=
 pfn++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page=
 =3D pfn_to_page(pfn);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __init_zone_device_page(page=
, pfn, zone_idx, nid, pgmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone_device_page_init_slow(p=
age, pfn, zone_idx, nid, pgmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prep_compound_tai=
l(page, head, order);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_count(pa=
ge, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone=20
>> *zone,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (pfn =3D start_pfn; pfn < end_pfn; pf=
n +=3D pfns_per_compound) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page=
 =3D pfn_to_page(pfn);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __init_zone_device_page(page=
, pfn, zone_idx, nid, pgmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone_device_page_init_slow(p=
age, pfn, zone_idx, nid, pgmap);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ALIGNED(pf=
n, PAGES_PER_SECTION))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cond_resched();
>> --=20
>> 2.20.1
>
