Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BA2D1F44;
	Sat, 23 May 2026 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538275; cv=none; b=mJgrDdzxuZliK60MoatcSPtSRQVSFuX+SiBljRf3mSEUe4jL9TJosfQH72nkWTvwp0bGpwhvOk5BTxBSIWhB9werARXwHi6wit+exIQ53grBwAsjLvkGAmEScxyMDFOZ1WK3ciA7l7Slr9dl5LNbskuGtUUS0IMmZYYCqcP1f2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538275; c=relaxed/simple;
	bh=TJpouY+WExPcn6UPnU+UiFviNKLNAKKaPS+QaWzLPQo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=C912XK4tqpgseSooDgLZRfIHo+zPYjS0or7Y6rvJWFXP3djF48I+UVYHroR8HPFgXM1cQkk+9Z/zyYguk00SIGDZp1XwrWhET0FRsTB7cd3pGaR+uIwYmTfOYAYGziByfubRjVi+7ua7vs6WcAOZEH2tB+qlgviCS9zyYJZUk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq9FjGic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq9FjGic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A652C1F00A3A;
	Sat, 23 May 2026 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779538274;
	bh=HfVu5i9oGVrZKznwyVgNmlbhPXsqzMVnma+Gfjw5hT0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Gq9FjGicG/zRK826fjDvqZ3DNNSrEVuvl/In1/2siNoMiy8lRY7iPDcvE0IG+d8M3
	 n9Woa1s10C/TRp75UdcsWyNKF2a2IAXmZEeoQj5V4oVPQvjCkz22LqGdfW7cl2w+70
	 PvCMY6o7V+V6XMRQV/FiribnrVEB2C1hJ2F62+SHvg8GaiInYMyN2dVl1XqzRQd6Jk
	 +Af7KS0c1Q4MOfEYcqRhRVhxt1RYIdxzqg8aEDMzEKvjKPGxwUcAfMSlQXg9SUDs99
	 5lZd+OUUTrwETdSU3glSYm3ja4R153L9IrgsaoX5mic+Q3ma8j+KyMNNlMBkAs1ZTJ
	 yrxZn4N689JUA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/7] mm: extend the template fast path to
 zone-device compound tails
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: apopple@nvidia.com, akpm@linux-foundation.org, arnd@arndb.de, 
 bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, 
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org, kees@kernel.org, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260521040124.10608-5-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
 <20260521040124.10608-5-lizhe.67@bytedance.com>
Date: Sat, 23 May 2026 15:10:52 +0300
Message-Id: <177953825220.3959652.6200899011132427221.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 12:01:21 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2992711351a0..17a84d4cda01 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1084,17 +1084,25 @@ static inline bool zone_device_page_init_optimization_enabled(void)
>  		IS_ALIGNED(sizeof(struct page), sizeof(u64));
>  }
>  
> -static inline void zone_device_template_page_init(struct page *template,
> -						  unsigned long pfn,
> -						  unsigned long zone_idx,
> -						  int nid,
> -						  struct dev_pagemap *pgmap)
> +static inline void zone_device_template_head_page_init(struct page *template,
> +		unsigned long pfn, unsigned long zone_idx, int nid,
> +		struct dev_pagemap *pgmap)

Yeah, two tabs from the start would be better :)

> @@ -1156,12 +1166,28 @@ static void __ref memmap_init_compound(struct page *head,
> [ ... skip 17 lines ... ]
> -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> -		prep_compound_tail(page, head, order);
> -		set_page_count(page, 0);
> +		if (use_template) {
> +			zone_device_page_init_from_template(page, pfn,
> +							    &template);

continue here and there won't be need to indent the slow path.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

