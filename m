Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44384 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfBRMuf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 07:50:35 -0500
MIME-Version: 1.0
References: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com>
 <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4> <CAFqt6zYL8q16a0dKvNb_1MpJCuz4VrkT1pKe=eqpywxA-hnL0Q@mail.gmail.com>
In-Reply-To: <CAFqt6zYL8q16a0dKvNb_1MpJCuz4VrkT1pKe=eqpywxA-hnL0Q@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 18 Feb 2019 18:20:20 +0530
Message-ID: <CAFqt6zZZaFU_i+srxk9rd_+5V9FTd767MH-rCocvJPfFcXJsCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: switch over to generic free_initmem()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@lst.de>, rkuo@codeaurora.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-riscv@lists.infradead.org
Message-ID: <20190218125020.SSqT0YZNlK_147cFy7W1riCxTv4804m_9KyEvfOdTMk@z>

On Mon, Feb 18, 2019 at 6:16 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Hi Mike,
>
> On Fri, Feb 15, 2019 at 2:19 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Thu, 14 Feb 2019 07:59:37 PST (-0800), rppt@linux.ibm.com wrote:
> > > The riscv version of free_initmem() differs from the generic one only in
> > > that it sets the freed memory to zero.
> > >
> > > Make ricsv use the generic version and poison the freed memory.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>
> Just for clarity, does same change applicable in below places -
>
> arch/openrisc/mm/init.c#L231
> arch/alpha/mm/init.c#L290
> arch/arc/mm/init.c#L213
> arch/m68k/mm/init.c#L109
> arch/nds32/mm/init.c#L247
> arch/nios2/mm/init.c#L92
> arch/openrisc/mm/init.c#L231

Please ignore this query. just saw the other patches.
Sorry for the noise.
>
>
> > > ---
> > >  arch/riscv/mm/init.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > >
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 658ebf6..2af0010 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -60,11 +60,6 @@ void __init mem_init(void)
> > >       mem_init_print_info(NULL);
> > >  }
> > >
> > > -void free_initmem(void)
> > > -{
> > > -     free_initmem_default(0);
> > > -}
> > > -
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > >  void free_initrd_mem(unsigned long start, unsigned long end)
> > >  {
> >
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> >
> > I'm going to assume this goes in with the rest of the patch set, thanks!
> >
