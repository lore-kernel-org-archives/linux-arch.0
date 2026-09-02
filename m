Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522A36495D;
	Wed,  2 Sep 2026 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788322585; cv=none; b=B2NvvuRPfQRf2MaRjiemAigieYtwLnGNRI7DbWgFyXsaPJ6LEvVZpK3g5+KKvl2MKp2FlvtzWhTSXPvfHDkA7uqgbGI8wsYpm97IHQOfe+JHC6UsMwQOxsB91JXQdLL6gg4gk/T0f1tEHF9/ok7/tk7IpzVP2dSnrWVJms1kqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788322585; c=relaxed/simple;
	bh=rGmxizZe0kb1uAevymfguatiHBKbE8vPlqYbx1eszQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGu+C7tibRSSZkZujslL8Q4BfgJaSajSkl5KV+ciTDjX/kmRtBlYDNGg4NalTi1vHtjhzCXEcrxkoM8Lg7LBEn1zfOxyjdzN693RjZ0jx6WhvhAVAWrxNwbKH+ozr7nSaOJbVHMGgjJZ54FVFbFsnfEIga9GFQZzRzvss1bbbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUs5V50K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUs5V50K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5DF1F000E9;
	Wed,  2 Sep 2026 04:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788322581;
	bh=BZLplcC78nW04+rNik0Rv2RsIFoVAuiKuAJHw6vULLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZUs5V50KLwRoGyMtkB1q+P4WuOZQdIgVCfbYV1lxIu+szOOxUYKyLxRa5oFZwj6Xn
	 MOFB+A3ho/QCG+1FNcOrk109aBfOPaUKGVFA4Y/udCbbfyS5hp1JBDcQn9Yioo8896
	 4gGmxHNyvahFFCMylZtWPPNXF9fXaJGyajMIGT0cRUKpe4Zc4QwmDEqvB0vj2/u8iF
	 9rqtus/lJejBJJnC8xR80EzOn2H0lkIGHH6zMPuUYv7WvO93WwnbuukJmcTAcSVxbI
	 j5uU2jayAE1ZLy9EzqJS/nZzUItVmAYk0xfBp0SYGdf+1iw64eby9gr9cW84kiUOOA
	 eVa67NbVMnDHg==
Date: Wed, 2 Sep 2026 07:16:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
	david@kernel.org, kees@kernel.org, mingo@redhat.com,
	muchun.song@linux.dev, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v11 3/7] mm: add a template-based fast path for
 zone-device page init
Message-ID: <apejDEdW95T-tekb@kernel.org>
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
 <20260831111638.76012-4-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831111638.76012-4-lizhe.67@bytedance.com>

On Mon, Aug 31, 2026 at 07:16:34PM +0800, Li Zhe wrote:
> memmap_init_zone_device() repeats nearly identical head-page
> initialization for each PFN. Initialize the first real ZONE_DEVICE head
> page through the existing path, copy that final state into a reusable
> template, refresh the PFN-dependent fields in that template before each
> copy, and copy it into the remaining destination pages.
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
> Base(v7.3-rc1):
>   Average of rebinds for nd_pmem driver: 221.07 ms
> 
> With this patch and its prerequisites applied:
>   Average of rebinds for nd_pmem driver: 155.00 ms
> 
> This reduces the average memmap initialization time measured during
> rebind from 221.07 ms to 155.00 ms, or about 29.9%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>

With one nit below

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> @@ -1093,10 +1106,29 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  		nr_pages = end_pfn - start_pfn;
>  	}
>  
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
> -		struct page *page = pfn_to_page(pfn);
> +	if (!nr_pages)
> +		return;
>  
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +	/*
> +	 * Seed the reusable head-page template from the first real struct
> +	 * page. The normal page-init and refcount helpers must operate on
> +	 * a real memmap entry rather than a stack object.
> +	 */
> +	pfn = start_pfn;
> +	page = pfn_to_page(pfn);
> +	__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +	memcpy(&template, page, sizeof(*page));
> +	if (pfns_per_compound != 1)
> +		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> +				     compound_nr_pages(pfn, altmap, pgmap));
> +	pfn += pfns_per_compound;
> +
> +	/* Initialize the remaining head pages from template. */
> +	for (; pfn < end_pfn; pfn += pfns_per_compound) {
> +		page = pfn_to_page(pfn);
> +
> +		zone_device_page_init_from_template(page, pfn,
> +						    &template);

Nit: this seems to fit into 80-chars line without wrapping.

>  
>  		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>  			cond_resched();
> -- 
> 2.20.1

-- 
Sincerely yours,
Mike.
