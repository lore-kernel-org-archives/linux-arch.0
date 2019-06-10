Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.codeweavers.com ([50.203.203.244]:60106 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfFJKcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 06:32:00 -0400
Date: Mon, 10 Jun 2019 11:31:52 +0100
From: Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Message-ID: <20190610103151.GD11076@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
 <20190610092751.GA11076@merlot.physics.ox.ac.uk>
 <58cedde2-0d54-7d2d-f519-77cb71f543fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cedde2-0d54-7d2d-f519-77cb71f543fd@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190610103152.zpnsWGShbehvaIBK_ZJdcblcZZtO-h1NNivRkKBsL9c@z>

On Mon, Jun 10, 2019 at 11:17:48AM +0100, Vincenzo Frascino wrote:
> On 10/06/2019 10:27, Huw Davies wrote:
> > On Thu, May 30, 2019 at 03:15:13PM +0100, Vincenzo Frascino wrote:
> >> --- /dev/null
> >> +++ b/include/vdso/datapage.h
> >> @@ -0,0 +1,91 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef __VDSO_DATAPAGE_H
> >> +#define __VDSO_DATAPAGE_H
> >> +
> >> +#ifdef __KERNEL__
> >> +
> >> +#ifndef __ASSEMBLY__
> >> +
> >> +#include <linux/bits.h>
> >> +#include <linux/time.h>
> >> +#include <linux/types.h>
> >> +
> >> +#define VDSO_BASES	(CLOCK_TAI + 1)
> >> +#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
> >> +			 BIT(CLOCK_MONOTONIC)		| \
> >> +			 BIT(CLOCK_BOOTTIME)		| \
> >> +			 BIT(CLOCK_TAI))
> >> +#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
> >> +			 BIT(CLOCK_MONOTONIC_COARSE))
> >> +#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
> >> +
> >> +#define CS_HRES_COARSE	0
> >> +#define CS_RAW		1
> > 
> > CS_HRES_COARSE seems like a confusing name choice to me.  What you
> > really mean is not RAW.
> > 
> > How about CS_ADJ to indicate that its updated by adjtime?
> > CS_XTIME might be another option.
> > 
> 
> I divided the timers in 3 sets (HRES, COARSE, RAW), CS_HRES_COARSE refers to the
> first two and CS_RAW to the third. I will ad a comment to explain the logic in
> the next iteration.

I'm thinking ahead about a possible CLOCK_MONOTONIC_RAW_COARSE (which
would be useful at least for Wine).  In that case you'd have four clock
types non-raw and raw, each with either hres or coarse.

Huw.
