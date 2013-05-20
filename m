From: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Subject: Re: [PATCHv4] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
Date: Mon, 20 May 2013 14:51:48 +0200
Message-ID: <519A1C64.3020807@dawncrow.de>
References: <518AA19B.2020209@dawncrow.de> <51979801.7010903@dawncrow.de> <519A030D.1030809@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52083 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab3ETMv4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2013 08:51:56 -0400
In-Reply-To: <519A030D.1030809@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Austin <jonathan.austin@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <Will.Deacon@arm.com>

Am 20.05.2013 13:03, schrieb Jonathan Austin:
> Hi Andr=C3=A9
>=20
> On 18/05/13 16:02, Andr=C3=A9 Hentschel wrote:
>> Am 08.05.2013 21:03, schrieb Andr=C3=A9 Hentschel:
>>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.d=
e>
>>>
>=20
> This is strangely formatted for me too, and I use a different client =
from Will so I'm not sure that the problem is just at our end...
>=20
> (Also see that the list archive has weird formatting:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/167325=
=2Ehtml )
>=20
> Your first couple of patches didn't come out strangely formatted, so =
I'm not really sure what's going on.

I'll retry it with plain Text or something. AFAIK git should understand=
 this =3DUTF=3D style, though.

>>> Since commit 6a1c53124aa1 the user writeable TLS register was zeroe=
d to
>>> prevent it from being used as a covert channel between two tasks.
>>>
>>> There are more and more applications coming to WinRT, Wine could su=
pport them,
>>> but mostly they expect to have the thread environment block (TEB) i=
n TPIDRURW.
>>>
>>> This patch preserves that register per thread instead of clearing i=
t.
>>> Unlike the TPIDRURO, which is already switched, the TPIDRURW
>>> can be updated from userspace so needs careful treatment in the cas=
e that we
>>> modify TPIDRURW and call fork(). To avoid this we must always read
>>> TPIDRURW in copy_thread.
>>>
>>> Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>>>
>>
>> Hi,
>> I'm not yet very familiar with the development process here,
>> am i getting no feedback on v4 because of the mergewindow being clos=
ed?
>> Or is there another reason? Sry for being impatient.
>>
>=20
> This is a feature, not a fix, so most likely it'll be included at the=
 next merge window. For that to happen it should be in Russell's tree a=
round the middle of this cycle.
>=20
> Can you please rebase on 3.10-rc2 (when it happens) and post one more=
 version? After that, assuming nobody else has any final comments, you =
could put it in to Russell's patch system...
>=20
> Just as a hint - one thing you might have done to increase the chance=
s of getting comments to clarify what's different between v3 and v4 - a=
s a way to make life easier for reviewers you can highlight the differe=
nces between versions after the "---" (where you currently have the des=
cription of why there are so many S-o-Bs).

I'll do, thank you very much for the reply and the clarification.
