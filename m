Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9B28DC4
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097046; cv=none; b=ONOiQBWN2g9zL3zIMD4fELpZGkpTTtF7/ZFuo2kpD7x9z5xcj7Nkh7p3LTOpwphoIrfPJDBQrGO80l7dHEMRnJHGHD9TlkbigsW5b4yry/4kLzOSahFZ9WUVpWrSCK6cm/eWYn8jXEJbII2AXCCX8Bu+WXHeI/kN0DVZP/9O/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097046; c=relaxed/simple;
	bh=scYE86tsEPFxauDv1n7o3T4yPdUKkLTEh8J7NafH39A=;
	h=To:Subject:Mime-Version:Content-Type:Cc:From:Date:Message-Id:
	 In-Reply-To:References; b=tYQpGOoA7aUh/fSOKOx56RUDZWXr23Oj+WqviO28U3z1tyhX3Ar7ewo4fr5IIZJvdRu/P+2Fv7A2jLce1TTzURdKXHM0OkgVYy8nlM3L9LuN91fqWscDo3p9pGQRtDhdL6bdqmco3xpGLb9G//YFj+i4XmZ324HgtIj5irnxavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JEk6VnCl; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JEk6VnCl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784097037; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lCB9dhy5QZLhYQKmcCdqDKGU5CSnd+c1XZ3RMoIJ+zg=;
 b=JEk6VnCljaCqr2AlzqWMSLv3qWCCgmkKzCwOxUFnWaCtg/s34R22lHy3OW1irDF/4PBDGi
 6KeLNhZQDUcnBM+XdcgWPx5QnSQg/AL/pqNV/iBiYpVgHqQhz9w5haatStv7IN3jb3w6Bo
 9S9ckujDWFvk0NXaQR9kKuCgWnY9xUdLjrFOS1OqxzeWbtmgYFI9WltxrKS0jxYNE73uur
 bYQUmTeYRbLLtcOi0KN6xrl63ZqzEzSTa0X+nXbyVz+b4s3KyXeXpALQX7Y3cyhj1+QawT
 Gh3ME05l7+IjyrrJn8kAaNMuYto+8ysRSfsRR0/YMz/8ps7GC3BL+n5pJy9psQ==
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
User-Agent: Mozilla Thunderbird
To: "Muchun Song" <muchun.song@linux.dev>
Subject: Re: [PATCH v6 8/8] mm: use memcpy_nt() in zone-device template copies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed, 15 Jul 2026 14:30:13 +0800
Message-Id: <fcfe93e4-e7fc-4d77-bce5-d027c597e556@bytedance.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <67BC9BE5-A201-4DED-B847-8C74BF30B16D@linux.dev>
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-9-lizhe.67@bytedance.com> <04f5b50a-a526-4644-b9f0-c54a0d6db702@linux.dev> <67BC9BE5-A201-4DED-B847-8C74BF30B16D@linux.dev>
X-Lms-Return-Path: <lba+26a57290b+8170e6+vger.kernel.org+lizhe.67@bytedance.com>

On 7/14/26 7:22 PM, Muchun Song wrote:
>
>> On Jul 14, 2026, at 17:45, Muchun Song <muchun.song@linux.dev> wrote:
>>
>>
>>
>> On 2026/7/9 19:25, Li Zhe wrote:
>>> The template fast path currently uses memcpy() for the actual struct
>>> page copy. Switch zone_device_page_init_from_template() to memcpy_nt()
>>> and add memcpy_nt_drain() before memmap_init_compound(), before
>>> prep_compound_head() updates overlapping tail metadata, and before
>>> returning from memmap_init_zone_device().
>>>
>>> ZONE_DEVICE memmap initialization is largely write-once: each struct
>>> page is populated once, and most destination cachelines are not expected
>>> to be reused immediately afterwards. On x86, a regular cached memcpy()
>>> can therefore incur write-allocate traffic by pulling destination
>>> cachelines into the cache before writeback, and can populate the cache
>>> with data that has little near-term reuse. Using memcpy_nt() lets this
>>> path request non-temporal stores for that copy pattern, which can reduce
>>> cache pollution and avoid part of the associated write-allocate
>>> overhead, while architectures without a specialized backend still fall
>>> back to memcpy().
>>>
>>> When memcpy_nt() maps to non-temporal stores, order those stores before
>>> memmap_init_compound(), before prep_compound_head() updates overlapping
>>> compound metadata, and before returning from memmap_init_zone_device().
>>>
>>> Keep sanitized builds on the slow path so KASAN/KMSAN retain their
>>> instrumented stores.
>>>
>>> Tested in a VM with a 100 GB fsdax namespace device configured with
>>> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
>>> server.
>>>
>>> Test procedure:
>>> Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
>>> initialization time from the pr_debug() output of
>>> memmap_init_zone_device().
>>>
>>> Base(v7.2-rc1):
>>>    First binding for nd_pmem driver: 1456 ms
>>>    Average of subsequent rebinds: 244.28 ms
>>>
>>>    First binding for dax_pmem driver: 1462 ms
>>>    Average of subsequent rebinds: 273.31 ms
>>>
>>> With this series:
>>>    First binding for nd_pmem driver: 1272 ms
>>>    Average of subsequent rebinds: 96.79 ms
>>>
>>>    First binding for dax_pmem driver: 1354 ms
>>>    Average of subsequent rebinds: 119.04 ms
>>>
>>> This reduces the average rebind time by about 60.4% for nd_pmem and
>>> 56.4% for dax_pmem.
>>>
>>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>> ---
>>>   mm/mm_init.c | 39 +++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>> index fb855bb0437a..addb4969587e 100644
>>> --- a/mm/mm_init.c
>>> +++ b/mm/mm_init.c
>>> @@ -1067,11 +1067,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
>>>
>>>   static inline bool zone_device_page_init_optimization_enabled(void)
>>>   {
>>> + /*
>>> + * Keep sanitized builds on the slow path so their stores stay
>>> + * instrumented.
>>> + */
>>> + if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_KMSAN))
>>> + return false;
>> It is not a major concern if struct page initialization lacks KASAN or
>> KMSAN instrumentation. To keep things simple, let's just entirely remove
>> zone_device_page_init_optimization_enabled() to simplify the code.
> BTW, If you really want to properly support KASAN, you should integrate
> the check directly into memcpy_flushcache() via kasan_check_write(), rather
> than treating it as a special case here.
I agree that proper KASAN-aware support, if ever needed for
memcpy_flushcache(), would belong in the low-level helper itself rather
than in this caller.

That said, for this series I would still prefer to keep the local check
in zone_device_page_init_optimization_enabled(). The goal here is not to
add full KASAN support to memcpy_flushcache(), but simply to keep
sanitized builds on the existing instrumented slow path.

When KASAN/KMSAN is enabled, performance is usually not the priority for
that configuration, while preserving the instrumented store path is.
Keeping the check local here avoids broadening the scope of this series
into a generic memcpy_flushcache() change.

Thanks,
Zhe

>
>> Thanks.
>>
>>> +
>>>    /*
>>>    * The template fast path copies a preinitialized struct page image.
>>>    * Skip it when the page_ref_set tracepoint is enabled.
>>>    */
>>> - return !page_ref_tracepoint_active(page_ref_set);
>>> + if (page_ref_tracepoint_active(page_ref_set))
>>> + return false;
>>> +
>>> + return true;
>>>   }
>>>
>>>   static inline void zone_device_tail_page_init(struct page *page,
>>> @@ -1110,7 +1120,7 @@ static void zone_device_page_init_from_template(struct page *page,
>>>    * to the destination page.
>>>    */
>>>    zone_device_page_update_template(template, pfn);
>>> - memcpy(page, template, sizeof(*page));
>>> + memcpy_nt(page, template, sizeof(*page));
>>>   }
>>>
>>>   /*
>>> @@ -1179,6 +1189,15 @@ static void __ref memmap_init_compound(struct page *head,
>>>       &template);
>>>    }
>>>    }
>>> +
>>> + /*
>>> + * When the template path is enabled, order the preceding tail-page copies
>>> + * before prep_compound_head() updates the overlapping compound metadata
>>> + * in the first tail-page descriptors. If memcpy_nt() fell back to
>>> + * regular cached stores, memcpy_nt_drain() may be a no-op.
>>> + */
>>> + if (use_template)
>>> + memcpy_nt_drain();
>>>    prep_compound_head(head, order);
>>>   }
>>>
>>> @@ -1238,10 +1257,26 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>>    if (pfns_per_compound == 1)
>>>    continue;
>>>
>>> + /*
>>> + * When the template path is enabled, order the preceding head-page copy
>>> + * before memmap_init_compound(), which immediately updates compound-head
>>> + * metadata. If memcpy_nt() fell back to regular cached stores,
>>> + * memcpy_nt_drain() may be a no-op.
>>> + */
>>> + if (use_template)
>>> + memcpy_nt_drain();
>>> +
>>>    memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
>>>        compound_nr_pages(pfn, altmap, pgmap),
>>>        use_template);
>>>    }
>>> + /*
>>> + * Ensure any prior template copies are ordered before returning.
>>> + * On architectures where memcpy_nt() used regular cached stores,
>>> + * memcpy_nt_drain() may be a no-op.
>>> + */
>>> + if (use_template)
>>> + memcpy_nt_drain();
>>>
>>>    pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
>>>
>>> --
>>> 2.20.1
>>>
