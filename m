From: Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Date: Wed, 13 Dec 2017 17:45:48 +0800
Message-ID: <20171213094548.GA23563@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com>
 <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
 <20171213021619.GA6254@gary-OptiPlex-3050>
 <CAEbi=3dtcnUNbd4SoueUnoYvRWot9fA1n62t0b4PWx1UYs2jZA@mail.gmail.com>
 <20171213081949.GA18840@gary-OptiPlex-3050>
 <CAEbi=3eKH5JESwtadq4LKF3ZvmBi1QwUWpCTb0btierBST_cRQ@mail.gmail.com>
 <20171213085334.GA21382@gary-OptiPlex-3050>
 <CAEbi=3fvdWMExreVsSu3TJqXUr5Zpt4k_q=cXXB3miJCvY-+1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEbi=3fvdWMExreVsSu3TJqXUr5Zpt4k_q=cXXB3miJCvY-+1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
