Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.codeweavers.com ([50.203.203.244]:57636 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfFJJew (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 05:34:52 -0400
Date: Mon, 10 Jun 2019 10:34:47 +0100
From: Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
Message-ID: <20190610093447.GC11076@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530141531.43462-4-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190610093447.EATdCwVQey0gP21Flpkddl2raJapRs0aPT1PZrIVREg@z>

On Thu, May 30, 2019 at 03:15:15PM +0100, Vincenzo Frascino wrote:
> With the definition of the unified vDSO library the implementations of
> update_vsyscall and update_vsyscall_tz became quite similar across
> architectures.
> 
> Define a unified implementation of this two functions in kernel/vdso and

... of these two functions ...

> provide the bindings that can be implemented by every architecture that
> takes advantage of the unified vDSO library.
