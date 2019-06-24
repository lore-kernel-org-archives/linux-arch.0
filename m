Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:52193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfFXB50 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Jun 2019 21:57:26 -0400
Date: Mon, 24 Jun 2019 11:20:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Message-ID: <20190624112029.4f42a8cd@canb.auug.org.au>
In-Reply-To: <20190624002430.GN2226@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
        <20190530141531.43462-19-vincenzo.frascino@arm.com>
        <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
        <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
        <20190614211710.GQ1513@sasha-vm>
        <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
        <20190623190929.GL2226@sasha-vm>
        <20190624075834.2491a61a@canb.auug.org.au>
        <20190624002430.GN2226@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UW6IjEE3Jj_YtxhGwam1e.t"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mikelley@microsoft.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20190624012029.mGiTTdC8YJoIKkqCvJEvL_jg7KtYlouJ1hrAdzRc9ck@z>

--Sig_/UW6IjEE3Jj_YtxhGwam1e.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Sun, 23 Jun 2019 20:24:30 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> Pushed now. For some reason the airport wifi was blocking ssh :/

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/UW6IjEE3Jj_YtxhGwam1e.t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QJV0ACgkQAVBC80lX
0GwUBQf/e/6tJWyAWMaopYMBDqN2qz4oN/vHsi0Cl4cEtZikDfm20K5/e1B/rwg4
3AdDGd4MfB2z5/yvCCH0gZcA3R8U8r/OX6rpU6BHD6jewnLN813ja7GesU+lgWGE
fDznHmIHmGaN2LljjUA34WkBymJGMDsOcA30q6ZIdO48ABULY+FstQOahDrTFMde
Btm0wVAvmSOP5iIIXt64JWYPhNzGJljLoW9Y5SzpAQOIrTCzYaTIcKceQsBXmPoK
XH6Ypn5GZCfCNZD/9reOW8IG8CNsSN+7OBdtFFC9W7/OGZdAmMz9n6eX+a/9WS3x
VqP7o7p8NE5G2ug+cDsnFn1aIkDb6g==
=/UhR
-----END PGP SIGNATURE-----

--Sig_/UW6IjEE3Jj_YtxhGwam1e.t--
