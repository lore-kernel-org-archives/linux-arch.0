From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 00/44] Meta Linux Kernel Port
Date: Wed, 30 Jan 2013 07:44:52 +1100
Message-ID: <20130130074452.f67abeeaae3a00d046f5699f@canb.auug.org.au>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
	<5102BB38.3050207@imgtec.com>
	<201301260025.10020.arnd@arndb.de>
	<51062460.9060902@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__30_Jan_2013_07_44_52_+1100_Y8/7NGD184iCD+MN"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51062460.9060902@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

--Signature=_Wed__30_Jan_2013_07_44_52_+1100_Y8/7NGD184iCD+MN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

On Mon, 28 Jan 2013 12:40:24 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com=
> wrote:
>
> Stephen, can you please add the following branch (rebased off 3.8-rc5) to=
 linux-next
>=20
> git://github.com/foss-for-synopsys-dwc-arc-processors/linux.git  arc-next

Added from today (though there may not be a linux-next release today).

> While the first pull request can go directly from github, I presume the l=
ogistics
> for setting up accounts on kernel.org will only kick start after the firs=
t batch
> of code has been accepted. I can't seem to find any discussions on lists =
to that
> effect.

Linus prefers to not pull from github, but will if you ask him to pull a
tag signed with a verifiable gpg key.  This is not a requirement if your
tree is on kernel.org (though you still need a verifiable gpg key to get
a kernel.org account).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__30_Jan_2013_07_44_52_+1100_Y8/7NGD184iCD+MN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRCDTEAAoJEECxmPOUX5FEvJYQAKaLABnY5uum6gM9796w6kpY
x1G+I93g+1cYyLEt8AyVHFEEsZWGAlTMmEs3/cphufj5qMa/Ie4dBe6xo7vL1eBN
XcHkrQSwESqyUSChNEwdWQNk+hPdqRnLMxBse0X1p10VlytSDBwGcuGv1p2bF77Q
V2btYxtJnbC+XEL41xYdyVmFfPPbYGxZVijpOVa0KCsqq52BPyI+wb9XuoheiT3y
5OKhxD4c9NhAu0JRosoMDTGEclxZ21YMsc0TM8dPQzadaWrwqn6YncMxWjwbN8Yd
8LZg+k/YY7BPtbFRJbZZMu1VH/pYqfdTqNq8oUP2gyST0vu32fR0MkUoQgIN6fQZ
X4CT+0o3s8GMwGuSVf3sLcIrIRYtpb5UegaTywGxYwzgom7I8IE/WuWK3yYYq7n1
ZsqdtZwUz+z2r9bxQWLcFikIfJxeMvJ/rOvQ3zjCzfZ/6US9BPzlo9w/ELi7Ckri
SqCEnxAdkNvZ5gaNRIq/f2rOhub/WyYjVrByzNJ1DXnBGdzRJoKoVTzKzrcrtnxQ
rKFfv6+72KwznBaZ9ZyPLopPPkUx5XvzWp/Omgp4ngKCAJ4+DBrUm8X+aKEYQDNq
dQPOTBQTZewwhYz62km3MclqMeT2PORw19GsWVZyJyin42vXxdGobrxI4sRGVWzo
6Yl90Ajgz0oDFQmB0wHC
=QijY
-----END PGP SIGNATURE-----

--Signature=_Wed__30_Jan_2013_07_44_52_+1100_Y8/7NGD184iCD+MN--
