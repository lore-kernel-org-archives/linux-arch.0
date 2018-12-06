From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/34] powerpc: allow NOT_COHERENT_CACHE for amigaone
Date: Thu, 6 Dec 2018 06:09:22 -0800
Message-ID: <20181206140922.GA29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

powerpc maintainers, can you pick this up as this is a bug fix for the
currently existing powerpc Kconfig code?

On Wed, Nov 14, 2018 at 09:22:42AM +0100, Christoph Hellwig wrote:
> AMIGAONE select NOT_COHERENT_CACHE, so we better allow it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/platforms/Kconfig.cputype | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index f4e2c5729374..6fedbf349fce 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -412,7 +412,8 @@ config NR_CPUS
>  
>  config NOT_COHERENT_CACHE
>  	bool
> -	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
> +	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
> +		GAMECUBE_COMMON || AMIGAONE
>  	default n if PPC_47x
>  	default y
>  
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
