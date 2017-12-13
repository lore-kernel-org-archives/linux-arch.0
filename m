From: Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Date: Wed, 13 Dec 2017 16:53:36 +0800
Message-ID: <20171213085334.GA21382@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com>
 <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
 <20171213021619.GA6254@gary-OptiPlex-3050>
 <CAEbi=3dtcnUNbd4SoueUnoYvRWot9fA1n62t0b4PWx1UYs2jZA@mail.gmail.com>
 <20171213081949.GA18840@gary-OptiPlex-3050>
 <CAEbi=3eKH5JESwtadq4LKF3ZvmBi1QwUWpCTb0btierBST_cRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEbi=3eKH5JESwtadq4LKF3ZvmBi1QwUWpCTb0btierBST_cRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 13, 2017 at 04:30:41PM +0800, Greentime Hu wrote:
> 2017-12-13 16:19 GMT+08:00 Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>:
> > On Wed, Dec 13, 2017 at 01:45:02PM +0800, Greentime Hu wrote:
> >
> >> I think it should be fine if an interruption between mtsr_dsb and
> >> tlbop_rwr because this is a optimization by sw.
> >
> > Fine? When there is an unexpected vaddr in SR_TLB_VPN, tlbop_rwr(*pte) will
> > break that vaddr's pfn in the CPU tlb-buffer entry. When linux access the
> > vaddr, it will get wrong data unless the entry has been replaced out.
> 
> Hi, Guo Ren:
> 
> Thanks. I get your point.
> It is needed to be protected.
> I will fix it in the next version patch.
> 
> if (vma->vm_mm == current->active_mm) {
>         local_irq_save(flags);
>         __nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
>         __nds32__tlbop_rwr(*pte);
>         __nds32__isb();
>         local_irq_restore(flags);
> }

If hardware tlbop_rwr could invalid NDS32_SR_TLB_VPN, then you needn't
protect.
I mean:
mtsr addr1 NDS32_SR_TLB_VPN
mtsr addr2 NDS32_SR_TLB_VPN
tlbop_rwr(*pte) // OK, and it will hit a hardware invalid bit internal.
tlbop_rwr(*pte) // SR_TLB_VPN invalided, then it will not cause problem.

:) How my idea?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
