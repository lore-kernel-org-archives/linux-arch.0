From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 23/24] C6X: Power and Sleep Controller
Date: Mon, 22 Aug 2011 23:20:40 +0200
Message-ID: <2590242.9BfSTyhCik@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-24-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1HVVVO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 17:21:14 -0400
In-Reply-To: <1314043785-2880-24-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:44 Mark Salter wrote:
> +void __init psc_init(void)
> +{
> +       struct device_node *node;
> +       const __be32 *p;
> +       int i, len;
> +
> +       node = of_find_compatible_node(NULL, NULL, "ti,c64x+psc");
> +       if (!node)
> +               return;
> +
> +       psc.base = of_iomap(node, 0);
> +       if (!psc.base) {
> +               of_node_put(node);
> +               return;
> +       }
> +
> +       p = of_get_property(node, "ti,number-psc-domains", &len);
> +       if (p && len == sizeof(u32))
> +               psc.num_domains = be32_to_cpup(p);
> +
> +       p = of_get_property(node, "ti,number-psc-modules", &len);
> +       if (p && len == sizeof(u32))
> +               psc.num_modules = be32_to_cpup(p);
> +
> +       p = of_get_property(node, "ti,module-domain-map", &len);
> +       if (p) {
> +               len /= sizeof(u32);
> +               if (len > MAX_PSC_MODULES)
> +                       len = MAX_PSC_MODULES;
> +               for (i = 0; i <= len; i++)
> +                       psc.module_domains[i] = be32_to_cpup(&p[i]);
> +       }
> +
> +       of_node_put(node);
> +}

I think this should be a proper driver instead, using a struct platform_driver
and a match table instead the hacky of_find_compatible_node. That is generally
the preferred approach for any nonessential code that can be initialized later
and is not referenced by core code. As far as I can tell, this is the case
here, though I could not actually find the callers so far.

	Arnd
