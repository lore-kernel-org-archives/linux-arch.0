From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Subject: Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
Date: Thu, 16 Jul 2020 13:54:01 +0200
Message-ID: <CANBLGcxme3=+G3tsd_4ckMFPfaECZ1HzsnKy=LybEhyje_9Wdw@mail.gmail.com>
References: <20200716112816.7356-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgGPLyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 07:54:15 -0400
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com, Guo Ren <guoren@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv <linux-riscv@lists.infradead.org>

On Thu, 16 Jul 2020 at 13:28, Will Deacon <will@kernel.org> wrote:
>
> Although mmiowb() is concerned only with serialising MMIO writes occuring
> in contexts where a spinlock is held, the call to mmiowb_set_pending()
> from the MMIO write accessors can occur in preemptible contexts, such
> as during driver probe() functions where ordering between CPUs is not
> usually a concern, assuming that the task migration path provides the
> necessary ordering guarantees.
>
> Unfortunately, the default implementation of mmiowb_set_pending() is not
> preempt-safe, as it makes use of a a per-cpu variable to track its
> internal state. This has been reported to generate the following splat
> on riscv:
>
>  | BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>  | caller is regmap_mmio_write32le+0x1c/0x46
>  | CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
>  | Call Trace:
>  |  walk_stackframe+0x0/0x7a
>  |  dump_stack+0x6e/0x88
>  |  regmap_mmio_write32le+0x18/0x46
>  |  check_preemption_disabled+0xa4/0xaa
>  |  regmap_mmio_write32le+0x18/0x46
>  |  regmap_mmio_write+0x26/0x44
>  |  regmap_write+0x28/0x48
>  |  sifive_gpio_probe+0xc0/0x1da
>
> Although it's possible to fix the driver in this case, other splats have
> been seen from other drivers, including the infamous 8250 UART, and so
> it's better to address this problem in the mmiowb core itself.
>
> Fix mmiowb_set_pending() by using the raw_cpu_ptr() to get at the mmiowb
> state and then only updating the 'mmiowb_pending' field if we are not
> preemptible (i.e. we have a non-zero nesting count).
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Palmer Dabbelt <palmer@dabbelt.com>

Nice. This fixes the problems I saw both in Qemu and on the HiFive Unleashed.

Btw. I was the one who originally stumbled upon this problem and send
the mail to linux-riscv that Palmer CC'ed you on, so I think this
ought to be
Reported-by: Emil Renner Berthing <kernel@esmil.dk>

In any case you can add
Tested-by: Emil Renner Berthing <kernel@esmil.dk>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> I can queue this in the arm64 tree as a fix, as I already have some other
> fixes targetting -rc6.
>
>  include/asm-generic/mmiowb.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> index 9439ff037b2d..5698fca3bf56 100644
> --- a/include/asm-generic/mmiowb.h
> +++ b/include/asm-generic/mmiowb.h
> @@ -27,7 +27,7 @@
>  #include <asm/smp.h>
>
>  DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> -#define __mmiowb_state()       this_cpu_ptr(&__mmiowb_state)
> +#define __mmiowb_state()       raw_cpu_ptr(&__mmiowb_state)
>  #else
>  #define __mmiowb_state()       arch_mmiowb_state()
>  #endif /* arch_mmiowb_state */
> @@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
>  static inline void mmiowb_set_pending(void)
>  {
>         struct mmiowb_state *ms = __mmiowb_state();
> -       ms->mmiowb_pending = ms->nesting_count;
> +
> +       if (likely(ms->nesting_count))
> +               ms->mmiowb_pending = ms->nesting_count;
>  }
>
>  static inline void mmiowb_spin_lock(void)
> --
> 2.27.0.389.gc38d7665816-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
