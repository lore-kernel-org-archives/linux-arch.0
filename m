Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A523C4FF
	for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779682343; cv=none; b=AA8Xw1v6sGuMWgSyOLG3TKgNwAo8GA48lWTEhhQvVWigMsZvySOaCqJ7ZzFwV69q8EXJGiniES43zAtZ1EliLxUpq7Xj8kIRL6cVFQOXoNnl4ObUlC1ts/cNyImD0v6XKzRvUMQjDQMvfVGVYL2yu9cZvUkx8eJg5fu+sIOrK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779682343; c=relaxed/simple;
	bh=S8x8ku68oTVz3r+/L/79bwyWMG0Tcj7UtXKYxRHCm84=;
	h=Message-Id:Mime-Version:In-Reply-To:Date:References:Cc:From:
	 Subject:To:Content-Type; b=o2+ABtFIiQpAznKyJK9OsuH6jTMi9T1dUIlsoC+oQCAr6E1wSjpmBthcKhUdiLP6iIPF1g2TC/TmOxU7CePYSeA57lUgFTeiiiFEhCevV4ehVq5qeF16O9pWqaD72OfOQ2RHn7KNyr9DVj+asKaJOLt6D9p/U1Sme6duaGRiCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fZBMo+up; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fZBMo+up"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779682326; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=d4pckDZxFf8QRPUPkIBfBrSh3CifT/9MSlxdT8SrZTU=;
 b=fZBMo+upVfv435usR0uWrVYcXDqQqCgLmm4Lwyi/S3s0dxrsKIQOaFE8f66+KM9MkuSnZi
 59V5kATwtCzlw1nH8p5Ibu/JF1Aqu240L4ip3jEhOe9b0zHhwgPWwGp5hlD4Ry96LedkMx
 cRxutn0ZDyEykK2nv84A8fXBWuOiF4nBZ5CDO4TQhY9TKoWAk/7iPObzoEIHSqP1rE/4Cc
 ajRX5kjrlGNyBepH6Os179hlIDMcUx92LcmGPv4nCJfyh1yR5mSKEd59fGXKAwZyOxH0UQ
 HgZ/jNN8GCEPZ+/2xEKgne3KkdXGiwVehuNgWFxE3JNM9zIeMq8vxseIuZjDPg==
Message-Id: <20260525041143.97194-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <177953825220.3959652.6200899011132427221.b4-review@b4>
X-Mailer: git-send-email 2.45.2
Date: Mon, 25 May 2026 12:11:43 +0800
References: <177953825220.3959652.6200899011132427221.b4-review@b4>
X-Lms-Return-Path: <lba+26a13cc15+c693f3+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v2 4/7] mm: extend the template fast path to zone-device compound tails
To: <rppt@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

On Sat, 23 May 2026 15:10:52 +0300, rppt@kernel.org wrote:

> On Thu, 21 May 2026 12:01:21 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 2992711351a0..17a84d4cda01 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1084,17 +1084,25 @@ static inline bool zone_device_page_init_optimization_enabled(void)
> >  		IS_ALIGNED(sizeof(struct page), sizeof(u64));
> >  }
> >
> > -static inline void zone_device_template_page_init(struct page *template,
> > -						  unsigned long pfn,
> > -						  unsigned long zone_idx,
> > -						  int nid,
> > -						  struct dev_pagemap *pgmap)
> > +static inline void zone_device_template_head_page_init(struct page *template,
> > +		unsigned long pfn, unsigned long zone_idx, int nid,
> > +		struct dev_pagemap *pgmap)
> 
> Yeah, two tabs from the start would be better :)
> 
> > @@ -1156,12 +1166,28 @@ static void __ref memmap_init_compound(struct page *head,
> > [ ... skip 17 lines ... ]
> > -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> > -		prep_compound_tail(page, head, order);
> > -		set_page_count(page, 0);
> > +		if (use_template) {
> > +			zone_device_page_init_from_template(page, pfn,
> > +							    &template);
> 
> continue here and there won't be need to indent the slow path.
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for the review. I will fix this in the next revision.

Thanks,
Zhe
