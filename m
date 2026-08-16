Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739622AE8D;
	Sun, 16 Aug 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786881884; cv=none; b=E7/h03JtWOrz0ojoQ9P8TTEqbqqF8tQCfOphcAdmrVQSlNQ8SMv11IABZe8ibdW+tNcBd7Y2JmmYX+mQ/wiEHfP4Zcg0nQfJBlTIVrXptE76JbiNWE2WA68XlSHttOzVrGmIHGSsxgEz4Ge/w53E0E+3Jo5vqkGCpAPUYWLknP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786881884; c=relaxed/simple;
	bh=XTbA6I1evJYQ1n9QHsMlEYaZ8jo0eWN7yoaQQ/cNQeU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LIW3MVRaugUeALxh8VCVHrkEQDOIY1g0XBjVywvQvOYs058zim8ZyiydEicHu1DdPlicNh5cLwTRBVSwKDhvw7V9ZD74owtXtCx2awZ5XMoPACV8c9dg1aRe8V4UPwKllkUAwtP6V9JxUD6LQTMmC2spFgnSTaT3q0DJAvo/QKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJnA59Sb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJnA59Sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6C1F00A3F;
	Sun, 16 Aug 2026 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786881883;
	bh=pcnkBAVEUjmpyOE2W5EPEYw0ee+IwKE8GrSAoYr+M2g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YJnA59SbM2V/tctiXXk5aj0gwDKO5k4NwOYPnb3dKchy6Dia81+Z5l9SU2HSqp2Oq
	 3brzwZte3zvXTVzMnIebltAc/hzQ7KBkUNY6n7kZwzr/K/1RP8hX1LCmwO08TT0Iph
	 hXqdbQh8EaJtBQDnelnxF64naJs7ybvmIleWm4pmCt1hhY1XFgM4gbB2PKUGE9gAoP
	 yIOUiFKdGHOB7LNCYvOwoFo/1ZYDz+iMFIvcyHEC8LXG+i5B9dIfAAVd5yaongKart
	 w/J6FnujDLCWlx9wcpngAXc7NmB95J/ZgCv18MkQ6KOcad7w/L0lpuR/PT6Aw4LBfe
	 0rX+Lc0kMaIdA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 2/8] mm: factor zone-device page init helpers out
 of __init_zone_device_page
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com, 
 david@kernel.org, kees@kernel.org, mingo@redhat.com, muchun.song@linux.dev, 
 rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org
In-Reply-To: <20260810122057.30447-3-lizhe.67@bytedance.com>
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
 <20260810122057.30447-3-lizhe.67@bytedance.com>
Date: Sun, 16 Aug 2026 15:04:30 +0300
Message-Id: <178688187038.2799959.7900723270155108493.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> memmap_init_zone_device() currently mixes refcount policy and core
> ZONE_DEVICE page setup in a single helper.
> 
> Factor the refcount-reset predicate into pagemap_requires_refcount_reset(),
> move the common page initialization into __zone_device_page_init(), and
> wrap the existing slow path in zone_device_page_init_slow().
> 
> This keeps the slow-path behaviour unchanged and gives later patches
> reusable helper boundaries.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 95808ab5cfdb..a70acb7431a6 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
>  }
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> +/*
> + * Return true when memmap_init_zone_device() must initialize the page
> + * refcount to 0. MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in
> + * the free path, while the remaining ZONE_DEVICE types start from 0 here
> + * and raise the count again when the allocator or driver hands the page
> + * out.
> + */
> +static inline bool pagemap_requires_refcount_reset(const struct dev_pagemap *pgmap)
> +{
> +	/*
> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> +	 * the count again when the allocator or driver hands the page out.
> +	 */
> +	switch (pgmap->type) {
> +	case MEMORY_DEVICE_FS_DAX:
> +	case MEMORY_DEVICE_PRIVATE:
> +	case MEMORY_DEVICE_COHERENT:
> +	case MEMORY_DEVICE_PCI_P2PDMA:
> +		return true;
> +	case MEMORY_DEVICE_GENERIC:
> +		return false;
> +	}
> +
> +	return false;
> +}
> +
> +static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
>  					  unsigned long zone_idx, int nid,
>  					  struct dev_pagemap *pgmap)
>  {
> -
>  	__init_single_page(page, pfn, zone_idx, nid);
>  
>  	/*
> @@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	 */
>  	page_folio(page)->pgmap = pgmap;
>  	page->zone_device_data = NULL;
> +}
>  
> -	/*
> -	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> -	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> -	 * the count again when the allocator or driver hands the page out.
> -	 */
> -	switch (pgmap->type) {
> -	case MEMORY_DEVICE_FS_DAX:
> -	case MEMORY_DEVICE_PRIVATE:
> -	case MEMORY_DEVICE_COHERENT:
> -	case MEMORY_DEVICE_PCI_P2PDMA:
> +static void __ref zone_device_page_init_slow(struct page *page,
> +		unsigned long pfn, unsigned long zone_idx, int nid,
> +		struct dev_pagemap *pgmap)
> +{
> +	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
> +	if (pagemap_requires_refcount_reset(pgmap))
>  		set_page_count(page, 0);
> -		break;
> -
> -	case MEMORY_DEVICE_GENERIC:
> -		break;
> -	}
>  }
>  
>  /*
> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
>  	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
>  		prep_compound_tail(page, head, order);
>  		set_page_count(page, 0);
>  	}
> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);

It looks like all callers of __init_zone_device_page() are now calling
zone_device_page_init_slow() that with series evolution became a thin
wrapper for __zone_device_page_init().

Maybe we can just rename __init_zone_device_page() to
__zone_device_page_init() and replace the open coded setting of the page
count with the call to pagemap_requires_refcount_reset() an be done
here?

-- 
Sincerely yours,
Mike.

