Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D438E13F;
	Fri, 22 May 2026 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446328; cv=none; b=osdQiFBb3Me96AR6roEpay94tYKDwKaY2oe+cNXEFeb3O9jMc0ydu3MN34ZTbAsMn4UAGYoQqygq2os1Ceojl85i74UE1Fra67yhoTPGap1L6bnsLe3/eGSaFqoGO+2dCksS8qfiGFOm0U7mkuvuwhHA3AX5IRequKG3qy/YG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446328; c=relaxed/simple;
	bh=RqkMYho4Yc7kOH0LueJfnc6XODgDoRr5RXGQOP2xdjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD3Pe2hqxppEiMf9ZwKKumRg8uX7KNkMYL4axK0vOmV6BsHVcHdLkb3OVYmUVOIXQA1uU3NyKqE7sd6P7wKOCAi/BAIxevyVaEkPHuDvciRGTHi5Ci05ilvoZwX3QP1+aDXPg1JeJ0Iil1tGcROBItL1gghCqKODMZH7CBmuPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UspOzoJC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UspOzoJC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97FF726BC;
	Fri, 22 May 2026 03:38:39 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A20B3F85F;
	Fri, 22 May 2026 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779446324; bh=RqkMYho4Yc7kOH0LueJfnc6XODgDoRr5RXGQOP2xdjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UspOzoJCY9ZHGdIe6Cyq0b0XfQrNkoc31Jtobq+h2ZXnoL67m4lM9te6G9lQ31fcE
	 C/jprDrxXZsnHPX1BAGqyqOsKbbv7G3ejV/aOZKPyAjHhx0fda5F+xWeyqlUHlKcV+
	 WX3LAGb/VFlU93zbcYID9+eyjTgopzgrgHu9OPMQ=
Date: Fri, 22 May 2026 11:38:40 +0100
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
Message-ID: <ahAyMO_6UcPc2q4U@arm.com>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <ag8fHYL-S26uO0yZ@arm.com>
 <ag8hmZ3kjtJINyIT@arm.com>
 <b7098272-a348-d918-774a-d5d2645fc7f4@huaweicloud.com>
 <ahAsPU00ZTTJV3Ye@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahAsPU00ZTTJV3Ye@arm.com>

On Fri, May 22, 2026 at 11:13:17AM +0100, Catalin Marinas wrote:
> On Fri, May 22, 2026 at 01:32:07PM +0800, Zeng Heng wrote:
> > On 2026/5/21 23:15, Catalin Marinas wrote:
> > > On Thu, May 21, 2026 at 04:05:07PM +0100, Catalin Marinas wrote:
> > > > On Thu, May 21, 2026 at 03:30:11PM +0800, Zeng Heng wrote:
> > > > > From: Zeng Heng <zengheng4@huawei.com>
> > > > > 
> > > > > When huge_pmd_unshare() is called to unshare a PMD table, the
> > > > > tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
> > > > > but the aarch64 tlb_flush() only checked tlb->freed_tables to
> > > > > determine whether to use TLBF_NONE (vae1is, invalidates walk
> > > > > cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
> > > > > 
> > > > > This caused the stale PMD page table entry to remain in the walk cache
> > > > > after unshare, potentially leading to incorrect page table walks.
> > > > > 
> > > > > Fix by including unshared_tables in the check, so that when
> > > > > unsharing tables, TLBF_NONE is used and the walk cache is properly
> > > > > invalidated.
> > > > > 
> > > > > Here is the detailed distinction between vae1is and vale1is:
> > > > > 
> > > > > | Instruction Combination  | Actual Invalidation Scope                         |
> > > > > | ------------------------ | --------------------------------------------------|
> > > > > | `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
> > > > > | `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
> > > > > | `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
> > > > > | `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |
[...]
> > Per the ARM Architecture Reference Manual, whether only the last-level
> > page table entry is invalidated is determined by the instruction used
> > (vale1is for leaf entry only, vae1is for walk cache including leaf entry and
> > non-leaf entry), rather than the TTL field. The TTL field merely specifies
> > which level the leaf entry belongs to.
> 
> Ah, yes, you are right. The TTL is still 2 in this case for a huge pmd,
> we just want the walk cache leading to it to be invalidated. So no need
> for the additional tlb_get_level().

The Arm ARM is still unclear. The RVAE1IS has this wording:

  The TTL hint is only guaranteed to invalidate:

  - Non-leaf-level entries in the range up to but not including the
    level described by the TTL hint.

  - Leaf-level entries in the range that match the level described by
    the TTL hint.

But we don't have such wording around non-leaf-level entries for VAE1IS.
I presume it would be the same but I'll ask internally next week. In the
meantime, I'll take this patch.

-- 
Catalin
