Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A33CFF61;
	Sun, 16 Aug 2026 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786881889; cv=none; b=f7uASiHjJptJidaPRnXtNPqqJTDGHjNkJuSCvCKP5tIGWJL8AQjMcsZ1S5Ur5mAIIJpj+7TDRiQnvNKvi51pECDQ82JOlzM1vF3G4OiNjSuHxkemxdYrx/K7mbLPd3+l9uIdhtP8oqahWeWQ51Rv6OzLBeTNWMU5gYHVricVrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786881889; c=relaxed/simple;
	bh=Pncluv/U7uoTxbNNG5qXvfSBxWy8l9s0pxZIGehbeaY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nMmodlXDl6B/3kW7cwe7qFgbByHj4bM1MVIRoEIbr2yJaYLnBKRbxOkZ2FISLoubbhSZv5u7A+mPPryz42j2qOaYp2It2PYLsW7T8qM9O+SYXBLA1T0unYPIy7nbqndcTafcZix6y8xvmx89nAtdfLbu6Ri4MZ6zotj6k0CAUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S33O3F6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S33O3F6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBBD1F000E9;
	Sun, 16 Aug 2026 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786881887;
	bh=z4ZIOaLur887dM5jmXZRYkMwRSiTmSfc8GojodwOQiY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=S33O3F6C5AUGl7vDtjdDX9lH/3T2taigTF+oc3i6gT1k8x45J6NKpx0Vs8H5Magkj
	 K3Rb9+AbInZ3sTS2QuFFNziA+5jrU+QiwlQ4dhSn3N0rszSwhcT7PgUU/au8tGJ1ep
	 Qb8/VHWq13vnhIIpexi7/pZAEv+cNVOQmj9NEUus7QKBRmd4uxgv8QnCe3ZJFYhhgy
	 8Mv2l2yzHg4j3K+anvdzlEJOcJbcjNEn6IONYyTlT3F6A9YLVw/mz3EbQXJsVvkAyW
	 EWpKtlg83ZquFVHuae/I1e+NTnVNg8AH6c8MlMP0xODBb6upaDlnJ0e6LdLAaB5ZMi
	 JrBiYGkWSoimA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 4/8] mm: add a template-based fast path for
 zone-device page init
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com, 
 david@kernel.org, kees@kernel.org, mingo@redhat.com, muchun.song@linux.dev, 
 rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org
In-Reply-To: <20260810122057.30447-5-lizhe.67@bytedance.com>
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
 <20260810122057.30447-5-lizhe.67@bytedance.com>
Date: Sun, 16 Aug 2026 15:04:30 +0300
Message-Id: <178688187038.2799959.7142225711373927632.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> memmap_init_zone_device() repeats nearly identical head-page
> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
> template through the existing slow path, refresh the PFN-dependent
> fields in that template before each copy, and memcpy it into each
> destination page.
> 
> Use the template path unconditionally. The page_ref_set tracepoint is
> primarily a debugging aid, while this code is still initializing struct
> pages before they are handed out. From the perspective of users of those
> pages, the initialization-time refcount transitions are not part of the
> observable page lifetime.
> 
> This means page_ref_set will no longer observe every initialization-time
> refcount assignment for copied ZONE_DEVICE head pages. The impact is
> controlled because the final initialized struct page state is unchanged,
> and keeping a separate non-template path only for this local tracepoint
> observability would add complexity to the common path.
> 
> This patch accelerates head-page initialization. The pfns_per_compound
> == 1 case gets the full benefit here, compound tails are handled in the
> next patch.
> 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
> path (pfns_per_compound == 1).
> 
> Test procedure:
> Rebind the nd_pmem driver 30 times and collect the memmap initialization
> time from the pr_debug() output of memmap_init_zone_device().
> 
> Base(v7.2-rc1):
>   Average of rebinds for nd_pmem driver: 244.28 ms
> 
> With this patch and its prerequisites applied:
>   Average of rebinds for nd_pmem driver: 215.55 ms
> 
> This reduces the average memmap initialization time measured during rebind
> from 244.28 ms to 215.55 ms, or about 11%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a70acb7431a6..56a36a71ba89 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1065,6 +1065,35 @@ static void __ref zone_device_page_init_slow(struct page *page,
>  		set_page_count(page, 0);
>  }
>  
> +/*
> + * 'template' is a reusable page prototype rather than a strictly immutable
> + * object. Most ZONE_DEVICE fields stay constant across the pages covered by
> + * the current template, but section bits and page->virtual may still depend
> + * on the PFN. Refresh those PFN-dependent fields in the template before
> + * copying it into @page.
> + */
> +static inline void zone_device_page_update_template(struct page *template,
> +		unsigned long pfn)
> +{
> +	set_page_section_from_pfn(template, pfn);
> +#ifdef WANT_PAGE_VIRTUAL
> +	if (!is_highmem_idx(ZONE_DEVICE))
> +		set_page_address(template, __va(pfn << PAGE_SHIFT));
> +#endif
> +}
> +
> +static void zone_device_page_init_from_template(struct page *page,
> +		unsigned long pfn, struct page *template)
> +{
> +	/*
> +	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
> +	 * page. Update the PFN-dependent fields in place before copying it
> +	 * to the destination page.
> +	 */
> +	zone_device_page_update_template(template, pfn);

Looks like it's the only user of zone_device_page_update_template().
I'd just fold it here and drop the comment.

> +	memcpy(page, template, sizeof(*page));
> +}
> +
>  /*
>   * With compound page geometry and when struct pages are stored in ram most
>   * tail pages are reused. Consequently, the amount of unique struct pages to
> @@ -1127,6 +1156,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	unsigned long zone_idx = zone_idx(zone);
>  	unsigned long start = jiffies;
>  	int nid = pgdat->node_id;
> +	struct page template;
>  
>  	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>  		return;
> @@ -1144,7 +1174,22 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> +		if (pfn == start_pfn) {
> +			/*
> +			 * Seed the reusable head-page template from the
> +			 * first real struct page. This initializes the
> +			 * first page through the existing slow path and
> +			 * then reuses that final state as the template
> +			 * for subsequent pages.
> +			 */
> +			zone_device_page_init_slow(page, pfn, zone_idx,
> +						   nid, pgmap);
> +			/* init template page */
> +			memcpy(&template, page, sizeof(*page));
> +		} else {
> +			zone_device_page_init_from_template(page, pfn,
> +							    &template);
> +		}

Why can't we init the template for the first page being initialized and
then call zone_device_page_init_from_template() unconditionally?

The same applies to the tail pages initialization.

-- 
Sincerely yours,
Mike.

