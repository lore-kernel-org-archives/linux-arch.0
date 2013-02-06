From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH] arm: Preserve TPIDRURW on context switch
Date: Thu, 07 Feb 2013 00:01:23 +0100
Message-ID: <5112E0C3.1080706@dawncrow.de>
References: <5112DC7E.4020108@dawncrow.de> <20130206225150.GL17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130206225150.GL17833@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

Am 06.02.2013 23:51, schrieb Russell King - ARM Linux:
> On Wed, Feb 06, 2013 at 11:43:10PM +0100, Andr=E9 Hentschel wrote:
>> There are more and more applications coming to WinRT, Wine could sup=
port them,
>> but mostly they expect to have the thread environment block (TEB) in=
 TPIDRURW.
>> This register must be preserved per thread instead of being cleared.
>=20
> I'd prefer this was done a little more sensitively to those CPUs wher=
e
> loads/stores are expensive, namely:
>=20
>> +
>> +	@ preserve TPIDRURW register state
>> +	get_tls2	r3, r4, r5
>> +	str	r3, [r1, #TI_TP2_VALUE]
>> +	ldr	r3, [r2, #TI_TP2_VALUE]
>> +	set_tls2	r3, r4, r5
>=20
> those two loads/stores get omitted from the thread switching if the C=
PU
> doesn't support it.  Do you think that's something you could do?

No, i'm not sure how to improve this. How does the process can continue=
, can you or someone else fix that and add his Signed-off-by?


--=20

Best Regards, Andr=E9 Hentschel
