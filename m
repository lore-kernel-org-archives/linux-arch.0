From: Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH V2 2/4] riscv: Rename __switch_to_aux -> fpu
Date: Thu, 23 Jan 2020 11:14:46 +0530
Message-ID: <CAAhSdy3pe4NNS4Gv3dxfe36mMQAB4wis3+wN2OzBmVF7BehK=A@mail.gmail.com>
References: <20200116143029.31441-1-guoren@kernel.org> <20200116143029.31441-2-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAWFpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 00:45:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so1625721wrl.13
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2020 21:44:58 -0800 (PST)
In-Reply-To: <20200116143029.31441-2-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <Anup.Patel@wdc.com>, Vincent Chen <vincent.chen@sifive.com>, Zong Li <zong.li@sifive.com>, Greentime Hu <greentime.hu@sifive.com>, Bin Meng <bmeng.cn@gmail.com>, Atish Patra <atish.patra@wdc.com>, Andreas Schwab <schwab@linux-m68k.org>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, Guo Ren <ren_guo@c-sky.com>

On Thu, Jan 16, 2020 at 8:01 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> The name of __switch_to_aux is not clear and rename it with the
> determine function: __switch_to_fpu. Next we could add other regs'
> switch.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Anup Patel <Anup.Patel@wdc.com>
> ---
>  arch/riscv/include/asm/switch_to.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 407bcc96a710..b9234e7178d0 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -44,7 +44,7 @@ static inline void fstate_restore(struct task_struct *task,
>         }
>  }
>
> -static inline void __switch_to_aux(struct task_struct *prev,
> +static inline void __switch_to_fpu(struct task_struct *prev,
>                                    struct task_struct *next)
>  {
>         struct pt_regs *regs;
> @@ -60,7 +60,7 @@ extern bool has_fpu;
>  #define has_fpu false
>  #define fstate_save(task, regs) do { } while (0)
>  #define fstate_restore(task, regs) do { } while (0)
> -#define __switch_to_aux(__prev, __next) do { } while (0)
> +#define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
>
>  extern struct task_struct *__switch_to(struct task_struct *,
> @@ -71,7 +71,7 @@ do {                                                  \
>         struct task_struct *__prev = (prev);            \
>         struct task_struct *__next = (next);            \
>         if (has_fpu)                                    \
> -               __switch_to_aux(__prev, __next);        \
> +               __switch_to_fpu(__prev, __next);        \
>         ((last) = __switch_to(__prev, __next));         \
>  } while (0)
>
> --
> 2.17.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
