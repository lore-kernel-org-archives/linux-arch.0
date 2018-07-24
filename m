From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Date: Tue, 24 Jul 2018 18:34:22 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08382A@us01wembx1.internal.synopsys.com>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On 07/24/2018 07:13 AM, Eugeniy Paltsev wrote:=0A=
> All DMA devices on ARC haven't worked with SW cache control=0A=
> since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
> This happens because we don't check direction argument at all in=0A=
> new implementation. Fix that.=0A=
=0A=
Good find and I presume painful to debug.=0A=
=0A=
Interesting though how the error tricked finally as the root cause was=0A=
arc_dma_sync_single*() were broken to begin with.=0A=
=0A=
Prior to common ops rework, arc_dma_sync_single_for_device() would uncondit=
ionally=0A=
do cache wback, independent of the direction (by calling _dma_cache_sync he=
lper=0A=
with TO_DEVICE). In 713a74624bba ("arc: simplify=0A=
arc_dma_sync_single_for_{cpu,device}") Christoph changed this to skip the h=
elper.=0A=
And then in a8eb92d02dd7, the usage of these routines was prolifirated to t=
he more=0A=
common kernel API dma_*map_page() API and that is where the original defici=
ency=0A=
showed up. I'll add this bit of history to changelog to remember this bette=
r.=0A=
=0A=
=0A=
> Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> NOTE:=0A=
>  * This patch was stress tested on HSDK with bonie++ (usb and sdio)=0A=
>    with IOC disabled. The ethernet wasn't tested because it doesn't=0A=
>    work with SW cache control as for today (see STAR 9001336019)=0A=
>=0A=
>  arch/arc/mm/dma.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--=0A=
>  1 file changed, 44 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c=0A=
> index 8c1071840979..cefb776a99ff 100644=0A=
> --- a/arch/arc/mm/dma.c=0A=
> +++ b/arch/arc/mm/dma.c=0A=
> @@ -129,14 +129,56 @@ int arch_dma_mmap(struct device *dev, struct vm_are=
a_struct *vma,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Cache operations depending on function and direction argument, inspir=
ed by=0A=
> + * https://lkml.org/lkml/2018/5/18/979=0A=
> + * "dma_sync_*_for_cpu and direction=3DTO_DEVICE (was Re: [PATCH 02/20]=
=0A=
> + * dma-mapping: provide a generic dma-noncoherent implementation)"=0A=
> + *=0A=
> + *          |   map          =3D=3D  for_device     |   unmap     =3D=3D=
  for_cpu=0A=
> + *          |-----------------------------------------------------------=
-----=0A=
> + * TO_DEV   |   writeback        writeback      |   none          none=
=0A=
> + * FROM_DEV |   invalidate       invalidate     |   invalidate    invali=
date=0A=
> + * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invali=
date=0A=
> + *=0A=
> + * NOTE: we don't check the validity of direction argument as it is done=
 in=0A=
> + * upper layer functions (in include/linux/dma-mapping.h)=0A=
> + */=0A=
> +=0A=
=0A=
Very nice !  Added to for-curr=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
>  void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,=0A=
>  		size_t size, enum dma_data_direction dir)=0A=
>  {=0A=
> -	dma_cache_wback(paddr, size);=0A=
> +	switch (dir) {=0A=
> +	case DMA_TO_DEVICE:=0A=
> +		dma_cache_wback(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	case DMA_FROM_DEVICE:=0A=
> +		dma_cache_inv(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	case DMA_BIDIRECTIONAL:=0A=
> +		dma_cache_wback_inv(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
>  }=0A=
>  =0A=
>  void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,=0A=
>  		size_t size, enum dma_data_direction dir)=0A=
>  {=0A=
> -	dma_cache_inv(paddr, size);=0A=
> +	switch (dir) {=0A=
> +	case DMA_TO_DEVICE:=0A=
> +		break;=0A=
> +=0A=
> +	case DMA_FROM_DEVICE:=0A=
> +	case DMA_BIDIRECTIONAL:=0A=
> +		dma_cache_inv(paddr, size);=0A=
> +		break;=0A=
> +=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
>  }=0A=
=0A=
