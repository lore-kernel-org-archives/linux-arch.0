From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCHv2] arm: Preserve TPIDRURW on context switch
Date: Mon, 22 Apr 2013 23:07:35 +0200
Message-ID: <5175A697.3080308@dawncrow.de>
References: <517168BB.3070903@dawncrow.de> <20130422143616.GP14496@n2100.arm.linux.org.uk> <20130422151836.GA15665@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63939 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3DVVHs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2013 17:07:48 -0400
In-Reply-To: <20130422151836.GA15665@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

Am 22.04.2013 17:18, schrieb Will Deacon:
> On Mon, Apr 22, 2013 at 03:36:16PM +0100, Russell King - ARM Linux wr=
ote:
>> On Fri, Apr 19, 2013 at 05:54:35PM +0200, Andr=E9 Hentschel wrote:
>>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.d=
e>
>>>
>>> There are more and more applications coming to WinRT, Wine could su=
pport them,
>>> but mostly they expect to have the thread environment block (TEB) i=
n TPIDRURW.
>>> This register must be preserved per thread instead of being cleared=
=2E
>>>
>>> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
>>
>> This actually makes things less efficient all round, because you
>> now use the value immediately after loading, which means it will cau=
se
>> pipeline stalls, certainly on older CPUs.
>>
>> Could you please rework the patch to try avoiding soo many modificat=
ions
>> to the way things have been done here?
>=20
> copy_thread also needs updating so that the *register* value for the =
parent
> is copied to the child, since the parent may have written the registe=
r
> after the last context-switch, meaning that tp_value is out-of-date.

Thank you both for reviewing.

I guess you mostly mean "ldr	r6, [r2, #TI_CPU_DOMAIN]".
I just thought about old CPUs and remembered again that we at Wine
need that patch only on v7 (and later). So is it ok to introduce a set_=
tls_v7
in tls.h and make use of CONFIG_CPU_V7 compile-time check in
the changed files and in the copy_thread function?
Do i need any further flag checks in copy_thread or can i use the
compile-time check to add unconditional code?
