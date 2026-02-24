Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73229B233;
	Tue, 24 Feb 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933323; cv=none; b=INCHTLSstXlcpv+wJM2c1YABj8MJ8OyhAT93A3Eyp8822GX7Y/bwsmNOqpqtmzdIFX4PxScunYK4xTL4wrzBpowsSBy8qRoQctKFSqc1KS6BZxgLElEP/1TRZf79kO6bBdWTM2H5gL5U7m/gk+pg069N6BeSzckKkW0m3D6ijIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933323; c=relaxed/simple;
	bh=DJrNCsRYhrSomX7haIp09xmCM5t4B9O1lk0YRoVwT+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGZTxtLMos2RmShdrtqoOuJzIDXRStUPUchCYBl1UHWHd2XOc+N7C4RLxdzGvoxlGCKGTatrLRYDV+Sy6J0Pjw2iepBWEl8H3fNvFbyFYazyve311tpPrrjIFDiWxKDyHo0FI+lPKvzGFGej7AK4kZ2dL5ce4sC3lBhbkQYrCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JdOZ20r4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JdOZ20r4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qTft1lZXxmebOkNzKC0YEuK2LVQvuuq00qby+pSHF1Q=; b=JdOZ20r4MlSjK7rMTiMJ2OxC+7
	L2QAHh/fh5IduAwQCQBSIHDC4lkRFmoJtRPLftyP7wBq8snDn8UwnlNuKsagN+6NMw/G1GbmIRh76
	heIKGuT8XwFLv9n/nkI0nyt+dThDtZ5QAl8dsAsyKmjNV7sJub48t1ABxAx15PvgGNb6XfROkaAOk
	n7g4vh2ej0iMT1alyh4Ilo4rsdVo97S6+AdJt718qtB7Uiv6ZGeLwLN58Cq1tCkZiIpot84xL9cjh
	XubLC1xIzTucthiO94ACfjipcj5A16oT9qO+GiiPqARxSzJNhDTWkixK9HTOKTG9FdtWg9e0+V1Hz
	xu33W8Dg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuqnZ-000000071Hd-2rZQ;
	Tue, 24 Feb 2026 11:41:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3DEC9300BDE; Tue, 24 Feb 2026 12:41:52 +0100 (CET)
Date: Tue, 24 Feb 2026 12:41:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
Message-ID: <20260224114152.GX1395266@noisy.programming.kicks-ass.net>
References: <20260224030700.35857-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224030700.35857-1-lance.yang@linux.dev>

On Tue, Feb 24, 2026 at 11:07:00AM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When freeing page tables, we try to batch them. If batch allocation fails
> (GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
> batching.
> 
> On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
> tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
> process is unmapping memory. IPI broadcast was reported to hurt RT
> workloads[1].
> 
> tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
> (e.g. GUP-fast) that rely on IRQ disabling. These walkers use
> local_irq_disable(), which is also an RCU read-side critical section.
> 
> This patch introduces tlb_remove_table_sync_rcu() which uses RCU grace
> period (synchronize_rcu()) instead of IPI broadcast. This provides the
> same guarantee as IPI but without disrupting all CPUs. Since batch
> allocation already failed, we are in a way slow path where sleeping is
> acceptable - we are in process context (unmap_region, exit_mmap) with only
> mmap_lock held. might_sleep() will catch any invalid context.

So sending the IPIs also requires non-atomic context, so change there.

What isn't explained, and very much not clear to me, is why
tlb_remove_table_sync_one() is retained?


> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 4aeac0c3d3f0..bdcc2778ac64 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -251,6 +251,8 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>  
>  void tlb_remove_table_sync_one(void);
>  
> +void tlb_remove_table_sync_rcu(void);
> +
>  #else
>  
>  #ifdef tlb_needs_table_invalidate
> @@ -259,6 +261,8 @@ void tlb_remove_table_sync_one(void);
>  
>  static inline void tlb_remove_table_sync_one(void) { }
>  
> +static inline void tlb_remove_table_sync_rcu(void) { }
> +
>  #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>  
>  
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index fe5b6a031717..2c6fa8db55df 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -296,6 +296,26 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>  	call_rcu(&batch->rcu, tlb_remove_table_rcu);
>  }
>  
> +/**
> + * tlb_remove_table_sync_rcu() - synchronize with software page-table walkers
> + *
> + * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
> + * broadcast. Use in slow paths where sleeping is acceptable.
> + *
> + * Software/Lockless page-table walkers use local_irq_disable(), which is also
> + * an RCU read-side critical section. synchronize_rcu() waits for all such
> + * sections, providing the same guarantee as tlb_remove_table_sync_one() but
> + * without disrupting all CPUs with IPIs.
> + *
> + * Do not use for freeing memory. Use RCU callbacks instead to avoid latency
> + * spikes. Cannot be called from any atomic context.
> + */
> +void tlb_remove_table_sync_rcu(void)
> +{
> +	might_sleep();
> +	synchronize_rcu();

synchronize_rcu() should end up in a might_sleep() at some point if it
blocks (which it typically will).

> +}
> +
>  #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>  
>  static void tlb_remove_table_free(struct mmu_table_batch *batch)
> @@ -339,7 +359,7 @@ static inline void __tlb_remove_table_one(void *table)
>  #else
>  static inline void __tlb_remove_table_one(void *table)
>  {
> -	tlb_remove_table_sync_one();
> +	tlb_remove_table_sync_rcu();
>  	__tlb_remove_table(table);
>  }
>  #endif /* CONFIG_PT_RECLAIM */
> -- 
> 2.49.0
> 
