Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60334 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBWRjt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2019 12:39:49 -0500
Date: Sat, 23 Feb 2019 18:39:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 00/23] Unify vDSOs across more architectures
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231835110.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190223173945.fgFNuXDeKDvAb74pCu2d6t_VKcu9jyS-NddG0rqklC8@z>

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
> This implementation contains the following design choices:
>  * Every architecture defines the arch specific code in an header in
>    "asm/vdso/".
>  * The generic implementation includes the arch specific one and lives
>    in "lib/vdso".
>  * The arch specific code for gettimeofday lives in
>    "<arch path>/vdso/gettimeofday.c" and includes the generic code only.
>  * This approach allows to consolidate the common code in a single place
>    with the benefit of avoiding code duplication.

This is moving into the right direction. Good job!

Thanks,

	tglx
