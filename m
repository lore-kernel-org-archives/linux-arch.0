Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A13D25C2;
	Fri,  3 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087603; cv=none; b=Vak+hhtbMO8XGrOlYJyyQfsoJ2o0VXYLfkVgE3I3L6AKSQxzkcf8jVyw6CgGBne6PWIkMc4l2p57KMcPTYafEYbddcAu433o+wviJf1GXUbbsIBnfcxcVZK9XCjnx7qIvFd56GxpQRO2Y6K7H371HGpqj/Z0R9Nggd1PJCLiykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087603; c=relaxed/simple;
	bh=1nBynMYrjOxt2oYrh38p8rFOIE9BYNqjdzW1X4NA8q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiulGgVGxNLZRWnoSAQiP9vcZppKabNOUZhihN149+SsXx5gENQTzOOIllYibmSfPq9iWFNjV7wRfXLgsnyKJqEiBCF7oWbxSb8ASVoTkwlSiPaSt+s9dKHiAfQxkFFZybA+n8ScrSTissrbtqZkZfL1O5mMU58806eDBTloBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp3q0TXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp3q0TXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBB11F000E9;
	Fri,  3 Jul 2026 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087601;
	bh=1pl8AC7qRBIEwlkot9AQuVgRYA3lF+ufbzrcbLLYwh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lp3q0TXLLJy3nqhzUHsU4dOWZjR3u2CraFKtZKVK7JOnHWpZNEOORVkR5AtEaoVFM
	 MkTqvcZg5727VjDHeVl1YFCJ+3Eh6f9QwEG1vKfxvygkdN9iwE8a44mkwbGhqGqqe6
	 geLge/IeNx9EBV3kvleMaIzjDDmfQ6Ts9RLrWzv8e+buz2IIbyzHrwNCd/rzxxjNM7
	 5YKkrzcyxrkzhjc8p6ZKxGvDO0RWIT87fhA5220Qm2pDZtz7A6L8Kmset3rjQQ6Kvb
	 psVhW82tgtKWptTPfTnTgtI0EQMyWDRmm8oTr6fFHLebyTc6qDhBrJ8OHNqqdbaNmc
	 oWXodFLtCI9+w==
Date: Fri, 3 Jul 2026 17:06:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org,
	kees@kernel.org, mingo@redhat.com, tglx@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 4/8] mm: add a template-based fast path for
 zone-device page init
Message-ID: <akfB6Qe-jKDEMUxz@kernel.org>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
 <20260701090553.62691-5-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701090553.62691-5-lizhe.67@bytedance.com>

On Wed, Jul 01, 2026 at 05:05:49PM +0800, Li Zhe wrote:
> memmap_init_zone_device() repeats nearly identical head-page
> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
> template through the existing slow path, refresh the PFN-dependent
> fields in that template before each copy, and memcpy it into each
> destination page.
> 
> This reduces the average rebind time from 244.28 ms to 217.19 ms, or
> about 11%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  mm/mm_init.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 4c7fad440c2a..cc8417951467 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1066,6 +1066,50 @@ static void __ref zone_device_page_init_slow(struct page *page,
>  		set_page_count(page, 0);
>  }
>  
> +static inline bool zone_device_page_init_optimization_enabled(void)
> +{
> +	/*
> +	 * The template fast path copies a preinitialized struct page image.
> +	 * Skip it when the page_ref_set tracepoint is enabled.
> +	 */
> +	return !page_ref_tracepoint_active(page_ref_set);
> +}
> +
> +static inline void zone_device_template_page_init(struct page *template,
> +						  struct page *src)
> +{
> +	memcpy(template, src, sizeof(*template));
> +}
> +
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
> +	memcpy(page, template, sizeof(*page));
> +}
> +

The whole bunch of template functions look like it could be useful for
initialization of the non-zone-device struct pages as well.

As I mentioned previously, it's interesting to see if this approach speeds
up normal memory map initialization as well. If if does could have a single
set of the template functions.

-- 
Sincerely yours,
Mike.
