Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdLSWC3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Dec 2017 17:02:29 -0500
Subject: Re: [PATCH v4 04/36] nds32: Kernel booting and initialization
References: <cover.1513577007.git.green.hu@gmail.com>
 <935ff034982f077b2e6f5eeccd6fe2110614fc9c.1513577007.git.green.hu@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <78afd442-4482-f104-746e-5984214658ee@infradead.org>
Date: Tue, 19 Dec 2017 14:01:40 -0800
MIME-Version: 1.0
In-Reply-To: <935ff034982f077b2e6f5eeccd6fe2110614fc9c.1513577007.git.green.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: Vincent Chen <vincentc@andestech.com>
Message-ID: <20171219220140.nHUlLE3AcMvCCzdTCWBx9FFOXMyW66MCn7msCW-CT3M@z>

On 12/17/2017 10:46 PM, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> This patch includes the kernel startup code. It can get dtb pointer
> passed from bootloader. It will create a temp mapping by tlb
> instructions at beginning and goto start_kernel.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
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
