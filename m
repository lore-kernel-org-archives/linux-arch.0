Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45840 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeLNSPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Dec 2018 13:15:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3027678pgc.12
        for <linux-arch@vger.kernel.org>; Fri, 14 Dec 2018 10:15:55 -0800 (PST)
Subject: Re: [PATCH v3 02/24] kernel: Define gettimeofday vdso common code
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-3-vincenzo.frascino@arm.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
Date: Fri, 14 Dec 2018 10:15:53 -0800
MIME-Version: 1.0
In-Reply-To: <20181213165746.56930-3-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181214181553.hh-vdmjC6Vcu-Yu8v7B2e4eQWTetOmq74TCCD_2_ELQ@z>

On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
>
> . . .
> +}
> +
> +#ifdef VDSO_HAS_TIME
> +static notrace time_t __cvdso_time(time_t *time)
> +{
> +	u32 seq;
> +	time_t t;
> +	const struct vdso_data *vd = __arch_get_vdso_data();
> +	struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];

-- Mark
