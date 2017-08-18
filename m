Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36748 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdHRMCj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 08:02:39 -0400
Received: by mail-wr0-f178.google.com with SMTP id f8so25011991wrf.3
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 05:02:38 -0700 (PDT)
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com> <1502280338-23002-4-git-send-email-Dave.Martin@arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 03/27] arm64: efi: Add missing Kconfig dependency on KERNEL_MODE_NEON
In-reply-to: <1502280338-23002-4-git-send-email-Dave.Martin@arm.com>
Date: Fri, 18 Aug 2017 13:02:36 +0100
Message-ID: <87o9rdhyn7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu
Message-ID: <20170818120236.KN-tJLj03dP_bEhF489mut2sMU_LHqRhWs_D8E4jJAU@z>


Dave Martin <Dave.Martin@arm.com> writes:

> The EFI runtime services ABI permits calls to EFI to clobber
> certain FPSIMD/NEON registers, as per the AArch64 procedure call
> standard.
>
> Saving/restoring the clobbered registers around such calls needs
> KERNEL_MODE_NEON, but the dependency is missing from Kconfig.
>
> This patch adds the missing dependency.
>
> This will aid bisection of the patches implementing support for the
> ARM Scalable Vector Extension (SVE).
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index dfd9086..fdc302e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1050,6 +1050,7 @@ config EFI_STUB
>  config EFI
>  	bool "UEFI runtime support"
>  	depends on OF && !CPU_BIG_ENDIAN
> +	depends on KERNEL_MODE_NEON
>  	select LIBFDT
>  	select UCS2_STRING
>  	select EFI_PARAMS_FROM_FDT


--
Alex Bennée
