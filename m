Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41081 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfG2Qe0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 12:34:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so59213134ljg.8
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 09:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
 <20190729125421.32482-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190729125421.32482-1-vincenzo.frascino@arm.com>
From: Matteo Croce <mcroce@redhat.com>
Date: Mon, 29 Jul 2019 18:33:48 +0200
Message-ID: <CAGnkfhw+=+50P=uaWsjZrtt_BuwJjXKZ_DSTjuJ8mzW4_kbu-w@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: Fix Makefile regression
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, sthotton@marvell.com, andre.przywara@arm.com, Andy Lutomirski <luto@kernel.org>
Message-ID: <20190729163348.wSDfCuHiKtTetMtbRVBDGEC7Nqw5aR0ycE_6wdWP_gA@z>

On Mon, Jul 29, 2019 at 2:54 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Using an old .config in combination with "make oldconfig" can cause
> an incorrect detection of the compat compiler:
>
> $ grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
>
> $ make oldconfig && make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
> Stop.
>
> Accordingly to the section 7.2 of the GNU Make manual "Syntax of
> Conditionals", "When the value results from complex expansions of
> variables and functions, expansions you would consider empty may
> actually contain whitespace characters and thus are not seen as
> empty. However, you can use the strip function to avoid interpreting
> whitespace as a non-empty value."
>
> Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
> evaluation.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Matteo Croce <mcroce@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index bb1f1dbb34e8..61de992bbea3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>
>    ifeq ($(CONFIG_CC_IS_CLANG), y)
>      $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(CROSS_COMPILE_COMPAT),)
> +  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
>      $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>    else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>      $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
> --
> 2.22.0
>

Tested-by: Matteo Croce <mcroce@redhat.com>

-- 
Matteo Croce
per aspera ad upstream
