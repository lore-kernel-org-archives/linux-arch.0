Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54446 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752563AbdLMJqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 04:46:08 -0500
Date: Wed, 13 Dec 2017 17:45:48 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Message-ID: <20171213094548.GA23563@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com>
 <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
 <20171213021619.GA6254@gary-OptiPlex-3050>
 <CAEbi=3dtcnUNbd4SoueUnoYvRWot9fA1n62t0b4PWx1UYs2jZA@mail.gmail.com>
 <20171213081949.GA18840@gary-OptiPlex-3050>
 <CAEbi=3eKH5JESwtadq4LKF3ZvmBi1QwUWpCTb0btierBST_cRQ@mail.gmail.com>
 <20171213085334.GA21382@gary-OptiPlex-3050>
 <CAEbi=3fvdWMExreVsSu3TJqXUr5Zpt4k_q=cXXB3miJCvY-+1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3fvdWMExreVsSu3TJqXUr5Zpt4k_q=cXXB3miJCvY-+1g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171213094548.xmaOc_L98GGfVryjq42C11ipBkNU4yFWQowu-V3Yda8@z>

Hello,

CPU team could improve the tlbop_*. Eg: Design a hardware
internal flag bit for SR_TLB_VPN, tlbop_* will invalid it and mtsr
SR_TLB_VPN will valid it.

So:
On Wed, Dec 13, 2017 at 05:03:33PM +0800, Greentime Hu wrote:
> mtsr addr1 NDS32_SR_TLB_VPN
>     interrupt coming
>         mtsr addr2 NDS32_SR_TLB_VPN <- TLB_VPN has been set to addr2 
	mtsr SR_TLB_VPN will valid the flag bit
>         tlbop_rwr(*pte);
	tlbop_rwr will invalid SR_TLB_VPN flag bit
>     interrupt finish
> tlbop_rwr(*pte); <- it will use the wrong TLB_VPN
Because SR_TLB_VPN is in a invalid state, no operation happen on
tlbop_rwr.

Then they are atomic safe ,no spin_lock_irq need.
:)

 Guo Ren
