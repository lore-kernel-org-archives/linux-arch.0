From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 20/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 09:49:05 +0100
Message-ID: <20150623084905.GE31504@arm.com>
References: <20150622133656.GG1583@arm.com>
 <1435046283-2073-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50511 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbbFWItJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2015 04:49:09 -0400
Content-Disposition: inline
In-Reply-To: <1435046283-2073-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Vineet,

On Tue, Jun 23, 2015 at 08:58:03AM +0100, Vineet Gupta wrote:
> ARCv2 based HS38 cores are weakly ordered and thus explicit barriers for
> kernel proper.
> 
> SMP barrier is provided by DMB instruction which also guarantees local
> barrier hence used as backend of smp_*mb() as well as *mb() APIs
> 
> Also hookup barriers into MMIO accessors to avoid ordering issues in IO
> 
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
> Changes since v1
>  * Better changelog and comments
>  * local/mandatory barriers to NOT use DSYNC, but DMB
>  * define DMB based mandatory barriers even for !SMP
> ---

Functionally, all looks good to me. However, my comment is completely
misleading ;)

> +/*
> + * MMIO can also get buffered/optimized in micro-arch, so barriers needed
> + * Based on ARM model for the typical use case
> + *
> + *	<writel_relaxed DMA buffer>
> + *	<writel MMIO "go" reg>
> + *   or:
> + *   	<readl MMIO "status" reg>
> + *   	<readl_relaxed DMA buffer>

The writel_relaxed/readl_relaxed parts here would actually just be
bog-standard loads and stores to an in-memory buffer. I was trying too hard
to show the barrier semantics and accidentally turned the DMA buffers into
__iomem regions.

If you fix the comment:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Sorry for messing you about.

Will
