From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 22/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 17:28:26 +0100
Message-ID: <20150623162826.GB11638@arm.com>
References: <20150623092624.GG31504@arm.com>
 <1435053126-4716-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51839 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933448AbbFWQ23 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2015 12:28:29 -0400
Content-Disposition: inline
In-Reply-To: <1435053126-4716-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Tue, Jun 23, 2015 at 10:52:06AM +0100, Vineet Gupta wrote:
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
> Changes since v2
>  * lkml discussion link points to lkml redirector (PeterZ)
>  * Updated comment about IO ordering to use standard LD/ST (Will Deacon)
> 
> Changes since v1
>  * Better changelog and comments
>  * local/mandatory barriers to NOT use DSYNC, but DMB
>  * define DMB based mandatory barriers even for !SMP
> ---

[...]

> +/*
> + * MMIO can also get buffered/optimized in micro-arch, so barriers needed
> + * Based on ARM model for the typical use case
> + *
> + *	<ST [DMA buffer]>
> + *		wmb()
> + *	<writel MMIO "go" reg>
> + *  or:
> + *	<readl MMIO "status" reg>
> + *		rmb()
> + *	<LD [DMA buffer]>
> + *
> + * http://lkml.kernel.org/r/20150622133656.GG1583@arm.com
> + */

If that makes sense to you, then fine, but I find the wmb() and rmb() a bit
odd since they're implied by the writel/readl macros.

Regardless, you can keep my reviewed-by from last time.

Will
