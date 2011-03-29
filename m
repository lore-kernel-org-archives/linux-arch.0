From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: Re: MACH_TYPE undeclared error
Date: Tue, 29 Mar 2011 15:08:10 +0530
Message-ID: <AANLkTi=Aha4R_tCdMC8ucp76yh3MD1ORayik7WmgfEiX@mail.gmail.com>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
	<20110329065457.GG30938@pengutronix.de>
	<AANLkTimsNOmK4H8MYMB2jjd+zkT4qcYD1dy+J1fxdd7w@mail.gmail.com>
	<20110329092421.GJ30938@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42079 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab1C2JiM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2011 05:38:12 -0400
Received: by qyg14 with SMTP id 14so2845296qyg.19
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2011 02:38:11 -0700 (PDT)
In-Reply-To: <20110329092421.GJ30938@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Uwe,

2011/3/29 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, Mar 29, 2011 at 02:01:10PM +0530, Madhavi Manchala wrote:
>> 2011/3/29 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>> > On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
>> >> I have defined a MACHINE_START macro in my board C file as follow=
s.
>> >>
>> >> MACHINE_START(S3C2510, "S3C2510")
>> >> =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D s3c2510_init_irq,
>> >> =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &s3c2510_time_init,
>> >> MACHINE_END
>> >>
>> >> When I try to compile this C file, I am seeing the following erro=
r message.
>> >>
>> >> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
>> >> undeclared here (not in a function)
>> > you need a line defining S3C2510 in arch/arm/tools/mach-types.
>>
>> Yeah. It is there in the arch/arm/tools/mach-types file. I did not a=
dd
>> to it, but it is automatically generated. The few lines from the
>> arch/arm/tools/mach-types file are as follows.
>>
>> izarus =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MACH_IZARUS =A0 =A0 =A0 =A0 =A0=
 =A0 IZARUS =A0 =A0 =A0 =A0 =A0573
>> pxa_rts =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_RTS =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0RTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 574
>> se5100 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MACH_SE5100 =A0 =A0 =A0 =A0 =A0=
 =A0 SE5100 =A0 =A0 =A0 =A0 =A0575
>> s3c2510 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_S3C2510 =A0 =A0S3C2510 =A0 =
=A0 =A0 =A0 576
>> csb437tl =A0 =A0 =A0 =A0 =A0 =A0 =A0MACH_CSB437TL =A0 CSB437TL =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0577
>> slauson =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_SLAUSON =A0 =A0SLAUSON =A0 =
=A0 =A0 =A0 578
>> pearlriver =A0 =A0 =A0 =A0 =A0 =A0MACH_PEARLRIVER PEARLRIVER =A0 =A0=
 =A0579
>> tdc_p210 =A0 =A0 =A0 =A0 =A0 =A0 =A0MACH_TDC_P210 =A0 TDC_P210 =A0 =A0=
 =A0 =A0580
>>
>> The machine S3C2510 is there in that file.
> Do you have
>
> =A0 =A0 =A0 =A0#include <asm/mach-types.h>
>
> in your machine file?

It is not included in my machine file, previously. Now I included it
in my machine file and I am able to compile the file without any
issues.

Thanks for your valuable information.

Thanks and Regards,
Madhavi M.

> Best regards
> Uwe
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Uwe Kleine-K=F6nig =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
