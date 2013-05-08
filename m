Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:32921 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756706Ab3EHQoP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2013 12:44:15 -0400
Date: Wed, 8 May 2013 17:43:41 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2 07/11] ARM64: mm: Make PAGE_NONE pages read only
 and no-execute.
Message-ID: <20130508164341.GG20820@mudshark.cambridge.arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-8-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368006763-30774-8-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130508164341.8yF-bM_56dF_qkbjB2c9C2Ax__q49oHqz9YJMX5dEBo@z>

On Wed, May 08, 2013 at 10:52:39AM +0100, Steve Capper wrote:
> If we consider the following code sequence:
> 
> 	my_pte = pte_modify(entry, myprot);
> 	x = pte_write(my_pte);
> 	y = pte_exec(my_pte);
> 
> If myprot comes from a PROT_NONE page, then x and y will both be
> true which is undesireable behaviour.
> 
> This patch sets the no-execute and read-only bits for PAGE_NONE
> such that the code above will return false for both x and y.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index e333a24..b1a1b59 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -66,7 +66,7 @@ extern pgprot_t pgprot_default;
>  
>  #define _MOD_PROT(p, b)		__pgprot_modify(p, 0, b)
>  
> -#define PAGE_NONE		__pgprot_modify(pgprot_default, PTE_TYPE_MASK, PTE_PROT_NONE)
> +#define PAGE_NONE		__pgprot_modify(pgprot_default, PTE_TYPE_MASK, PTE_PROT_NONE | PTE_RDONLY | PTE_UXN)
>  #define PAGE_SHARED		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
>  #define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN)
>  #define PAGE_COPY		_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_RDONLY)
> @@ -76,7 +76,7 @@ extern pgprot_t pgprot_default;
>  #define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY)
>  #define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY)
>  
> -#define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE)
> +#define __PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_RDONLY | PTE_UXN)
>  #define __PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
>  #define __PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
>  #define __PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_RDONLY)

Whilst it's not strictly needed for pte_exec to work, I think you should
include PTE_PXN in the PAGE_NONE definitions as well.

Will
