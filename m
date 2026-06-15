Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA429AB05;
	Mon, 15 Jun 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550037; cv=none; b=nPh82sKdLNImrItio8RvOK/BxBlR6Zl62NChvTRgcqs8JLFueK8Sa9esaSRtpdcf7YNFKzmA2kU6VPSX1C+lSG33j427e4qOWDH6PfNPN95Zl2vhpaxW5d3XlKvJkvLZd8FAvjkYE+bFdL1gqD/ylnbD7ISMbxPAEV8TfyjAoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550037; c=relaxed/simple;
	bh=XoeP39y7tlhVOdV2lYvrbccnHrguMbKcrucP1jFdqsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llW9AYqWw3itDfIvbumMHcIoec3wqnhNpw37n7rjW1utJZJKZ1ygqkI1qKJaJaSayw+HMtfw1+q9XmbbPKU0d9Lg7+HZsiOuDZSE6FwlNTdvvXK3u7E2REohs4Ebp1qzegYCFi1gWzfxnD716QfcLymaRdoqfNKY/WL5mEXEebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QapKVi9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QapKVi9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A981F000E9;
	Mon, 15 Jun 2026 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781550036;
	bh=L5632MlVaxdfn63LCzQJ702LNCM3id8ay4/ZLRAvTMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QapKVi9FS/U9MMnxdfB4NrulrCNWaHoYMUi2Qtzhjj5MAR+vxHftirQfxam77fUFO
	 F6cMDyFa02pPVGhJYBe+2cagBbkhOf9w+J9pv0hPbs0gQ9SpFR7SQPRGQannBB11tc
	 W7nlL1fyLgK02nguk3OnG7sADs4pIFVDWeN5ujHpYxiNOM2Ogbb0LgrNNUYRHCivD4
	 FtuzaKVLt1R/8T4CxR4JbLUOWYm2Bs4hSxIlQK414Ht6fwPICORRLO3KVC+hzSLM9k
	 +TYtbV2yz5uEZ6kX40zncXUU0HEd2luDfj9O2qlpBRd083QBG6nRGogyD8mEVXmQ3h
	 jeeIrcyzQHCcQ==
Message-ID: <171b31d1-4168-4dd9-92e8-4e032388937d@kernel.org>
Date: Mon, 15 Jun 2026 21:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
To: Catalin Marinas <catalin.marinas@arm.com>,
 Zeng Heng <zengheng@huaweicloud.com>
Cc: will@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
 aneesh.kumar@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <ag8fHYL-S26uO0yZ@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ag8fHYL-S26uO0yZ@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 17:05, Catalin Marinas wrote:
> + David H.
> 
> On Thu, May 21, 2026 at 03:30:11PM +0800, Zeng Heng wrote:
>> From: Zeng Heng <zengheng4@huawei.com>
>>
>> When huge_pmd_unshare() is called to unshare a PMD table, the
>> tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
>> but the aarch64 tlb_flush() only checked tlb->freed_tables to
>> determine whether to use TLBF_NONE (vae1is, invalidates walk
>> cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
>>
>> This caused the stale PMD page table entry to remain in the walk cache
>> after unshare, potentially leading to incorrect page table walks.
>>
>> Fix by including unshared_tables in the check, so that when
>> unsharing tables, TLBF_NONE is used and the walk cache is properly
>> invalidated.
>>
>> Here is the detailed distinction between vae1is and vale1is:
>>
>> | Instruction Combination  | Actual Invalidation Scope                         |
>> | ------------------------ | --------------------------------------------------|
>> | `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
>> | `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
>> | `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
>> | `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |
>>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> 
> The fix looks fine but does it need:

I'm late ... just stumbled over this in my inbox while digging though a pile.

> 
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: <stable@vger.kernel.org>

Very likely, yes.

> 
>> ---
>>  arch/arm64/include/asm/tlb.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index 10869d7731b8..751bd57bc3ba 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -53,7 +53,8 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
>>  static inline void tlb_flush(struct mmu_gather *tlb)
>>  {
>>  	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
>> -	tlbf_t flags = tlb->freed_tables ? TLBF_NONE : TLBF_NOWALKCACHE;
>> +	tlbf_t flags = (tlb->freed_tables || tlb->unshared_tables) ?
>> +			TLBF_NONE : TLBF_NOWALKCACHE;
>>  	unsigned long stride = tlb_get_unmap_size(tlb);
>>  	int tlb_level = tlb_get_level(tlb);
>>  

Right, the old code would have effectively called flush_tlb_range() ->
flush_tlb_mm_range() with freed_tables=true.

I recall that being a tricky bit. The commit documents that as:

    (1) tlb_remove_table_sync_one() is a NOP on architectures without
        CONFIG_MMU_GATHER_RCU_TABLE_FREE.

        Here, the assumption is that the previous TLB flush would send an
        IPI to all relevant CPUs. Careful: some architectures like x86 only
        send IPIs to all relevant CPUs when tlb->freed_tables is set.

        The relevant architectures should be selecting
        MMU_GATHER_RCU_TABLE_FREE, but x86 might not do that in stable
        kernels and it might have been problematic before this patch.

        Also, the arch flushing behavior (independent of IPIs) is different
        when tlb->freed_tables is set. Do we have to enlighten them to also
        take care of tlb->unshared_tables? So far we didn't care, so
        hopefully we are fine. Of course, we could be setting
        tlb->freed_tables as well, but that might then unnecessarily flush
        too much, because the semantics of tlb->freed_tables are a bit
        fuzzy.


Turns out I was thinking too much in terms of optimizing IPIs.

Besides arm64 and x86, powerpc and riscv also rely on "tlb->freed_tables"
in tlb_flush(). But only arm64, x86 and riscv support ARCH_WANT_HUGE_PMD_SHARE.

Which makes me wonder whether we also need:


diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 50b63b5c15bd..17c551322b5d 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -16,7 +16,8 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_MMU
-       if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
+       if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables ||
+           tlb->unshared_tables)
                flush_tlb_mm(tlb->mm);
        else
                flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,

CCing riscv maintainers.

-- 
Cheers,

David
