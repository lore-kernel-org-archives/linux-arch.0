Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E998322B7B
	for <linux-arch@vger.kernel.org>; Mon, 18 May 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098073; cv=none; b=H0+d46Pf6dnHT1IRru169L/NiQeYH0/lfKUFdh1OXBlXXZx/YgN5AzOyjLU9+DMym92AE0Xb+i2TV7KC3qmLyNpuCfmh0fZ4b6RqgVAGqyRgB3tK9nYsbpq3FeIlxARZmJFU5XaAFPwEmcGGaeDoCnRUiRHlN5oga7fS9+q126k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098073; c=relaxed/simple;
	bh=NChihXEvG23alR8QhZshHpO1iaPcNDVZok/hIN6nsYY=;
	h=References:Cc:From:Mime-Version:Subject:Date:In-Reply-To:
	 Content-Type:To:Message-Id; b=tiB+8BIJudsXm954AswT24KYk61AAqEA1ihzkZMkzv2srJ8l5bRrVDQCSKqmUIUoUMGK3Xw3V+QdVPOVJU2Dbh0aBLME1ZN6av1GyJIAeERLA0hQT8I3BrGPhV46TTDyRU/xauWOxoOvIc+BIUsjuZ7f12S3P5yjXSp5QZR9Rss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XLPdiWCB; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XLPdiWCB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779098066; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wgbr+2+9/hNiYiWVufx6FjCu45ByoByDRte7+gOCp9c=;
 b=XLPdiWCBSTzzojXfvVfLm3V5EiuD8qZJ53pghpWj65OMMC8mHXkPwKn/uu1x3cmIBl2mNJ
 sjGeOLzg99PizJFccmkHf3qw7iSZxFF9NQFxe2lbo6Db+3rwwz+F3q1LKbkF/geNlDTXhE
 YQaDli+c5KUpF+UrEnOHdlCSPl+Z4MLLrMRrYbeGfQoXDDppegnZUD3lcLkivRUcGYspAJ
 wx8U3GlBPxgO2iJHycv8NNLXLynnfqzIux9TecZ1yuZ2VsH4hUqLLAm4qYUGNLfySgy1Nl
 1pP8618TIv89cxTWIVs6VchP3cDGv8ZFL45KjJBjgTXII8IAL+qru5oA3UYSsA==
References: <agq29raPaAPlM8kV@kernel.org>
X-Lms-Return-Path: <lba+26a0ae1d0+6675ca+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] mm: add a template-based fast path for zone-device page init
Date: Mon, 18 May 2026 17:54:05 +0800
In-Reply-To: <agq29raPaAPlM8kV@kernel.org>
Content-Type: text/plain; charset=UTF-8
To: <rppt@kernel.org>
Message-Id: <20260518095405.76367-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2

On Mon, 18 May 2026 09:51:34 +0300, rppt@kernel.org wrote:

> Hi,
> 
> On Fri, May 15, 2026 at 04:20:43PM +0800, Li Zhe wrote:
> > On 64-bit builds, memmap_init_zone_device() spends most of its time
> > repeating the same struct page initialization for every PFN. Prepare a
> > template page through the existing slow path once, then copy that
> > template into each destination page and fix up the PFN-dependent state
> > afterwards.
> >
> > Keep the optimized path disabled when the page_ref_set tracepoint is
> > active, because the template-copy path bypasses set_page_count() and
> > would otherwise hide the corresponding trace event.
> >
> > Non-64-bit builds continue to use the existing slow path.
> 
> ZONE_DEVICE depends on MEMORY_HOTPLUG and MEMORY_HOTPLUG is only supported
> for 64 bits, so there can't be 32-bit builds for ZONE_DEVICE functionality.

Thanks for the clarification.
Indeed ZONE_DEVICE depends on MEMORY_HOTPLUG which is 64-bit only. I
will refine the description accordingly in v2.

> > Tested in a VM with a 100 GB fsdax namespace device configured with
> > map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
> > path (pfns_per_compound == 1).
> >
> > Test procedure:
> > Rebind the nd_pmem driver 30 times and collect the memmap initialization
> > time from the pr_debug() output of memmap_init_zone_device().
> >
> > Base(v7.1-rc3):
> >   First binding: 1486 ms
> >   Average of subsequent rebinds: 273.52 ms
> >
> > With this patch:
> >   First binding: 1421 ms
> >   Average of subsequent rebinds: 246.14 ms
> >
> > This reduces the average rebind time from 273.52 ms to 246.14 ms, or
> > about 10%.
> >
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > ---
> >  mm/mm_init.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 96 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 5244acb96dbb..4c475c71a9d6 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1013,7 +1013,7 @@ static inline int zone_device_page_init_refcount(
> >  	}
> >  }
> >
> > -static void __ref generic_init_zone_device_page(struct page *page,
> > +static void __ref generic_init_zone_device_page_slow(struct page *page,
> >  		unsigned long pfn, unsigned long zone_idx, int nid,
> >  		struct dev_pagemap *pgmap)
> >  {
> > @@ -1040,12 +1040,9 @@ static void __ref generic_init_zone_device_page(struct page *page,
> >  		set_page_count(page, 0);
> >  }
> >
> > -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> > -					  unsigned long zone_idx, int nid,
> > -					  struct dev_pagemap *pgmap)
> > +static void __ref zone_device_page_init_pageblock(struct page *page,
> > +						  unsigned long pfn)
> 
> Please move splitting _pageblock helper into the first patch, so that the
> first patch would contain all code movement.

Thanks, I will move the _pageblock helper split into the first patch
in v2.

> >  {
> > -	generic_init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> > -
> >  	/*
> >  	 * Mark the block movable so that blocks are reserved for
> >  	 * movable at startup. This will force kernel allocations
> > @@ -1062,6 +1059,88 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> >  	}
> >  }
> >
> > +static inline void __init_zone_device_page(struct page *page, unsigned long pfn,
> > +					   unsigned long zone_idx, int nid,
> > +					   struct dev_pagemap *pgmap)
> > +{
> > +	generic_init_zone_device_page_slow(page, pfn, zone_idx, nid, pgmap);
> > +	zone_device_page_init_pageblock(page, pfn);
> > +}
> > +
> > +#if BITS_PER_LONG == 64
> > +static inline bool zone_device_page_init_optimization_enabled(void)
> > +{
> > +	/*
> > +	 * We use template pages and assign page->_refcount via memory copy.
> > +	 * This means the optimized path bypasses set_page_count(), so the
> > +	 * page_ref_set tracepoint cannot observe this initialization.
> > +	 * Skip the optimized path when the tracepoint is enabled.
> > +	 */
> > +	return !page_ref_tracepoint_active(page_ref_set);
> > +}
> > +
> > +static inline void struct_page_layout_check(void)
> > +{
> > +	BUILD_BUG_ON(sizeof(struct page) & (sizeof(u64) - 1));
> 
> Does it have to be a BUILD_BUG()? Can't we fallback to slow path if struct
> page has a weird size?
> Just do the check in zone_device_page_init_optimization_enabled().

Thanks, I'll replace the BUILD_BUG_ON() with a runtime check and fall
back to the slow path accordingly.

> > +}
> > +
> > +static inline void init_template_page(struct page *template,
> > +				      unsigned long pfn,
> > +				      unsigned long zone_idx,
> > +				      int nid,
> > +				      struct dev_pagemap *pgmap)
> 
> The name should include zone_device to avoid confusion with regular pages.

Thanks, I will rename it to include zone_device in v2.

> > +{
> > +	generic_init_zone_device_page_slow(template, pfn, zone_idx, nid, pgmap);
> > +}
> > +
> > +/*
> > + * Initialize parts that differ from the template
> > + */
> > +static inline void generic_init_zone_device_page_finish(struct page *page,
> > +							unsigned long pfn)
> > +{
> > +#ifdef SECTION_IN_PAGE_FLAGS
> > +	set_page_section(page, pfn_to_section_nr(pfn));
> 
> Can we add a stub for set_page_address() for !SECTION_IN_PAGE_FLAGS case
> and drop the #ifdef here and in set_page_links()?

Thanks, I will add the stub and remove the #ifdef in the next version.

> > +#endif
> > +#ifdef WANT_PAGE_VIRTUAL
> > +	if (!is_highmem_idx(ZONE_DEVICE))
> > +		set_page_address(page, __va(pfn << PAGE_SHIFT));
> 
> set_page_address() is a not when WANT_PAGE_VIRTUAL, you can drop the ifdef.

Upon checking the implementation, set_page_address() also has another
implementation for HASHED_PAGE_VIRTUAL

Following the style of __init_single_page(), we only want to call
set_page_address() under WANT_PAGE_VIRTUAL for ZONE_DEVICE initialization,
so would it be acceptable to keep the #ifdef guard here?

> > +#endif
> > +}
> > +
> > +static void init_zone_device_page_from_template(struct page *page,
> > +		unsigned long pfn, const struct page *template)
> 
> zone_device_page_init_from_template() please.

Thanks, I will rename it to zone_device_page_init_from_template in v2.

Thanks,
Zhe
