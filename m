From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH] arm: Preserve TPIDRURW on context switch
Date: Tue, 12 Feb 2013 16:02:45 +0100
Message-ID: <511A5995.5000607@parrot.com>
References: <5112DC7E.4020108@dawncrow.de> <20130206225150.GL17833@n2100.arm.linux.org.uk> <5112E0C3.1080706@dawncrow.de> <20130208154809.GF3495@mudshark.cambridge.arm.com> <511A4B93.1000700@dawncrow.de> <20130212140950.GC4123@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:56239 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760056Ab3BLPCu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2013 10:02:50 -0500
In-Reply-To: <20130212140950.GC4123@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Will Deacon a =E9crit :
> Hi Andre,
>=20
> On Tue, Feb 12, 2013 at 02:02:59PM +0000, Andr=E9 Hentschel wrote:
>> Am 08.02.2013 16:48, schrieb Will Deacon:
>>> On Wed, Feb 06, 2013 at 11:01:23PM +0000, Andr=E9 Hentschel wrote:
>>>> No, i'm not sure how to improve this. How does the process can con=
tinue, can you or someone else fix that and add his Signed-off-by?
>>> How about something like the (completely untested) diff below?
>>>
>>> Andre: if this works for you, I'm happy to write a commit message e=
tc.
>> Thx for your effort, but it doesn't work, at least not with my 3.4.6=
 suse kernel.
>> Be free to have another try, i'll be happy to test it.
>=20
> Well, cheers for testing. Can you be more specific about what goes wr=
ong
> please? What do you see in TPIDRURW?
>=20
The tls value is never saved to : thread->tp_value[1].

Also I don't know if you can avoid the extra ldr in the software case.

Matthieu
