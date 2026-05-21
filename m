Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA0334C1C;
	Thu, 21 May 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376543; cv=none; b=tMQijI+fPt6G9NP1/ZVxyJMSI4rXq37Nhsqfbsb/DVJO+tEx5bgxE1SfAV/RKx5r11bDlIS/ahFxo/9QJgOCono9wJYHf60DFTXkWvuCNyf5axbmE2FxLRYPORgVU9iqhQoF012/v0NHPT/ldOFnCar0iSivwUq0MF+40LLQfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376543; c=relaxed/simple;
	bh=MNIY+H2hz8eNtjx2NQ8oK9Y7qZVnP9XLnCR/UB41CLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVYROMn3Qlwh3xISVRRJRuTdk6NTXLKvdHYHZ3Wfvua+mhe3IvucTLQ6T6bCUSzPUPsEWSGVa8/cnDtxz8v8G1NAyJBNiZEN8nOHponEOwid1S/K4V/rAbNALKyfiVqJ4T/Xy5cXHriZqmkVFSC+pofxeo884SQScoLHr/vh9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gemme+ZS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gemme+ZS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 357CD4A03;
	Thu, 21 May 2026 08:15:36 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B0C3F7B4;
	Thu, 21 May 2026 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779376541; bh=MNIY+H2hz8eNtjx2NQ8oK9Y7qZVnP9XLnCR/UB41CLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gemme+ZSaLhd4Tk3MSmYUDcqmIj6z1xhnlwkLRuTm5nUM/ZDUx6VkmyUfM7ZolbPj
	 NBeJX8Ebd5phpr1NQ0osyFWnterTKoFrCzWNmJdA8mz8Os+o04XMj5cGTydavR+U5T
	 cC0ECiFd/6DCP8krzcEyfkEC6BDi3F1/zDtxgHGA=
Date: Thu, 21 May 2026 16:15:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zeng Heng <zengheng@huaweicloud.com>
Cc: will@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
	aneesh.kumar@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Message-ID: <ag8hmZ3kjtJINyIT@arm.com>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <ag8fHYL-S26uO0yZ@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8fHYL-S26uO0yZ@arm.com>

On Thu, May 21, 2026 at 04:05:07PM +0100, Catalin Marinas wrote:
> + David H.
> 
> On Thu, May 21, 2026 at 03:30:11PM +0800, Zeng Heng wrote:
> > From: Zeng Heng <zengheng4@huawei.com>
> > 
> > When huge_pmd_unshare() is called to unshare a PMD table, the
> > tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
> > but the aarch64 tlb_flush() only checked tlb->freed_tables to
> > determine whether to use TLBF_NONE (vae1is, invalidates walk
> > cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
> > 
> > This caused the stale PMD page table entry to remain in the walk cache
> > after unshare, potentially leading to incorrect page table walks.
> > 
> > Fix by including unshared_tables in the check, so that when
> > unsharing tables, TLBF_NONE is used and the walk cache is properly
> > invalidated.
> > 
> > Here is the detailed distinction between vae1is and vale1is:
> > 
> > | Instruction Combination  | Actual Invalidation Scope                         |
> > | ------------------------ | --------------------------------------------------|
> > | `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
> > | `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
> > | `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
> > | `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |
> > 
> > Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> 
> The fix looks fine but does it need:
> 
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: <stable@vger.kernel.org>
> 
> > ---
> >  arch/arm64/include/asm/tlb.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index 10869d7731b8..751bd57bc3ba 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -53,7 +53,8 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
> >  static inline void tlb_flush(struct mmu_gather *tlb)
> >  {
> >  	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
> > -	tlbf_t flags = tlb->freed_tables ? TLBF_NONE : TLBF_NOWALKCACHE;
> > +	tlbf_t flags = (tlb->freed_tables || tlb->unshared_tables) ?
> > +			TLBF_NONE : TLBF_NOWALKCACHE;
> >  	unsigned long stride = tlb_get_unmap_size(tlb);
> >  	int tlb_level = tlb_get_level(tlb);

Do we need this as well?

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 10869d7731b8..3f4ab38cfd6e 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -24,7 +24,7 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline int tlb_get_level(struct mmu_gather *tlb)
 {
 	/* The TTL field is only valid for the leaf entry. */
-	if (tlb->freed_tables)
+	if (tlb->freed_tables || tlb->unshared_tables)
 		return TLBI_TTL_UNKNOWN;
 
 	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
