Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37124 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbeHAJ0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 05:26:36 -0400
MIME-Version: 1.0
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
In-Reply-To: <20180731051519.101249-1-ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Aug 2018 09:42:02 +0200
Message-ID: <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Rob Landley <rob@landley.net>, Matthew Wilcox <willy@infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Sato-san,

CC Rob , Willy, linux-arch

On Tue, Jul 31, 2018 at 7:15 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> pgd_cache specifies __GFP_ZERO when allocating.
> This constructor is meaningless.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/arch/sh/mm/pgtable.c
> +++ b/arch/sh/mm/pgtable.c
> @@ -9,20 +9,11 @@ static struct kmem_cache *pgd_cachep;
>  static struct kmem_cache *pmd_cachep;
>  #endif
>
> -void pgd_ctor(void *x)
> -{
> -       pgd_t *pgd = x;
> -
> -       memcpy(pgd + USER_PTRS_PER_PGD,
> -              swapper_pg_dir + USER_PTRS_PER_PGD,
> -              (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> -}
> -
>  void pgtable_cache_init(void)
>  {
>         pgd_cachep = kmem_cache_create("pgd_cache",
>                                        PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
> -                                      PAGE_SIZE, SLAB_PANIC, pgd_ctor);
> +                                      PAGE_SIZE, SLAB_PANIC, NULL);
>  #if PAGETABLE_LEVELS > 2
>         pmd_cachep = kmem_cache_create("pmd_cache",
>                                        PTRS_PER_PMD * (1<<PTE_MAGNITUDE),

While I can confirm your patch fixes the

    WARNING: CPU: 0 PID: 1 at mm/slub.c:2412
___slab_alloc.constprop.34+0x196/0x288

seen since commit 128227e7fe4087b6 ("slab: __GFP_ZERO is incompatible
with a constructor"), I'm not 100% sure this is the correct fix.

swapper_pg_dir[] does have two non-zero entries (768 and 895), which were
copied by the constructor.  Perhaps SH does have a need for these two
entries, and thus for the constructor?

Unfortunately I'm too SH-illiterate to answer this myself.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
