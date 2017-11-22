From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 12/31] nds32: Device specific operations
Date: Wed, 22 Nov 2017 18:02:59 +0800
Message-ID: <CAEbi=3cMgyeGmsWecsvWAV6s8LHROyrF-UH5TDP3VGkk0UO86g@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <4e9acf2ec55fb26ddb290ca2d955eeea628e0a77.1510118606.git.green.hu@gmail.com>
 <CAK8P3a04p+GUz3ex=t=CVy8ZcVFFZGwJaaPDoyT74bjieiKHVw@mail.gmail.com>
 <CAEbi=3eoTQ+operFB5Oq9VkAjG-Ehs=UQhOOELkeK2eSuuf0=g@mail.gmail.com>
 <CAEbi=3fCjkTSXLe+jP4UTe1W7570aN9LEpM9-v54p8xEW2YnAA@mail.gmail.com> <CAK8P3a3u8JECzVqzfX4pGN3e_UHsZ_o+Q7PpHAoMuj6iR-7uKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:41466 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbdKVKDk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Nov 2017 05:03:40 -0500
In-Reply-To: <CAK8P3a3u8JECzVqzfX4pGN3e_UHsZ_o+Q7PpHAoMuj6iR-7uKQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com

2017-11-11 0:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> Could you move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
> out of that #ifdef, or would that break other architectures?
>

It seems ok. I just tried arm64, x86 and nds32.

#endif /* CONFIG_MMU */
#ifndef ioremap_nocache
void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
#define ioremap_nocache ioremap_nocache
static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
{
        return ioremap(offset, size);
}
#endif

#ifndef ioremap_uc
#define ioremap_uc ioremap_uc
static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
{
        return ioremap_nocache(offset, size);
}
#endif

#ifndef ioremap_wc
#define ioremap_wc ioremap_wc
static inline void __iomem *ioremap_wc(phys_addr_t offset, size_t size)
{
        return ioremap_nocache(offset, size);
}
#endif

#ifndef ioremap_wt
#define ioremap_wt ioremap_wt
static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
{
        return ioremap_nocache(offset, size);
}
#endif
