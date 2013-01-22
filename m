From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: arm: Request to preserve TPIDRURW per thread
Date: Tue, 22 Jan 2013 01:16:01 +0100
Message-ID: <50FDDA41.7090201@dawncrow.de>
References: <50FDD7A8.1080402@dawncrow.de> <20130122001143.GA4107@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55318 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab3AVAQM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 19:16:12 -0500
In-Reply-To: <20130122001143.GA4107@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, will.deacon@arm.com, rmk+kernel@arm.linux.org.uk

Am 22.01.2013 01:11, schrieb Greg KH:
> On Tue, Jan 22, 2013 at 01:04:56AM +0100, Andr=E9 Hentschel wrote:
>> Hi,
>> that comes a bit late, but [1] asked for objections.
>> As you can see in [2] there are more and more applications coming to=
 WinRT, Wine could support them,
>> but mostly they expect to have the thread environment block (TEB) in=
 TPIDRURW.
>> This register must be preserved per thread and we have patches for t=
hat.
>>
>> Currently there exist two kernel behaviours:
>>
>> 1. the kernel does not touch TPIDRURW at all ("covert channel")
>> 2. the kernel clears TPIDRURW on thread switch
>>
>> Attached to [3] you'll find kernel patches you can freely use.
>> Permission and more info you'll find in [4].
>> Any hints or suggestions?
>>
>> [1] http://www.kernelhub.org/?p=3D2&msg=3D57979
>> [2] http://forum.xda-developers.com/showthread.php?t=3D2092348
>> [3] http://bugs.winehq.org/show_bug.cgi?id=3D31322
>> [4] http://bugs.winehq.org/show_bug.cgi?id=3D31308
>=20
> Please submit the patches to fix this in the way described in
> Documentation/SubmittingPatches.  Once they are in Linus's tree, I'll=
 be
> glad to take them in the stable tree if they meet the guidelines that
> are described in Documentation/stable_kernel_rules.txt.
>=20
> Does that help?
>=20
> thanks,
>=20
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Sure, thx.
It only will take a while, because i'm out for some days. I'll report b=
ack.

--=20

Best Regards, Andr=E9 Hentschel
