From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Date: Wed, 4 Dec 2019 13:32:58 +0100
Message-ID: <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
References: <20190219103148.192029670@infradead.org> <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com> <20191204104733.GR2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204104733.GR2844@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-arch.vger.kernel.org

Hoi Peter,

On Wed, Dec 4, 2019 at 11:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > Generic mmu_gather provides everything SH needs (range tracking and
> > > cache coherency).
> > >
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Nick Piggin <npiggin@gmail.com>
> > > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > Cc: Rich Felker <dalias@libc.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > I got remote access to an SH7722-based Migo-R again, which spews a long
> > sequence of BUGs during userspace startup.  I've bisected this to commit
> > c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
>
> Whoopsy.. also, is this really the first time anybody booted an SH
> kernel in over a year ?!?

Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.

> > Do you have a clue?
>
> Does the below help?

Unfortunately not.

> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index 22d968bfe9bb..73a2c00de6c5 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -36,9 +36,8 @@ do {                                                  \
>  #if CONFIG_PGTABLE_LEVELS > 2
>  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
>  do {                                                   \
> -       struct page *page = virt_to_page(pmdp);         \
> -       pgtable_pmd_page_dtor(page);                    \
> -       tlb_remove_page((tlb), page);                   \
> +       pgtable_pmd_page_dtor(pmdp);                    \

expected ‘struct page *’ but argument is of type ‘pmd_t * {aka struct
<anonymous> *}’

> +       tlb_remove_page((tlb), (pmdp));                 \

likewise

>  } while (0);
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
