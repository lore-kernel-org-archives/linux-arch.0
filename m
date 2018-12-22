From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 0/5] alpha: system call table generation support
Date: Sat, 22 Dec 2018 21:27:20 +1100
Message-ID: <20181222212720.6637ef8e@canb.auug.org.au>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
        <CALxhOngxbsYFSbK1Y0okuiTmjWEQ8Zcd4vQ0OezhXBgXH82DtA@mail.gmail.com>
        <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com>
        <CAK8P3a366UUWv8hXxWFQo9EQs++t5x4N+JmJ5abgD8BP99hECQ@mail.gmail.com>
        <CAEdQ38EY3ix6XAwAjY8H4OhFwRcT1Yuvk4ofLa_GVyh5COpkRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K95BLF44cm9c5f5+VcHpoTZ"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEdQ38EY3ix6XAwAjY8H4OhFwRcT1Yuvk4ofLa_GVyh5COpkRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Turner <mattst88@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>, linux-alpha <linux-alpha@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

--Sig_/K95BLF44cm9c5f5+VcHpoTZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, 21 Dec 2018 11:46:59 -0500 Matt Turner <mattst88@gmail.com> wrote:
>
> Probably so. This is just a super part-time thing for me, so I've
> never figured out what I needed to do to be included in linux-next.

The requirements are:

"You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary."

Just send me an email with the URL of a git tree that has a branch that
I can fetch every day.

However, I am not doing any releases until Jan 2, so it will be
included then.

--=20
Cheers,
Stephen Rothwell

--Sig_/K95BLF44cm9c5f5+VcHpoTZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlweEYgACgkQAVBC80lX
0GzAZQf/ceFemIRud5chQHnpxdM8Q4WTwZPcT3g997vj97b35xydgjUw24JHscAi
OJN7B2qj6Ieus3yyy+yrveCkxQlIVkmv9dhKete6KHiGIHogCcmwBT7lpsQK1qje
CsdoKSEffgDUzPYe7uhGHGI2JdJnfM2OjfYXe/VgLdduUoMVD8S2z8qtAD6h27IC
/M5zUSPPXF/+j8TXBeRPhIUMANw2q5oWx5rH10DTsC2NJ1rDsgy2adJY2kdul99d
ORSsdvb/UqsjN8fjeoDFqsZEvGjicv9nN29IatD0Ih44cUZVdnPeB7S1OSCiwrsL
Fomphge7jlCE0BrSP1LetXSjSHHzsQ==
=KcoK
-----END PGP SIGNATURE-----

--Sig_/K95BLF44cm9c5f5+VcHpoTZ--
