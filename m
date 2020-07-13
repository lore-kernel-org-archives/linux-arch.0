Return-Path: <SRS0=ixnu=AY=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40381 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgGMNTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 09:19:54 -0400
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-6-hch@lst.de>
 <20200713122148.GA51007@lakrids.cambridge.arm.com>
In-Reply-To: <20200713122148.GA51007@lakrids.cambridge.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2020 15:19:42 +0200
Message-ID: <CAMuHMdUCmEeU0G9wkUxZKm5tC9YoB-KXSSCLKwpSia746Myebw@mail.gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv <linux-riscv@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20200713131942.DbM8b9ob4vjajqz6eY7ZHk7hdPwIrzvzVuKhhftxRyE@z>

Hi Mark,

On Mon, Jul 13, 2020 at 2:21 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jul 10, 2020 at 03:57:05PM +0200, Christoph Hellwig wrote:
> > Add helpers to wraper the get_fs/set_fs magic for undoing any damange
> > done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> > documents the intent of these calls better, and will allow stubbing the
> > functions out easily for kernels builds that do not allow address space
> > overrides in the future.
>
> > diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
> > index 191e75a6bb249e..30471549e1e224 100644
> > --- a/arch/m68k/include/asm/tlbflush.h
> > +++ b/arch/m68k/include/asm/tlbflush.h
> > @@ -13,13 +13,13 @@ static inline void flush_tlb_kernel_page(void *addr)
> >       if (CPU_IS_COLDFIRE) {
> >               mmu_write(MMUOR, MMUOR_CNL);
> >       } else if (CPU_IS_040_OR_060) {
> > -             mm_segment_t old_fs = get_fs();
> > -             set_fs(KERNEL_DS);
> > +             mm_segment_t old_fs = force_uaccess_begin();
> > +
>
> This used to set KERNEL_DS, and now it sets USER_DS, which looks wrong
> superficially.

Thanks for noticing, and sorry for missing that myself.

The same issue is present for SuperH:

    -               set_fs(KERNEL_DS);
    +               oldfs = force_uaccess_begin();

So the patch description should be:

    "Add helpers to wraper the get_fs/set_fs magic for undoing any damage
     done by set_fs(USER_DS)."

and leave alone users setting KERNEL_DS?

> If the new behaviour is fine it suggests that the old behaviour was
> wrong, or that this is superfluous and could go entirely.
>
> Geert?

Nope, on m68k, TLB cache operations operate on the current address space.
Hence to flush a kernel TLB entry, you have to switch to KERNEL_DS first.

If we're guaranteed to be already using KERNEL_DS, I guess the
address space handling can be removed.  But can we be sure?


> >               __asm__ __volatile__(".chip 68040\n\t"
> >                                    "pflush (%0)\n\t"
> >                                    ".chip 68k"
> >                                    : : "a" (addr));
> > -             set_fs(old_fs);
> > +             force_uaccess_end(old_fs);
> >       } else if (CPU_IS_020_OR_030)
> >               __asm__ __volatile__("pflush #4,#4,(%0)" : : "a" (addr));
>
> > +/*
> > + * Force the uaccess routines to be wired up for actual userspace access,
> > + * overriding any possible set_fs(KERNEL_DS) still lingering around.  Undone
> > + * using force_uaccess_end below.
> > + */
> > +static inline mm_segment_t force_uaccess_begin(void)
> > +{
> > +     mm_segment_t fs = get_fs();
> > +
> > +     set_fs(USER_DS);
> > +     return fs;
> > +}
> > +
> > +static inline void force_uaccess_end(mm_segment_t oldfs)
> > +{
> > +     set_fs(oldfs);
> > +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
