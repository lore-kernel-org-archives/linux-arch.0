Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DE30E0E9;
	Mon, 17 Aug 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965368; cv=none; b=fomX0HGTwcOvkSw2WODVDr6x+LDzXepwDVZ3iPK4nHeGHNeS5+xBCEEsN1p6hy+aNIoIOtQnGaYYk/XUEItylzUXJ782gp+CeupEYzvFFkGIaU6P8YjdLNGkWXkJCEkso5zRHpBwNMsuwCyT6WFgcjwjFwWY77RCLPV+DTVMnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965368; c=relaxed/simple;
	bh=RlBey3ICrIGs9TtvveUZmJ6NMHs8dDYLBZy4uyLNcuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7A921S5RlB5hQ5tPvAh7k4cTmHeyvEIc+706wKXsBpVmtnwTgPcpkZ5m0t148z/4lNTHJ3FFZou3wGqdTnbYfiwUaMU/RNzx3ZLDGQXvJfFiZ0PvQnh/8nDGWjAlPkA3w2v58iRWNcpaf32QoTBwQJwT/mNrnfWaKNTyoZUGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUszP7iB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUszP7iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274DB1F000E9;
	Mon, 17 Aug 2026 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786965366;
	bh=pEiCzvWeUGYIvROwUcLdzkful8DGFhkVU5axYHnXzAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VUszP7iBiEwWM7jmKtcc8MgMRH4a0eQSsEFEfoa70VpX1A6FvPSIknklIJi4I/AYh
	 yfLB6G7kLoMzpjN3A60NMZNKJe1M+VKut9hayU38wkxmjVO60UTjO/GtNBHjbVjMhE
	 b/MuzWASuTMIMAwN5TSoU3s0cu5U8paStGq5Q+ZtJSrsKAlhq6LWJZIgL/M7EzIgDy
	 +LV01x9H3stNdokj7k88f8IVWJbk9zOcPGBaMocn0QhNSUn74vRB+fzjZ+9WFugzp7
	 smSj05Avv6foZ3ei/8Za9Lld+hAfGQ6O5qvrU3/2FUP+AAr0D/+vtGRuHjNLDtZZsB
	 dfJxAe+dtzX5w==
Date: Mon, 17 Aug 2026 14:15:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
	david@kernel.org, kees@kernel.org, mingo@redhat.com,
	muchun.song@linux.dev, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v10 2/8] mm: factor zone-device page init helpers out of
 __init_zone_device_page
Message-ID: <aoLtbbv5euE4H1xO@kernel.org>
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
 <20260810122057.30447-3-lizhe.67@bytedance.com>
 <178688187038.2799959.7900723270155108493.b4-review@b4>
 <050c317f-111e-4293-aee5-ac8e154ebc7e@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050c317f-111e-4293-aee5-ac8e154ebc7e@bytedance.com>

On Mon, Aug 17, 2026 at 03:11:56PM +0800, Li Zhe wrote:
> On 8/16/26 8:04 PM, Mike Rapoport wrote:
> > Hi,
> >
> >> memmap_init_zone_device() currently mixes refcount policy and core
> >> ZONE_DEVICE page setup in a single helper.
> >>
> >> Factor the refcount-reset predicate into pagemap_requires_refcount_reset(),
> >> move the common page initialization into __zone_device_page_init(), and
> >> wrap the existing slow path in zone_device_page_init_slow().
> >>
> >> This keeps the slow-path behaviour unchanged and gives later patches
> >> reusable helper boundaries.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> >> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index 95808ab5cfdb..a70acb7431a6 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -1005,11 +1005,37 @@ static void __init memmap_init(void)
> >>   }
> >>   
> >>   #ifdef CONFIG_ZONE_DEVICE
> >> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> >> +/*
> >> + * Return true when memmap_init_zone_device() must initialize the page
> >> + * refcount to 0. MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in
> >> + * the free path, while the remaining ZONE_DEVICE types start from 0 here
> >> + * and raise the count again when the allocator or driver hands the page
> >> + * out.
> >> + */
> >> +static inline bool pagemap_requires_refcount_reset(const struct dev_pagemap *pgmap)
> >> +{
> >> +	/*
> >> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> >> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> >> +	 * the count again when the allocator or driver hands the page out.
> >> +	 */
> >> +	switch (pgmap->type) {
> >> +	case MEMORY_DEVICE_FS_DAX:
> >> +	case MEMORY_DEVICE_PRIVATE:
> >> +	case MEMORY_DEVICE_COHERENT:
> >> +	case MEMORY_DEVICE_PCI_P2PDMA:
> >> +		return true;
> >> +	case MEMORY_DEVICE_GENERIC:
> >> +		return false;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +static void __ref __zone_device_page_init(struct page *page, unsigned long pfn,
> >>   					  unsigned long zone_idx, int nid,
> >>   					  struct dev_pagemap *pgmap)
> >>   {
> >> -
> >>   	__init_single_page(page, pfn, zone_idx, nid);
> >>   
> >>   	/*
> >> @@ -1028,23 +1054,15 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> >>   	 */
> >>   	page_folio(page)->pgmap = pgmap;
> >>   	page->zone_device_data = NULL;
> >> +}
> >>   
> >> -	/*
> >> -	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> >> -	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> >> -	 * the count again when the allocator or driver hands the page out.
> >> -	 */
> >> -	switch (pgmap->type) {
> >> -	case MEMORY_DEVICE_FS_DAX:
> >> -	case MEMORY_DEVICE_PRIVATE:
> >> -	case MEMORY_DEVICE_COHERENT:
> >> -	case MEMORY_DEVICE_PCI_P2PDMA:
> >> +static void __ref zone_device_page_init_slow(struct page *page,
> >> +		unsigned long pfn, unsigned long zone_idx, int nid,
> >> +		struct dev_pagemap *pgmap)
> >> +{
> >> +	__zone_device_page_init(page, pfn, zone_idx, nid, pgmap);
> >> +	if (pagemap_requires_refcount_reset(pgmap))
> >>   		set_page_count(page, 0);
> >> -		break;
> >> -
> >> -	case MEMORY_DEVICE_GENERIC:
> >> -		break;
> >> -	}
> >>   }
> >>   
> >>   /*
> >> @@ -1090,7 +1108,7 @@ static void __ref memmap_init_compound(struct page *head,
> >>   	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
> >>   		struct page *page = pfn_to_page(pfn);
> >>   
> >> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> >> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> >>   		prep_compound_tail(page, head, order);
> >>   		set_page_count(page, 0);
> >>   	}
> >> @@ -1126,7 +1144,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >>   	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
> >>   		struct page *page = pfn_to_page(pfn);
> >>   
> >> -		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> >> +		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> > It looks like all callers of __init_zone_device_page() are now calling
> > zone_device_page_init_slow() that with series evolution became a thin
> > wrapper for __zone_device_page_init().
> >
> > Maybe we can just rename __init_zone_device_page() to
> > __zone_device_page_init() and replace the open coded setting of the page
> > count with the call to pagemap_requires_refcount_reset() an be done
> > here?
> 
> 
> Yes, that would make patch 2 simpler.
> 
> The reason I kept the refcount policy outside __zone_device_page_init()
> is the compound-tail initialization added later in patch 5. Tail pages
> still need the same basic ZONE_DEVICE struct page initialization as head
> pages, including __init_single_page(), PageReserved, pgmap and
> zone_device_data setup. After that, the tail-page path calls
> prep_compound_tail() and sets the tail refcount to 0 unconditionally.
> 
> Folding pagemap_requires_refcount_reset() into __zone_device_page_init()
> would make that helper include the head-page refcount policy even for
> callers that will immediately apply the tail-page refcount rule
> afterwards.

But you still call zone_device_page_init_slow() from
zone_device_tail_page_init() so it's anyway there.

I'd suggest combining this and the next patch into one, keeping
__init_zone_device_page() name without renaming it at all and open-coding
the initialization of the first head and the first tail page to properly
set refcount and call other prep methods.

I'd also pull the initialization of the first page in both cases out of the
loop and make the loop only use the _template version.
 
> That preserves the final state, but I was trying to keep the common
> ZONE_DEVICE page setup separate from the head-page refcount policy for
> this reason.
> 
> Would you still prefer the simpler renamed helper here, or should I keep
> the common ZONE_DEVICE page setup separate from the refcount policy and
> make the naming clearer in v11?
> 
> Thanks,
> Zhe
> 

-- 
Sincerely yours,
Mike.
