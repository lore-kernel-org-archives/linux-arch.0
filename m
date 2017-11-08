From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 02/31] nds32: Kernel booting and initialization
Date: Wed, 8 Nov 2017 07:38:42 -0600
Message-ID: <CAL_JsqLG05ha3ApwHJooqqZThH30p=Yu8GbXpg6RyC-2v+K=NA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <5d06ac8d2a19c78a445b958a1b0a925559bd9f9c.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbdKHNjE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Nov 2017 08:39:04 -0500
In-Reply-To: <5d06ac8d2a19c78a445b958a1b0a925559bd9f9c.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Tue, Nov 7, 2017 at 11:54 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>

Commit message needed.

> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---

> +       /* it could update max_pfn */
> +       if (max_pfn - ram_start_pfn <= MAXMEM_PFN)
> +               max_low_pfn = max_pfn;
> +       else {
> +               max_low_pfn = MAXMEM_PFN + ram_start_pfn;
> +#ifndef CONFIG_HIGHMEM

Use IS_ENABLED here and other ifdef's if possible.

> +               max_pfn = MAXMEM_PFN + ram_start_pfn;
> +#endif
> +       }


> +static int __init nds32_device_probe(void)
> +{
> +       return of_platform_populate(NULL, NULL, NULL, NULL);
> +}
> +
> +device_initcall(nds32_device_probe);

You can drop this. The core code will call of_platform_populate for you.
