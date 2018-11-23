Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45660 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNY1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Nov 2018 08:24:27 -0500
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-6-hch@lst.de>
In-Reply-To: <20181115190538.17016-6-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:41:19 +0900
Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: consolidate the PCI_DOMAINS and
 PCI_DOMAINS_GENERIC config options
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Message-ID: <20181123024119.HGsIkORx1HOPZIJWpFhDTvQGs68BfRmh-uW_urZ6vT4@z>

On Fri, Nov 16, 2018 at 4:07 AM Christoph Hellwig <hch@lst.de> wrote:

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a8128a1946a2..95812fc4958c 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -21,6 +21,15 @@ menuconfig PCI
>           support for PCI-X and the foundations for PCI Express support.
>           Say 'Y' here unless you know what you are doing.
>
> +config PCI_DOMAINS
> +       depends on PCI
> +       bool
> +
> +config PCI_DOMAINS_GENERIC
> +       depends on PCI
> +       select PCI_DOMAINS
> +       bool
> +
>  source "drivers/pci/pcie/Kconfig"
>
>  config PCI_MSI


I reordered this so it 'bool' comes first.

config PCI_DOMAINS
       bool
       depends on PCI


config PCI_DOMAINS_GENERIC
       bool
       depends on PCI
       select PCI_DOMAINS


Of course, it is just a matter of slight taste.
I just wanted the code to look consistent.




-- 
Best Regards
Masahiro Yamada
