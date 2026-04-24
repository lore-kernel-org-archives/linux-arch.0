Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0A282F34;
	Fri, 24 Apr 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043115; cv=none; b=cRZQIxP4JErq2n8rK5OmmddB42/tWaKGFyU2HS8fZ+pXghhhbR5ps0/vOqLzumD0gBbw6Ggwv0VPjkZBoqahNFLvUDk8K9DibsykGki3+p0YhV4X3K+t0qJRUSzQ3ESJviEpIlu8BXHRa1syYHclUNeOEizs0j+eaU4nGwAWFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043115; c=relaxed/simple;
	bh=9w2606aQeabbJIZdtf5lj1VrPlSyQZSZtKQ8LlTuxTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrNAVHFmA91r07duKqD0eYmxSn97XWwRplzASSeH3EA738mcX3TMLxUvPFfYeNnHl1P6PUCOaLB/CeUIXdQFusgVDUWUl5icOyL7M8BdBrL8Hmy14hH1gH4V6JHjiHdBVPqJEgrUPHrvTtvytNbD6kmzrx0tu9srdEx9FTbKm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GBm3gHMf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBm3gHMf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+NqApcQrwdhaOtWhqBdoM6sLqZ2bCPI9lnI5VOoCdDg=; b=GBm3gHMfOVuha9S9cV0gdRX1yr
	YcsRzjFVJFChaczV7xWUg5ocsiMLja9wCwp5Ve36UGe/gNs1EIRcmW2rdxVQ6S/dBxD5qmnQPhvmf
	5U21nno16gogxpiGy+1qJeXBKtgHU8bR35ejMKPbsORtH5XVNUEN/5vQcZ6dyIKoqOMOrGOPELKDZ
	wl8otUg1MRTIkW6pKcv3flWlUHnMZyCopyIXfGgnK1XG5Fb1dOgYyiC+r4vMmPw1oW5xYL1ZG0myt
	VAkU6mqW+K3yF9kV+LpWrUvXsAeCSKveJOLDeejVyi85mDGUVGs3vF32tZmElrGMfcYYpl+qDoS4E
	RfyT2c+Q==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGI5O-0000000FNxB-407k;
	Fri, 24 Apr 2026 15:04:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8B7E8301261; Fri, 24 Apr 2026 17:04:54 +0200 (CEST)
Date: Fri, 24 Apr 2026 17:04:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
	jannh@google.com, jgross@suse.com, seanjc@google.com,
	pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 1/2] mm/mmu_gather: prepare to skip redundant
 sync IPIs
Message-ID: <20260424150454.GF3126523@noisy.programming.kicks-ass.net>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424062528.71951-2-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424062528.71951-2-lance.yang@linux.dev>

On Fri, Apr 24, 2026 at 02:25:27PM +0800, Lance Yang wrote:
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 3985d856de7f..37a6a711c37e 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -283,6 +283,14 @@ void tlb_remove_table_sync_one(void)
>  	 * It is however sufficient for software page-table walkers that rely on
>  	 * IRQ disabling.
>  	 */
> +
> +	/*
> +	 * Skip IPI if the preceding TLB flush already synchronized with
> +	 * all CPUs that could be doing software/lockless page table walks.
> +	 */
> +	if (tlb_table_flush_implies_ipi_broadcast())
> +		return;
> +
>  	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
>  }
>  
> @@ -312,6 +320,13 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   */
>  void tlb_remove_table_sync_rcu(void)
>  {
> +	/*
> +	 * Skip RCU wait if the preceding TLB flush already synchronized
> +	 * with all CPUs that could be doing software/lockless page table walks.
> +	 */
> +	if (tlb_table_flush_implies_ipi_broadcast())
> +		return;
> +
>  	synchronize_rcu();
>  }

So I don't like this at all.... The comment says there is a preceding
TLB flush, but there is nothing that guarantees there is. One would have
to go audit all users and ensure this is always true.

This thing is incredibly fragile.

Also, the comment in gup_fast() is nonsense, the local_irq_disable()
isn't about tlb_remove_table_sync_one(), it is primarily about TLBI
IPIs.



