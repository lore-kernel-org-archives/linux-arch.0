From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Date: Mon, 13 Jul 2020 18:06:42 +0800
Message-ID: <CAEbi=3fk9u9n5vcENFuSMkob81+hg2r2dd0oN2FfaqLg0eosSw@mail.gmail.com>
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMKHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 06:07:20 -0400
In-Reply-To: <20200710135706.537715-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Christoph Hellwig <hch@lst.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=8810=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add helpers to wraper the get_fs/set_fs magic for undoing any damange
> done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/sdei.c         |  2 +-
>  arch/m68k/include/asm/tlbflush.h | 12 ++++++------
>  arch/mips/kernel/unaligned.c     | 27 +++++++++++++--------------
>  arch/nds32/mm/alignment.c        |  7 +++----
>  arch/sh/kernel/traps_32.c        | 18 ++++++++----------
>  drivers/firmware/arm_sdei.c      |  5 ++---
>  include/linux/uaccess.h          | 18 ++++++++++++++++++
>  kernel/events/callchain.c        |  5 ++---
>  kernel/events/core.c             |  5 ++---
>  kernel/kthread.c                 |  5 ++---
>  kernel/stacktrace.c              |  5 ++---
>  mm/maccess.c                     | 22 ++++++++++------------
>  12 files changed, 69 insertions(+), 62 deletions(-)
>
[...]
> diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
> index c8b9061a2ee3d5..1eb7ded6992b57 100644
> --- a/arch/nds32/mm/alignment.c
> +++ b/arch/nds32/mm/alignment.c
> @@ -512,7 +512,7 @@ int do_unaligned_access(unsigned long addr, struct pt=
_regs *regs)
>  {
>         unsigned long inst;
>         int ret =3D -EFAULT;
> -       mm_segment_t seg =3D get_fs();
> +       mm_segment_t seg;
>
>         inst =3D get_inst(regs->ipc);
>
> @@ -520,13 +520,12 @@ int do_unaligned_access(unsigned long addr, struct =
pt_regs *regs)
>               "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n", a=
ddr,
>               regs->ipc, inst);
>
> -       set_fs(USER_DS);
> -
> +       seg =3D force_uaccess_begin();
>         if (inst & NDS32_16BIT_INSTRUCTION)
>                 ret =3D do_16((inst >> 16) & 0xffff, regs);
>         else
>                 ret =3D do_32(inst, regs);
> -       set_fs(seg);
> +       force_uaccess_end(seg);
>
>         return ret;
>  }

Hi Christoph, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
