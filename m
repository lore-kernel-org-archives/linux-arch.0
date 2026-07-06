Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C953BED56
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323972; cv=none; b=Vlf77IWz1lbkUqdi728tKDTadI3h4vsBulo60NwmSEG1I7/KoiYBB5OQC/eujwEMW1VuhgBSNobi6Eb/Shm22HBuk1zpDBkjWLDZ3y9ivBPlnSNCvKh8+YDE5XErS5rOojjofecUeuZ3gajsXvrjnsecztHRBWoJmmYeZqalz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323972; c=relaxed/simple;
	bh=9XefnfWK9TEY2YEAWePtrhrCW+V7nnuoK4APLqKmnuI=;
	h=Subject:Date:In-Reply-To:Content-Type:Cc:Mime-Version:References:
	 Message-Id:From:To; b=b+a39rs5ld/3pkb/mMucZkgFCiVmkOHK1wIvcWKkbviZpjSXrGU1B7ykAq19RZlJ2oLd2O+cfWAyjP/9fwMqZmdSDaIKW1/7raVFBotAgkHV42ToiDqIZ0xjrORYMnTkQ7zYZhhPViBajX1Sx7IjvqvwUKea0ZCoCXtCdluEWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dTdvR0Ty; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dTdvR0Ty"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783323951; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/z6wV3oJTOVm+St0XwYa3g9dR2I+dcMz7cR6ea5u0LE=;
 b=dTdvR0TyV0l782HOvbS5Rxs5l31ff73b+/mteCRsgiZLLBmDc1UwDTDHhLg7TF37RmFFbT
 A3p7OXLNnuPBVMfiytFMH0hv1Hg+9cDUl8Xjf3J5SLIDyQYU6TV5Brsl/VyGwRpWZz5d7V
 a5GO4buKYG6P2lwBOY0/HEs14IenDMx4VQjkBEkFuESxN4Tl09wwz9vLCFGeSfAWwZk2Yw
 0rDtGl2+eaCkgVF1uJmJla0D9avSWrdAE7aZ8MBuOjss6cwjN+W16t4RVM5GiS6Q/R6KkF
 ournOd4jO7u8YaUq/H/y/FYZaXYkFL0d9lbSOHgLx6ZZElI0WBfp7WYHx//xZg==
Subject: Re: [PATCH v5 4/8] mm: add a template-based fast path for zone-device page init
Date: Mon,  6 Jul 2026 15:45:27 +0800
In-Reply-To: <akfB6Qe-jKDEMUxz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
References: <akfB6Qe-jKDEMUxz@kernel.org>
Message-Id: <20260706074527.23978-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4b5d2d+fafbf6+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <rppt@kernel.org>

On Fri, 3 Jul 2026 17:06:33 +0300, rppt@kernel.org wrote:

> On Wed, Jul 01, 2026 at 05:05:49PM +0800, Li Zhe wrote:
> > memmap_init_zone_device() repeats nearly identical head-page
> > initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
> > template through the existing slow path, refresh the PFN-dependent
> > fields in that template before each copy, and memcpy it into each
> > destination page.
> >
> > This reduces the average rebind time from 244.28 ms to 217.19 ms, or
> > about 11%.
> >
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > ---
> >  mm/mm_init.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 74 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 4c7fad440c2a..cc8417951467 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1066,6 +1066,50 @@ static void __ref zone_device_page_init_slow(struct page *page,
> >  		set_page_count(page, 0);
> >  }
> >
> > +static inline bool zone_device_page_init_optimization_enabled(void)
> > +{
> > +	/*
> > +	 * The template fast path copies a preinitialized struct page image.
> > +	 * Skip it when the page_ref_set tracepoint is enabled.
> > +	 */
> > +	return !page_ref_tracepoint_active(page_ref_set);
> > +}
> > +
> > +static inline void zone_device_template_page_init(struct page *template,
> > +						  struct page *src)
> > +{
> > +	memcpy(template, src, sizeof(*template));
> > +}
> > +
> > +/*
> > + * 'template' is a reusable page prototype rather than a strictly immutable
> > + * object. Most ZONE_DEVICE fields stay constant across the pages covered by
> > + * the current template, but section bits and page->virtual may still depend
> > + * on the PFN. Refresh those PFN-dependent fields in the template before
> > + * copying it into @page.
> > + */
> > +static inline void zone_device_page_update_template(struct page *template,
> > +		unsigned long pfn)
> > +{
> > +	set_page_section_from_pfn(template, pfn);
> > +#ifdef WANT_PAGE_VIRTUAL
> > +	if (!is_highmem_idx(ZONE_DEVICE))
> > +		set_page_address(template, __va(pfn << PAGE_SHIFT));
> > +#endif
> > +}
> > +
> > +static void zone_device_page_init_from_template(struct page *page,
> > +		unsigned long pfn, struct page *template)
> > +{
> > +	/*
> > +	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
> > +	 * page. Update the PFN-dependent fields in place before copying it
> > +	 * to the destination page.
> > +	 */
> > +	zone_device_page_update_template(template, pfn);
> > +	memcpy(page, template, sizeof(*page));
> > +}
> > +
> 
> The whole bunch of template functions look like it could be useful for
> initialization of the non-zone-device struct pages as well.
> 
> As I mentioned previously, it's interesting to see if this approach speeds
> up normal memory map initialization as well. If if does could have a single
> set of the template functions.

Thanks for the suggestion. I agree this is worth exploring.

For this series, I would prefer to keep the scope limited to the
ZONE_DEVICE initialization path and get that part settled first.

After this series is settled, I plan to look into whether a similar
template-based approach can also help normal page initialization. If it
shows a real benefit there as well, I can follow up with a separate
series.

Thanks,
Zhe
