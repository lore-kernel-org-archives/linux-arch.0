From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 18/29] nios2: Device tree support
Date: Tue, 15 Jul 2014 11:41:58 +0200
Message-ID: <5098448.1h12jNJ4cv@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-19-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59859 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758505AbaGOJmD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:42:03 -0400
In-Reply-To: <1405413956-2772-19-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

On Tuesday 15 July 2014 16:45:45 Ley Foon Tan wrote:
> +static struct of_device_id altera_of_bus_ids[] __initdata = {
> +       { .compatible = "simple-bus", },
> +       { .compatible = "altr,avalon", },
> +       {}
> +};

Can you change the avalon bus nodes to be compatible to with "simple-bus"
as well, so you can use the default id list?

> +static int __init nios2_soc_device_init(void)
> +{
> +       struct soc_device *soc_dev;
> +       struct soc_device_attribute *soc_dev_attr;
> +       const char *machine;
> +
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (soc_dev_attr) {
> +               machine = of_flat_dt_get_machine_name();
> +               if (machine)
> +                       soc_dev_attr->machine = kasprintf(GFP_KERNEL, "%s",
> +                                               machine);
> +
> +               soc_dev_attr->family = "Nios II";
> +
> +               soc_dev = soc_device_register(soc_dev_attr);
> +               if (IS_ERR(soc_dev)) {
> +                       kfree(soc_dev_attr->machine);
> +                       kfree(soc_dev_attr);
> +               }
> +       }
> +
> +       return of_platform_bus_probe(NULL, altera_of_bus_ids, NULL);
> +}
> +
> +device_initcall(nios2_soc_device_init);
> 
I think you should use of_platform_populate instead of of_platform_bus_probe
here.

	ARnd
