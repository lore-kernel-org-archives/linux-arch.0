From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/6] powerpc/powernv: must include hvcall.h to get PAPR defines
Date: Thu, 09 Jul 2020 20:05:18 +1000
Message-ID: <87fta1vw9t.fsf@mpe.ellerman.id.au>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-2-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200706043540.1563616-2-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> An include goes away in future patches which breaks compilation
> without this.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> index f923359d8afc..8eba6ece7808 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -15,6 +15,7 @@
>  
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> +#include <asm/hvcall.h> /* share error returns with PAPR */
>  #include "pci.h"
>  
>  unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
> -- 
> 2.23.0

This isn't needed anymore AFAICS, since:

5f202c1a1d42 ("powerpc/powernv/ioda: Return correct error if TCE level allocation failed")

cheers
