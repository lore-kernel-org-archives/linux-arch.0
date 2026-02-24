Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA412207A20
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898984; cv=none; b=haKDe955mlA/DQlSf26Jj5jyF3jrWd8mkn/zBsSZIXI89LtrhfhtAaqIkMoPH4G0rF8TfTL2phhS79cACMO9xN+2esIKSVnmlDnmUk1ZOUl628SPj5Ock8CBq9ov9lRLeuFxBBLN0Pz0/SG02ojK+5jAWMoQ9mlEY20V4/JDMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898984; c=relaxed/simple;
	bh=f/qGJtwL6q7IM52E3wmiBMD2ZuskxAjnIsT38xAk5ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SW8RVimoy7SoXzdgaf7MRmkXpXIgy2l5qqBRFgPCYJssrgypM9ln+C1NImEiWsPgfqWuoXFyyBW/rds/9sn1jRNegFTN+TRYi/sWKqW18gbcwjnwZDYS+ZlHCXnWWVZmIxmRWwpmVqu8G5X6Jq1W0kkQFdjWExWfJFmLIVKuep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1AsSxEi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1AsSxEi"
Message-ID: <f44fac08-771f-4619-b8a4-6ea740df424f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771898979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsOHJFJbnSTxPZLSbT4LkMBTkNe2O/zQhx5vUKRpKF4=;
	b=r1AsSxEiipWjSEiJDqxsxjbymAD2ieCd5isZWeDQIQEJ4s/D5zIfTHoZQQ18x5YpcHtvJy
	weiniOLhq/1vfl2Tn4Y+zxwjjyGgn0YOreYsPY0MNVI6sw9FE8BrBg4ReKO8tTXUzhmgE2
	vi3pC+gTkxw7dIgPN6pMx8ODLDFtgUc=
Date: Tue, 24 Feb 2026 10:09:18 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmu_gather: define RCU version tlb_remove_table_one()
 in CONFIG_MMU_GATHER_RCU_TABLE_FREE
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 "David Hildenbrand (Arm)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, peterz@infradead.org, npiggin@gmail.com
References: <20260222004512.839-1-richard.weiyang@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260222004512.839-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Wei,

On 2/22/26 8:45 AM, Wei Yang wrote:
> Before commit 718b13861d22 ("x86: mm: free page table pages by RCU
> instead of semi RCU"), the page table pages will be freed by semi RCU,
> that is:
> 
>    - batch table freeing: asynchronous free by RCU
>    - single table freeing: IPI + synchronous free
> 
> This commit introduce a RCU version for single table freeing to support
> PT_RECLAIM. While it is not necessary to limit the RCU version only in
> CONFIG_PT_RECLAIM. It is reasonable to asynchronous free single table by
> RCU if CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> 
> This patch moves the definition of single table freeing in
> CONFIG_MMU_GATHER_RCU_TABLE_FREE, so we have both RCU version
> batch/single table freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE.

Thank you for doing this, but we can't do it right now.

See the latest version: 
https://github.com/torvalds/linux/commit/9c8c02df3f8742f6db927e787ab971fd0b5ac08a, 
when the
HAVE_ARCH_TLB_REMOVE_TABLE is selected, the pt_rcu_head member
cannot be used.

Thanks,
Qi

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Qi Zheng <qi.zheng@linux.dev>
> Cc: "David Hildenbrand (Arm)" <david@kernel.org>
> ---
>   mm/mmu_gather.c | 51 +++++++++++++++++++++----------------------------
>   1 file changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index fe5b6a031717..6c1cbd9c717b 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -296,6 +296,22 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   	call_rcu(&batch->rcu, tlb_remove_table_rcu);
>   }
>   
> +static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
> +{
> +	struct ptdesc *ptdesc;
> +
> +	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
> +	__tlb_remove_table(ptdesc);
> +}
> +
> +static inline void tlb_remove_table_one(void *table)
> +{
> +	struct ptdesc *ptdesc;
> +
> +	ptdesc = table;
> +	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
> +}
> +
>   #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>   
>   static void tlb_remove_table_free(struct mmu_table_batch *batch)
> @@ -303,6 +319,12 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   	__tlb_remove_table_free(batch);
>   }
>   
> +static inline void tlb_remove_table_one(void *table)
> +{
> +	tlb_remove_table_sync_one();
> +	__tlb_remove_table(table);
> +}
> +
>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>   
>   /*
> @@ -320,35 +342,6 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
>   	}
>   }
>   
> -#ifdef CONFIG_PT_RECLAIM
> -static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
> -{
> -	struct ptdesc *ptdesc;
> -
> -	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
> -	__tlb_remove_table(ptdesc);
> -}
> -
> -static inline void __tlb_remove_table_one(void *table)
> -{
> -	struct ptdesc *ptdesc;
> -
> -	ptdesc = table;
> -	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
> -}
> -#else
> -static inline void __tlb_remove_table_one(void *table)
> -{
> -	tlb_remove_table_sync_one();
> -	__tlb_remove_table(table);
> -}
> -#endif /* CONFIG_PT_RECLAIM */
> -
> -static void tlb_remove_table_one(void *table)
> -{
> -	__tlb_remove_table_one(table);
> -}
> -
>   static void tlb_table_flush(struct mmu_gather *tlb)
>   {
>   	struct mmu_table_batch **batch = &tlb->batch;

