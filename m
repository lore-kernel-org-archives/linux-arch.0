Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36152 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3JsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Nov 2018 04:48:10 -0500
Date: Thu, 29 Nov 2018 23:41:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 04/28] kernel: Add masks support for Raw and NTP
 time
In-Reply-To: <20181129170530.37789-5-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com> <20181129170530.37789-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181129224103.lnEPwAxEd4mSJJMxMx1aphHrXEdL1RJKLCeb9Z_h6kc@z>

On Thu, 29 Nov 2018, Vincenzo Frascino wrote:

> Depending on the clocksource selected there can be supported a
> different resolution hence we require a mask to be applied to the
> time calculation.
> 
> This patch exposes the mask in the datapage for Raw and NTP adjusted
> clock.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/vdso/datapage.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index d50a108afaed..0a7bdccf5773 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -34,6 +34,8 @@ struct vdso_data {
>  	__u64 wtm_clock_nsec;
>  	__u64 btm_nsec;		/* Monotonic to boot time */
>  	__u64 tai_sec;		/* International Atomic Time */
> +	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
> +	__u64 cs_raw_mask;	/* Raw clocksource mask */

And why would they be different? The core timekeeper has them duplicated
purely for access pattern optimization and simplicity.

Thanks,

	tglx
