Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3622E3E9;
	Fri, 22 May 2026 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425058; cv=none; b=ktjAtPNKwRjoClzEjlT0+g3q09AUotfXn4y8HjXhy3E4TfP3npv6gUabDUwFY5JBt9vUSrFsVV00vibXcgZKq6O4IZI8ta+sXedZ8uJPn8mqbH2kIvfSfkZ3BJEqUnEp0cmECFHWp0Rx2o3a3mhnpSSunC2/yhq8b1ZDxOK0UJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425058; c=relaxed/simple;
	bh=0ovAUcf7zJNIrxrkW2ongDkxP6HPqqvxrgSIWshfckQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFm4eRtdSAXIwd+Jp+Y4Wk+jmnq88Bk1atHqmHTaw3i+s4bHPSj12T+0MPL9wHs6neYhoLcZkrermTJS3adP6FXt2Idvc3gbAw+gaHURdomiBabTxwQsApPdnXRx03iGyKk28Hp5A9I4lyg2q927JAwjnKjWXOaDH8SxuV1im8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gMCMR61M9zYQtl8;
	Fri, 22 May 2026 12:43:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14DA74056B;
	Fri, 22 May 2026 12:44:03 +0800 (CST)
Received: from [10.174.179.37] (unknown [10.174.179.37])
	by APP4 (Coremail) with SMTP id gCh0CgBnL1sL3w9qXpfDDA--.53130S3;
	Fri, 22 May 2026 12:43:57 +0800 (CST)
Message-ID: <d78ebf12-075c-5abd-d83e-f66f0f45e92e@huaweicloud.com>
Date: Fri, 22 May 2026 12:43:55 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
 aneesh.kumar@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 David Hildenbrand <david@kernel.org>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <ag8fHYL-S26uO0yZ@arm.com>
From: Zeng Heng <zengheng@huaweicloud.com>
In-Reply-To: <ag8fHYL-S26uO0yZ@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnL1sL3w9qXpfDDA--.53130S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWkGw4UCr45Cr43Cr4Uurg_yoW5Jr4Upa
	43CF13KFZ5Wr1UtF1vqr4UXFy3Can8Jr9ruryrZasYvF12yF1vgFWvyryruFy0yFZ5tr4f
	WF1j9FnrZF4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: p2hqwxhhqjqx5xdzvxpfor3voofrz/

Hi Catalin,

On 2026/5/21 23:05, Catalin Marinas wrote:
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
> The fix looks fine but does it need:
>
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: <stable@vger.kernel.org>

It makes sense to me. Thanks a lot for that.


Best regards,
Zeng Heng

>> ---
>>   arch/arm64/include/asm/tlb.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index 10869d7731b8..751bd57bc3ba 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -53,7 +53,8 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>   {
>>   	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
>> -	tlbf_t flags = tlb->freed_tables ? TLBF_NONE : TLBF_NOWALKCACHE;
>> +	tlbf_t flags = (tlb->freed_tables || tlb->unshared_tables) ?
>> +			TLBF_NONE : TLBF_NOWALKCACHE;
>>   	unsigned long stride = tlb_get_unmap_size(tlb);
>>   	int tlb_level = tlb_get_level(tlb);
>>   
>> -- 
>> 2.43.0

