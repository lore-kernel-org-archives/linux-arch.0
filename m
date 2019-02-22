Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfBVM6T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:58:19 -0500
Date: Fri, 22 Feb 2019 12:58:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
Message-ID: <20190222125812.GF42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-2-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222125813.kw28OzTNswBp7Btry9FtBwLHU7oFF1EOrCE2cxJ6bNA@z>

Hi Vincenzo,

On Fri, Feb 22, 2019 at 12:24:08PM +0000, Vincenzo Frascino wrote:
> +#ifdef __KERNEL__

I believe that __KERNEL__ guards haven't been necessary (in non-UAPI
headers) since the UAPI split, and can be removed.

[...]

> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/time.h>

Nit: could we please keep these in alphabetical order?

> +/*
> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
> + * clock_id. For high-resolution clocks, this encodes the time
> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
> + * the actual time.
> + *
> + * To be noticed that for highres clocks nsec is left-shifted by
> + * vdso_data.cs[x].shift.

Nit: this would read better as:

	Note that for highres clocks nsec is left-shifted by
	vdso_data.cs[x].shift.

[...]

> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */

Perhaps:

/*
 * This structure will be accessed by native and compat vDSOs, so we
 * need to ensure the layout is identical for native and compat code.
 */

... which I think is what you're trrying to say?

Thanks,
Mark.
