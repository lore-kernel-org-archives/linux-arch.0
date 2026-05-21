Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3892DE702;
	Thu, 21 May 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375907; cv=none; b=XSjBUmajesCuTerNp5Ivmjg+aMDZnrHbPjjLAzoVjHxRdi5OqCbkckwEfGPeVs8peL1Xiaabv0rMUQLt0jxhfjwit0qXMk36LfEQnK/Ochdvy1RfVvZjTNFO4uhPFXlxsX76VoHrcqub6tU42VdBtqab+Yz9QFqjdtkmqgyptO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375907; c=relaxed/simple;
	bh=Q7O9TQ82OHo1p5kXqghd2ovKAQGxVssYtzqC81EqQEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI/X4efZOV+wqrClnJw60GfVh2+WrX3eWFlRFMZT09m4hrmDgpY7bFSWQ73ssMT0EGoS/djeQbFjWGuePypiQ1EDgHMHmhbeBUukon7OOTjYMjBpA5+fWVEnK/gdu9kjXlCVCJJOj1D8NzlCQYE31aZRxjSWO3Z8E9sAgjaz6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KFzIoCPE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KFzIoCPE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458243AEC;
	Thu, 21 May 2026 08:05:00 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC6C3F7B4;
	Thu, 21 May 2026 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779375905; bh=Q7O9TQ82OHo1p5kXqghd2ovKAQGxVssYtzqC81EqQEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFzIoCPEPcx3cVuWH0SZMeEuo77BiH520eb+dYLqeaDbD/oRUXkOuPqannRIsIY2W
	 PwaKHVrvBNC0I6regX8avJTj5BiGd1Aj6A7NJVA8/UCd9HTnM2lzMd5teeqs1Cvl3Y
	 Nf0BUfFMD37qrdrXDow+8UloD884B3iKyoK9quVk=
Date: Thu, 21 May 2026 16:05:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zeng Heng <zengheng@huaweicloud.com>
Cc: will@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
	aneesh.kumar@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Message-ID: <ag8fHYL-S26uO0yZ@arm.com>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521073011.4121277-1-zengheng@huaweicloud.com>

+ David H.

On Thu, May 21, 2026 at 03:30:11PM +0800, Zeng Heng wrote:
> From: Zeng Heng <zengheng4@huawei.com>
> 
> When huge_pmd_unshare() is called to unshare a PMD table, the
> tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
> but the aarch64 tlb_flush() only checked tlb->freed_tables to
> determine whether to use TLBF_NONE (vae1is, invalidates walk
> cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
> 
> This caused the stale PMD page table entry to remain in the walk cache
> after unshare, potentially leading to incorrect page table walks.
> 
> Fix by including unshared_tables in the check, so that when
> unsharing tables, TLBF_NONE is used and the walk cache is properly
> invalidated.
> 
> Here is the detailed distinction between vae1is and vale1is:
> 
> | Instruction Combination  | Actual Invalidation Scope                         |
> | ------------------------ | --------------------------------------------------|
> | `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
> | `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
> | `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
> | `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

The fix looks fine but does it need:

Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: <stable@vger.kernel.org>

> ---
>  arch/arm64/include/asm/tlb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 10869d7731b8..751bd57bc3ba 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -53,7 +53,8 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
> -	tlbf_t flags = tlb->freed_tables ? TLBF_NONE : TLBF_NOWALKCACHE;
> +	tlbf_t flags = (tlb->freed_tables || tlb->unshared_tables) ?
> +			TLBF_NONE : TLBF_NOWALKCACHE;
>  	unsigned long stride = tlb_get_unmap_size(tlb);
>  	int tlb_level = tlb_get_level(tlb);
>  
> -- 
> 2.43.0

-- 
Catalin
