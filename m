From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/27] arm64: Override defaults from generic/tlb.h
Date: Thu, 15 May 2014 10:34:31 +0100
Message-ID: <20140515093430.GE11117@localhost>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
 <1400093999-18703-2-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:46160 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751122AbaEOJeq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 May 2014 05:34:46 -0400
Content-Disposition: inline
In-Reply-To: <1400093999-18703-2-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Steve Capper <steve.capper@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 14, 2014 at 07:59:33PM +0100, Richard Weinberger wrote:
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -19,7 +19,14 @@
>  #ifndef __ASM_TLB_H
>  #define __ASM_TLB_H
>  
> +/* These defines are needed to override the defaults from asm-generic/tlb.h */
>  #define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
> +#define tlb_start_vma tlb_start_vma
> +#define tlb_end_vma tlb_end_vma
> +#define __tlb_remove_tlb_entry __tlb_remove_tlb_entry
> +#define tlb_flush tlb_flush
> +#define __pte_free_tlb __pte_free_tlb
> +#define __pmd_free_tlb __pmd_free_tlb
>  
>  #include <asm-generic/tlb.h>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I hope subsequent series would consolidate some more of the above (for
example tlb_start_vma() is not really arm64 specific.
