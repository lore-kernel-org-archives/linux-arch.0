Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:46512 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdLMKF0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 05:05:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171213094548.GA23563@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com> <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
 <20171213021619.GA6254@gary-OptiPlex-3050> <CAEbi=3dtcnUNbd4SoueUnoYvRWot9fA1n62t0b4PWx1UYs2jZA@mail.gmail.com>
 <20171213081949.GA18840@gary-OptiPlex-3050> <CAEbi=3eKH5JESwtadq4LKF3ZvmBi1QwUWpCTb0btierBST_cRQ@mail.gmail.com>
 <20171213085334.GA21382@gary-OptiPlex-3050> <CAEbi=3fvdWMExreVsSu3TJqXUr5Zpt4k_q=cXXB3miJCvY-+1g@mail.gmail.com>
 <20171213094548.GA23563@gary-OptiPlex-3050>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 13 Dec 2017 18:04:44 +0800
Message-ID: <CAEbi=3eo9WqpzaVK_KoGE3JnvwjYGG8bOnbCQTd5RpvrQ_ySTA@mail.gmail.com>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171213100444.x4fLN-esmfqPZvk5Ur6oPfogLu6qi1nJs32eyg9xTxU@z>

2017-12-13 17:45 GMT+08:00 Guo Ren <ren_guo@c-sky.com>:
> Hello,
>
> CPU team could improve the tlbop_*. Eg: Design a hardware
> internal flag bit for SR_TLB_VPN, tlbop_* will invalid it and mtsr
> SR_TLB_VPN will valid it.
>
> So:
> On Wed, Dec 13, 2017 at 05:03:33PM +0800, Greentime Hu wrote:
>> mtsr addr1 NDS32_SR_TLB_VPN
>>     interrupt coming
>>         mtsr addr2 NDS32_SR_TLB_VPN <- TLB_VPN has been set to addr2
>         mtsr SR_TLB_VPN will valid the flag bit
>>         tlbop_rwr(*pte);
>         tlbop_rwr will invalid SR_TLB_VPN flag bit
>>     interrupt finish
>> tlbop_rwr(*pte); <- it will use the wrong TLB_VPN
> Because SR_TLB_VPN is in a invalid state, no operation happen on
> tlbop_rwr.
>
> Then they are atomic safe ,no spin_lock_irq need.
> :)
>

Oh, I see. I may propose this idea to our ARCH colleagues for the next
version design.
Many thanks.
