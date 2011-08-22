From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/24] C6X: EMIF - External Memory Interface
Date: Mon, 22 Aug 2011 23:17:45 +0200
Message-ID: <6640139.XM528fXZpr@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-23-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49503 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1HVVSU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 17:18:20 -0400
In-Reply-To: <1314043785-2880-23-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:43 Mark Salter wrote:
> +/*
> + * Parse device tree for existence of an EMIF (External Memory Interface)
> + * and initialize it if found.
> + */
> +static int __init c6x_emifa_init(void)
> +{
> +       struct emifa_regs __iomem *regs;
> +       struct device_node *node;
> +       const __be32 *p;
> +       int i, len;
> +
> +       node = of_find_compatible_node(NULL, NULL, "ti,c64x+emifa");
> +       if (!node)
> +               return 0;
> +
> +       regs = of_iomap(node, 0);
> +       if (!regs)
> +               return 0;
> +
> +       /* emif power/clocks */
> +       soc_dev_enable(SOC_DEV_EMIF, 0);
> +
> +       p = of_get_property(node, "ti,emifa-ce-config", &len);
> +       if (p) {
> +               len /= sizeof(u32);
> +               if (len > NUM_EMIFA_CHIP_ENABLES)
> +                       len = NUM_EMIFA_CHIP_ENABLES;
> +               for (i = 0; i <= len; i++)
> +                       soc_writel(be32_to_cpup(&p[i]), &regs->cecfg[i]);
> +       }
> +
> +       p = of_get_property(node, "ti,emifa-burst-priority", &len);
> +       if (p && len == sizeof(u32))
> +               soc_writel(be32_to_cpup(p), &regs->bprio);
> +
> +       p = of_get_property(node, "ti,emifa-async-wait-control", &len);
> +       if (p && len == sizeof(u32))
> +               soc_writel(be32_to_cpup(p), &regs->awcc);
> +
> +       of_node_put(node);
> +       return 0;
> +}
> +pure_initcall(c6x_emifa_init);

It looks like you are missing an iounmap here. Obviously a nop on nommu, but
it caught my eye anyway and perheps you get an mmu at some point.

	Arnd
