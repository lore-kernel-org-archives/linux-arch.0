Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67421CA03;
	Mon, 25 May 2026 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779672335; cv=none; b=UdQ23QMRxpYkNpguorL2BYFwlvIIac65mxmEXK/B+4sZAYyN0niOjIiXOC9AUlUJFAeRzicXl2sVRDDtkghF5MGbhkd5uj8syPP4rzr4VshPU67qv7MZ+e2Bzulh/SdpYfqePtQM8m8OXxbtblDXyq2vkLDvh1DhazhCDy18Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779672335; c=relaxed/simple;
	bh=8O17hZz+O0ZRTWEM/9z4CGUh7VKdx8gbE5TGxC+KSvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiL9x4UVx2Hm54TJWxQK6HWD5vJW21JvKy2ShF4dr5x/Ff5/DEa9vYISCdlV7GXZL4OA2b7B+GHcAlc08AdcZ5QXbIlhh5UTb3RHg9mgnyZZCMiBdwd6w+g2/OgGdRtW3wVulO2G9kRyBRMSGZrMEmmXdsxfGjRWRh8dgUzQp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gNypj3zFJzYQtFM;
	Mon, 25 May 2026 09:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A86CC4058F;
	Mon, 25 May 2026 09:25:21 +0800 (CST)
Received: from [10.174.179.37] (unknown [10.174.179.37])
	by APP4 (Coremail) with SMTP id gCh0CgCXX1v_pBNqhkwhDg--.58648S3;
	Mon, 25 May 2026 09:25:21 +0800 (CST)
Message-ID: <46b71e74-420e-bd4f-c407-87f3e812e44b@huaweicloud.com>
Date: Mon, 25 May 2026 09:25:19 +0800
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
Cc: yezhenyu2@huawei.com, zhurui3@huawei.com, will@kernel.org,
 akpm@linux-foundation.org, npiggin@gmail.com, aneesh.kumar@kernel.org,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, zengheng4@huawei.com
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <ag8fHYL-S26uO0yZ@arm.com> <ag8hmZ3kjtJINyIT@arm.com>
 <b7098272-a348-d918-774a-d5d2645fc7f4@huaweicloud.com>
 <ahAsPU00ZTTJV3Ye@arm.com> <ahAyMO_6UcPc2q4U@arm.com>
From: Zeng Heng <zengheng@huaweicloud.com>
In-Reply-To: <ahAyMO_6UcPc2q4U@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXX1v_pBNqhkwhDg--.58648S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw17Ww4rKF4kGr1DXFyfCrg_yoW5Ww4Dpr
	W3KF12yFWkXr1UJr1qqw4rXr1ak3yUJF48Wr1rCrySv3Z0vrn2qFyktr409Fyktr93Jr4U
	XFWjgFW7ZryjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2026/5/22 18:38, Catalin Marinas wrote:
> On Fri, May 22, 2026 at 11:13:17AM +0100, Catalin Marinas wrote:
>> On Fri, May 22, 2026 at 01:32:07PM +0800, Zeng Heng wrote:
>>> On 2026/5/21 23:15, Catalin Marinas wrote:
>>>> On Thu, May 21, 2026 at 04:05:07PM +0100, Catalin Marinas wrote:
>>>>> On Thu, May 21, 2026 at 03:30:11PM +0800, Zeng Heng wrote:
>>>>>> From: Zeng Heng <zengheng4@huawei.com>
>>>>>>
>>>>>> When huge_pmd_unshare() is called to unshare a PMD table, the
>>>>>> tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
>>>>>> but the aarch64 tlb_flush() only checked tlb->freed_tables to
>>>>>> determine whether to use TLBF_NONE (vae1is, invalidates walk
>>>>>> cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
>>>>>>
>>>>>> This caused the stale PMD page table entry to remain in the walk cache
>>>>>> after unshare, potentially leading to incorrect page table walks.
>>>>>>
>>>>>> Fix by including unshared_tables in the check, so that when
>>>>>> unsharing tables, TLBF_NONE is used and the walk cache is properly
>>>>>> invalidated.
>>>>>>
>>>>>> Here is the detailed distinction between vae1is and vale1is:
>>>>>>
>>>>>> | Instruction Combination  | Actual Invalidation Scope                         |
>>>>>> | ------------------------ | --------------------------------------------------|
>>>>>> | `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
>>>>>> | `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
>>>>>> | `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
>>>>>> | `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |

To clarify, the above was confirmed internally with the Kunpeng team.

>>> Per the ARM Architecture Reference Manual, whether only the last-level
>>> page table entry is invalidated is determined by the instruction used
>>> (vale1is for leaf entry only, vae1is for walk cache including leaf entry and
>>> non-leaf entry), rather than the TTL field. The TTL field merely specifies
>>> which level the leaf entry belongs to.
>>
>> Ah, yes, you are right. The TTL is still 2 in this case for a huge pmd,
>> we just want the walk cache leading to it to be invalidated. So no need
>> for the additional tlb_get_level().
> 
> The Arm ARM is still unclear. The RVAE1IS has this wording:
> 
>    The TTL hint is only guaranteed to invalidate:
> 
>    - Non-leaf-level entries in the range up to but not including the
>      level described by the TTL hint.
> 
>    - Leaf-level entries in the range that match the level described by
>      the TTL hint.
> 
> But we don't have such wording around non-leaf-level entries for VAE1IS.
> I presume it would be the same but I'll ask internally next week. In the
> meantime, I'll take this patch.
> 

Got it. I agree the official ARM documentation doesn’t fully explain
this clearly.

Thanks for the additional confirmation.

Best regards,
Zeng Heng

