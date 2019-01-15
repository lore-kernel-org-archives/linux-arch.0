Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfAOO5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2019 09:57:36 -0500
Date: Tue, 15 Jan 2019 15:57:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
In-Reply-To: <20190115135539.24762-2-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com> <20190115135539.24762-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190115145730.PbOEIzujY_0Et-8ilKtZb8awR9v27NbaFlUgtEENh2g@z>

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:

> +/*
> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
> + * clock_id. For high-resolution clocks, this encodes the time
> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
> + * the actual time.
> + *
> + * To be noticed that nsec is left-shifted by vdso_data.shift.

This is only true for highres clocks. For coarse the nsec value is not
shifted.

> + */
> +struct vdso_timestamp {
> +	u64 sec;
> +	u64 nsec;
> +};
> +
> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */
> +struct vdso_data {
> +	u32 seq;		/* Timebase sequence counter */
> +
> +	s32 clock_mode;
> +	u64 cycle_last;		/* Timebase at clocksource init */
> +	u64 mask;		/* Clocksource mask (mono = raw) */

mono = raw? This is broken. The VDSO cannot define time different from the
regular syscall interfaces.

Thanks,

	tglx
