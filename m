From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH] arm: Preserve TPIDRURW on context switch
Date: Wed, 20 Feb 2013 20:34:37 +0100
Message-ID: <5125254D.7040401@dawncrow.de>
References: <5112DC7E.4020108@dawncrow.de> <20130206225150.GL17833@n2100.arm.linux.org.uk> <5112E0C3.1080706@dawncrow.de> <20130208154809.GF3495@mudshark.cambridge.arm.com> <511A4B93.1000700@dawncrow.de> <20130212140950.GC4123@mudshark.cambridge.arm.com> <511A5995.5000607@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64324 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933749Ab3BTTe5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Feb 2013 14:34:57 -0500
In-Reply-To: <511A5995.5000607@parrot.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Am 12.02.2013 16:02, schrieb Matthieu CASTET:
> Will Deacon a =E9crit :
>> Hi Andre,
>>
>> On Tue, Feb 12, 2013 at 02:02:59PM +0000, Andr=E9 Hentschel wrote:
>>> Am 08.02.2013 16:48, schrieb Will Deacon:
>>>> On Wed, Feb 06, 2013 at 11:01:23PM +0000, Andr=E9 Hentschel wrote:
>>>>> No, i'm not sure how to improve this. How does the process can co=
ntinue, can you or someone else fix that and add his Signed-off-by?
>>>> How about something like the (completely untested) diff below?
>>>>
>>>> Andre: if this works for you, I'm happy to write a commit message =
etc.
>>> Thx for your effort, but it doesn't work, at least not with my 3.4.=
6 suse kernel.
>>> Be free to have another try, i'll be happy to test it.
>>
>> Well, cheers for testing. Can you be more specific about what goes w=
rong
>> please? What do you see in TPIDRURW?
>>
> The tls value is never saved to : thread->tp_value[1].
>=20
> Also I don't know if you can avoid the extra ldr in the software case=
=2E
>=20
> Matthieu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Hi Will,
seems like Matthieu is right, any update on this?

--=20

Best Regards, Andr=E9 Hentschel
