From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible function
Date: Tue, 20 Aug 2019 12:16:43 -0500
Message-ID: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-4-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820145821.27214-4-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Stefan Wahren <wahrenst@gmx.net>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>, phill@raspberryi.org, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Matthias Brugger <mbrugger@suse.com>moderat
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 20, 2019 at 9:58 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Provides the same functionality as of_machine_is_compatible.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> Changes in v2: None
>
>  drivers/of/fdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9cdf14b9aaab..06ffbd39d9af 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -802,6 +802,13 @@ const char * __init of_flat_dt_get_machine_name(void)
>         return name;
>  }
>
> +static const int __init of_fdt_machine_is_compatible(char *name)

No point in const return (though name could possibly be const), and
the return could be bool instead.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +{
> +       unsigned long dt_root = of_get_flat_dt_root();
> +
> +       return of_flat_dt_is_compatible(dt_root, name);
> +}
> +
>  /**
>   * of_flat_dt_match_machine - Iterate match tables to find matching machine.
>   *
> --
> 2.22.0
>
