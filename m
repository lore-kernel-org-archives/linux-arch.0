Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8502D1F44;
	Sat, 23 May 2026 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538279; cv=none; b=JndobLYDj+X4PBZuteDH+XlGV94YDVgIiVX22IFiJc1c59Kv/h1qiMowF2Re8nV48uoeFnrWpbOCtzsfDT/GkzR3YqGB+Bb8CEov/SRGD8eOBHZ74s22DDC3pvTjUEOMT7aLETfO3WNM78/vb9ZMrtBoY2Zeth/Xga6L6wRDWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538279; c=relaxed/simple;
	bh=8IOPiHphKS24MbMajYiZHejjFvd+vyIWFrEoHb4rllQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Mo5Cder3++3vZjCBJGrJJ08i8obD7NUdeAOX9dnKgBZYHnMMe0U6BNVT1cwFpkO/3iHwRGz6tzZOVHE3tx+yyvYtEhsTt3EZ4E7oP7D+OWZ5aPywUnDrs2o+/pw2uy3SIUAThJu8yYqd6kCh9BIYqxN1+Cn25Bh1KlYb8ADVje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emz2jnqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emz2jnqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A08F1F000E9;
	Sat, 23 May 2026 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779538277;
	bh=b1wgwA+Vq+cgG6DenLipxbTjkVMrwQwE1EoJ9iSs0eY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=emz2jnqjttKsnlrghDgcd5WlZbWZQl5vO8MV7m6QcVNWYJJsetTutVKdxOYDr1RNf
	 SOxsVBZvg1JRLSLhY98fdzCocFAq7kA0pP4ZAmJHofZbmW6W4gLUv18kQBzh0IWpmP
	 nwDjDGNhkMqDNkK+GtUUS0ODdO8IhwwIYbs7zIGEU78Cq+vCLvr5I50O9+dm9xRNhy
	 s1vcZqpdtOP9poWeMhc/KKy7najXxo1cTBiCzRGqPeYIY7SCK8+jHh6hL/beB8Y989
	 ufbDFxWBjnOAj4waGSwuWbo2F93+N+HYYkmJyDOjKVNp/W507T6OuMJflP/ntvBDXR
	 dlSzNw/LPsk8Q==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 7/7] mm: use memcpy_streaming() in zone-device
 template copies
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: apopple@nvidia.com, akpm@linux-foundation.org, arnd@arndb.de, 
 bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, 
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org, kees@kernel.org, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260521040124.10608-8-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
 <20260521040124.10608-8-lizhe.67@bytedance.com>
Date: Sat, 23 May 2026 15:10:52 +0300
Message-Id: <177953825222.3959652.3741865801916579097.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 12:01:24 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 17a84d4cda01..08feb24795b8 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1075,13 +1075,15 @@ static void __ref zone_device_page_init_slow(struct page *page,
> [ ... skip 12 lines ... ]
>  	 */
> -	return !page_ref_tracepoint_active(page_ref_set) &&
> -		IS_ALIGNED(sizeof(struct page), sizeof(u64));
> +	return !IS_ENABLED(CONFIG_KASAN) && !IS_ENABLED(CONFIG_KMSAN) &&
> +	       !page_ref_tracepoint_active(page_ref_set) &&
> +	       IS_ALIGNED(sizeof(struct page), sizeof(u64));

Oh, can we rewrite it as a sequence of

	if (cond)
		return false;
	...

	return true;

I believe the compilers would generate the same code.

> @@ -1104,30 +1106,42 @@ static inline void zone_device_template_tail_page_init(struct page *template,
> [ ... skip 10 lines ... ]
> + * copying it into @page.
>   */
> -static inline void zone_device_page_init_finish(struct page *page,
> -							unsigned long pfn)
> +static inline void zone_device_page_update_template(struct page *template,
> +						    unsigned long pfn)

Two tabs for indentation here from the first patch this function
appears please.

Why do we need the intermediate step of _init_finish() if we later
change it to _update_template()?

> [ ... skip 30 lines ... ]
> +		memcpy(page, template, sizeof(*page));
> +	else
> +		memcpy_streaming(page, template, sizeof(*page));
>  
> -	for (i = 0; i < sizeof(struct page) / sizeof(u64); i++)
> -		dst[i] = src[i];

If you replace this with memcpy, what's the point for doing the loop in
intermediate patches?

-- 
Sincerely yours,
Mike.

