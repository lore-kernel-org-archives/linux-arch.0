Return-Path: <SRS0=cGiU=22=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEJBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 04:01:46 -0500
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <87o8viwb44.fsf@hase.home>
In-Reply-To: <87o8viwb44.fsf@hase.home>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 5 Jan 2020 17:01:31 +0800
Message-ID: <CAJF2gTREKZ7FwQtyG+3YJ-Ne2BiyyWNhy4dgjVt0Y_qyy79p-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com, aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>, vincent.chen@sifive.com, zong.li@sifive.com, greentime.hu@sifive.com, Bin Meng <bmeng.cn@gmail.com>, Atish Patra <atish.patra@wdc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20200105090131.xFHdns4xz92BXm_R9KlrVLHwhq_bsgTaY7cbIm7YxvU@z>

Oops, thx. :)

On Sun, Jan 5, 2020 at 4:39 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jan 05 2020, guoren@kernel.org wrote:
>
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d8efbaa78d67..3d336f869ffe 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -286,6 +286,15 @@ config FPU
> >
> >         If you don't know what to do here, say Y.
> >
> > +config VECTOR
> > +     bool "VECTOR support"
> > +     default n
>
> default n is the default.  Did you mean default y?
>
> > +     help
> > +       Say N here if you want to disable all vecotr related procedure
>
> s/vecotr/vector/
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
