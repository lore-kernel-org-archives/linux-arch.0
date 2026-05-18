Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD73C6A39;
	Mon, 18 May 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085951; cv=none; b=DbVO4noaikJ/tv12SDNGjMPE0q8mCpwQNuqtQ8hH4WBbEs4QQct9jeInd1IPzcdyVpXeDu90GVPiIstccPT1kDtnGUs10zZTVMd8n80tctqobP5Njwmfpy48XzFhlf1Z4W+XQTmhBP6uWFP8t7wzYE6qkbClhglHGa8juDx2aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085951; c=relaxed/simple;
	bh=rUV2HjQXZO7sfqTTk9IjtWhQHj2MdFmFFqNhZEMa2h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCFha0L148WR6Ef1THI3+AXhFJTAJ3us6CO1wa0r7HyzzDUcKljfZMCMJzqXaquBHlZn6qEDyjtzsYXPHDyX2EMhlHyCbE3FyifNVnUDdiomq2HXEmpK0tLysn72c6BRaPefJQhWvu2t34UySasXcjjthCQRqObrqTwzmPtYaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og+6qPd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og+6qPd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7030C2BCB7;
	Mon, 18 May 2026 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779085950;
	bh=rUV2HjQXZO7sfqTTk9IjtWhQHj2MdFmFFqNhZEMa2h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Og+6qPd670cvWeHTzLyJZvKdtvjnhP1wBWakivhOrQry8c9Ks62iyoyAAXHqwUjzn
	 4EFb7DXdv5GeOX5oQ4L0GoivdXT9BFOHh8KgITS4KT7APm3v90cdQappGioXkw4kAf
	 2Z0HIBnjr9VXzA8h0prMHg39OnMSV9oatLPyJqdSLRkTw+mC4QOhSxyrrOHZY8A6yx
	 CTQRFaZb/GL8VCzbbehWccEcuhFjnxhSQgxQZZm8m0geP/BeL0YM2B9GjPQcQCpNZT
	 5rJoEjU1GKJfh4VlfDUkv/36pnHk/XF65ODt2ASBeLhv0ZIP2evK+Dz6UNysYtb1JK
	 C4asp49Fg7k2w==
Date: Mon, 18 May 2026 09:32:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, arnd@arndb.de,
	akpm@linux-foundation.org, david@kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: factor zone-device page init helpers out of
 __init_zone_device_page
Message-ID: <agqyd5Kncrx5B_ex@kernel.org>
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
 <20260515082045.63029-2-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515082045.63029-2-lizhe.67@bytedance.com>

Hi,

On Fri, May 15, 2026 at 04:20:42PM +0800, Li Zhe wrote:
> __init_zone_device_page() currently mixes three different jobs: deciding
> the initial page refcount, initializing the generic ZONE_DEVICE state, and
> setting up pageblock metadata.
> 
> Split the refcount policy into zone_device_page_init_refcount() and move
> the generic page initialization into generic_init_zone_device_page(). This
> keeps the slow path behavior unchanged, but makes the individual pieces
> reusable by later fast-path patches.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  mm/mm_init.c | 62 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..5244acb96dbb 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -987,11 +987,36 @@ static void __init memmap_init(void)
>  }
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> -					  unsigned long zone_idx, int nid,
> -					  struct dev_pagemap *pgmap)

Since you are already changing __init_zone_device_page(), I'd suggest
renaming it to zone_device_page_init().

> +static inline int zone_device_page_init_refcount(
> +		const struct dev_pagemap *pgmap)
>  {
> +	/*
> +	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> +	 * directly to the driver page allocator which will set the page count
> +	 * to 1 when allocating the page.
> +	 *
> +	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
> +	 * their refcount reset to one whenever they are freed (ie. after
> +	 * their refcount drops to 0).
> +	 */
> +	switch (pgmap->type) {
> +	case MEMORY_DEVICE_FS_DAX:
> +	case MEMORY_DEVICE_PRIVATE:
> +	case MEMORY_DEVICE_COHERENT:
> +	case MEMORY_DEVICE_PCI_P2PDMA:
> +		return 0;
> +	case MEMORY_DEVICE_GENERIC:
> +		return 1;
> +	default:
> +		WARN_ONCE(1, "Unknown memory type!");
> +		return 1;
> +	}
> +}
>  
> +static void __ref generic_init_zone_device_page(struct page *page,
> +		unsigned long pfn, unsigned long zone_idx, int nid,
> +		struct dev_pagemap *pgmap)
> +{

Here also would be better to use zone_device_page_ prefix. 
And I don't think "generic" adds clarity about what this function is doing.

Seeing that later patches rename it again to _slow variant, I'd suggest to
call it __zone_device_page_init() at keep this name going forward.

>  	__init_single_page(page, pfn, zone_idx, nid);
>  
>  	/*

-- 
Sincerely yours,
Mike.
