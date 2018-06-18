From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Mon, 18 Jun 2018 15:53:11 -0700
Message-ID: <563bd0ab-e40c-f9ad-4e9c-dbf5b13358b5@synopsys.com>
References: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On 06/15/2018 05:58 AM, Eugeniy Paltsev wrote:
> The ARC HS processor provides an IOC port (I/O coherency bus
> interface) that allows external devices such as DMA devices
> to access memory through the cache hierarchy, providing
> coherency between I/O transactions and the complete memory
> hierarchy.

This is really nice: having this a per device behaviour has been desirabl=
e rather
than the current blunt system-wide behaviour.

However the patch doesn't seem to change the routing off non-coherent tra=
ffic -
everything would still go thru it - per the current default setting of
CREG_AXI_M_*_SLV[0-1] registers. Ideally you would want to disable that a=
s well,
an addon patch is fine.

>
> Some recent SoC with ARC HS (like HSDK) allow to select bus
> port (IOC or non-IOC port) for connecting DMA devices in runtime.
>
> With this patch we can use both HW-coherent and regular DMA
> peripherals simultaneously.
>
> For example we can connect USB and SDIO controllers through IOC port
> (so we don't need to need to maintain cache coherency for these
> devices manualy. All cache sync ops will be nop)
> And we can connect Ethernet directly to RAM port (so we had to
> maintain cache coherency manualy. Cache sync ops will be real
> flush/invalidate operations)
>
> Cache ops are set per-device and depends on "dma-coherent" device
> tree property:
> "dma_noncoherent_ops" are used if no "dma-coherent" property is
> present (or IOC is disabled)
> "dma_direct_ops" are used if "dma-coherent" property is present.

I agree with Christoph that creating a new file for this seems excessive.=


> NOTE 1:
> It works perfectly fine only if we don't have ZONE_HIGHMEM used
> as IOC doesn't cover all physical memory. As for today It configured
> to cover 1GiB starting from 0x8z (which is ZONE_NORMAL memory for
> us). Transactions outside this region are sent on the non-coherent
> I/O bus interface.
> We can't configure IOC to cover all physical memory as it has several
> limitations relating to aperture size and start address.
>
> And if we get DMA buffer from ZONE_HIGHMEM memory we need to
> do real flush/invalidate operations on that buffer, which is obviously
> not done by "dma_direct_ops".
>
> So I am not sure about "dma_direct_ops" using - probably we need to
> create our special cache ops like "arc_ioc_ops" which will handle
> ZONE_HIGHMEM case.
>
> (BTW: current ARC dma_noncoherent_ops implementation also has same
> problem if IOC and HIGHMEM are enabled.)

Can we highlight this fact, add error prints somewhere ?

> NOTE 2:
> In this RFC only hsdk.dts changes are shown to reduce patch size.
> AXS103 device tree changes are not shown.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/Kconfig                   |  1 +
>  arch/arc/boot/dts/hsdk.dts         |  4 ++++
>  arch/arc/include/asm/dma-mapping.h | 14 ++++++++++++++
>  arch/arc/mm/Makefile               |  2 +-
>  arch/arc/mm/cache.c                | 15 +--------------
>  arch/arc/mm/dma-mapping.c          | 20 ++++++++++++++++++++
>  arch/arc/mm/dma.c                  | 14 +-------------
>  7 files changed, 42 insertions(+), 28 deletions(-)
>  create mode 100644 arch/arc/include/asm/dma-mapping.h
>  create mode 100644 arch/arc/mm/dma-mapping.c
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index e81bcd271be7..0a2fcd2a8c32 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -17,6 +17,7 @@ config ARC
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
>  	select DMA_NONCOHERENT_OPS
> +	select DMA_DIRECT_OPS
>  	select DMA_NONCOHERENT_MMAP
>  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LL=
SC)
>  	select GENERIC_CLOCKEVENTS
> diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
> index 006aa3de5348..ebb686c21393 100644
> --- a/arch/arc/boot/dts/hsdk.dts
> +++ b/arch/arc/boot/dts/hsdk.dts
> @@ -176,6 +176,7 @@
>  			phy-handle =3D <&phy0>;
>  			resets =3D <&cgu_rst HSDK_ETH_RESET>;
>  			reset-names =3D "stmmaceth";
> +			dma-coherent;
> =20
>  			mdio {
>  				#address-cells =3D <1>;
> @@ -194,12 +195,14 @@
>  			compatible =3D "snps,hsdk-v1.0-ohci", "generic-ohci";
>  			reg =3D <0x60000 0x100>;
>  			interrupts =3D <15>;
> +			dma-coherent;
>  		};
> =20
>  		ehci@40000 {
>  			compatible =3D "snps,hsdk-v1.0-ehci", "generic-ehci";
>  			reg =3D <0x40000 0x100>;
>  			interrupts =3D <15>;
> +			dma-coherent;
>  		};
> =20
>  		mmc@a000 {
> @@ -212,6 +215,7 @@
>  			clock-names =3D "biu", "ciu";
>  			interrupts =3D <12>;
>  			bus-width =3D <4>;
> +			dma-coherent;
>  		};
>  	};
> =20
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/=
dma-mapping.h
> new file mode 100644
> index 000000000000..640a851bd331
> --- /dev/null
> +++ b/arch/arc/include/asm/dma-mapping.h
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// (C) 2018 Synopsys, Inc. (www.synopsys.com)
> +
> +#ifndef ASM_ARC_DMA_MAPPING_H
> +#define ASM_ARC_DMA_MAPPING_H
> +
> +#define arch_setup_dma_ops arch_setup_dma_ops
> +
> +#include <asm-generic/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent);
> +
> +#endif
> diff --git a/arch/arc/mm/Makefile b/arch/arc/mm/Makefile
> index 3703a4969349..45683897c27b 100644
> --- a/arch/arc/mm/Makefile
> +++ b/arch/arc/mm/Makefile
> @@ -7,5 +7,5 @@
>  #
> =20
>  obj-y	:=3D extable.o ioremap.o dma.o fault.o init.o
> -obj-y	+=3D tlb.o tlbex.o cache.o mmap.o
> +obj-y	+=3D tlb.o tlbex.o cache.o mmap.o dma-mapping.o
>  obj-$(CONFIG_HIGHMEM)	+=3D highmem.o
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
> index 9dbe645ee127..c5d1f2a2c4da 100644
> --- a/arch/arc/mm/cache.c
> +++ b/arch/arc/mm/cache.c
> @@ -896,15 +896,6 @@ static void __dma_cache_wback_slc(phys_addr_t star=
t, unsigned long sz)
>  	slc_op(start, sz, OP_FLUSH);
>  }
> =20
> -/*
> - * DMA ops for systems with IOC
> - * IOC hardware snoops all DMA traffic keeping the caches consistent w=
ith
> - * memory - eliding need for any explicit cache maintenance of DMA buf=
fers
> - */
> -static void __dma_cache_wback_inv_ioc(phys_addr_t start, unsigned long=
 sz) {}
> -static void __dma_cache_inv_ioc(phys_addr_t start, unsigned long sz) {=
}
> -static void __dma_cache_wback_ioc(phys_addr_t start, unsigned long sz)=
 {}
> -
>  /*
>   * Exported DMA API
>   */
> @@ -1253,11 +1244,7 @@ void __init arc_cache_init_master(void)
>  	if (is_isa_arcv2() && ioc_enable)
>  		arc_ioc_setup();
> =20
> -	if (is_isa_arcv2() && ioc_enable) {
> -		__dma_cache_wback_inv =3D __dma_cache_wback_inv_ioc;
> -		__dma_cache_inv =3D __dma_cache_inv_ioc;
> -		__dma_cache_wback =3D __dma_cache_wback_ioc;
> -	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {

Maybe also tweak the boot printing in setup.c to indicate that we now do =
per
peripheral ioc !

> +	if (is_isa_arcv2() && l2_line_sz && slc_enable) {
>  		__dma_cache_wback_inv =3D __dma_cache_wback_inv_slc;
>  		__dma_cache_inv =3D __dma_cache_inv_slc;
>  		__dma_cache_wback =3D __dma_cache_wback_slc;
> diff --git a/arch/arc/mm/dma-mapping.c b/arch/arc/mm/dma-mapping.c
> new file mode 100644
> index 000000000000..9d0d310bbf5a
> --- /dev/null
> +++ b/arch/arc/mm/dma-mapping.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// (C) 2018 Synopsys, Inc. (www.synopsys.com)
> +
> +#include <linux/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent)
> +{
> +	const struct dma_map_ops *dma_ops =3D &dma_noncoherent_ops;
> +
> +	/*
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> +	 * with memory - eliding need for any explicit cache maintenance of
> +	 * DMA buffers - so we can use dma_direct cache ops.
> +	 */
> +	if (is_isa_arcv2() && ioc_enable && coherent)
> +		dma_ops =3D &dma_direct_ops;
> +
> +	set_dma_ops(dev, dma_ops);

Add a debug printk here maybe ?

> +}
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 8c1071840979..4fd130e786c7 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -33,19 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size=
, dma_addr_t *dma_handle,
>  	if (!page)
>  		return NULL;
> =20
> -	/*
> -	 * IOC relies on all data (even coherent DMA data) being in cache
> -	 * Thus allocate normal cached memory
> -	 *
> -	 * The gains with IOC are two pronged:
> -	 *   -For streaming data, elides need for cache maintenance, saving
> -	 *    cycles in flush code, and bus bandwidth as all the lines of a
> -	 *    buffer need to be flushed out to memory
> -	 *   -For coherent data, Read/Write to buffers terminate early in cac=
he
> -	 *   (vs. always going to memory - thus are faster)
> -	 */
> -	if ((is_isa_arcv2() && ioc_enable) ||
> -	    (attrs & DMA_ATTR_NON_CONSISTENT))
> +	if (attrs & DMA_ATTR_NON_CONSISTENT)
>  		need_coh =3D 0;
> =20
>  	/*
