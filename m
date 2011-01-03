From: "Guan Xuetao" <guanxuetao@mprc.pku.edu.cn>
Subject: RE: [PATCHv1 09/12] unicore32 core architecture: timer and time
Date: Mon, 3 Jan 2011 13:52:26 +0800
Message-ID: <00ef01cbab0a$66bfce60$343f6b20$@mprc.pku.edu.cn>
References: <00d601cba465$27154a70$753fdf50$@mprc.pku.edu.cn> <AANLkTinjzzMz4WFRYmjZiM=P6c1wtSxpY2bzOuUe0Vrd@mail.gmail.com> <008f01cbaa62$2001fff0$6005ffd0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:50920 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1ACFwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2011 00:52:47 -0500
In-Reply-To: <008f01cbaa62$2001fff0$6005ffd0$@mprc.pku.edu.cn>
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'john stultz' <johnstul@us.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-arch-owner@vger.kernel.org [mailto:linux-arch-owner@vger.=
kernel.org] On Behalf Of Guan Xuetao
> Sent: Sunday, January 02, 2011 5:48 PM
> To: 'john stultz'
> Cc: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCHv1 09/12] unicore32 core architecture: timer and t=
ime
>=20
>=20
>=20
> > -----Original Message-----
> > From: johnstul.lkml@gmail.com [mailto:johnstul.lkml@gmail.com] On B=
ehalf Of john stultz
> > Sent: Tuesday, December 28, 2010 5:27 AM
> > To: Guan Xuetao
> > Cc: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCHv1 09/12] unicore32 core architecture: timer and=
 time
> >
> > 2010/12/25 Guan Xuetao <guanxuetao@mprc.pku.edu.cn>:
> > > From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> > >
> > > Patch 9 implements timer and time. RTC and PWM device drivers are=
 also here.
> > >
> > > Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> >
> > Just a small request:
> >
> > > +static struct clocksource cksrc_puv3_oscr =3D {
> > > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "oscr",
> > > + =A0 =A0 =A0 .rating =A0 =A0 =A0 =A0 =3D 200,
> > > + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D puv3_read_oscr,
> > > + =A0 =A0 =A0 .mask =A0 =A0 =A0 =A0 =A0 =3D CLOCKSOURCE_MASK(32),
> > > + =A0 =A0 =A0 .shift =A0 =A0 =A0 =A0 =A0=3D 18,
> >
> > Drop the shift assignment here.
> >
> > > + =A0 =A0 =A0 cksrc_puv3_oscr.mult =3D
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocksource_hz2mult(CLOCK_TICK_RATE=
, cksrc_puv3_oscr.shift);
> > > +
> > Drop the mult assignment here.
> >
> >
> > > + =A0 =A0 =A0 clocksource_register(&cksrc_puv3_oscr);
> >
> > Use "clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE );" =
and
> > the kernel will fill in mult/shift appropriately.
> >
> > If you have any troubles after doing so, let me know.
>=20
> When using clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE =
),
>  the shift value become 0, and mult value become 0x838a91a7, and the =
system will be broken
> after printing "Switching to clocksource oscr".
>=20
> When using clocksource_register_khz(&cksrc_puv3_oscr, CLOCK_TICK_RATE=
 ),
> the shift value become 0, and mult value become  0x4359611, and the s=
ystem will run smoothly,
> but timer interrupt seems too frequently. Perhaps it is 4 times faste=
r.
>=20
> For comparison, originally, when shift value is set to 0x12, the mult=
 value become 1175e5e.
>=20

The error is the implementation of do_div() function.
When replacing the arch-specific div64.h with asm-generic/div64.h, cloc=
ksource_rigister_hz() works.
Thanks.

> Which one is better?
>=20
> >
> > thanks
> > -john
>=20
> Thanks john.
>=20
> Guan Xuetao
>=20

Guan Xuetao
