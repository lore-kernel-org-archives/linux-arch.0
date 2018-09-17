From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Date: Mon, 17 Sep 2018 21:54:43 +1000
Message-ID: <20180917215443.3b5808c5@canb.auug.org.au>
References: <cover.1536757532.git.ren_guo@c-sky.com>
        <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
        <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yEI4_c=IeDPHRljjUJxAYIO"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

--Sig_/yEI4_c=IeDPHRljjUJxAYIO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Sun, 16 Sep 2018 12:53:26 +0800 Guo Ren <ren_guo@c-sky.com> wrote:
>
> I'm Guo Ren from C-SKY and I'm working on csky linux port upstream.
> I've prepared my git-tree based on linux-4.19-rc3:
> git clone -b linux-next https://github.com/c-sky/csky-linux.git
>=20
> Here is the pre-built cross compiler for fast test from our CI:
> https://gitlab.com/c-sky/buildroot/-/jobs/97941896/artifacts/file/output/=
images/csky_toolchain_csky_ck860_platform_defconfig_72371bf75a51f27ea59fc34=
eeaf236e06b75bf69.tar.xz
>=20
> You can also build newest gcc, binutils and they are upstreamed but not
> released on gnu.org. Glibc is uptreaming now.
>=20
> Please have a look and any feed back is welcome.

Added from today (called "csky").

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/yEI4_c=IeDPHRljjUJxAYIO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluflgMACgkQAVBC80lX
0Gy+0AgAi7LvoRN3SAZxDLH8U8IIVDVNkt7QObfeynIb1nTHO1dq3+SAHYC4+1p7
EcGP2c+4FVY8QX7Zdxx0aQqxvr4T2I7ej7A4LKFI20KQB0nXBip2u5kmwGYRUE/4
9y99/SyI6y8MXRURnM+bIB+qbXx1NJTTTgCR+UOVh4xSOmSIHiVpwoPpRHzsNevI
MN43Ntd3AZ6mwhjbLUBfIabtiDNkaQ3aLuPoheZqnhEF066w37oPwYhKgvwYGeQh
3wYwcVIvLm2xLJIJpy2jhHufjB1I5JG/r+kDzcuIey3/QHUUFKQmvCrexWE4bBZS
49URtExtPUzaBtVZ3ZZvz/x+u0JR/A==
=I9rI
-----END PGP SIGNATURE-----

--Sig_/yEI4_c=IeDPHRljjUJxAYIO--
