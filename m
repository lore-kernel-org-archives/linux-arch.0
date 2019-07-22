Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfGVJls (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jul 2019 05:41:48 -0400
Date: Mon, 22 Jul 2019 10:41:41 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: vdso: Cleanup Makefiles
Message-ID: <20190722094140.giv5vivoqm4bzl5t@willie-the-truck>
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
 <20190719101018.1984-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719101018.1984-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, john.stultz@linaro.org, naohiro.aota@wdc.com, yamada.masahiro@socionext.com
Message-ID: <20190722094141.EEnYFAqM8vMdL9N1UwhY7cIy4oCRgqMoVr_Dy2NfkHE@z>

On Fri, Jul 19, 2019 at 11:10:18AM +0100, Vincenzo Frascino wrote:
> The recent changes to the vdso library for arm64 and the introduction of
> the compat vdso library have generated some misalignment in the
> Makefiles.
> 
> Cleanup the Makefiles for vdso and vdso32 libraries:
>   * Removing unused rules.
>   * Unifying the displayed compilation messages.
>   * Simplifying the generic library inclusion path for
>     arm64 vdso.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/vdso/Makefile   |  9 +++------
>  arch/arm64/kernel/vdso32/Makefile | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)

Thanks, I'll queue this for -rc2.

Will
