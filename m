Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33090 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbbDMNwx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 09:52:53 -0400
Date: Mon, 13 Apr 2015 15:52:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 05/24] arm64: Remove signal translation and exec_domain
Message-ID: <20150413135247.GA32744@ulmo.nvidia.com>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
 <1428785283-20501-6-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <1428785283-20501-6-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@infradead.org, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org
Message-ID: <20150413135248.hhwfRZp4UC4U3BVjdwDiQ4lr8vBJIoo8oYffdG9LVuA@z>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2015 at 10:47:44PM +0200, Richard Weinberger wrote:
[...]
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 660ccf9..9f28eaa 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -294,12 +294,6 @@ static void handle_signal(struct ksignal *ksig, stru=
ct pt_regs *regs)
>  	int ret;
> =20
>  	/*
> -	 * translate the signal
> -	 */
> -	if (usig < 32 && thread->exec_domain && thread->exec_domain->signal_inv=
map)
> -		usig =3D thread->exec_domain->signal_invmap[usig];
> -
> -	/*

This hunk triggers a warning in linux-next about the thread variable now
being unused.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVK8osAAoJEN0jrNd/PrOhmpcP/1i5oNjerwo/LVbb04YZQ7M8
6yZ/Q/oWRQmRtAfGEiw3go8VjE5LAt4dNZvNk879eS1GB3jKXAqUMgCeNyd/5i4E
nlM9p94oPJsX0jNTECKDPP1qE7/7eokK6hlHrtZ9Zxe7Zw9pgI76LYeNd9SPFPR0
IW5VsapD0WxLyUNMUL/RbAfr7S/a5qbvPCPbo49Q6DC42dzNZesyRRRI0ADpOUO2
/ZN8NDWCsBzVgAdbryUPxJ8a/BN/gxM8dcrqFmOWhf9dGlvo0xVMVbviaxjXUc+x
JTvMdZOnp3bsFvGHTs8QZLquqJID0y5r3bSHFUXCQp4t7Rb1gG4cwHTAkM9faj+8
L6iF1FDbeNZMaSqJsZgwfw1HXRkLWJpH2a8NtCXJPMsBHNiDG5+dt8dZwf54SZyE
38jqj+TXfK5H6GMr4l2JCVq89ENq1bZoOkkuM2klB3w8oWrhWdKTHiA8xbZ649Ta
NjoEnTbZG8rlG88pWZEwSdgxVKRUo+YjewYU8flPBFGxgKheGEIGEaTPL+SOW9JE
EZr64uFvyLQbJgQriigL+fdiHNX5a3T8Dd5/mVhPYUZSMydCNE1kIsBl6c0WVZJq
CPZf/AVQjfPPoN47QpW3U8Bu9bEiLQJAt30ZMgP3SO9qK6kWXv2pl+ixowbVWem6
YoJVrrSz4GPqv4iL/iBB
=MA08
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
