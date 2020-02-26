From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v2 09/19] arm64: mte: Add specific SIGSEGV codes
Date: Wed, 26 Feb 2020 13:05:52 -0600
Message-ID: <874kvdxj73.fsf@x220.int.ebiederm.org>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
        <20200226180526.3272848-10-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:48534 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 14:07:59 -0500
In-Reply-To: <20200226180526.3272848-10-catalin.marinas@arm.com> (Catalin
        Marinas's message of "Wed, 26 Feb 2020 18:05:16 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Catalin Marinas <catalin.marinas@arm.com> writes:

> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Add MTE-specific SIGSEGV codes to siginfo.h.
>
> Note that the for MTE we are reusing the same SPARC ADI codes because
> the two functionalities are similar and they cannot coexist on the same
> system.

Any chance you can move the v2 notes up into the description or
otherwise fix it.  The description talks about reusing the ADI codes
which is no longer happening.

Otherwise the patch looks good.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
> [catalin.marinas@arm.com: dropped #ifdef __aarch64__, renumbered]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>
> Notes:
>     v2:
>     - Dropped the #ifdef __aarch64__.
>     - Renumbered the SEGV_MTE* values to avoid clash with ADI.
>
>  include/uapi/asm-generic/siginfo.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c267181..7aacf9389010 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -229,7 +229,9 @@ typedef struct siginfo {
>  #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
>  #define SEGV_ADIDERR	6	/* Disrupting MCD error */
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
> -#define NSIGSEGV	7
> +#define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
> +#define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> +#define NSIGSEGV	9
>  
>  /*
>   * SIGBUS si_codes
