Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39072 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdK0Odq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:33:46 -0500
MIME-Version: 1.0
In-Reply-To: <380808fe9139e2c3800ae76dfa6aa5cbbbc4894f.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <380808fe9139e2c3800ae76dfa6aa5cbbbc4894f.1511785528.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 15:33:45 +0100
Message-ID: <CAK8P3a2P+A55TyC_1bCj=sDjLZmpQoMptbZ59yd191fqdUstSA@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] nds32: L2 cache support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127143345.-GAXu4miw8cnG0lqcpJeq-VlwZMUo3qBb0n13cBA79s@z>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
> +
> +#define L2C_R_REG(offset)               __raw_readl(atl2c_base + offset)
> +#define L2C_W_REG(offset, value)        __raw_writel(value, atl2c_base + offset)

__raw_readl() is generally not endian-safe, and might  not have the barriers you
require here. Could you use readl/writel here, and only fall back to
readl_relaxed()/writel_relaxed() when you absolutely must avoid the barriers?

> diff --git a/arch/nds32/kernel/atl2c.c b/arch/nds32/kernel/atl2c.c
> new file mode 100644
> index 0000000..dd87fc9
> --- /dev/null
> +++ b/arch/nds32/kernel/atl2c.c
> +#include <linux/compiler.h>
> +#include <linux/of_address.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
> +#include <asm/l2_cache.h>

If this is the only file that includes asm/l2_cache.h, then I'd simply
move the entire
contents in here, rather than having a separate file in the global namespace.

          Arnd
