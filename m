Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE32D1F44;
	Sat, 23 May 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538263; cv=none; b=Z0zieDT1k2prLSg7h96mWHLfEs5UaprEBC6DBf/1mP4Fcv7yBPC9FU8s4Yg7UlsF5j3GW9EeiM4jS/fTEelUK6xzAUIOmTxsu66q82OBraEVyW1xiLOoHzDADqR2Scc+09hJSt4Q5watVjZximd+yHygLVwLvKOs5uWV4jvlIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538263; c=relaxed/simple;
	bh=NPClmFA4KwkKK/XXm3hYSoPNyJqE2V68Yd0M5gOoqHk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=b07kMlSw3vrgwx/lbaWNQ3wc5Q7jrfuTy8wvM3Lb2L0RqU38SGiLoynaIMtITnQYD8f0pySmgihuNMNLb5jTc6bz2zl4vnrKiFjOAqpIt0aOr52ezEwem5HNR/7kXdez++qbepTqWh1il0z+/OnPccpVSeMwJ7dE5ujGQxAgejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIgrkQz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIgrkQz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F351E1F000E9;
	Sat, 23 May 2026 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779538262;
	bh=jjoXD8XwhLty3iY7UWgSjV13en+BJQVZoZqE9+402Ks=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZIgrkQz2lnkHB+TNWttFbCvJGShCKoMk5IY1X4wPFKyUjwXNFaFY+Bw8prdihmpqY
	 b9Nz/9AC0aws6sHoyg9vWmk2qHY939xawthSJIQmjvIwVhwGvyyB0kuAkKSX/EWbxU
	 5Y7MvM3a5Qblu0eCwuDNgDCxvfvCOmHPcwXWBUg7O3c4GPGPTbyfyjOQ55D0qk3AYv
	 QMMsldFXbvqBDp2USR6fesd8k2RIt4cMQcqTcEcc0EdTXOBIWeUvoM4cmOjWB3RDim
	 WM1fwq74KhEYDcmKAkF92xgqnH17JX6QadRz05EHdjxvpoQS+UT6Jv+6V2Znk+Cl9o
	 pxijT3mbp4Njw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] mm: factor zone-device page init helpers out of
 __init_zone_device_page
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: apopple@nvidia.com, akpm@linux-foundation.org, arnd@arndb.de, 
 bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, 
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org, kees@kernel.org, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260521040124.10608-2-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
 <20260521040124.10608-2-lizhe.67@bytedance.com>
Date: Sat, 23 May 2026 15:10:52 +0300
Message-Id: <177953825215.3959652.4404326127425239303.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 12:01:18 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..4ba506df93bc 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -987,11 +987,36 @@ static void __init memmap_init(void)
>  }
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> +static inline int zone_device_page_init_refcount(
> +		const struct dev_pagemap *pgmap)

The name zone_device_page_init_refcount() implies that this function
actually intializes the refcount, but it's actually used as a predicate
based on pagemap properties, so let's make it bool and name accordingly. 
How about

static inline bool pagemap_resets_refcount(const struct dev_pagemap *pagemap)

Other than that:

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

