From: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Subject: Re: arm: Only load TLS values when needed
Date: Wed, 17 Jul 2013 21:49:06 +0200
Message-ID: <51E6F532.1030004@dawncrow.de>
References: <51E42E11.1010903@dawncrow.de> <51E5836B.1010904@arm.com> <51E59E8F.1060501@dawncrow.de> <51E67B98.9040101@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52918 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab3GQTtk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2013 15:49:40 -0400
In-Reply-To: <51E67B98.9040101@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Austin <jonathan.austin@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

Am 17.07.2013 13:10, schrieb Jonathan Austin:
> Hi Andr=C3=A9,
>=20
> On 16/07/13 20:27, Andr=C3=A9 Hentschel wrote:
>> Hi Jonathan, First, thank you for your review.
>>
>> Am 16.07.2013 19:31, schrieb Jonathan Austin:
>>> Hi Andr=C3=A9,
>>>
>>> On 15/07/13 18:14, Andr=C3=A9 Hentschel wrote:
>>>> From: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>>>>
>>>> This patch intents to reduce loading instructions when the
>>>> resulting value is not used. It's a follow up on
>>>> a4780adeefd042482f624f5e0d577bf9cdcbb760
>>>>
>>>
>>> Have you done any benchmarking to see that this has any real
>>> impact? Or tested on a !Vv6k system? It looks possible that the
>>> only case where this will perform better is where we're using
>>> switch_tls_none or switch_tls_software (both rare cases, I think)
>>> and there's some change it will make things worse in other cases?
>>
>> I have to admit that i only tested it on v6k and did no benchmark.
>>
> Do you have access to anything v6-NOT-k-ish? If not I can try and tes=
t this on something appropriate. How does your test-case access tpidrur=
w? If it uses inline asm then it won't work on v6-not-k, as those instr=
uctions aren't defined...

I don't, so it'd be nice if you could do that. I could imagine you have=
 a good choice of devices at ARM :)

In my crappy test application i do it similar to Wine:
https://github.com/AndreRH/tpidrurw-test/blob/master/main.c#L29

but Wine code won't work out of the box on v6:
http://source.winehq.org/git/wine.git/blob/HEAD:/dlls/ntdll/signal_arm.=
c#l851

>>> One of the reasons for Russell's suggestion of placing the ldrd
>>> (which became the two ldr instructions you've removed from
>>> __switch_to, in order to maintain building for older cores) where
>>> it is was in order to reduce the chance of pipeline stalls.
>>>
>>> As I've pointed out below, there is some risk that changing that
>>> has implications for the v6 only case below (and the v6k case is
>>> now more prone to stalls with !CONFIG_CPU_USE_DOMAINS, but newer
>>> cores should have more advanced scheduling to avoid such issues
>>> anyway...)
>>
>> I'm not sure how this could make things worse on v6k, could you
>> elaborate please? Besides of the ldr and str being too close to each
>> other
>=20
> Yea, that's the only issue, and in the !CONFIG_CPU_USE_DOMAINS case t=
hings are slightly worse than they were before
>=20
>> i thought this patch is a good idea, because it removes two ldr
>> which are always executed. (Continuing below...)
>=20
> Indeed, as long as it doesn't cause pipeline stalls then that's a gai=
n for some cases :)
>=20
> [...]
>>> Now we've only got one instruction between the store and the load
>>> and risk stalling the pipeline...
>>>
>>> Dave M cautiously says "The ancient advice was that one instruction
>>> was enough" but this is very core dependent... I wonder if anyone
>>> has a good idea about whether this is an issue here...?
>>
>> We could use a ldrd at the top, that'd be nearly what we have right
>> now, don't we?
>=20
> Yea, that'd be good - as far as I can see from an 1136 TRM, the ldrd =
*may* be two cycles (depending on alignment of the words) but the ldr a=
nd ldrne will always be two cycles. Ahhh, the joys of modifying the fas=
t path ;)
