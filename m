From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
Date: Thu, 16 Jul 2020 12:00:01 -0700 (PDT)
Message-ID: <mhng-6528b0ae-d92c-41b2-b0fd-3be58c80f280@palmerdabbelt-glaptop1>
References: <20200716112816.7356-1-will@kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, will@kernel.org, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, guoren@kernel.org, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

On Thu, 16 Jul 2020 04:28:16 PDT (-0700), will@kernel.org wrote:
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
> -#define __mmiowb_state()	this_cpu_ptr(&__mmiowb_state)
> +#define __mmiowb_state()	raw_cpu_ptr(&__mmiowb_state)
>  #else
>  #define __mmiowb_state()	arch_mmiowb_state()
>  #endif	/* arch_mmiowb_state */
> @@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
>  static inline void mmiowb_set_pending(void)
>  {
>  	struct mmiowb_state *ms = __mmiowb_state();
> -	ms->mmiowb_pending = ms->nesting_count;
> +
> +	if (likely(ms->nesting_count))
> +		ms->mmiowb_pending = ms->nesting_count;
>  }
>
>  static inline void mmiowb_spin_lock(void)

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

The arm64 tree works for me.

Thanks!
