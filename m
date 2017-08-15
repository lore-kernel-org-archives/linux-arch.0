Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34051 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbdHORhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2017 13:37:20 -0400
Received: by mail-io0-f171.google.com with SMTP id o9so5612848iod.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Aug 2017 10:37:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502280338-23002-17-git-send-email-Dave.Martin@arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com> <1502280338-23002-17-git-send-email-Dave.Martin@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 15 Aug 2017 18:37:19 +0100
Message-ID: <CAKv+Gu_1LdHuSP1fAeiNNc9PbAw8MQBP2tYhWFJ+szv=nQjHvQ@mail.gmail.com>
Subject: Re: [PATCH 16/27] arm64/sve: Preserve SVE registers around
 kernel-mode NEON use
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, libc-alpha@sourceware.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20170815173719.JzN36LLPhJxf0mcLyISNkvMhvjx70aCyjFTy1Ewp1tQ@z>

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
