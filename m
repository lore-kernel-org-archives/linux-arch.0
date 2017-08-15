From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 16/27] arm64/sve: Preserve SVE registers around
 kernel-mode NEON use
Date: Tue, 15 Aug 2017 18:37:19 +0100
Message-ID: <CAKv+Gu_1LdHuSP1fAeiNNc9PbAw8MQBP2tYhWFJ+szv=nQjHvQ@mail.gmail.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-17-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <1502280338-23002-17-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Dave Martin <Dave.Martin@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 9 August 2017 at 13:05, Dave Martin <Dave.Martin@arm.com> wrote:
> Kernel-mode NEON will corrupt the SVE vector registers, due to the
> way they alias the FPSIMD vector registers in the hardware.
>
> This patch ensures that any live SVE register content for the task
> is saved by kernel_neon_begin().  The data will be restored in the
> usual way on return to userspace.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 955c873..b7fb836 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -758,8 +758,10 @@ void kernel_neon_begin(void)
>         __this_cpu_write(kernel_neon_busy, true);
>
>         /* Save unsaved task fpsimd state, if any: */
> -       if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> -               fpsimd_save_state(&current->thread.fpsimd_state);
> +       if (current->mm) {
> +               task_fpsimd_save();
> +               set_thread_flag(TIF_FOREIGN_FPSTATE);
> +       }
>
>         /* Invalidate any task state remaining in the fpsimd regs: */
>         __this_cpu_write(fpsimd_last_state, NULL);

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
