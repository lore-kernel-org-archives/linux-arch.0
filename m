Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6763F075A;
	Tue, 14 Jul 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022331; cv=none; b=i+E6sUCxD0G6gj03RqRSzS1gLSs/Ubj9BtefsZ9NBqF+UmLk5RozuHbrxBl63IXGdVBFiyO4GOG3lY4Qkq9g3oGA66Sut6UOyJl8B+bLBktb3ds0Zw8nQYea2I3eGPc+VZ7r+TZnb5oR6FSnXYeSLxQJsbO5WJM8bCL4VdP26ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022331; c=relaxed/simple;
	bh=gcD0aYAmdIDfX+o5qeVTzlWkMrJJjaaRQvytk9PwmNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhaKb+vFizh6HPb/INiIqAzkGdv86Bhs4Pv15ruVzz2ofc4Kzoxhx83yPB5DxW45dYaL3RKEdTqTrnY88SeohoAiaBs8SmX5V5skB8IWwW6hqr8BWYk0kiAJN5b4lYFyLDx23wEcjWMyh3/0GlE0H9ESTk20mcmhwD6D+h2Gnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s2kVBwVl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s2kVBwVl"
Message-ID: <04f5b50a-a526-4644-b9f0-c54a0d6db702@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784022323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mekORx+dFKRiABrAy+XEgciHwWSjZPvElZQGPDy01aI=;
	b=s2kVBwVl7nJQg4Gb/Kqxo1bPGuZQp8vx9e/9dh096WOea1GmNZvCyunI+kd7T22YqJYDA/
	NKH2dTJV7HWZL661cCIPgju0vw80HFbKnXFteGddtiUZO3JDANIoYLOYb9ukTtCzgsEIpr
	nc7fRXOdZErHcdm3A2EnLN4UvV7I5T4=
Date: Tue, 14 Jul 2026 17:45:17 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 8/8] mm: use memcpy_nt() in zone-device template copies
To: Li Zhe <lizhe.67@bytedance.com>
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
 david@kernel.org, kees@kernel.org, mingo@redhat.com, rppt@kernel.org,
 tglx@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-9-lizhe.67@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-9-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/9 19:25, Li Zhe wrote:
> The template fast path currently uses memcpy() for the actual struct
> page copy. Switch zone_device_page_init_from_template() to memcpy_nt()
> and add memcpy_nt_drain() before memmap_init_compound(), before
> prep_compound_head() updates overlapping tail metadata, and before
> returning from memmap_init_zone_device().
>
> ZONE_DEVICE memmap initialization is largely write-once: each struct
> page is populated once, and most destination cachelines are not expected
> to be reused immediately afterwards. On x86, a regular cached memcpy()
> can therefore incur write-allocate traffic by pulling destination
> cachelines into the cache before writeback, and can populate the cache
> with data that has little near-term reuse. Using memcpy_nt() lets this
> path request non-temporal stores for that copy pattern, which can reduce
> cache pollution and avoid part of the associated write-allocate
> overhead, while architectures without a specialized backend still fall
> back to memcpy().
>
> When memcpy_nt() maps to non-temporal stores, order those stores before
> memmap_init_compound(), before prep_compound_head() updates overlapping
> compound metadata, and before returning from memmap_init_zone_device().
>
> Keep sanitized builds on the slow path so KASAN/KMSAN retain their
> instrumented stores.
>
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> server.
>
> Test procedure:
> Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
>
> Base(v7.2-rc1):
>    First binding for nd_pmem driver: 1456 ms
>    Average of subsequent rebinds: 244.28 ms
>
>    First binding for dax_pmem driver: 1462 ms
>    Average of subsequent rebinds: 273.31 ms
>
> With this series:
>    First binding for nd_pmem driver: 1272 ms
>    Average of subsequent rebinds: 96.79 ms
>
>    First binding for dax_pmem driver: 1354 ms
>    Average of subsequent rebinds: 119.04 ms
>
> This reduces the average rebind time by about 60.4% for nd_pmem and
> 56.4% for dax_pmem.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>   mm/mm_init.c | 39 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index fb855bb0437a..addb4969587e 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1067,11 +1067,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
>
>   static inline bool zone_device_page_init_optimization_enabled(void)
>   {
> +	/*
> +	 * Keep sanitized builds on the slow path so their stores stay
> +	 * instrumented.
> +	 */
> +	if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_KMSAN))
> +		return false;

It is not a major concern if struct page initialization lacks KASAN or
KMSAN instrumentation. To keep things simple, let's just entirely remove
zone_device_page_init_optimization_enabled() to simplify the code.

Thanks.

> +
>   	/*
>   	 * The template fast path copies a preinitialized struct page image.
>   	 * Skip it when the page_ref_set tracepoint is enabled.
>   	 */
> -	return !page_ref_tracepoint_active(page_ref_set);
> +	if (page_ref_tracepoint_active(page_ref_set))
> +		return false;
> +
> +	return true;
>   }
>
>   static inline void zone_device_tail_page_init(struct page *page,
> @@ -1110,7 +1120,7 @@ static void zone_device_page_init_from_template(struct page *page,
>   	 * to the destination page.
>   	 */
>   	zone_device_page_update_template(template, pfn);
> -	memcpy(page, template, sizeof(*page));
> +	memcpy_nt(page, template, sizeof(*page));
>   }
>
>   /*
> @@ -1179,6 +1189,15 @@ static void __ref memmap_init_compound(struct page *head,
>   							    &template);
>   		}
>   	}
> +
> +	/*
> +	 * When the template path is enabled, order the preceding tail-page copies
> +	 * before prep_compound_head() updates the overlapping compound metadata
> +	 * in the first tail-page descriptors. If memcpy_nt() fell back to
> +	 * regular cached stores, memcpy_nt_drain() may be a no-op.
> +	 */
> +	if (use_template)
> +		memcpy_nt_drain();
>   	prep_compound_head(head, order);
>   }
>
> @@ -1238,10 +1257,26 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   		if (pfns_per_compound == 1)
>   			continue;
>
> +		/*
> +		 * When the template path is enabled, order the preceding head-page copy
> +		 * before memmap_init_compound(), which immediately updates compound-head
> +		 * metadata. If memcpy_nt() fell back to regular cached stores,
> +		 * memcpy_nt_drain() may be a no-op.
> +		 */
> +		if (use_template)
> +			memcpy_nt_drain();
> +
>   		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
>   				     compound_nr_pages(pfn, altmap, pgmap),
>   				     use_template);
>   	}
> +	/*
> +	 * Ensure any prior template copies are ordered before returning.
> +	 * On architectures where memcpy_nt() used regular cached stores,
> +	 * memcpy_nt_drain() may be a no-op.
> +	 */
> +	if (use_template)
> +		memcpy_nt_drain();
>
>   	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
>
> --
> 2.20.1
>

