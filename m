From: Jonathan Austin <jonathan.austin@arm.com>
Subject: Re: [PATCHv4] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
Date: Mon, 20 May 2013 12:03:41 +0100
Message-ID: <519A030D.1030809@arm.com>
References: <518AA19B.2020209@dawncrow.de> <51979801.7010903@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51979801.7010903@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi Andr=C3=A9

On 18/05/13 16:02, Andr=C3=A9 Hentschel wrote:
> Am 08.05.2013 21:03, schrieb Andr=C3=A9 Hentschel:
>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de=
>
>>

This is strangely formatted for me too, and I use a different client=20
from Will so I'm not sure that the problem is just at our end...

(Also see that the list archive has weird formatting:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/167325.h=
tml )

Your first couple of patches didn't come out strangely formatted, so I'=
m=20
not really sure what's going on.

>> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed=
 to
>> prevent it from being used as a covert channel between two tasks.
>>
>> There are more and more applications coming to WinRT, Wine could sup=
port them,
>> but mostly they expect to have the thread environment block (TEB) in=
 TPIDRURW.
>>
>> This patch preserves that register per thread instead of clearing it=
=2E
>> Unlike the TPIDRURO, which is already switched, the TPIDRURW
>> can be updated from userspace so needs careful treatment in the case=
 that we
>> modify TPIDRURW and call fork(). To avoid this we must always read
>> TPIDRURW in copy_thread.
>>
>> Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>>
>
> Hi,
> I'm not yet very familiar with the development process here,
> am i getting no feedback on v4 because of the mergewindow being close=
d?
> Or is there another reason? Sry for being impatient.
>

This is a feature, not a fix, so most likely it'll be included at the=20
next merge window. For that to happen it should be in Russell's tree=20
around the middle of this cycle.

Can you please rebase on 3.10-rc2 (when it happens) and post one more=20
version? After that, assuming nobody else has any final comments, you=20
could put it in to Russell's patch system...

Just as a hint - one thing you might have done to increase the chances=20
of getting comments to clarify what's different between v3 and v4 - as =
a=20
way to make life easier for reviewers you can highlight the differences=
=20
between versions after the "---" (where you currently have the=20
description of why there are so many S-o-Bs).

Hope that helps,
Jonny
