Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00156367B8E
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089325; cv=none; b=Ehl0mH+ahUJAi3i+K/8zZ7tdEBtOmqkjpouCXTFaTqsThqEHk8U+EHxO1AMFvtmmbQcoMjhM5b2XRz/D22B9Xnx+Y1jxsghhN3BSIIrvoJ728fW50wJOr82+/Y3qqm35bbX9k7OIGip0rs/NsF+H0z+uZ33bJKBWN0MzaREygyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089325; c=relaxed/simple;
	bh=+iXPt0ONtXluhXO6lgQ1VsSIPLvlDZ/rbWbf6ggoj+8=;
	h=To:Subject:Mime-Version:References:Cc:Date:Message-Id:In-Reply-To:
	 From:Content-Type; b=GPVeCAMNgULo68iIxwyw167FLpgDlSeNLEIRUnkOCaWsQPzO5pNuN6t2BJ28XfR1RiOADE2v64AaMz81QfTq8CNrE2hTOfr9nnJ4hssubdHVSNXdDVf1thEkda06q+cpxWagLigzcEyvIg/y+zQldYXpShFp4CfFzfmsOO1HYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AwLibNUi; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AwLibNUi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784089318; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+iXPt0ONtXluhXO6lgQ1VsSIPLvlDZ/rbWbf6ggoj+8=;
 b=AwLibNUiW9Ur6IgBBhsB14GQTFtXN5bPUSrypIFIaHbOWEKO2LLRNIb9grBTJGjObOaDH7
 VkFZytdK9NYEtxEJ8p2YD34/WvDMMdHWXaPw2E0Jfht+Vx1/hPtR9JLkuY56A4KgdZWGpH
 zkMg4izLCkdELfXwJPMCaEgF+c4C4dAdLAxOnf/dqaULts8lP+XKzwKWJ0j0gRoslRGAxJ
 faxpRjdlHygZ1+Yq/vuedJ/R31ShHkYl4EHx4BOMdk/5lRtBaWIu8FHyzXniQ6D5jEkZ1Q
 dSGIYeFNFjsYbjgyLxfKyMLsheQcilTeS0eNAwPRP+eSjWUerJcAS79rcgzjcA==
X-Lms-Return-Path: <lba+26a570ae4+4ef745+vger.kernel.org+lizhe.67@bytedance.com>
To: "Muchun Song" <muchun.song@linux.dev>
Subject: Re: [PATCH v6 4/8] mm: add a template-based fast path for zone-device page init
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-5-lizhe.67@bytedance.com> <03158ab2-94e0-4a48-94d1-df2eedbc5545@linux.dev>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Date: Wed, 15 Jul 2026 12:21:35 +0800
Message-Id: <7bb26368-a305-43a5-ba6a-dc08a62a94bb@bytedance.com>
In-Reply-To: <03158ab2-94e0-4a48-94d1-df2eedbc5545@linux.dev>
Content-Transfer-Encoding: quoted-printable
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

On 7/13/26 9:28 PM, Muchun Song wrote:
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
>
> An 11% reduction is definitely a solid achievement. While the
> absolute gain is in the range of a few dozen milliseconds, I=E2=80=99d
> love to better understand the compounding impact. In which
> specific latency-sensitive scenarios or workloads does saving
> these few dozen milliseconds translate into a major breakthrough
> for the user experience?
>
> Muchun,
> Thanks.

Patch 4 by itself is only an incremental step, not the full result of
the series.

The target scenario here is large fsdax/devdax pmem bind/rebind
latency. This patch removes the repeated head-page initialization
overhead on the pfns_per_compound =3D=3D 1 path, so the gain at this stage
is only a few dozen milliseconds.

The later patches extend the same idea to compound tails and then switch
the template-copy path over to memcpy_nt(), which is where the larger
reduction reported for the full series comes from. Even this
incremental reduction still helps shorten the control-path latency for
large namespace bind/rebind operations.

Thanks,
Zhe

>
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
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pgmap || zone_id=
x !=3D ZONE_DEVICE))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> @@ -1144,7 +1184,24 @@ void __ref memmap_init_zone_device(struct zone=20
>> *zone,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (pfn =3D start_pfn; pfn < end_pfn; pf=
n +=3D pfns_per_compound) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page=
 =3D pfn_to_page(pfn);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zone_device_page_init=
_slow(page, pfn, zone_idx, nid, pgmap);
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
>
