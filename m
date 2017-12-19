From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v4 04/36] nds32: Kernel booting and initialization
Date: Tue, 19 Dec 2017 14:01:40 -0800
Message-ID: <78afd442-4482-f104-746e-5984214658ee@infradead.org>
References: <cover.1513577007.git.green.hu@gmail.com>
 <935ff034982f077b2e6f5eeccd6fe2110614fc9c.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <935ff034982f077b2e6f5eeccd6fe2110614fc9c.1513577007.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org
Cc: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 12/17/2017 10:46 PM, Greentime Hu wrote:
> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> 
> This patch includes the kernel startup code. It can get dtb pointer
> passed from bootloader. It will create a temp mapping by tlb
> instructions at beginning and goto start_kernel.
> 
> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> ---
>  arch/nds32/kernel/head.S  |  189 ++++++++++++++++++++++
>  arch/nds32/kernel/setup.c |  383 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 572 insertions(+)
>  create mode 100644 arch/nds32/kernel/head.S
>  create mode 100644 arch/nds32/kernel/setup.c
> 

> diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
> new file mode 100644
> index 0000000..7718c58
> --- /dev/null
> +++ b/arch/nds32/kernel/setup.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005-2017 Andes Technology Corporation
> +

[snip]

> +struct cache_info L1_cache_info[2];
> +static void __init dump_cpu_info(int cpu)
> +{
> +	int i, p = 0;
> +	char str[sizeof(hwcap_str) + 16];
> +
> +	for (i = 0; hwcap_str[i]; i++) {
> +		if (elf_hwcap & (1 << i)) {
> +			sprintf(str + p, "%s ", hwcap_str[i]);
> +			p += strlen(hwcap_str[i]) + 1;
> +		}
> +	}
> +
> +	pr_info("CPU%d Featuretures: %s\n", cpu, str);

	               Features:


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
