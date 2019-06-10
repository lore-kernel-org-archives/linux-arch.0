From: Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Date: Mon, 10 Jun 2019 10:27:52 +0100
Message-ID: <20190610092751.GA11076@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190530141531.43462-2-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Paul Burton <paul.burton@mips.com>, linux-kselftest@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 30, 2019 at 03:15:13PM +0100, Vincenzo Frascino wrote:
> --- /dev/null
> +++ b/include/vdso/datapage.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_DATAPAGE_H
> +#define __VDSO_DATAPAGE_H
> +
> +#ifdef __KERNEL__
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/bits.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define VDSO_BASES	(CLOCK_TAI + 1)
> +#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
> +			 BIT(CLOCK_MONOTONIC)		| \
> +			 BIT(CLOCK_BOOTTIME)		| \
> +			 BIT(CLOCK_TAI))
> +#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
> +			 BIT(CLOCK_MONOTONIC_COARSE))
> +#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
> +
> +#define CS_HRES_COARSE	0
> +#define CS_RAW		1

CS_HRES_COARSE seems like a confusing name choice to me.  What you
really mean is not RAW.

How about CS_ADJ to indicate that its updated by adjtime?
CS_XTIME might be another option.

Huw.
