Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC921412C07
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203040; cv=none; b=bRZOBDrCdbcFy+Rd17sQP/3mOd6AkGhMz74G7hiwGA4E7NXrleFL3cUPeWgLGngT6NiixCD8GU4L7SysLuERyIdjSB9/apKlr7WalpLst9p3nnuD4p4mGkIOUiZ3rPgAjqMSIjzVl+kcJJE5FUgbI3IalcMTq5CiYnWtJjTc5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203040; c=relaxed/simple;
	bh=Ta89MU67kAgoIbMPqRHVemmiq8uUBPzV0O1mGv8P4tw=;
	h=Message-Id:In-Reply-To:To:From:Subject:Date:Cc:Mime-Version:
	 References:Content-Type; b=SLBveDMUl8Oh4zwQehS21FUTGpnu+xd9ePrB2F4o4hP1YG7K3Ga8fn6bHgIBb7xYIMo8hNBo2hftilYx1IE12GOgfBYpArfgpWGx8BRMJBfcntKyq0r0TpzH4GKTobrAl/+euHwInI32Uo+IecurZmsdg1yt5YHNQMA+3+oHB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AJNb6aDx; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AJNb6aDx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784203032; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=w7po/hPV41ebN4SVCqHfXqnGtA3i/KcvpBhmzyD+bII=;
 b=AJNb6aDxv0WDBNphnYixnCKDK1hE4Ty1BsgmdMn7dK7QsFkTOIKivRtq98pkrHpQkPvrxT
 aaxPvQzU+nUQ6m/wPE26CNbqLye8mFIIGEKxwqyi4kwHIi3U7A60IXvFCpMisxDwCDnZ0b
 E9NQFZTy+uLnBjXlsCXbVo7nKa6+TqzzTMK5/+Q/lH/0FCunF28Je+Pazkx2bEZmmkvmb2
 AQF61Ugp4RdgzjuBit/jH34f/U5IM+nqo2plwhDOciWjQupnakv8mdtjtm8MNr3kbHEi8+
 v73qGNlLwWfCpux8Ym35wHIhN3mW8/3P4gC8orIG4whIqlAJMjHnMJSjvctiuA==
Message-Id: <2e4ecb6f-4c9d-45b6-8ae1-3c165110c9ad@bytedance.com>
In-Reply-To: <10E87709-2116-46E3-96E2-6BC4E6F69952@linux.dev>
Content-Transfer-Encoding: 7bit
To: "Muchun Song" <muchun.song@linux.dev>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v6 8/8] mm: use memcpy_nt() in zone-device template copies
X-Lms-Return-Path: <lba+26a58c716+9595b8+vger.kernel.org+lizhe.67@bytedance.com>
Date: Thu, 16 Jul 2026 19:56:48 +0800
User-Agent: Mozilla Thunderbird
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-9-lizhe.67@bytedance.com> <04f5b50a-a526-4644-b9f0-c54a0d6db702@linux.dev> <67BC9BE5-A201-4DED-B847-8C74BF30B16D@linux.dev> <fcfe93e4-e7fc-4d77-bce5-d027c597e556@bytedance.com> <10E87709-2116-46E3-96E2-6BC4E6F69952@linux.dev>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

On 7/15/26 5:45 PM, Muchun Song wrote:
>
>> On Jul 15, 2026, at 14:30, Li Zhe <lizhe.67@bytedance.com> wrote:
>>
>> On 7/14/26 7:22 PM, Muchun Song wrote:
>>>> On Jul 14, 2026, at 17:45, Muchun Song <muchun.song@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/7/9 19:25, Li Zhe wrote:
>>>>> The template fast path currently uses memcpy() for the actual struct
>>>>> page copy. Switch zone_device_page_init_from_template() to memcpy_nt()
>>>>> and add memcpy_nt_drain() before memmap_init_compound(), before
>>>>> prep_compound_head() updates overlapping tail metadata, and before
>>>>> returning from memmap_init_zone_device().
>>>>>
>>>>> ZONE_DEVICE memmap initialization is largely write-once: each struct
>>>>> page is populated once, and most destination cachelines are not expected
>>>>> to be reused immediately afterwards. On x86, a regular cached memcpy()
>>>>> can therefore incur write-allocate traffic by pulling destination
>>>>> cachelines into the cache before writeback, and can populate the cache
>>>>> with data that has little near-term reuse. Using memcpy_nt() lets this
>>>>> path request non-temporal stores for that copy pattern, which can reduce
>>>>> cache pollution and avoid part of the associated write-allocate
>>>>> overhead, while architectures without a specialized backend still fall
>>>>> back to memcpy().
>>>>>
>>>>> When memcpy_nt() maps to non-temporal stores, order those stores before
>>>>> memmap_init_compound(), before prep_compound_head() updates overlapping
>>>>> compound metadata, and before returning from memmap_init_zone_device().
>>>>>
>>>>> Keep sanitized builds on the slow path so KASAN/KMSAN retain their
>>>>> instrumented stores.
>>>>>
>>>>> Tested in a VM with a 100 GB fsdax namespace device configured with
>>>>> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
>>>>> server.
>>>>>
>>>>> Test procedure:
>>>>> Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
>>>>> initialization time from the pr_debug() output of
>>>>> memmap_init_zone_device().
>>>>>
>>>>> Base(v7.2-rc1):
>>>>>    First binding for nd_pmem driver: 1456 ms
>>>>>    Average of subsequent rebinds: 244.28 ms
>>>>>
>>>>>    First binding for dax_pmem driver: 1462 ms
>>>>>    Average of subsequent rebinds: 273.31 ms
>>>>>
>>>>> With this series:
>>>>>    First binding for nd_pmem driver: 1272 ms
>>>>>    Average of subsequent rebinds: 96.79 ms
>>>>>
>>>>>    First binding for dax_pmem driver: 1354 ms
>>>>>    Average of subsequent rebinds: 119.04 ms
>>>>>
>>>>> This reduces the average rebind time by about 60.4% for nd_pmem and
>>>>> 56.4% for dax_pmem.
>>>>>
>>>>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>>>> ---
>>>>>   mm/mm_init.c | 39 +++++++++++++++++++++++++++++++++++++--
>>>>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>>> index fb855bb0437a..addb4969587e 100644
>>>>> --- a/mm/mm_init.c
>>>>> +++ b/mm/mm_init.c
>>>>> @@ -1067,11 +1067,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
>>>>>
>>>>>   static inline bool zone_device_page_init_optimization_enabled(void)
>>>>>   {
>>>>> + /*
>>>>> + * Keep sanitized builds on the slow path so their stores stay
>>>>> + * instrumented.
>>>>> + */
>>>>> + if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_KMSAN))
>>>>> + return false;
>>>> It is not a major concern if struct page initialization lacks KASAN or
>>>> KMSAN instrumentation. To keep things simple, let's just entirely remove
>>>> zone_device_page_init_optimization_enabled() to simplify the code.
>>> BTW, If you really want to properly support KASAN, you should integrate
>>> the check directly into memcpy_flushcache() via kasan_check_write(), rather
>>> than treating it as a special case here.
>> I agree that proper KASAN-aware support, if ever needed for
>> memcpy_flushcache(), would belong in the low-level helper itself rather
>> than in this caller.
>>
>> That said, for this series I would still prefer to keep the local check
>> in zone_device_page_init_optimization_enabled(). The goal here is not to
>> add full KASAN support to memcpy_flushcache(), but simply to keep
>> sanitized builds on the existing instrumented slow path.
>>
>> When KASAN/KMSAN is enabled, performance is usually not the priority for
>> that configuration, while preserving the instrumented store path is.
>> Keeping the check local here avoids broadening the scope of this series
>> into a generic memcpy_flushcache() change.
> However, there is an even simpler approach: just don't do any special handling
> for KASAN. In fact, many callers of memcpy_flushcache don't handle it at all.
>
> So I'm curious, why are you keen on handling KASAN as a special case here?
>
> Thanks.
I agree that this is a simpler direction.

If we do not need to keep the sanitizer case on the non-template path,
then there is little value in keeping a separate
zone_device_page_init_optimization_enabled() helper either. The template
path can be the only initialization path, and the old non-template helper
code can be removed.

If this looks good to everyone, I plan to do that as a separate cleanup
patch in the next version, likely as patch 9. The reason for keeping it
separate is that patches 4 and 5 introduce the template initialization
logic, while patch 8 only switches the copy primitive used by that path.
Dropping the remaining non-template fallback is a follow-up cleanup made
possible by this discussion, so a separate patch should make the change
easier to review: first add and use the template path, then remove the
now-unneeded fallback code.

Thanks,
Zhe

>> Thanks,
>> Zhe
>>
>>>> Thanks.
>>>>
>>>>> +
>>>>>    /*
>>>>>    * The template fast path copies a preinitialized struct page image.
>>>>>    * Skip it when the page_ref_set tracepoint is enabled.
>>>>>    */
>>>>> - return !page_ref_tracepoint_active(page_ref_set);
>>>>> + if (page_ref_tracepoint_active(page_ref_set))
>>>>> + return false;
>>>>> +
>>>>> + return true;
>>>>>   }
>>>>>
>>>>>   static inline void zone_device_tail_page_init(struct page *page,
>>>>> @@ -1110,7 +1120,7 @@ static void zone_device_page_init_from_template(struct page *page,
>>>>>    * to the destination page.
>>>>>    */
>>>>>    zone_device_page_update_template(template, pfn);
>>>>> - memcpy(page, template, sizeof(*page));
>>>>> + memcpy_nt(page, template, sizeof(*page));
>>>>>   }
>>>>>
>>>>>   /*
>>>>> @@ -1179,6 +1189,15 @@ static void __ref memmap_init_compound(struct page *head,
>>>>>       &template);
>>>>>    }
>>>>>    }
>>>>> +
>>>>> + /*
>>>>> + * When the template path is enabled, order the preceding tail-page copies
>>>>> + * before prep_compound_head() updates the overlapping compound metadata
>>>>> + * in the first tail-page descriptors. If memcpy_nt() fell back to
>>>>> + * regular cached stores, memcpy_nt_drain() may be a no-op.
>>>>> + */
>>>>> + if (use_template)
>>>>> + memcpy_nt_drain();
>>>>>    prep_compound_head(head, order);
>>>>>   }
>>>>>
>>>>> @@ -1238,10 +1257,26 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>>>>    if (pfns_per_compound == 1)
>>>>>    continue;
>>>>>
>>>>> + /*
>>>>> + * When the template path is enabled, order the preceding head-page copy
>>>>> + * before memmap_init_compound(), which immediately updates compound-head
>>>>> + * metadata. If memcpy_nt() fell back to regular cached stores,
>>>>> + * memcpy_nt_drain() may be a no-op.
>>>>> + */
>>>>> + if (use_template)
>>>>> + memcpy_nt_drain();
>>>>> +
>>>>>    memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
>>>>>        compound_nr_pages(pfn, altmap, pgmap),
>>>>>        use_template);
>>>>>    }
>>>>> + /*
>>>>> + * Ensure any prior template copies are ordered before returning.
>>>>> + * On architectures where memcpy_nt() used regular cached stores,
>>>>> + * memcpy_nt_drain() may be a no-op.
>>>>> + */
>>>>> + if (use_template)
>>>>> + memcpy_nt_drain();
>>>>>
>>>>>    pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
>>>>>
>>>>> --
>>>>> 2.20.1
