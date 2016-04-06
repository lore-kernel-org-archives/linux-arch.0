Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33894 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbcDFG6b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2016 02:58:31 -0400
Date: Wed, 6 Apr 2016 08:58:06 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 10/10] arch: fix has_transparent_hugepage()
Message-ID: <20160406065806.GC3078@gmail.com>
References: <alpine.LSU.2.11.1604051329480.5965@eggly.anvils>
 <alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andres Lagar-Cavilla <andreslc@google.com>, Yang Shi <yang.shi@linaro.org>, Ning Qu <quning@gmail.com>, Arnd Bergman <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Miller <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20160406065806.hMn4GGYv54Iet1S6KxcXVvO3dpMd01eHKnDsYBb8bJs@z>


* Hugh Dickins <hughd@google.com> wrote:

> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -181,6 +181,7 @@ static inline int pmd_trans_huge(pmd_t p
>  	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
>  }
>  
> +#define has_transparent_hugepage has_transparent_hugepage
>  static inline int has_transparent_hugepage(void)
>  {
>  	return cpu_has_pse;

Small nit, just writing:

  #define has_transparent_hugepage

ought to be enough, right?

In any case:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Another nit, this:

> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -806,4 +806,12 @@ static inline int pmd_clear_huge(pmd_t *
>  #define io_remap_pfn_range remap_pfn_range
>  #endif
>  
> +#ifndef has_transparent_hugepage
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define has_transparent_hugepage() 1
> +#else
> +#define has_transparent_hugepage() 0
> +#endif
> +#endif

Looks a bit more structured as:

  #ifndef has_transparent_hugepage
  # ifdef CONFIG_TRANSPARENT_HUGEPAGE
  #  define has_transparent_hugepage() 1
  # else
  #  define has_transparent_hugepage() 0
  # endif
  #endif

BYMMV.

Thanks,

	Ingo
