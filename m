From: =?ISO-8859-15?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCHv4] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
Date: Sat, 18 May 2013 17:02:25 +0200
Message-ID: <51979801.7010903@dawncrow.de>
References: <518AA19B.2020209@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55315 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab3ERPCb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 May 2013 11:02:31 -0400
In-Reply-To: <518AA19B.2020209@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Jonathan Austin <jonathan.austin@arm.com>

Am 08.05.2013 21:03, schrieb Andr=E9 Hentschel:
> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>
>=20
> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed =
to
> prevent it from being used as a covert channel between two tasks.
>=20
> There are more and more applications coming to WinRT, Wine could supp=
ort them,
> but mostly they expect to have the thread environment block (TEB) in =
TPIDRURW.
>=20
> This patch preserves that register per thread instead of clearing it.
> Unlike the TPIDRURO, which is already switched, the TPIDRURW
> can be updated from userspace so needs careful treatment in the case =
that we
> modify TPIDRURW and call fork(). To avoid this we must always read
> TPIDRURW in copy_thread.
>=20
> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>=20
>=20

Hi,
I'm not yet very familiar with the development process here,
am i getting no feedback on v4 because of the mergewindow being closed?
Or is there another reason? Sry for being impatient.
