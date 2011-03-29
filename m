From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: Re: MACH_TYPE undeclared error
Date: Tue, 29 Mar 2011 14:01:10 +0530
Message-ID: <AANLkTimsNOmK4H8MYMB2jjd+zkT4qcYD1dy+J1fxdd7w@mail.gmail.com>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
	<20110329065457.GG30938@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50627 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1C2IbL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2011 04:31:11 -0400
Received: by qyk7 with SMTP id 7so1786366qyk.19
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2011 01:31:10 -0700 (PDT)
In-Reply-To: <20110329065457.GG30938@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Uwe,

2011/3/29 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
>> Dear All,
>>
>> I have defined a MACHINE_START macro in my board C file as follows.
>>
>> MACHINE_START(S3C2510, "S3C2510")
>> =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D s3c2510_init_irq,
>> =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &s3c2510_time_init,
>> MACHINE_END
>>
>> When I try to compile this C file, I am seeing the following error m=
essage.
>>
>> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
>> undeclared here (not in a function)
> you need a line defining S3C2510 in arch/arm/tools/mach-types.

Yeah. It is there in the arch/arm/tools/mach-types file. I did not add
to it, but it is automatically generated. The few lines from the
arch/arm/tools/mach-types file are as follows.

izarus		MACH_IZARUS		IZARUS		573
pxa_rts		MACH_RTS		RTS			574
se5100		MACH_SE5100		SE5100		575
s3c2510		MACH_S3C2510	S3C2510		576
csb437tl		MACH_CSB437TL	CSB437TL		577
slauson		MACH_SLAUSON	SLAUSON		578
pearlriver		MACH_PEARLRIVER	PEARLRIVER	579
tdc_p210		MACH_TDC_P210	TDC_P210	580

The machine S3C2510 is there in that file.

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
