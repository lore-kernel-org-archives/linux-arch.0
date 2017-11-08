From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 12/30] arm64/sve: Low-level CPU setup
Date: Wed, 08 Nov 2017 16:37:51 +0000
Message-ID: <87efp8rajk.fsf@linaro.org>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com> <1509465082-30427-13-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:54427 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdKHQhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 11:37:53 -0500
Received: by mail-wr0-f194.google.com with SMTP id l22so2971122wrc.11
        for <linux-arch@vger.kernel.org>; Wed, 08 Nov 2017 08:37:53 -0800 (PST)
In-reply-to: <1509465082-30427-13-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org


Dave Martin <Dave.Martin@arm.com> writes:

> To enable the kernel to use SVE, SVE traps from EL1 to EL2 must be
> disabled.  To take maximum advantage of the hardware, the full
> available vector length also needs to be enabled for EL1 by
> programming ZCR_EL2.LEN.  (The kernel will program ZCR_EL1.LEN as
> required, but this cannot override the limit set by ZCR_EL2.)
>
> This patch makes the appropriate changes to the EL2 early setup
> code.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
>
> **Dropped at v3** Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> (Due to significant changes to the logic.)

Have it back:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  arch/arm64/kernel/head.S | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cfa90a4..67e86a0 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -524,8 +524,19 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and =
E0E on LE systems
>  	mov	x0, #0x33ff
>  	msr	cptr_el2, x0			// Disable copro. traps to EL2
>
> +	/* SVE register access */
> +	mrs	x1, id_aa64pfr0_el1
> +	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
> +	cbz	x1, 7f
> +
> +	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
> +	msr	cptr_el2, x0			// Disable copro. traps to EL2
> +	isb
> +	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
> +	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
> +
>  	/* Hypervisor stub */
> -	adr_l	x0, __hyp_stub_vectors
> +7:	adr_l	x0, __hyp_stub_vectors
>  	msr	vbar_el2, x0
>
>  	/* spsr */
