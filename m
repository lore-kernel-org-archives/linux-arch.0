Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:51050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfFXN4a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 09:56:30 -0400
Date: Mon, 24 Jun 2019 14:56:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 01/25] kernel: Standardize vdso_datapage
Message-ID: <20190624135624.GB29120@arrakis.emea.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-2-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>
Message-ID: <20190624135624.maYTJo5_uPSu-Qty34aq79cR7AzOg4QulZB1fgx43I8@z>

On Fri, Jun 21, 2019 at 10:52:28AM +0100, Vincenzo Frascino wrote:
> In an effort to unify the common code for managing the vdso library in
> between all the architectures that support it, this patch tries to
> provide a common format for the vdso datapage.
> 
> As a result of this, this patch generalized the data structures in vgtod.h
> from x86 private includes to general includes (include/vdso).
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Tested-by: Shijith Thotton <sthotton@marvell.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>

Minor clean-up patch (on top of the tip timers/vdso branch):

------------8<------------------------------
