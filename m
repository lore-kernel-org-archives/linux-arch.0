Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeISSCB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Sep 2018 14:02:01 -0400
Date: Wed, 19 Sep 2018 13:24:39 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 07/11] arm/tlb: Convert to generic mmu_gather
Message-ID: <20180919122439.GC22723@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.247989787@infradead.org>
 <20180918141034.GF16498@arm.com>
 <20180919112829.GA24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919112829.GA24124@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180919122439.R4c24_gbD85frfxmr4-XMJ1olAM1e_YzzrRetfpH428@z>

On Wed, Sep 19, 2018 at 01:28:29PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 18, 2018 at 03:10:34PM +0100, Will Deacon wrote:
> 
> > So whilst I was reviewing this, I realised that I think we should be
> > selecting HAVE_RCU_TABLE_INVALIDATE for arch/arm/ if HAVE_RCU_TABLE_FREE.
> 
> Yes very much so. Let me invert that option, you normally want that,
> except if you don't natively use the linux page-tables.

Yeah, inverting this to be opt-out is definitely the safe thing to do.
Patch below looks good:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> ---
> Subject: asm-generic/tlb: Invert HAVE_RCU_TABLE_INVALIDATE
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Sep 19 13:24:41 CEST 2018
> 
> Make issuing a TLB invalidate for page-table pages the normal case.
> 
> The reason is twofold:
> 
>  - too many invalidates is safer than too few,
>  - most architectures use the linux page-tables natively
>    and would this require this.
> 
> Make it an opt-out, instead of an opt-in.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
