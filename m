Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTRQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 13:16:56 -0400
MIME-Version: 1.0
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-4-nsaenzjulienne@suse.de>
In-Reply-To: <20190820145821.27214-4-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 20 Aug 2019 12:16:43 -0500
Message-ID: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible function
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Stefan Wahren <wahrenst@gmx.net>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>, phill@raspberryi.org, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Matthias Brugger <mbrugger@suse.com>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20190820171643.GZEuryKZ9opBqA32aLKBkfP7jxC5T6YvXlm38Z3wQlA@z>

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
