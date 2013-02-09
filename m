From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH] arm: Preserve TPIDRURW on context switch
Date: Sat, 09 Feb 2013 17:44:21 +0100
Message-ID: <51167CE5.6060303@dawncrow.de>
References: <5112DC7E.4020108@dawncrow.de> <20130206225150.GL17833@n2100.arm.linux.org.uk> <5112E0C3.1080706@dawncrow.de> <20130208154809.GF3495@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56035 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760762Ab3BIQoa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 11:44:30 -0500
In-Reply-To: <20130208154809.GF3495@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>

Am 08.02.2013 16:48, schrieb Will Deacon:
> On Wed, Feb 06, 2013 at 11:01:23PM +0000, Andr=E9 Hentschel wrote:
>> Am 06.02.2013 23:51, schrieb Russell King - ARM Linux:
>>> On Wed, Feb 06, 2013 at 11:43:10PM +0100, Andr=E9 Hentschel wrote:
>>>> There are more and more applications coming to WinRT, Wine could s=
upport them,
>>>> but mostly they expect to have the thread environment block (TEB) =
in TPIDRURW.
>>>> This register must be preserved per thread instead of being cleare=
d.
>>>
>>> I'd prefer this was done a little more sensitively to those CPUs wh=
ere
>>> loads/stores are expensive, namely:
>>>
>>>> +
>>>> +	@ preserve TPIDRURW register state
>>>> +	get_tls2	r3, r4, r5
>>>> +	str	r3, [r1, #TI_TP2_VALUE]
>>>> +	ldr	r3, [r2, #TI_TP2_VALUE]
>>>> +	set_tls2	r3, r4, r5
>>>
>>> those two loads/stores get omitted from the thread switching if the=
 CPU
>>> doesn't support it.  Do you think that's something you could do?
>>
>> No, i'm not sure how to improve this. How does the process can conti=
nue, can you or someone else fix that and add his Signed-off-by?
>=20
> How about something like the (completely untested) diff below?
>=20
> Andre: if this works for you, I'm happy to write a commit message etc=
=2E
>=20
> Cheers,
>=20
> Will
>=20
> --->8

I'll try the next days and report back, thx.
--=20

Best Regards, Andr=E9 Hentschel
