Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBSMsD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 07:48:03 -0500
Date: Tue, 19 Feb 2019 12:47:58 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 13/18] asm-generic/tlb: Introduce
 HAVE_MMU_GATHER_NO_GATHER
Message-ID: <20190219124758.GF8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.633310832@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103233.633310832@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20190219124758.kd70s-sZkKKhVkLSOXlZJeCQBu-umEVaI-4IbSxHfgo@z>

On Tue, Feb 19, 2019 at 11:32:01AM +0100, Peter Zijlstra wrote:
> Add the Kconfig option HAVE_MMU_GATHER_NO_GATHER to the generic
> mmu_gather code. If the option is set the mmu_gather will not
> track individual pages for delayed page free anymore. A platform
> that enables the option needs to provide its own implementation
> of the __tlb_remove_page_size function to free pages.
> 
> Cc: npiggin@gmail.com
> Cc: heiko.carstens@de.ibm.com
> Cc: will.deacon@arm.com
> Cc: aneesh.kumar@linux.vnet.ibm.com
> Cc: akpm@linux-foundation.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux@armlinux.org.uk
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180918125151.31744-2-schwidefsky@de.ibm.com
> ---
>  arch/Kconfig              |    3 +
>  include/asm-generic/tlb.h |    9 +++
>  mm/mmu_gather.c           |  107 +++++++++++++++++++++++++---------------------
>  3 files changed, 70 insertions(+), 49 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
