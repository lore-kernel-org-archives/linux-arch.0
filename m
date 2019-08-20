From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 04/11] of/fdt: add early_init_dt_get_dma_zone_size()
Date: Tue, 20 Aug 2019 12:14:16 -0500
Message-ID: <CAL_Jsq+Nr88Nvd_ZA8eJGm4xLwssv7CnDJLsnZyFqiM=EQWYxg@mail.gmail.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-5-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820145821.27214-5-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Stefan Wahren <wahrenst@gmx.net>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>, phill@raspberryi.org, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Matthias Brugger <mbrugger@suse.com>moderat
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 20, 2019 at 9:58 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Some devices might have weird DMA addressing limitations that only apply
> to a subset of the available peripherals. For example the Raspberry Pi 4
> has two interconnects, one able to address the whole lower 4G memory
> area and another one limited to the lower 1G.
>
> Being an uncommon situation we simply hardcode the device wide DMA
> addressable memory size conditionally to the machine compatible name and
> set 'dma_zone_size' accordingly.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes in v2:
> - New approach to getting dma_zone_size, instead of parsing the dts we
>   hardcode it conditionally to the machine compatible name.
>
>  drivers/of/fdt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 06ffbd39d9af..f756e8c05a77 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -27,6 +27,7 @@
>
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> +#include <asm/dma.h>   /* for dma_zone_size */
>
>  #include "of_private.h"
>
> @@ -1195,6 +1196,12 @@ void __init early_init_dt_scan_nodes(void)
>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>  }
>
> +void __init early_init_dt_get_dma_zone_size(void)

static

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +{
> +       if (of_fdt_machine_is_compatible("brcm,bcm2711"))
> +               dma_zone_size = 0x3c000000;
> +}
> +
>  bool __init early_init_dt_scan(void *params)
>  {
>         bool status;
> @@ -1204,6 +1211,7 @@ bool __init early_init_dt_scan(void *params)
>                 return false;
>
>         early_init_dt_scan_nodes();
> +       early_init_dt_get_dma_zone_size();
>         return true;
>  }
>
> --
> 2.22.0
>
