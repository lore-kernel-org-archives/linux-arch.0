From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 2/6] nds32: use uaccess_kernel in show_regs
Date: Mon, 13 Jul 2020 18:02:44 +0800
Message-ID: <CAEbi=3dKwDQ5-wdxQagX2n5Z3tYeYwTcmDNqxPH=83Dy-VKA1w@mail.gmail.com>
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgGMKDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 06:03:22 -0400
In-Reply-To: <20200710135706.537715-3-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Christoph Hellwig <hch@lst.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=8810=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use the uaccess_kernel helper instead of duplicating it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
> index 9712fd474f2ca3..f06265949ec28b 100644
> --- a/arch/nds32/kernel/process.c
> +++ b/arch/nds32/kernel/process.c
> @@ -121,7 +121,7 @@ void show_regs(struct pt_regs *regs)
>                 regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->ure=
gs[0]);
>         pr_info("  IRQs o%s  Segment %s\n",
>                 interrupts_enabled(regs) ? "n" : "ff",
> -               segment_eq(get_fs(), KERNEL_DS)? "kernel" : "user");
> +               uaccess_kernel() ? "kernel" : "user");
>  }
>
>  EXPORT_SYMBOL(show_regs);

Hi Christoph, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
