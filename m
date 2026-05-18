Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5663E3170
	for <linux-arch@vger.kernel.org>; Mon, 18 May 2026 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095538; cv=none; b=hM/4jGZITg5NoVdWP7fuhk+JjN83D6Br5+kFiZKZC1tSdpIdRfn6M/GkIHbKyYSykExGhbgeWb8pH6UBoLmUAWh8wcN1Le+pW3WBVxNyHbn5Igr9pJDGZCImcTeNeQd731Q/XFcHAKRyFovsgQN4km+w90tMgY/luexz5xlXHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095538; c=relaxed/simple;
	bh=lgQ7F/xeFPJ7y9dnDIX5KGG808+7k/qCC1kpIMcbH7o=;
	h=Cc:From:Subject:Date:Message-Id:Mime-Version:To:In-Reply-To:
	 References:Content-Type; b=BVOJuurtdY+r70B7TQ+E7EOIAZCoPCrsNIZjvQ1TjEJnPhfPCSy8UY2mYuc2Sb2iDLtoaxj1Pvy/QLgpFLcpRY2rf5v3+08BpgSRSJVsOvgTGKSGQWZPjPh9SOJ06cYokxqQpW+J+Bl6j9NvjTBlNARhg3Xm5PCBrHENwNtQXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LYGusmmj; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LYGusmmj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779095524; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JWXNe2P5R0SlkTM/8T8R92El2t5JoKtgbEM8w2iwBC8=;
 b=LYGusmmjkEfWhVSAfT9kv1tNfy5iAMNEmB5goHpQwtsNtYQ5ad1j9f0YNZYMItBTNsSdoM
 rfceGc32aCdPrg9YC902Vk4E81vOpCwSRPYwbNufD3CYsnc2DIYrSAboMjuGXsMAP2IzTs
 CiD7YYWF6C0l7Y+TjxZ4sKpeQUpaJ3imQD/Y730IcQCgJDYEVqITZVe4PKm+jng3kRkpHr
 T8c6c0qs3tJDcIUV5d/Or+Ic5RCFdwuscBDHlyx9qPQ3giEDQ7yYymRo8X49ZHvF1RfXRf
 qckBbcU0U1u+eJ+Yrlt3f256Cw1iqkV1emP4dAdCfhQIUA7i6guE0bMkrFgfew==
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
X-Lms-Return-Path: <lba+26a0ad7e2+fddd01+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH 1/4] mm: factor zone-device page init helpers out of __init_zone_device_page
Date: Mon, 18 May 2026 17:11:42 +0800
Message-Id: <20260518091142.71965-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <agqyd5Kncrx5B_ex@kernel.org>
References: <agqyd5Kncrx5B_ex@kernel.org>
Content-Type: text/plain; charset=UTF-8

On Mon, 18 May 2026 09:23:33 +0300, rppt@kernel.org wrote:

> Hi,
> 
> On Fri, May 15, 2026 at 04:20:42PM +0800, Li Zhe wrote:
> > __init_zone_device_page() currently mixes three different jobs: deciding
> > the initial page refcount, initializing the generic ZONE_DEVICE state, and
> > setting up pageblock metadata.
> >
> > Split the refcount policy into zone_device_page_init_refcount() and move
> > the generic page initialization into generic_init_zone_device_page(). This
> > keeps the slow path behavior unchanged, but makes the individual pieces
> > reusable by later fast-path patches.
> >
> > No functional change intended.
> >
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > ---
> >  mm/mm_init.c | 62 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 38 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index f9f8e1af921c..5244acb96dbb 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -987,11 +987,36 @@ static void __init memmap_init(void)
> >  }
> >
> >  #ifdef CONFIG_ZONE_DEVICE
> > -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> > -					  unsigned long zone_idx, int nid,
> > -					  struct dev_pagemap *pgmap)
> 
> Since you are already changing __init_zone_device_page(), I'd suggest
> renaming it to zone_device_page_init().
> 
> > +static inline int zone_device_page_init_refcount(
> > +		const struct dev_pagemap *pgmap)
> >  {
> > +	/*
> > +	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> > +	 * directly to the driver page allocator which will set the page count
> > +	 * to 1 when allocating the page.
> > +	 *
> > +	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
> > +	 * their refcount reset to one whenever they are freed (ie. after
> > +	 * their refcount drops to 0).
> > +	 */
> > +	switch (pgmap->type) {
> > +	case MEMORY_DEVICE_FS_DAX:
> > +	case MEMORY_DEVICE_PRIVATE:
> > +	case MEMORY_DEVICE_COHERENT:
> > +	case MEMORY_DEVICE_PCI_P2PDMA:
> > +		return 0;
> > +	case MEMORY_DEVICE_GENERIC:
> > +		return 1;
> > +	default:
> > +		WARN_ONCE(1, "Unknown memory type!");
> > +		return 1;
> > +	}
> > +}
> >
> > +static void __ref generic_init_zone_device_page(struct page *page,
> > +		unsigned long pfn, unsigned long zone_idx, int nid,
> > +		struct dev_pagemap *pgmap)
> > +{
> 
> Here also would be better to use zone_device_page_ prefix.
> And I don't think "generic" adds clarity about what this function is doing.
> 
> Seeing that later patches rename it again to _slow variant, I'd suggest to
> call it __zone_device_page_init() at keep this name going forward.

Thanks, I will fix this in the v2 revision.

Thanks,
Zhe
