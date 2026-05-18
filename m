Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA83CB2E5;
	Mon, 18 May 2026 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087102; cv=none; b=mP1KesB+3QOgeNmpENvXwr61p73IKg2NVr7WPqzdlCwQLWsoGGrVSD4H0nz4gSkjRqm8ctQpziEKBh6xUOLrJx9rTcXcClSFNvkygB0/IJL3mFJ+6wUqnqb9eklYiLeb5FldZo+PakuV2EvWiPhuxQ5GWwPkvktTF2vTRLeAbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087102; c=relaxed/simple;
	bh=pEyIxFagBCELnPW4KcSVXAY+aeER7qyhiWWCCVSH+pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoptznOAle9eVkN2w1ocJzLhyA4iK7T1/83FGIv38FwKOdWhRxPvZi0YHBRDh7LbgH9QBjIH/3hcodKbx2f2E5eNysQP9yEe1LMjbyXEyMfTR2EUE7jz0wqrGJwnMeKNHZLZsRh/TxR+WhygGSbG9Lmme6UBBd7rsFnAP9L8NQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPNld9Z4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPNld9Z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4920C2BCC6;
	Mon, 18 May 2026 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087101;
	bh=pEyIxFagBCELnPW4KcSVXAY+aeER7qyhiWWCCVSH+pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPNld9Z4cds8IsWOlBIkgYc3kXkjFaWbcKQr0Wx6TagD433jfmdyGlBVqpyLsUsku
	 dihDbwlYK6l9ooqn1o8aZQ9v+yJkf3/aDJq+PtctLIV8FMn2FD2xQtH54NtzPoQWt1
	 B11vYboEF94jelyJtlq1Oa+VRZONFsrw2WxJIbOihxHu+02JY1UIoiK8rQsiQaSj8+
	 +guQQZmhvz6AnQiwfG4uUaZsVEOBWkTTN28YDEeuKhBNwAhexOVC4ItbJHumUc75dQ
	 iiS7PosOgjnVt3PxZo8dS+KuP0kVlEv31umpAxyR0wCHkm5OHkJCHiyRxOC7+ptOgE
	 yGD1rU2xfIMEA==
Date: Mon, 18 May 2026 09:51:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, arnd@arndb.de,
	akpm@linux-foundation.org, david@kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm: add a template-based fast path for zone-device
 page init
Message-ID: <agq29raPaAPlM8kV@kernel.org>
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
 <20260515082045.63029-3-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515082045.63029-3-lizhe.67@bytedance.com>

Hi,

On Fri, May 15, 2026 at 04:20:43PM +0800, Li Zhe wrote:
> On 64-bit builds, memmap_init_zone_device() spends most of its time
> repeating the same struct page initialization for every PFN. Prepare a
> template page through the existing slow path once, then copy that
> template into each destination page and fix up the PFN-dependent state
> afterwards.
> 
> Keep the optimized path disabled when the page_ref_set tracepoint is
> active, because the template-copy path bypasses set_page_count() and
> would otherwise hide the corresponding trace event.
> 
> Non-64-bit builds continue to use the existing slow path.

ZONE_DEVICE depends on MEMORY_HOTPLUG and MEMORY_HOTPLUG is only supported
for 64 bits, so there can't be 32-bit builds for ZONE_DEVICE functionality.
 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
> path (pfns_per_compound == 1).
> 
> Test procedure:
> Rebind the nd_pmem driver 30 times and collect the memmap initialization
> time from the pr_debug() output of memmap_init_zone_device().
> 
> Base(v7.1-rc3):
>   First binding: 1486 ms
>   Average of subsequent rebinds: 273.52 ms
> 
> With this patch:
>   First binding: 1421 ms
>   Average of subsequent rebinds: 246.14 ms
> 
> This reduces the average rebind time from 273.52 ms to 246.14 ms, or
> about 10%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  mm/mm_init.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 96 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 5244acb96dbb..4c475c71a9d6 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1013,7 +1013,7 @@ static inline int zone_device_page_init_refcount(
>  	}
>  }
>  
> -static void __ref generic_init_zone_device_page(struct page *page,
> +static void __ref generic_init_zone_device_page_slow(struct page *page,
>  		unsigned long pfn, unsigned long zone_idx, int nid,
>  		struct dev_pagemap *pgmap)
>  {
> @@ -1040,12 +1040,9 @@ static void __ref generic_init_zone_device_page(struct page *page,
>  		set_page_count(page, 0);
>  }
>  
> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> -					  unsigned long zone_idx, int nid,
> -					  struct dev_pagemap *pgmap)
> +static void __ref zone_device_page_init_pageblock(struct page *page,
> +						  unsigned long pfn)

Please move splitting _pageblock helper into the first patch, so that the
first patch would contain all code movement.

>  {
> -	generic_init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> -
>  	/*
>  	 * Mark the block movable so that blocks are reserved for
>  	 * movable at startup. This will force kernel allocations
> @@ -1062,6 +1059,88 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	}
>  }
>  
> +static inline void __init_zone_device_page(struct page *page, unsigned long pfn,
> +					   unsigned long zone_idx, int nid,
> +					   struct dev_pagemap *pgmap)
> +{
> +	generic_init_zone_device_page_slow(page, pfn, zone_idx, nid, pgmap);
> +	zone_device_page_init_pageblock(page, pfn);
> +}
> +
> +#if BITS_PER_LONG == 64
> +static inline bool zone_device_page_init_optimization_enabled(void)
> +{
> +	/*
> +	 * We use template pages and assign page->_refcount via memory copy.
> +	 * This means the optimized path bypasses set_page_count(), so the
> +	 * page_ref_set tracepoint cannot observe this initialization.
> +	 * Skip the optimized path when the tracepoint is enabled.
> +	 */
> +	return !page_ref_tracepoint_active(page_ref_set);
> +}
> +
> +static inline void struct_page_layout_check(void)
> +{
> +	BUILD_BUG_ON(sizeof(struct page) & (sizeof(u64) - 1));

Does it have to be a BUILD_BUG()? Can't we fallback to slow path if struct
page has a weird size?
Just do the check in zone_device_page_init_optimization_enabled().

> +}
> +
> +static inline void init_template_page(struct page *template,
> +				      unsigned long pfn,
> +				      unsigned long zone_idx,
> +				      int nid,
> +				      struct dev_pagemap *pgmap)

The name should include zone_device to avoid confusion with regular pages.
> +{
> +	generic_init_zone_device_page_slow(template, pfn, zone_idx, nid, pgmap);
> +}
> +
> +/*
> + * Initialize parts that differ from the template
> + */
> +static inline void generic_init_zone_device_page_finish(struct page *page,
> +							unsigned long pfn)
> +{
> +#ifdef SECTION_IN_PAGE_FLAGS
> +	set_page_section(page, pfn_to_section_nr(pfn));

Can we add a stub for set_page_address() for !SECTION_IN_PAGE_FLAGS case
and drop the #ifdef here and in set_page_links()?

> +#endif
> +#ifdef WANT_PAGE_VIRTUAL
> +	if (!is_highmem_idx(ZONE_DEVICE))
> +		set_page_address(page, __va(pfn << PAGE_SHIFT));

set_page_address() is a not when WANT_PAGE_VIRTUAL, you can drop the ifdef.

> +#endif
> +}
> +
> +static void init_zone_device_page_from_template(struct page *page,
> +		unsigned long pfn, const struct page *template)

zone_device_page_init_from_template() please.

> +{
> +	const u64 *src = (const u64 *)template;
> +	u64 *dst = (u64 *)page;
> +	unsigned int i;
> +
> +	for (i = 0; i < sizeof(struct page) / sizeof(u64); i++)
> +		dst[i] = src[i];
> +	generic_init_zone_device_page_finish(page, pfn);
> +	zone_device_page_init_pageblock(page, pfn);
> +}

-- 
Sincerely yours,
Mike.
