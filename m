Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 14:31:47 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTAW9-1iIGzt0Vvb-00UYVV for <linux-arch@vger.kernel.org>; Wed, 11 Dec
 2019 20:31:46 +0100
Received: by mail-qv1-f44.google.com with SMTP id t7so6248632qve.4
        for <linux-arch@vger.kernel.org>; Wed, 11 Dec 2019 11:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-13-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-13-catalin.marinas@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Dec 2019 20:31:28 +0100
Message-ID: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20191211193128.0jqcHbtgPFhcyF-8Mk5zAkuLowON38b3OyJXauKTIm0@z>

On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Add MTE-specific SIGSEGV codes to siginfo.h.
>
> Note that the for MTE we are reusing the same SPARC ADI codes because
> the two functionalities are similar and they cannot coexist on the same
> system.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  include/uapi/asm-generic/siginfo.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c267181..a5184a5438c6 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -227,8 +227,13 @@ typedef struct siginfo {
>  # define SEGV_PKUERR   4       /* failed protection key checks */
>  #endif
>  #define SEGV_ACCADI    5       /* ADI not enabled for mapped object */
> -#define SEGV_ADIDERR   6       /* Disrupting MCD error */
> -#define SEGV_ADIPERR   7       /* Precise MCD exception */
> +#ifdef __aarch64__
> +# define SEGV_MTEAERR  6       /* Asynchronous MTE error */
> +# define SEGV_MTESERR  7       /* Synchronous MTE exception */
> +#else
> +# define SEGV_ADIDERR  6       /* Disrupting MCD error */
> +# define SEGV_ADIPERR  7       /* Precise MCD exception */
> +#endif

SEGV_ADIPERR/SEGV_ADIDERR were added together with SEGV_ACCADI,
it seems a bit odd to make only two of them conditional but not the others.

I think we are generally working towards having the same constants
across architectures even for features that only exist on one of them.

Adding Al and Eric to Cc, maybe they have another suggestion on what
constants should be used.

     Arnd
