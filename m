Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:27549
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbeKTI4A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Nov 2018 03:56:00 -0500
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 3/5] mips: remove syscall table entries
Date: Mon, 19 Nov 2018 22:29:29 +0000
Message-ID: <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <048540EEEDA7B04DAE7C3A95B96AB90D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Message-ID: <20181119222929.Zw3CoYaYiG7eeCqc6FpXzsUyI4JBcz_Iroy2OuaMXYc@z>

Hi Firoz,

On Thu, Nov 15, 2018 at 11:44:19AM +0530, Firoz Khan wrote:
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o3=
2.S
> index a9b895f..4eee437 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -208,6 +208,18 @@ einval: li	v0, -ENOSYS
>  	jr	ra
>  	END(sys_syscall)
> =20
> +#ifdef CONFIG_MIPS_MT_FPAFF
> +	/*
> +	 * For FPU affinity scheduling on MIPS MT processors, we need to
> +	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> +	 * in kernel/sched/core.c.  Considered only temporary we only support
> +	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> +	 * atm.
> +	 */
> +#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
> +#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity

Is this backwards? ie. should it be:

    #define sys_sched_setaffinity mipsmt_sys_sched_setaffinity
    #define sys_sched_getaffinity mipsmt_sys_sched_getaffinity

?

I don't see how the mipsmt_* functions will ever be used after this
patch.

Thanks,
    Paul

> +#endif /* CONFIG_MIPS_MT_FPAFF */
> +
>  	.align	2
>  	.type	sys_call_table, @object
>  EXPORT(sys_call_table)
> @@ -450,20 +462,8 @@ EXPORT(sys_call_table)
>  	PTR	sys_tkill
>  	PTR	sys_sendfile64
>  	PTR	sys_futex
> -#ifdef CONFIG_MIPS_MT_FPAFF
> -	/*
> -	 * For FPU affinity scheduling on MIPS MT processors, we need to
> -	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> -	 * in kernel/sched/core.c.  Considered only temporary we only support
> -	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> -	 * atm.
> -	 */
> -	PTR	mipsmt_sys_sched_setaffinity
> -	PTR	mipsmt_sys_sched_getaffinity
> -#else
>  	PTR	sys_sched_setaffinity
>  	PTR	sys_sched_getaffinity		/* 4240 */
> -#endif /* CONFIG_MIPS_MT_FPAFF */
>  	PTR	sys_io_setup
>  	PTR	sys_io_destroy
>  	PTR	sys_io_getevents
> --=20
> 1.9.1
>=20
