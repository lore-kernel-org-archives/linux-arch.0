Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46912 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdINKwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2017 06:52:25 -0400
Received: by mail-wr0-f173.google.com with SMTP id o42so5508536wrb.3
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2017 03:52:24 -0700 (PDT)
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com> <1504198860-12951-18-git-send-email-Dave.Martin@arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 17/28] arm64/sve: Preserve SVE registers around kernel-mode NEON use
In-reply-to: <1504198860-12951-18-git-send-email-Dave.Martin@arm.com>
Date: Thu, 14 Sep 2017 11:52:22 +0100
Message-ID: <87efr9a6xl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20170914105222.96CwNKLHLYO0afN_tTzZ6kyPOjDNOM2PReR_LTsD50c@z>


Dave Martin <Dave.Martin@arm.com> writes:

> Kernel-mode NEON will corrupt the SVE vector registers, due to the
> way they alias the FPSIMD vector registers in the hardware.
>
> This patch ensures that any live SVE register content for the task
> is saved by kernel_neon_begin().  The data will be restored in the
> usual way on return to userspace.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  arch/arm64/kernel/fpsimd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index cea05a7..dd89acf 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -744,8 +744,10 @@ void kernel_neon_begin(void)
>  	__this_cpu_write(kernel_neon_busy, true);
>
>  	/* Save unsaved task fpsimd state, if any: */
> -	if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> -		fpsimd_save_state(&current->thread.fpsimd_state);
> +	if (current->mm) {
> +		task_fpsimd_save();
> +		set_thread_flag(TIF_FOREIGN_FPSTATE);
> +	}
>
>  	/* Invalidate any task state remaining in the fpsimd regs: */
>  	__this_cpu_write(fpsimd_last_state, NULL);


--
Alex Bennée
