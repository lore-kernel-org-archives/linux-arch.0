Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E9175A70;
	Sat, 25 Apr 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108484; cv=none; b=Umg/4gRWjuLvqtVvRHe9yn5r/Vcdc0mTezOY+Q615IyGjT7rGnBBTgMt30fD3o6dmIrbAd409Ch5wCL8kyIRXR4tVuzZyIdjKl4aPatqomVzgjWdpi8H3DW58/gaEvYtdK2ywW/KlHUCliEdFNMMCH4oieRYLr9ZvUFUZwKhfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108484; c=relaxed/simple;
	bh=ndwM1adU0Ywc49Htd35zTWEkTDTVzUK6JgCrM5wCvp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCLvDqtfVcZyIXo/21sL34C0WK2/cQMwVRvfuPVUd6GHjiiyMLljMTxTf2tiSKOT8TsxafEHXj+k1Gx5+Rbp0YwrfXOQbVPdi85eLFo/fYnY84wKagvBzt715SP4WCXBlY8AR7yFxrdMwxp+g43vQU2+Qa46DOQX4TX8Ru6iGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hs/REWCj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hs/REWCj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ECCE1762;
	Sat, 25 Apr 2026 02:14:35 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441373F62B;
	Sat, 25 Apr 2026 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777108480; bh=ndwM1adU0Ywc49Htd35zTWEkTDTVzUK6JgCrM5wCvp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hs/REWCj1nJJbdFLaDzl5x3SlkAUdGEOeK2cS1VirrpLk0LadSf0nMMFYkELitCEb
	 2cF/0fQYvMLiHmbRZwhac5JlGZi8yxE7lcFtAnbolD9wmjiSTUVPWoN8g0hFcOMXjP
	 o5xr1kzh6WR2heWeC6UU0QJrGjqiD3QydgEZKLcM=
Date: Sat, 25 Apr 2026 10:14:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: arnd@arndb.de, kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, david@kernel.org, urezki@gmail.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, tglx@kernel.org,
	usama.anjum@arm.com, mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3 1/3] vmalloc: add __GFP_SKIP_KASAN support
Message-ID: <aeyF-pEruWRMk5bS@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
 <20260424130157.3163009-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424130157.3163009-2-dev.jain@arm.com>

On Fri, Apr 24, 2026 at 06:31:55PM +0530, Dev Jain wrote:
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b31b208f6ecb3..c94fcb2725b6b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3939,7 +3939,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				__GFP_NOFAIL | __GFP_ZERO |\
>  				__GFP_NORETRY | __GFP_RETRY_MAYFAIL |\
>  				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
> -				GFP_USER | __GFP_NOLOCKDEP)
> +				GFP_USER | __GFP_NOLOCKDEP | __GFP_SKIP_KASAN)
>  
>  static gfp_t vmalloc_fix_flags(gfp_t flags)
>  {
> @@ -3980,6 +3980,9 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
>   *
>   * %__GFP_NOWARN can be used to suppress failure messages.
>   *
> + * %__GFP_SKIP_KASAN can be used to skip unpoisoning of mapped pages
> + * (when prot=%PAGE_KERNEL).

I just realised, if we go with this flag for vmalloc(), there's also a
comment in gfp_types.h implying that pages are unpoisoned by
kasan_unpoison_vmalloc() instead. This is no longer the case with this
patch.

A VM_SKIP_KASAN flag may have been nicer but we already have
THREADINFO_GFP and GFP_VMAP_STACK, so all those call sites would have to
be moved to call the lower-level __vmalloc_node_range().

-- 
Catalin
