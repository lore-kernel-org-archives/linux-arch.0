Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18053C81A3;
	Fri, 22 May 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444806; cv=none; b=l9jGFKOZ6y3u9XdyllLruL8rhEUcaezwVnxi6dQtchvk/hI5VsQtFH9X0ZrZgbHaLOQkAMO936BOYXwJ5ZMcF3LzSsIAMgSJyal0BrsCqHx9eN/AflAI6UhggXRG6mnIz67ORKj2FDRGNaHYnnyKqHqzdSrQl8CaO8f2sJUxEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444806; c=relaxed/simple;
	bh=DNbpyntwF+hMLXGYG7QS6XgYK9N3tC6rW9pSIUZL2UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOLGhZOeHvSqpVTAShDdv6Hq0Uk//mKPy3/Infwj5tkiaJW/9uNH7YARJYrSYioGvLmUmrtBiJ/pCcL2MzPh05e+HfdT2JD9Wais8ylP4OdAdoVYtQlWcmJj9IaT18rI+bOyFW3zAY/8Qnq5cGPfBa/L3Aj6wK4Ext8dy3mfpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WnPzawxV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WnPzawxV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0471C0A;
	Fri, 22 May 2026 03:13:18 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653EE3F85F;
	Fri, 22 May 2026 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779444803; bh=DNbpyntwF+hMLXGYG7QS6XgYK9N3tC6rW9pSIUZL2UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnPzawxVOZEsilVN+FrmjqG+d5EGMvtws0WvCEFdP0vTh8WmzqaQCT20F6/XSKi4Y
	 M4M+vtYWNuQY8ZNHie4OyF0sEuGltPkBQhiJ7hC+28iuovNettd25yWTfGENWI6CMX
	 oC5xoSsmgStsFj6eIQ7W50kH7UNJLX8uN3r3m4GE=
Date: Fri, 22 May 2026 11:13:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zeng Heng <zengheng@huaweicloud.com>
Cc: yezhenyu2@huawei.com, zhurui3@huawei.com, will@kernel.org,
	akpm@linux-foundation.org, npiggin@gmail.com,
	aneesh.kumar@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, David Hildenbrand <david@kernel.org>,
	zengheng4@huawei.com
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Message-ID: <ahAsPU00ZTTJV3Ye@arm.com>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <ag8fHYL-S26uO0yZ@arm.com>
 <ag8hmZ3kjtJINyIT@arm.com>
 <b7098272-a348-d918-774a-d5d2645fc7f4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7098272-a348-d918-774a-d5d2645fc7f4@huaweicloud.com>

On Fri, May 22, 2026 at 01:32:07PM +0800, Zeng Heng wrote:
> On 2026/5/21 23:15, Catalin Marinas wrote:
> > On Thu, May 21, 2026 at 04:05:07PM +0100, Catalin Marinas wrote:
> > > On Thu, May 21, 2026 at 03:30:11PM +0800, Zeng Heng wrote:
> > > > From: Zeng Heng <zengheng4@huawei.com>
> > > > 
> > > > When huge_pmd_unshare() is called to unshare a PMD table, the
> > > > tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
> > > > but the aarch64 tlb_flush() only checked tlb->freed_tables to
> > > > determine whether to use TLBF_NONE (vae1is, invalidates walk
> > > > cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
> > > > 
> > > > This caused the stale PMD page table entry to remain in the walk cache
> > > > after unshare, potentially leading to incorrect page table walks.
> > > > 
> > > > Fix by including unshared_tables in the check, so that when
> > > > unsharing tables, TLBF_NONE is used and the walk cache is properly
> > > > invalidated.
> > > > 
> > > > Here is the detailed distinction between vae1is and vale1is:
> > > > 
> > > > | Instruction Combination  | Actual Invalidation Scope                         |
> > > > | ------------------------ | --------------------------------------------------|
> > > > | `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
> > > > | `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
> > > > | `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
> > > > | `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |
> > > > 
> > > > Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> > > The fix looks fine but does it need:
> > > 
> > > Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> > > Cc: <stable@vger.kernel.org>
> > > 
> > > > ---
> > > >   arch/arm64/include/asm/tlb.h | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > > > index 10869d7731b8..751bd57bc3ba 100644
> > > > --- a/arch/arm64/include/asm/tlb.h
> > > > +++ b/arch/arm64/include/asm/tlb.h
> > > > @@ -53,7 +53,8 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
> > > >   static inline void tlb_flush(struct mmu_gather *tlb)
> > > >   {
> > > >   	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
> > > > -	tlbf_t flags = tlb->freed_tables ? TLBF_NONE : TLBF_NOWALKCACHE;
> > > > +	tlbf_t flags = (tlb->freed_tables || tlb->unshared_tables) ?
> > > > +			TLBF_NONE : TLBF_NOWALKCACHE;
> > > >   	unsigned long stride = tlb_get_unmap_size(tlb);
> > > >   	int tlb_level = tlb_get_level(tlb);
> > Do we need this as well?
> 
> The proposed fix has been validated against the issue scenarios and
> works as expected.
> 
> Per the ARM Architecture Reference Manual, whether only the last-level
> page table entry is invalidated is determined by the instruction used
> (vale1is for leaf entry only, vae1is for walk cache including leaf entry and
> non-leaf entry), rather than the TTL field. The TTL field merely specifies
> which level the leaf entry belongs to.

Ah, yes, you are right. The TTL is still 2 in this case for a huge pmd,
we just want the walk cache leading to it to be invalidated. So no need
for the additional tlb_get_level().

Thanks.

-- 
Catalin
